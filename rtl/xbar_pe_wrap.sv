
/*
 * Copyright (C) 2013-2017 ETH Zurich, University of Bologna
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished 
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Bug fixes and contributions will eventually be released under the
 * SolderPad open hardware license in the context of the PULP platform
 * (http://www.pulp-platform.org), under the copyright of ETH Zurich and the
 * University of Bologna.
 */

/* 
 This is the xbar_pe_wrap to connect NB_CORES+NB_MPERIPH Slave Ports to
 NB_SPERIPH Master Ports. It is obtained with NB_CORES+NB_MPERIPHS stream_demux.
 Every stream_demux has NB_SPERIPH output, each one going to one of the NB_SPERIPH rr_arb_tree.
 Each rr_arb_tree performes arbitration using an internal round robin counter.
 For each Slave Port, there is a stream_mux to  multiplex the NB_SPERIPH responses. 
*/

module xbar_pe_wrap
  import pulp_cluster_package::*;
  #(
  parameter NB_CORES           = 8,
  parameter NB_MPERIPHS        = 1,
  parameter NB_SPERIPHS        = 10,   
  parameter ADDR_WIDTH         = 32,
  parameter DATA_WIDTH         = 32,
  parameter BE_WIDTH           = 0,
  parameter PE_ROUTING_LSB     = 10,
  parameter PE_ROUTING_MSB     = 13,
  parameter bit HWPE_PRESENT   = 1'b1,
  parameter CLUSTER_ALIAS      = 1,
  parameter CLUSTER_ALIAS_BASE =  12'h000,
  parameter ADDREXT         = 1'b0
)
(
  input logic                          clk_i,
  input logic                          rst_ni,
  XBAR_PERIPH_BUS.Slave                core_periph_slave[NB_CORES-1:0],
  XBAR_PERIPH_BUS.Master               speriph_master[NB_SPERIPHS-1:0],
  XBAR_TCDM_BUS.Slave                  mperiph_slave[NB_MPERIPHS-1:0]
 );

  logic                               cluster_alias;
   
  assign cluster_alias = (CLUSTER_ALIAS == 1) ? 1'b1 : 1'b0;

  localparam int unsigned PE_XBAR_N_INPS = NB_CORES + NB_MPERIPHS;
  localparam int unsigned PE_XBAR_N_OUPS = NB_SPERIPHS;
  typedef logic [ADDR_WIDTH-1:0]              pe_addr_t;
  typedef logic [DATA_WIDTH-1:0]              pe_data_t;
  typedef logic [$clog2(PE_XBAR_N_OUPS)-1:0]  pe_idx_t;
  typedef logic [PE_XBAR_N_INPS-1:0]          pe_id_t;
  typedef struct packed {
    pe_addr_t             addr;
    pe_data_t             data;
    pe_id_t               id;
    logic                 we_n; // active low on `XBAR_PERIPH_BUS` and `XBAR_TCDM_BUS`
    logic [BE_WIDTH-1:0]  be;
  } pe_req_t;
  typedef struct packed {
    pe_data_t   data;
    pe_id_t     id;
    logic       opc;
  } pe_resp_t;

  // Peripherals: Bind inputs and decode addresses.
  pe_idx_t  [PE_XBAR_N_INPS-1:0]  pe_inp_idx;
  pe_req_t  [PE_XBAR_N_INPS-1:0]  pe_inp_wdata;
  pe_resp_t [PE_XBAR_N_INPS-1:0]  pe_inp_rdata;
  logic     [PE_XBAR_N_INPS-1:0]  pe_inp_req,
                                  pe_inp_gnt,
                                  pe_inp_rvalid;
  localparam pe_idx_t PE_IDX_EXT = pulp_cluster_package::SPER_EXT_ID;
  localparam pe_idx_t PE_IDX_ERR = pulp_cluster_package::SPER_ERROR_ID;
  function automatic pe_idx_t addr_to_pe_idx(input pe_addr_t addr, input logic [31:0] addrext);
    pe_idx_t pe_idx;
    if (ADDREXT && addrext != '0) begin
      return PE_IDX_EXT;
    end else begin
      if (
        // if the access is to this cluster ..
        (addr[31:24] == 8'h10 || (cluster_alias && addr[31:24] == CLUSTER_ALIAS_BASE[11:4]))
        // .. and the peripherals
        && (addr[23:20] >= 4'h2 && addr[23:20] <= 4'h3)
      ) begin
        // decode peripheral to access
        pe_idx = addr[PE_ROUTING_MSB:PE_ROUTING_LSB];
        if (addr[23:20] == 4'h2 && addr[19:PE_ROUTING_MSB+1] == '0 && pe_idx < NB_SPERIPHS) begin
          if (pe_idx >= pulp_cluster_package::SPER_EVENT_U_ID &&
              pe_idx < pulp_cluster_package::SPER_EVENT_U_ID
                        + pulp_cluster_package::NB_SPERIPH_PLUGS_EU
          ) begin
            // Index is in event unit range, so return unified event unit port.
            return pulp_cluster_package::SPER_EVENT_U_ID;
          end else if (!HWPE_PRESENT && pe_idx == pulp_cluster_package::SPER_HWPE_ID) begin
            // Decode non-present HWPE to error slave.
            return PE_IDX_ERR;
          end else if (pe_idx == PE_IDX_EXT) begin
            // Decode direct accesses to external peripheral to error slave to break addressing
            // loop.
            return PE_IDX_ERR;
          end else begin
            // Return index of other peripheral.
            return pe_idx;
          end
        // .. or, if the address does not decode to a peripheral, decode to error slave
        end else begin
          return PE_IDX_ERR;
        end
      end else begin
        // otherwise decode to 'external' peripheral
        return PE_IDX_EXT;
      end
    end
  endfunction
  for (genvar i = 0; i < NB_CORES; i++) begin : gen_pe_xbar_bind_cores
    assign pe_inp_req[i] = core_periph_slave[i].req;
    assign pe_inp_idx[i] = addr_to_pe_idx(core_periph_slave[i].add, '0);
    assign pe_inp_wdata[i].addr = core_periph_slave[i].add;
    assign pe_inp_wdata[i].data = core_periph_slave[i].wdata;
    assign pe_inp_wdata[i].id   = 1 << i;
    assign pe_inp_wdata[i].we_n = core_periph_slave[i].wen;
    assign pe_inp_wdata[i].be   = core_periph_slave[i].be;
    assign core_periph_slave[i].gnt     = pe_inp_gnt[i];
    assign core_periph_slave[i].r_id    = pe_inp_rdata[i].id;
    assign core_periph_slave[i].r_rdata = pe_inp_rdata[i].data;
    assign core_periph_slave[i].r_opc   = pe_inp_rdata[i].opc;
    assign core_periph_slave[i].r_valid = pe_inp_rvalid[i];
  end
  for (genvar i = 0; i < NB_MPERIPHS; i++) begin : gen_pe_xbar_bind_mperiphs
    assign pe_inp_req[i+NB_CORES] = mperiph_slave[i].req;
    assign pe_inp_idx[i+NB_CORES] = addr_to_pe_idx(mperiph_slave[i].add, '0);
    assign pe_inp_wdata[i+NB_CORES].addr  = mperiph_slave[i].add;
    assign pe_inp_wdata[i+NB_CORES].data  = mperiph_slave[i].wdata;
    assign pe_inp_wdata[i+NB_CORES].id    = 1 << (i + NB_CORES);
    assign pe_inp_wdata[i+NB_CORES].we_n  = mperiph_slave[i].wen;
    assign pe_inp_wdata[i+NB_CORES].be    = mperiph_slave[i].be;
    assign mperiph_slave[i].gnt     = pe_inp_gnt[i+NB_CORES];
    assign mperiph_slave[i].r_rdata = pe_inp_rdata[i+NB_CORES].data;
    assign mperiph_slave[i].r_opc   = pe_inp_rdata[i+NB_CORES].opc;
    assign mperiph_slave[i].r_valid = pe_inp_rvalid[i+NB_CORES];
  end

  // Peripherals: Bind outputs.
  pe_req_t  [PE_XBAR_N_OUPS-1:0]  pe_oup_wdata;
  pe_resp_t [PE_XBAR_N_OUPS-1:0]  pe_oup_rdata;
  logic     [PE_XBAR_N_OUPS-1:0]  pe_oup_req,
                                  pe_oup_gnt,
                                  pe_oup_rvalid;
  for (genvar i = 0; i < NB_SPERIPHS; i++) begin : gen_pe_xbar_bind_speriphs
    assign speriph_master[i].req    = pe_oup_req[i];
    assign pe_oup_gnt[i]            = speriph_master[i].gnt;
    assign speriph_master[i].add    = pe_oup_wdata[i].addr;
    assign speriph_master[i].wdata  = pe_oup_wdata[i].data;
    assign speriph_master[i].id     = pe_oup_wdata[i].id;
    assign speriph_master[i].wen    = pe_oup_wdata[i].we_n;
    assign speriph_master[i].be     = pe_oup_wdata[i].be;
    assign pe_oup_rdata[i].data = speriph_master[i].r_rdata;
    assign pe_oup_rdata[i].id   = speriph_master[i].r_id;
    assign pe_oup_rdata[i].opc  = speriph_master[i].r_opc;
    assign pe_oup_rvalid[i] = speriph_master[i].r_valid;
  end

  // Peripheral Interconnect
  logic [PE_XBAR_N_INPS-1:0][PE_XBAR_N_OUPS-1:0] pe_req, pe_gnt;
  // Demux requests of inputs and mux responses to inputs.
  for (genvar i = 0; i < PE_XBAR_N_INPS; i++) begin : gen_pe_xbar_inps
    stream_demux #(
      .N_OUP(PE_XBAR_N_OUPS)
    ) i_req_demux (
      .inp_valid_i  (pe_inp_req[i]),
      .inp_ready_o  (pe_inp_gnt[i]),
      .oup_sel_i    (pe_inp_idx[i]),
      .oup_valid_o  (pe_req[i]),
      .oup_ready_i  (pe_gnt[i])
    );
    logic [PE_XBAR_N_OUPS-1:0] pe_oup_reqs;
    for (genvar j = 0; j < PE_XBAR_N_OUPS; j++) begin : gen_pe_xbar_inps_oup_reqs
          assign pe_oup_reqs[j] = pe_oup_rvalid[j] & (pe_oup_rdata[j].id == 1 << i);
    end
    pe_idx_t oup_sel;
    onehot_to_bin #(
      .ONEHOT_WIDTH (PE_XBAR_N_OUPS)
    ) i_ohb (
      .onehot (pe_oup_reqs),
      .bin    (oup_sel)
    );
    stream_mux #(
      .DATA_T (pe_resp_t),
      .N_INP  (PE_XBAR_N_OUPS)
    ) i_resp_mux (
      .inp_data_i   (pe_oup_rdata),
      .inp_valid_i  (pe_oup_reqs),
      .inp_ready_o  (/* unused */),
      .inp_sel_i    (oup_sel),
      .oup_data_o   (pe_inp_rdata[i]),
      .oup_valid_o  (pe_inp_rvalid[i]),
      .oup_ready_i  (1'b1)
    );
  end
  // Arbitrate requests to outputs.
  for (genvar i = 0; i < PE_XBAR_N_OUPS; i++) begin : gen_pe_xbar_oups
    logic [PE_XBAR_N_INPS-1:0] reqs, gnts;
    for (genvar j = 0; j < PE_XBAR_N_INPS; j++) begin : gen_pe_xbar_oup_arb_inps
      assign reqs[j] = pe_req[j][i];
      assign pe_gnt[j][i] = gnts[j];
    end
    rr_arb_tree #(
      .NumIn      (PE_XBAR_N_INPS),
      .DataWidth  ($bits(pe_req_t)),
      .ExtPrio    (1'b0),
      .AxiVldRdy  (1'b0),
      .LockIn     (1'b0)
    ) i_arb (
      .clk_i,
      .rst_ni,
      .flush_i  (1'b0),
      .rr_i     ('0),

      .req_i    (reqs),
      .gnt_o    (gnts),
      .data_i   (pe_inp_wdata),

      .gnt_i    (pe_oup_gnt[i]),
      .req_o    (pe_oup_req[i]),
      .data_o   (pe_oup_wdata[i]),
      .idx_o    (/* unused */)
    );
  end

endmodule
