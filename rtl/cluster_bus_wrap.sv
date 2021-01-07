// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/*
 * cluster_bus_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

`include "pulp_soc_defines.sv"
`include "cluster_bus_defines.sv"
`include "axi/assign.svh"
`include "axi/typedef.svh"


module cluster_bus_wrap
    import axi_pkg::xbar_cfg_t;
#(
  parameter NB_CORES              = 4 ,
  parameter AXI_ADDR_WIDTH        = 32,
  parameter AXI_DATA_WIDTH        = 64,
  parameter AXI_ID_IN_WIDTH       = 4 ,
  parameter AXI_ID_OUT_WIDTH      = 6 ,
  parameter AXI_USER_WIDTH        = 6 ,
  parameter DMA_NB_OUTSND_BURSTS  = 8 ,
  parameter TCDM_SIZE             = 0

)
(
  input logic       clk_i,
  input logic       rst_ni,
  input logic       test_en_i,
  input logic [5:0] cluster_id_i,
  AXI_BUS.Slave     data_slave,
  AXI_BUS.Slave     instr_slave,
  AXI_BUS.Slave     dma_slave,
  AXI_BUS.Slave     ext_slave,
  //INITIATOR
  AXI_BUS.Master    tcdm_master,
  AXI_BUS.Master    periph_master,
  AXI_BUS.Master    ext_master
);

  localparam AXI_STRB_WIDTH = AXI_DATA_WIDTH/8;
  localparam NB_MASTER      = `NB_MASTER;
  localparam NB_SLAVE       = `NB_SLAVE;
  localparam NB_REGION      = `NB_REGION;

  
  typedef logic [AXI_ID_OUT_WIDTH -1:0] id_mst_t;
  typedef logic [AXI_ID_IN_WIDTH  -1:0] id_slv_t;
  typedef logic [AXI_ADDR_WIDTH   -1:0] addr_t;
  typedef logic [AXI_DATA_WIDTH   -1:0] data_t;
  typedef logic [AXI_DATA_WIDTH/8 -1:0] strb_t;
  typedef logic [AXI_USER_WIDTH   -1:0] user_t;
  `AXI_TYPEDEF_AW_CHAN_T ( mst_aw_chan_t, addr_t, id_mst_t,         user_t)
  `AXI_TYPEDEF_AW_CHAN_T ( slv_aw_chan_t, addr_t, id_slv_t,         user_t)
  `AXI_TYPEDEF_W_CHAN_T  (      w_chan_t, data_t,           strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T  (  mst_b_chan_t,         id_mst_t,         user_t)
  `AXI_TYPEDEF_B_CHAN_T  (  slv_b_chan_t,         id_slv_t,         user_t)
  `AXI_TYPEDEF_AR_CHAN_T ( mst_ar_chan_t, addr_t, id_mst_t,         user_t)
  `AXI_TYPEDEF_AR_CHAN_T ( slv_ar_chan_t, addr_t, id_slv_t,         user_t)
  `AXI_TYPEDEF_R_CHAN_T  (  mst_r_chan_t, data_t, id_mst_t,         user_t)
  `AXI_TYPEDEF_R_CHAN_T  (  slv_r_chan_t, data_t, id_slv_t,         user_t)
  `AXI_TYPEDEF_REQ_T     (     mst_req_t, mst_aw_chan_t, w_chan_t, mst_ar_chan_t)
  `AXI_TYPEDEF_REQ_T     (     slv_req_t, slv_aw_chan_t, w_chan_t, slv_ar_chan_t)
  `AXI_TYPEDEF_RESP_T    (    mst_resp_t,  mst_b_chan_t, mst_r_chan_t)
  `AXI_TYPEDEF_RESP_T    (    slv_resp_t,  slv_b_chan_t, slv_r_chan_t)
  mst_req_t   [NB_MASTER-1:0] mst_reqs;
  mst_resp_t  [NB_MASTER-1:0] mst_resps;
  slv_req_t   [NB_SLAVE -1:0] slv_reqs;
  slv_resp_t  [NB_SLAVE -1:0] slv_resps;

  // Binding of Master Ports
  `AXI_ASSIGN_FROM_REQ  (tcdm_master,   mst_reqs[0]   );
  `AXI_ASSIGN_TO_RESP   (mst_resps[0],  tcdm_master   );
  `AXI_ASSIGN_FROM_REQ  (periph_master, mst_reqs[1]   );
  `AXI_ASSIGN_TO_RESP   (mst_resps[1],  periph_master );
  `AXI_ASSIGN_FROM_REQ  (ext_master,    mst_reqs[2]   );
  `AXI_ASSIGN_TO_RESP   (mst_resps[2],  ext_master    );

  // Binding of Slave Ports
  `AXI_ASSIGN_TO_REQ    (slv_reqs[0],   ext_slave     );
  `AXI_ASSIGN_FROM_RESP (ext_slave,     slv_resps[0]  );
  `AXI_ASSIGN_TO_REQ    (slv_reqs[1],   dma_slave     );
  `AXI_ASSIGN_FROM_RESP (dma_slave,     slv_resps[1]  );
  `AXI_ASSIGN_TO_REQ    (slv_reqs[2],   data_slave    );
  `AXI_ASSIGN_FROM_RESP (data_slave,    slv_resps[2]  );
  `AXI_ASSIGN_TO_REQ    (slv_reqs[3],   instr_slave   );
  `AXI_ASSIGN_FROM_RESP (instr_slave,   slv_resps[3]  );

  // Address Map
  addr_t cluster_base_addr;
  assign cluster_base_addr = 32'h1000_0000 + ( cluster_id_i << 22);
  localparam int unsigned N_RULES = 4;
  axi_pkg::xbar_rule_32_t [N_RULES-1:0] addr_map;
  assign addr_map[0] = '{ // everything below cluster to ext_slave
    idx:  2,
    start_addr: 32'h0000_0000,
    end_addr:   cluster_base_addr
  };
  assign addr_map[1] = '{ // everything above cluster to ext_slave
    idx:  2,
    start_addr: cluster_base_addr + 32'h0040_0000,
    end_addr:   32'hFFFF_FFFF
  };
  assign addr_map[2] = '{ // TCDM
    idx:  0,
    start_addr: cluster_base_addr,
    end_addr:   cluster_base_addr + TCDM_SIZE
  };
  assign addr_map[3] = '{ // Peripherals
    idx:  1,
    start_addr: cluster_base_addr + 32'h0020_0000,
    end_addr:   cluster_base_addr + 32'h0040_0000
  };
  // pragma translate_off
  `ifndef VERILATOR
    initial begin
      assert (AXI_ADDR_WIDTH == 32)
        else $fatal("Address map is only defined for 32-bit addresses!");
      assert (TCDM_SIZE <= 128*1024)
        else $fatal(1, "TCDM size exceeds available address space in cluster bus!");
      assert (TCDM_SIZE > 0)
        else $fatal(1, "TCDM size must be non-zero!");
      assert (AXI_ID_IN_WIDTH + $clog2(NB_SLAVE) <= AXI_ID_OUT_WIDTH)
        else $fatal(1, "Insufficient AXI_ID_OUT_WIDTH!");
    end
  `endif
  // pragma translate_on

  // Crossbar
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH  ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH  )
  ) slv_intf [NB_SLAVE-1:0]();
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH  ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH    )
  ) mst_intf [NB_MASTER-1:0]();
  for (genvar i = 0; i < NB_SLAVE; i++) begin : gen_assign_slv
    `AXI_ASSIGN_FROM_REQ(slv_intf[i], slv_reqs[i])
    `AXI_ASSIGN_TO_RESP(slv_resps[i], slv_intf[i])
  end
  for (genvar i = 0; i < NB_MASTER; i++) begin : gen_assign_mst
    `AXI_ASSIGN_TO_REQ(mst_reqs[i], mst_intf[i])
    `AXI_ASSIGN_FROM_RESP(mst_intf[i], mst_resps[i])
  end
  localparam int unsigned MAX_TXNS_PER_SLV_PORT = (DMA_NB_OUTSND_BURSTS > NB_CORES) ?
                                                    DMA_NB_OUTSND_BURSTS : NB_CORES;


    localparam xbar_cfg_t AXI_XBAR_CFG = '{
                                                    NoSlvPorts: NB_SLAVE,
                                                    NoMstPorts: NB_MASTER,
                                                    MaxMstTrans: MAX_TXNS_PER_SLV_PORT,       //The TCDM ports do not support
                                                    //outstanding transactiions anyways
                                                    MaxSlvTrans: DMA_NB_OUTSND_BURSTS + NB_CORES,       //Allow up to 4 in-flight transactions
                                                    //per slave port
                                                    FallThrough: 1'b0,       //Use the reccomended default config (for pulp_soc_interconnect is 1)
                                                    LatencyMode: axi_pkg::CUT_ALL_AX | axi_pkg::DemuxW,
                                                    AxiIdWidthSlvPorts: AXI_ID_IN_WIDTH,
                                                    AxiIdUsedSlvPorts: AXI_ID_IN_WIDTH,
                                                    AxiAddrWidth: AXI_ADDR_WIDTH,
                                                    AxiDataWidth: AXI_DATA_WIDTH,
                                                    NoAddrRules: N_RULES
                                                    };

  axi_xbar_intf #(
    .AXI_USER_WIDTH         ( AXI_USER_WIDTH                        ),
    .Cfg                   (AXI_XBAR_CFG                           ),
    .rule_t                 ( axi_pkg::xbar_rule_32_t               )
  ) i_xbar (
    .clk_i,
    .rst_ni,
    .test_i                 (test_en_i),
    .slv_ports              (slv_intf),
    .mst_ports              (mst_intf),
    .addr_map_i             (addr_map),
    .en_default_mst_port_i  ('0), // disable default master port for all slave ports
    .default_mst_port_i     ('0)
  );

endmodule


