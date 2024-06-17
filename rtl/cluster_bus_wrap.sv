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


`include "axi/assign.svh"
`include "axi/typedef.svh"

module cluster_bus_wrap
    import axi_pkg::xbar_cfg_t;
#(
  parameter  int unsigned               NB_MASTER              = 3         ,
  parameter  int unsigned               NB_SLAVE               = 4         ,
  parameter  int unsigned               NB_CORES               = 12        ,
  parameter  int unsigned               AXI_ADDR_WIDTH         = 48        ,
  parameter  int unsigned               AXI_DATA_WIDTH         = 64        ,
  parameter  int unsigned               AXI_ID_IN_WIDTH        = 4         ,
  parameter  int unsigned               AXI_ID_OUT_WIDTH       = 6         ,
  parameter  int unsigned               AXI_USER_WIDTH         = 10        ,
  parameter  int unsigned               DMA_NB_OUTSND_BURSTS   = 8         ,
  parameter  int unsigned               TCDM_SIZE              = 256*1024  ,
  parameter  logic [AXI_ADDR_WIDTH-1:0] BaseAddr               = 'h50000000,
  parameter  logic [AXI_ADDR_WIDTH-1:0] ClusterPeripheralsOffs = 'h00200000,
  parameter  logic [AXI_ADDR_WIDTH-1:0] ClusterExternalOffs    = 'h00400000,
  localparam int unsigned               STRB                   = AXI_DATA_WIDTH/8,
  localparam type                       axi_aw_t               = logic[AXI_ADDR_WIDTH-1:0],
  localparam type                       axi_dw_t               = logic[AXI_DATA_WIDTH-1:0],
  localparam type                       axi_uw_t               = logic[AXI_USER_WIDTH-1:0],
  localparam type                       axi_slv_iw_t           = logic[AXI_ID_IN_WIDTH-1:0],
  localparam type                       axi_mst_iw_t           = logic[AXI_ID_OUT_WIDTH-1:0],
  localparam type                       axi_strbw_t            = logic[STRB-1:0]
)(
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

  `AXI_TYPEDEF_ALL_CT(xbar_slv, xbar_slv_req_t, xbar_slv_rsp_t, axi_aw_t, axi_slv_iw_t, axi_dw_t, axi_strbw_t, axi_uw_t)
  `AXI_TYPEDEF_ALL_CT(xbar_mst, xbar_mst_req_t, xbar_mst_rsp_t, axi_aw_t, axi_mst_iw_t, axi_dw_t, axi_strbw_t, axi_uw_t)

  //Ensure that AXI_ID out width has the correct size with an elaboration system task
  if (AXI_ID_OUT_WIDTH < AXI_ID_IN_WIDTH + $clog2(NB_SLAVE))
    $error("ID width of AXI output ports is to small. The output id width must be input ID width + clog2(<nr slave ports>) which is %d but it was %d", AXI_ID_IN_WIDTH + $clog2(NB_SLAVE), AXI_ID_OUT_WIDTH);
  else if (AXI_ID_OUT_WIDTH > AXI_ID_IN_WIDTH + $clog2(NB_SLAVE))
    $warning("ID width of the AXI output port has the wrong length. It is larger than the required value. Trim it to the right length to get rid of this warning.");

  // if (AXI_ADDR_WIDTH != 48)
  //   $fatal(1,"Address map is only defined for 48-bit addresses!");
  if (TCDM_SIZE == 0)
    $fatal(1,"TCDM size must be non-zero!");
  if (TCDM_SIZE >2048*1024) // Periph start address is at offset 0x0020_0000, which actually allows for up to 2 MiB of TCDM,
                            // do not know why to trigger te assertion for more than 128 KiB TCDM size...
    $fatal(1,"TCDM size exceeds available address space in cluster bus!");

  // Crossbar
  /***************/
  /* Slave buses */
  /***************/
  xbar_slv_req_t [NB_SLAVE-1:0] slave_req;
  xbar_slv_rsp_t [NB_SLAVE-1:0] slave_rsp;
  // data_slv -> slave_req[0]
  // data_slv <- slave_rsp[0]
  `AXI_ASSIGN_TO_REQ(slave_req[0], data_slave)
  `AXI_ASSIGN_FROM_RESP(data_slave, slave_rsp[0])
  // instr_slv -> slave_req[1]
  // instr_slv <- slave_rsp[1]
  `AXI_ASSIGN_TO_REQ(slave_req[1], instr_slave)
  `AXI_ASSIGN_FROM_RESP(instr_slave, slave_rsp[1])
  // dma_slv -> slave_req[2]
  // dma_slv <- slave_rsp[2]
  `AXI_ASSIGN_TO_REQ(slave_req[2], dma_slave)
  `AXI_ASSIGN_FROM_RESP(dma_slave, slave_rsp[2])
  // ext_slv -> slave_req[3]
  // ext_slv <- slave_rsp[3]
  `AXI_ASSIGN_TO_REQ(slave_req[3], ext_slave)
  `AXI_ASSIGN_FROM_RESP(ext_slave, slave_rsp[3])

  /****************/
  /* Master buses */
  /****************/
  xbar_mst_req_t [NB_MASTER-1:0] master_req;
  xbar_mst_rsp_t [NB_MASTER-1:0] master_rsp;
  // tcdm_master <- master_req[0]
  // tcdm_master -> master_rsp[0]
  `AXI_ASSIGN_FROM_REQ(tcdm_master, master_req[0])
  `AXI_ASSIGN_TO_RESP(master_rsp[0], tcdm_master)
  // periph_master <- master_req[1]
  // periph_master -> master_rsp[1]
  `AXI_ASSIGN_FROM_REQ(periph_master, master_req[1])
  `AXI_ASSIGN_TO_RESP(master_rsp[1], periph_master)
  // ext_master <- master_req[2]
  // ext_master -> master_rsp[2]
  `AXI_ASSIGN_FROM_REQ(ext_master, master_req[2])
  `AXI_ASSIGN_TO_RESP(master_rsp[2], ext_master)
  
  // Address Map Rule
  typedef struct packed {
      logic [AXI_ADDR_WIDTH-1:0] idx       ;
      logic [AXI_ADDR_WIDTH-1:0] start_addr;
      logic [AXI_ADDR_WIDTH-1:0] end_addr  ;
  } addr_map_rule_t;

  // address map
  logic [AXI_ADDR_WIDTH-1:0] cluster_base_addr;
  assign cluster_base_addr = BaseAddr + ( cluster_id_i << 22);
  localparam int unsigned N_RULES = 4;
  addr_map_rule_t [N_RULES-1:0] addr_map;

  assign addr_map[0] = '{ // TCDM
    idx:  0,
    start_addr: cluster_base_addr,
    end_addr:   cluster_base_addr + TCDM_SIZE
  };
  assign addr_map[1] = '{ // Peripherals
    idx:  1,
    start_addr: cluster_base_addr + ClusterPeripheralsOffs,
    end_addr:   cluster_base_addr + ClusterExternalOffs
  };
  assign addr_map[2] = '{ // everything above cluster to ext_slave
    idx:  2,
    start_addr: cluster_base_addr + ClusterExternalOffs,
    end_addr:   32'hFFFF_FFFF
  };
  assign addr_map[3] = '{ // everything below cluster
    idx:  2,
    start_addr: 'h0,
    end_addr:   cluster_base_addr
  };
    
  localparam int unsigned MAX_TXNS_PER_SLV_PORT = (DMA_NB_OUTSND_BURSTS > NB_CORES) ?
                                                    DMA_NB_OUTSND_BURSTS : NB_CORES;

  localparam xbar_cfg_t AXI_XBAR_CFG = '{
    NoSlvPorts: NB_SLAVE,
    NoMstPorts: NB_MASTER,
    MaxMstTrans: MAX_TXNS_PER_SLV_PORT,       //The TCDM ports do not support
    //outstanding transactiions anyways
    MaxSlvTrans: DMA_NB_OUTSND_BURSTS + NB_CORES,       //Allow up to 4 in-flight transactions
    //per slave port
    FallThrough: 1'b0,       //Use the reccomended default config 
    LatencyMode: axi_pkg::CUT_MST_AX, // axi_pkg::CUT_ALL_AX | axi_pkg::DemuxW,
    PipelineStages: 0,
    AxiIdWidthSlvPorts: AXI_ID_IN_WIDTH,
    AxiIdUsedSlvPorts: AXI_ID_IN_WIDTH,
    UniqueIds: 1'b0,
    AxiAddrWidth: AXI_ADDR_WIDTH,
    AxiDataWidth: AXI_DATA_WIDTH,
    NoAddrRules: N_RULES
  };

  axi_xbar #(
    .Cfg            ( AXI_XBAR_CFG  ),
    .slv_aw_chan_t  ( xbar_slv_aw_chan_t ),
    .mst_aw_chan_t  ( xbar_mst_aw_chan_t ),
    .w_chan_t       ( xbar_mst_w_chan_t  ),
    .slv_b_chan_t   ( xbar_slv_b_chan_t  ),
    .mst_b_chan_t   ( xbar_mst_b_chan_t  ),
    .slv_ar_chan_t  ( xbar_slv_ar_chan_t ),
    .mst_ar_chan_t  ( xbar_mst_ar_chan_t ),
    .slv_r_chan_t   ( xbar_slv_r_chan_t  ),
    .mst_r_chan_t   ( xbar_mst_r_chan_t  ),
    .slv_req_t      ( xbar_slv_req_t     ),
    .slv_resp_t     ( xbar_slv_rsp_t     ),
    .mst_req_t      ( xbar_mst_req_t     ),
    .mst_resp_t     ( xbar_mst_rsp_t     ),
    .rule_t         ( addr_map_rule_t   )
  ) i_xbar          (
    .clk_i,
    .rst_ni,
    .test_i                 ( test_en_i  ),
    .slv_ports_req_i        ( slave_req  ),
    .slv_ports_resp_o       ( slave_rsp  ),
    .mst_ports_req_o        ( master_req ),
    .mst_ports_resp_i       ( master_rsp ),
    .addr_map_i             ( addr_map   ),
    .en_default_mst_port_i  ( '0         ),
    .default_mst_port_i     ( '0         )
  );

endmodule


