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

`include "pulp_soc_defines.sv"

module cluster_interconnect_wrap import tcdm_interconnect_pkg::topo_e;

#(
  parameter NB_CORES        = 8,
  parameter NB_HWPE_PORTS   = 4,
  parameter NB_DMAS         = 4,
  parameter NB_EXT          = 4,
  parameter NB_MPERIPHS     = 1,
  parameter NB_TCDM_BANKS   = 16,
  parameter NB_SPERIPHS     = 8, //differ

  parameter DATA_WIDTH      = 32,
  parameter ADDR_WIDTH      = 32,
  parameter BE_WIDTH        = DATA_WIDTH/8,

  //TCDM PARAMETERS
  parameter TEST_SET_BIT    = 20,
  parameter ADDR_MEM_WIDTH  = 11,
  parameter LOG_CLUSTER     = 5,
  parameter PE_ROUTING_LSB  = 16,
  parameter PE_ROUTING_MSB  = PE_ROUTING_LSB+$clog2(NB_SPERIPHS)-1, //differ
  parameter CLUSTER_ALIAS_BASE = 12'h000
)
(
  input logic                          clk_i,
  input logic                          rst_ni,
  XBAR_TCDM_BUS.Slave                  core_tcdm_slave[NB_CORES+NB_HWPE_PORTS-1:0],
  input logic [NB_CORES-1:0][5:0]      core_tcdm_slave_atop,
  XBAR_PERIPH_BUS.Slave                core_periph_slave[NB_CORES-1:0],
  input logic [NB_CORES-1:0][5:0]      core_periph_slave_atop,
  XBAR_TCDM_BUS.Slave                  ext_slave[NB_EXT-1:0],
  input logic [NB_EXT-1:0][5:0]        ext_slave_atop,
  XBAR_TCDM_BUS.Slave                  dma_slave[NB_DMAS-1:0], //FIXME IGOR --> check NB_CORES depend ASK DAVIDE
  XBAR_TCDM_BUS.Slave                  mperiph_slave[NB_MPERIPHS-1:0],
  TCDM_BANK_MEM_BUS.Master             tcdm_sram_master[NB_TCDM_BANKS-1:0],
  XBAR_PERIPH_BUS.Master               speriph_master[NB_SPERIPHS-1:0],
  output logic [NB_SPERIPHS-1:0][5:0]  speriph_master_atop,
  input logic [1:0]                    TCDM_arb_policy_i
);

  // DMA --> LOGARITHMIC INTERCONNECT BUS SIGNALS
  logic [NB_EXT+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_wdata;
  logic [NB_EXT+NB_DMAS-1:0][ADDR_WIDTH-1:0]              s_dma_bus_add;
  logic [NB_EXT+NB_DMAS-1:0]                              s_dma_bus_req;
  logic [NB_EXT+NB_DMAS-1:0]                              s_dma_bus_wen;
  logic [NB_EXT+NB_DMAS-1:0][BE_WIDTH-1:0]                s_dma_bus_be;
  logic [NB_EXT+NB_DMAS-1:0]                              s_dma_bus_gnt;
  logic [NB_EXT+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_r_rdata;
  logic [NB_EXT+NB_DMAS-1:0]                              s_dma_bus_r_valid;


  // DEMUX --> LOGARITHMIC INTERCONNECT BUS SIGNALS
  logic [NB_CORES+NB_HWPE_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_wdata;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][ADDR_WIDTH-1:0] s_core_tcdm_bus_add;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_req;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_wen;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][BE_WIDTH-1:0]   s_core_tcdm_bus_be;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_gnt;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_r_rdata;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_r_valid;

  // LOGARITHMIC INTERCONNECT --> AMO Shims
  logic [NB_TCDM_BANKS-1:0][ADDR_MEM_WIDTH-1:0] s_tcdm_bus_amo_shim_add;
  logic [NB_TCDM_BANKS-1:0]                     s_tcdm_bus_amo_shim_req;
  logic [NB_TCDM_BANKS-1:0]                     s_tcdm_bus_amo_shim_gnt;
  logic [NB_TCDM_BANKS-1:0]                     s_tcdm_bus_amo_shim_wen;
  logic [NB_TCDM_BANKS-1:0][BE_WIDTH-1:0]       s_tcdm_bus_amo_shim_be;

  // TCDM BANK MEM SIGNAL
  logic [NB_TCDM_BANKS-1:0][ADDR_MEM_WIDTH-1:0]           s_tcdm_bus_sram_add;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_req;
  logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]               s_tcdm_bus_sram_wdata;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_wen;
  logic [NB_TCDM_BANKS-1:0][BE_WIDTH-1:0]                 s_tcdm_bus_sram_be;
  logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]               s_tcdm_bus_sram_rdata;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_gnt;


  //********************************************************
  //****** BINDING INTERFACES TO XBAR_TCDM BUS SIGNALS *****
  //********************************************************
  generate
    for (genvar i=0; i<NB_CORES+NB_HWPE_PORTS; i++)
    begin : CORE_TCDM_BIND
      assign s_core_tcdm_bus_add[i]      = core_tcdm_slave[i].add-32'h1000_0000;
      assign s_core_tcdm_bus_req[i]      = core_tcdm_slave[i].req;
      assign s_core_tcdm_bus_wdata[i]    = core_tcdm_slave[i].wdata;
      assign s_core_tcdm_bus_wen[i]      = core_tcdm_slave[i].wen;
      assign s_core_tcdm_bus_be[i]       = core_tcdm_slave[i].be;

      assign core_tcdm_slave[i].gnt      = s_core_tcdm_bus_gnt[i];
      assign core_tcdm_slave[i].r_valid  = s_core_tcdm_bus_r_valid[i];
      assign core_tcdm_slave[i].r_rdata  = s_core_tcdm_bus_r_rdata[i];
    end // block: CORE_TCDM_BIND
  endgenerate

  generate
    for (genvar i=0; i<NB_EXT; i++)
    begin : AXI2MEM_BIND
      assign s_dma_bus_add[i]      = ext_slave[i].add-32'h1000_0000;
      assign s_dma_bus_req[i]      = ext_slave[i].req;
      assign s_dma_bus_wdata[i]    = ext_slave[i].wdata;
      assign s_dma_bus_wen[i]      = ext_slave[i].wen;
      assign s_dma_bus_be[i]       = ext_slave[i].be;

      assign ext_slave[i].gnt      = s_dma_bus_gnt[i];
      assign ext_slave[i].r_valid  = s_dma_bus_r_valid[i];
      assign ext_slave[i].r_rdata  = s_dma_bus_r_rdata[i];
    end
  endgenerate

  generate
    for (genvar i=0; i<NB_DMAS; i++)  //4 takes into account the 4 ports used in axi2mem
    begin : DMAS_BIND
      assign s_dma_bus_add[i+NB_EXT]    = dma_slave[i].add;
      assign s_dma_bus_req[i+NB_EXT]    = dma_slave[i].req;
      assign s_dma_bus_wdata[i+NB_EXT]  = dma_slave[i].wdata;
      assign s_dma_bus_wen[i+NB_EXT]    = dma_slave[i].wen;
      assign s_dma_bus_be[i+NB_EXT]     = dma_slave[i].be;

      assign dma_slave[i].gnt      = s_dma_bus_gnt[i+NB_EXT];
      assign dma_slave[i].r_valid  = s_dma_bus_r_valid[i+NB_EXT];
      assign dma_slave[i].r_rdata  = s_dma_bus_r_rdata[i+NB_EXT];
    end
  endgenerate

  // start modifying from here for atomics



  //-********************************************************
  //-*********** LOGARITHMIC INTERCONNECT TO TCDM ***********
  //-********************************************************
  localparam NUM_TCDM_ICONN_IN = NB_CORES + NB_HWPE_PORTS + NB_DMAS + NB_EXT;
  typedef struct packed {
    logic [DATA_WIDTH-1:0]  data;
    logic [5:0]             atop;
  } tcdm_data_t;
  tcdm_data_t [NUM_TCDM_ICONN_IN-1:0] iconn_inp_wdata, iconn_inp_rdata;
  tcdm_data_t     [NB_TCDM_BANKS-1:0] iconn_oup_wdata, iconn_oup_rdata;

  tcdm_interconnect #(
    .NumIn        ( NUM_TCDM_ICONN_IN           ),
    .NumOut       ( NB_TCDM_BANKS              ),
    .AddrWidth    ( ADDR_WIDTH                  ),
    .DataWidth    ( $bits(tcdm_data_t)          ),
    .ByteOffWidth ( $clog2(DATA_WIDTH-1)-3      ), // determine byte offset from real data width
    .AddrMemWidth ( ADDR_MEM_WIDTH              ),
    .WriteRespOn  ( 1                           ),
    .RespLat      ( 1                           ),
    .Topology     ( tcdm_interconnect_pkg::LIC  )
  ) i_tcdm_interconnect (
    .clk_i,
    .rst_ni,

    .req_i    ( { s_dma_bus_req,      s_core_tcdm_bus_req}      ),
    .add_i    ( { s_dma_bus_add,      s_core_tcdm_bus_add}      ),
    .wen_i    ( { s_dma_bus_wen,      s_core_tcdm_bus_wen}      ),
    .wdata_i  ( iconn_inp_wdata                                 ),
    .be_i     ( { s_dma_bus_be,       s_core_tcdm_bus_be}       ),
    .gnt_o    ( { s_dma_bus_gnt,      s_core_tcdm_bus_gnt}      ),
    .vld_o    ( { s_dma_bus_r_valid,  s_core_tcdm_bus_r_valid}  ),
    .rdata_o  ( iconn_inp_rdata                                 ),

    .req_o    ( s_tcdm_bus_amo_shim_req                         ),
    .gnt_i    ( s_tcdm_bus_amo_shim_gnt                         ),
    .add_o    ( s_tcdm_bus_amo_shim_add                         ),
    .wen_o    ( s_tcdm_bus_amo_shim_wen                         ),
    .wdata_o  ( iconn_oup_wdata                                 ),
    .be_o     ( s_tcdm_bus_amo_shim_be                          ),
    .rdata_i  ( iconn_oup_rdata                                 )
  );

  for (genvar i = 0; i < NUM_TCDM_ICONN_IN; i++) begin : gen_iconn_pack_inp_data
    if (i < NB_CORES + NB_HWPE_PORTS) begin
      assign iconn_inp_wdata[i].data = s_core_tcdm_bus_wdata[i];
      assign s_core_tcdm_bus_r_rdata[i] = iconn_inp_rdata[i].data;
    end else begin
      assign iconn_inp_wdata[i].data = s_dma_bus_wdata[i - (NB_CORES + NB_HWPE_PORTS)];
      assign s_dma_bus_r_rdata[i - (NB_CORES + NB_HWPE_PORTS)] = iconn_inp_rdata[i].data;
    end
    if (i < NB_CORES) begin
      assign iconn_inp_wdata[i].atop = core_tcdm_slave_atop[i];
    end else if (i < NB_CORES + NB_EXT) begin
      assign iconn_inp_wdata[i].atop = ext_slave_atop[i-NB_CORES];
    end else begin
      assign iconn_inp_wdata[i].atop = '0;
    end
  end

  for (genvar i = 0; i < NB_TCDM_BANKS; i++) begin : gen_amo_shim
    // Map ATOPs by CV32E40Ps to AMOs.
    logic [DATA_WIDTH-1:0] data;
    logic [5:0] atop;
    logic [3:0] amo;
    assign atop = iconn_oup_wdata[i].atop;
    always_comb begin
      amo = '0;
      data = iconn_oup_wdata[i].data;
      if (atop[5]) begin
        unique casez (atop[4:0])
          cv32e40p_pkg::AMO_ADD:   amo = 4'h2;
          cv32e40p_pkg::AMO_SWAP:  amo = 4'h1;
          cv32e40p_pkg::AMO_LR:    `ifndef SYNTHESIS $error("Unsupported LR on L1!") `endif;
          cv32e40p_pkg::AMO_SC:    `ifndef SYNTHESIS $error("Unsupported SC on L1!") `endif;
          default: begin
            `ifndef SYNTHESIS
              assert (atop[1:0] == '0) else $error("Illegal AMO!");
            `endif
            unique case (atop[4:2])
              cv32e40p_pkg::AMO_XOR[4:2]:  amo = 4'h5;
              cv32e40p_pkg::AMO_OR[4:2]:   amo = 4'h4;
              cv32e40p_pkg::AMO_AND[4:2]:  amo = 4'h3;
              cv32e40p_pkg::AMO_MIN[4:2]:  amo = 4'h8;
              cv32e40p_pkg::AMO_MAX[4:2]:  amo = 4'h6;
              cv32e40p_pkg::AMO_MINU[4:2]: amo = 4'h9;
              cv32e40p_pkg::AMO_MAXU[4:2]: amo = 4'h7;
            endcase
          end
        endcase
      end else begin
        amo = 4'h0; // AMONone
      end
    end
    logic write_enable;
    logic [ADDR_MEM_WIDTH+2-1:0] addr;
    amo_shim #(
      .AddrMemWidth (ADDR_MEM_WIDTH+2),
      .DataWidth    (DATA_WIDTH)
    ) i_amo_shim (
      .clk_i,
      .rst_ni,

      .in_req_i     (s_tcdm_bus_amo_shim_req[i]),
      .in_gnt_o     (s_tcdm_bus_amo_shim_gnt[i]),
      .in_add_i     ({s_tcdm_bus_amo_shim_add[i], 2'b00}),
      .in_amo_i     (amo),
      .in_wen_i     (~s_tcdm_bus_amo_shim_wen[i]), // 0 = write, 1 = read
      .in_wdata_i   (data),
      .in_be_i      (s_tcdm_bus_amo_shim_be[i]),
      .in_rdata_o   (iconn_oup_rdata[i].data),

      .out_req_o    (tcdm_sram_master[i].req),
      .out_add_o    (addr),
      .out_wen_o    (write_enable),
      .out_wdata_o  (tcdm_sram_master[i].wdata),
      .out_be_o     (tcdm_sram_master[i].be),
      .out_rdata_i  (tcdm_sram_master[i].rdata)
    );
    assign iconn_oup_rdata[i].atop = '0;
    always_comb begin
      tcdm_sram_master[i].add = '0;
      tcdm_sram_master[i].add[ADDR_MEM_WIDTH-1:0] = addr[ADDR_MEM_WIDTH+2-1:2];
    end
    assign tcdm_sram_master[i].wen = ~write_enable;
  end // block: gen_amo_shim


  //********************************************************
  //******* LOGARITHMIC INTERCONNECT TO PERIPHERALS ********
  //********************************************************
  xbar_pe_wrap
  #(
    .NB_CORES           ( NB_CORES             ),
    .NB_MPERIPHS        ( NB_MPERIPHS          ),
    .NB_SPERIPHS        ( NB_SPERIPHS          ),

    .ADDR_WIDTH         ( ADDR_WIDTH           ),
    .DATA_WIDTH         ( DATA_WIDTH           ),
    .BE_WIDTH           ( BE_WIDTH             ),
    .PE_ROUTING_LSB     ( PE_ROUTING_LSB       ),
    .PE_ROUTING_MSB     ( PE_ROUTING_MSB       ),
    .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE   )
   )
   xbar_pe_inst
   (
    .clk_i            ( clk_i ),
    .rst_ni           ( rst_ni),
    .core_periph_slave( core_periph_slave),
    .core_periph_slave_atop(core_periph_slave_atop),
    .speriph_master   ( speriph_master   ),
    .speriph_master_atop( speriph_master_atop ),
    .mperiph_slave    ( mperiph_slave    )
    );


endmodule
