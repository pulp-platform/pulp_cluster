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
 * pulp_cluster.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 * Angelo Garofalo <angelo.garofalo@unibo.it>
 */

`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "cluster_bus_defines.sv"
`include "pulp_interfaces.sv"
`include "register_interface/typedef.svh"

module pulp_cluster
  import pulp_cluster_package::*;
  import hci_package::*;
  import rapid_recovery_pkg::*;
  import fpnew_pkg::*;
#(
  parameter  pulp_cluster_package::pulp_cluster_cfg_t Cfg = pulp_cluster_package::PulpClusterDefaultCfg,
  localparam int unsigned TcdmBankSize = Cfg.TcdmSize/Cfg.TcdmNumBank,
  localparam int unsigned TcdmNumRows  = TcdmBankSize/4,
  localparam int unsigned MaxUniqId = 1,
  localparam int unsigned AxiIdInWidth = pulp_cluster_package::AxiSubordinateIdwidth,
  localparam int unsigned AxiIdOutWidth = pulp_cluster_package::AxiManagerIdwidth,
  // CDC AXI parameters (external to cluster)
  localparam int unsigned AwInWidth = axi_pkg::aw_width(Cfg.AxiAddrWidth,
                                                        Cfg.AxiIdInWidth,
                                                        Cfg.AxiUserWidth),
  localparam int unsigned WInWidth = axi_pkg::w_width(Cfg.AxiDataInWidth,
                                                      Cfg.AxiUserWidth),
  localparam int unsigned BInWidth = axi_pkg::b_width(Cfg.AxiIdInWidth,
                                                      Cfg.AxiUserWidth),
  localparam int unsigned ArInWidth = axi_pkg::ar_width(Cfg.AxiAddrWidth,
                                                        Cfg.AxiIdInWidth,
                                                        Cfg.AxiUserWidth),
  localparam int unsigned RInWidth = axi_pkg::r_width(Cfg.AxiDataInWidth,
                                                      Cfg.AxiIdInWidth,
                                                      Cfg.AxiUserWidth),
  localparam int unsigned AsyncInAwDatawidth = (2**Cfg.AxiCdcLogDepth)*AwInWidth,
  localparam int unsigned AsyncInWDatawidth  = (2**Cfg.AxiCdcLogDepth)*WInWidth,
  localparam int unsigned AsyncInBDataWidth  = (2**Cfg.AxiCdcLogDepth)*BInWidth,
  localparam int unsigned AsyncInArDatawidth = (2**Cfg.AxiCdcLogDepth)*ArInWidth,
  localparam int unsigned AsyncInRDataWidth  = (2**Cfg.AxiCdcLogDepth)*RInWidth,
  // CDC AXI parameters (cluster to external)
  localparam int unsigned AwOutWidth = axi_pkg::aw_width(Cfg.AxiAddrWidth,
                                                         Cfg.AxiIdOutWidth,
                                                         Cfg.AxiUserWidth),
  localparam int unsigned WOutWidth = axi_pkg::w_width(Cfg.AxiDataOutWidth,
                                                       Cfg.AxiUserWidth),
  localparam int unsigned BOutWidth = axi_pkg::b_width(Cfg.AxiIdOutWidth,
                                                       Cfg.AxiUserWidth),
  localparam int unsigned ArOutWidth = axi_pkg::ar_width(Cfg.AxiAddrWidth,
                                                         Cfg.AxiIdOutWidth,
                                                         Cfg.AxiUserWidth),
  localparam int unsigned ROutWidth = axi_pkg::r_width(Cfg.AxiDataOutWidth,
                                                       Cfg.AxiIdOutWidth,
                                                       Cfg.AxiUserWidth),
  localparam int unsigned AsyncOutAwDataWidth = (2**Cfg.AxiCdcLogDepth)*AwOutWidth,
  localparam int unsigned AsyncOutWDataWidth  = (2**Cfg.AxiCdcLogDepth)*WOutWidth,
  localparam int unsigned AsyncOutBDataWidth  = (2**Cfg.AxiCdcLogDepth)*BOutWidth,
  localparam int unsigned AsyncOutArDataWidth = (2**Cfg.AxiCdcLogDepth)*ArOutWidth,
  localparam int unsigned AsyncOutRDataWidth  = (2**Cfg.AxiCdcLogDepth)*ROutWidth,
  // Internal bus parameters
  // TCDM data bus width (never changes)
  localparam int unsigned DataWidth = 32,
  // TCDM address bus width (never changes)
  localparam int unsigned AddrWidth = 32,
  // TCDM bank enable width (never changes)
  localparam int unsigned BeWidth = DataWidth/8,
  // Indicates a test-and-set operation during a load in TCDM
  localparam int unsigned TestSetBit = 20,
  // Word address width per TCDM bank
  localparam int unsigned AddrMemWidth= $clog2(TcdmNumRows),
  // Byte address width of TCDM
  localparam int unsigned TcdmAddrWidth = AddrMemWidth + $clog2(Cfg.TcdmNumBank) + 2,
  // Synchronous event bus size
  localparam int unsigned EventWidth = 8,
  // Asynchronous event bus size
  localparam int unsigned AsyncEventDataWidth = (2**Cfg.AxiCdcLogDepth)*EventWidth,
  // LSB used as routing BIT in periph interco
  localparam int unsigned PeRoutingLsb = 10,
  // FPU bus parameters
  localparam int unsigned FpuNumArgs = 3,
  localparam int unsigned FpuOpCodeWidth = 6,
  localparam int unsigned FpuTypeWidth = 3,
  localparam int unsigned FpuInFlagsWidth = 15,
  localparam int unsigned FpuOutFlagsWidth = 5,
  // Number of parity bits for ECC in memory banks
  localparam int unsigned ParityWidth = 7,
  // Number of parity bits for metadata in ECC-extended HCI
  localparam int unsigned MetaParityWidth = $clog2( AddrMemWidth+2 + BeWidth +1 ) + 2,
  // TCDM banks data width extended with parity for ECCs
  localparam int unsigned ProtectedTcdmWidth = DataWidth + ParityWidth,
  // Number of parity bits for ECC-extended HCI HWPE branch
  localparam int unsigned HWPEParityWidth = ($clog2(DataWidth)+2)*Cfg.HwpeNumPorts + ($clog2(AddrWidth+(Cfg.HwpeNumPorts*DataWidth)/8+1)+2)
)(
  input logic                                    clk_i,
  input logic                                    rst_ni,
  input logic                                    ref_clk_i,
  input logic                                    pwr_on_rst_ni,
  input logic                                    pmu_mem_pwdn_i,


  input logic [3:0]                              base_addr_i,

  input logic                                    test_mode_i,

  input logic                                    en_sa_boot_i,

  input logic [5:0]                              cluster_id_i,

  input logic                                    fetch_en_i,

  output logic                                   eoc_o,

  output logic                                   busy_o,

  input  logic                                   axi_isolate_i,
  output logic                                   axi_isolated_o,

  input logic                                    dma_pe_evt_ack_i,
  output logic                                   dma_pe_evt_valid_o,

  input logic                                    dma_pe_irq_ack_i,
  output logic                                   dma_pe_irq_valid_o,

  input logic                                    pf_evt_ack_i,
  output logic                                   pf_evt_valid_o,

  input logic [Cfg.NumCores-1:0]                 dbg_irq_valid_i,

  input logic                                    mbox_irq_i,

  input  logic [Cfg.AxiCdcLogDepth:0]            async_cluster_events_wptr_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_cluster_events_rptr_o,
  input  logic [AsyncEventDataWidth-1:0]         async_cluster_events_data_i,


  // AXI4 SLAVE
  //***************************************
  // WRITE ADDRESS CHANNEL
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_aw_wptr_i,
  input  logic [AsyncInAwDatawidth-1:0]          async_data_slave_aw_data_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_aw_rptr_o,

  // READ ADDRESS CHANNEL
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_ar_wptr_i,
  input  logic [AsyncInArDatawidth-1:0]          async_data_slave_ar_data_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_ar_rptr_o,

  // WRITE DATA CHANNEL
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_w_wptr_i,
  input  logic [AsyncInWDatawidth-1:0]           async_data_slave_w_data_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_w_rptr_o,

  // READ DATA CHANNEL
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_r_wptr_o,
  output logic [AsyncInRDataWidth-1:0]           async_data_slave_r_data_o,
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_r_rptr_i,

  // WRITE RESPONSE CHANNEL
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_b_wptr_o,
  output logic [AsyncInBDataWidth-1:0]           async_data_slave_b_data_o,
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_slave_b_rptr_i,
  // AXI4 MASTER
  //***************************************
  // WRITE ADDRESS CHANNEL
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_master_aw_wptr_o,
  output logic [AsyncOutAwDataWidth-1:0]         async_data_master_aw_data_o,
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_master_aw_rptr_i,

  // READ ADDRESS CHANNEL
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_master_ar_wptr_o,
  output logic [AsyncOutArDataWidth-1:0]         async_data_master_ar_data_o,
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_master_ar_rptr_i,

  // WRITE DATA CHANNEL
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_master_w_wptr_o,
  output logic [AsyncOutWDataWidth-1:0]          async_data_master_w_data_o,
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_master_w_rptr_i,

  // READ DATA CHANNEL
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_master_r_wptr_i,
  input  logic [AsyncOutRDataWidth-1:0]          async_data_master_r_data_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_master_r_rptr_o,

  // WRITE RESPONSE CHANNEL
  input  logic [Cfg.AxiCdcLogDepth:0]            async_data_master_b_wptr_i,
  input  logic [AsyncOutBDataWidth-1:0]          async_data_master_b_data_i,
  output logic [Cfg.AxiCdcLogDepth:0]            async_data_master_b_rptr_o
);

//Ensure that the input AXI ID width is big enough to accomodate the accomodate the IDs of internal wiring
if (Cfg.AxiIdInWidth < 1 + $clog2(Cfg.iCacheNumBanks))
  $info("AXI input ID width must be larger than 1+$clog2(Cfg.iCacheNumBanks) which is %d but was %d", 1 + $clog2(Cfg.iCacheNumBanks), Cfg.AxiIdInWidth);

localparam int unsigned NB_L1_CUTS      = 16;
localparam int unsigned RW_MARGIN_WIDTH = 4;
`ifdef FEATURE_ICACHE_STAT
  localparam bit          FEATURE_STAT    = 1'b1;
`else
  localparam bit          FEATURE_STAT    = 1'b0;
`endif

//********************************************************
//***************** SIGNALS DECLARATION ******************
//********************************************************

logic [Cfg.NumCores-1:0]                fetch_enable_reg_int;
logic [Cfg.NumCores-1:0]                fetch_en_int;
logic [Cfg.NumCores-1:0][AddrWidth-1:0] boot_addr;
logic [Cfg.NumCores-1:0]                dbg_core_halt;
logic [Cfg.NumCores-1:0]                dbg_core_resume;
logic [Cfg.NumCores-1:0]                dbg_core_halted;
logic [Cfg.NumCores-1:0]                dbg_core_havereset;
logic [Cfg.NumCores-1:0]                dbg_core_running;
logic [Cfg.NumCores-1:0]                s_dbg_irq;
logic                                   s_hwpe_en;
logic [$clog2(MAX_NUM_HWPES)-1:0]       s_hwpe_sel;

logic                     fetch_en_synch;
logic                     en_sa_boot_synch;
logic                     axi_isolate_synch;
logic                     eoc_synch;

logic                     s_cluster_periphs_busy;
logic                     s_axi2mem_busy;
logic                     s_per2axi_busy;
logic                     s_axi2per_busy;
logic                     s_dmac_busy;
logic                     s_cluster_cg_en;
logic [Cfg.NumCores-1:0]      s_dma_event;
logic [Cfg.NumCores-1:0]      s_dma_irq;
logic [Cfg.NumCores-1:0][3:0] s_hwpe_remap_evt;
logic [Cfg.NumCores-1:0][1:0] s_hwpe_evt;
logic                     s_hwpe_busy;
hci_package::hci_interconnect_ctrl_t s_hci_ctrl;

logic [Cfg.NumCores-1:0]               clk_core_en;

// CLK reset, and other control signals

logic                              s_cluster_int_busy;
logic                              s_fregfile_disable;

logic [Cfg.NumCores-1:0]           core_busy;

logic                              s_incoming_req;
logic                              s_isolate_cluster;
logic                              s_events_async;

logic                              s_events_valid;
logic                              s_events_ready;
logic [EventWidth-1:0]             s_events_data;

// Signals Between CORE_ISLAND and INSTRUCTION CACHES
logic [Cfg.NumCores-1:0]                        instr_req;
logic [Cfg.NumCores-1:0][AddrWidth-1:0]         instr_addr;
logic [Cfg.NumCores-1:0]                        instr_gnt;
logic [Cfg.NumCores-1:0]                        instr_r_valid;
logic [Cfg.NumCores-1:0][Cfg.iCachePrivateDataWidth-1:0] instr_r_rdata;

logic [1:0]                                 s_TCDM_arb_policy;
logic                                       tcdm_sleep;

logic[Cfg.NumCores-1:0][4:0] irq_id;
logic[Cfg.NumCores-1:0][4:0] irq_ack_id;
logic[Cfg.NumCores-1:0]      irq_req;
logic[Cfg.NumCores-1:0]      irq_ack;

logic [Cfg.NumCores-1:0]                s_core_dbg_irq;


logic [NB_L1_CUTS-1:0][RW_MARGIN_WIDTH-1:0] s_rw_margin_L1;

logic                                       s_dma_cl_event;
logic                                       s_dma_cl_irq;
logic                                       s_dma_fc_event;
logic                                       s_dma_fc_irq;

logic [Cfg.NumCores-1:0] hmr_barrier_matched;
logic [Cfg.NumCores-1:0] hmr_dmr_sw_resynch_req, hmr_tmr_sw_resynch_req;
logic [Cfg.NumCores-1:0] hmr_dmr_sw_synch_req, hmr_tmr_sw_synch_req;

localparam hci_package::hci_size_parameter_t HciCoreSizeParam = '{
  DW:  DataWidth,
  AW:  AddrWidth,
  BW:  DEFAULT_BW,
  UW:  DEFAULT_UW,
  IW:  DEFAULT_IW,
  EW:  DEFAULT_EW,
  EHW: DEFAULT_EHW
};
localparam hci_package::hci_size_parameter_t HciHwpeSizeParam = '{
  DW:  Cfg.HwpeNumPorts * DataWidth,
  AW:  AddrWidth,
  BW:  DEFAULT_BW,
  UW:  DEFAULT_UW,
  IW:  DEFAULT_IW,
  EW:  (Cfg.ECCInterco) ? HWPEParityWidth : DEFAULT_EW,
  EHW: DEFAULT_EHW
};
/* logarithmic and peripheral interconnect interfaces */
// ext -> log interconnect
hci_core_intf #(
  .DW ( HciCoreSizeParam.DW ),
  .AW ( HciCoreSizeParam.AW )
) s_hci_ext[0:Cfg.DmaNumPlugs-1] (
  .clk ( clk_i )
);

// periph interconnect -> slave peripherals
XBAR_PERIPH_BUS s_xbar_speriph_bus[Cfg.NumSlvPeriphs-1:0]();

// periph interconnect -> HWPE subsystem
XBAR_PERIPH_BUS s_hwpe_cfg_bus();

// DMA -> log interconnect
hci_core_intf #(
  .DW ( HciCoreSizeParam.DW ),
  .AW ( HciCoreSizeParam.AW )
) s_hci_dma[0:Cfg.DmaNumPlugs-1] (
  .clk ( clk_i )
);
XBAR_TCDM_BUS s_dma_plugin_xbar_bus[Cfg.DmaNumPlugs-1:0]();

// ext -> xbar periphs FIXME
XBAR_TCDM_BUS s_mperiph_xbar_bus[Cfg.NumMstPeriphs-1:0]();

// periph demux
XBAR_TCDM_BUS s_mperiph_bus();

// cores & accelerators -> log interconnect
hci_core_intf #(
  .DW   ( HciHwpeSizeParam.DW  ),
  .AW   ( HciHwpeSizeParam.AW  ),
  .EW   ( HciHwpeSizeParam.EW  ),
  .EHW  ( HciHwpeSizeParam.EHW )
) s_hci_hwpe [0:0] (
  .clk ( clk_i )
);
hci_core_intf #(
  .DW ( HciCoreSizeParam.DW ),
  .AW ( HciCoreSizeParam.AW )
) s_hci_core [0:Cfg.NumCores-1] (
  .clk ( clk_i )
);

// cores -> periph interconnect
XBAR_PERIPH_BUS s_core_periph_bus[Cfg.NumCores-1:0]();

// periph interconnect -> DMA
XBAR_PERIPH_BUS s_periph_dma_bus[1:0]();

// periph interconnect -> HMR unit
XBAR_PERIPH_BUS s_periph_hmr_bus ();

// periph interconnect -> TCDM scrubber
XBAR_PERIPH_BUS s_periph_tcdm_scrubber_bus ();

// periph interconnect -> HCI with ECC
XBAR_PERIPH_BUS s_periph_hwpe_hci_ecc_bus ();

// debug
XBAR_TCDM_BUS s_debug_bus[Cfg.NumCores-1:0]();

/* other interfaces */
// cores -> DMA ctrl
// FIXME: iDMA
hci_core_intf #(
  .DW ( HciCoreSizeParam.DW ),
  .AW ( HciCoreSizeParam.AW )
) s_core_dmactrl_bus [0:Cfg.NumCores-1] (
  .clk ( clk_i )
);

// cores -> event unit ctrl
XBAR_PERIPH_BUS s_core_euctrl_bus[Cfg.NumCores-1:0]();

// apu-interconnect
// handshake signals
logic [Cfg.NumCores-1:0] s_apu_master_req;
logic [Cfg.NumCores-1:0] s_apu_master_gnt;
// request channel
logic [Cfg.NumCores-1:0][FpuNumArgs-1:0][31:0] s_apu_master_operands;
logic [Cfg.NumCores-1:0][FpuOpCodeWidth-1:0] s_apu_master_op;
logic [Cfg.NumCores-1:0][FpuTypeWidth-1:0] s_apu_master_type;
logic [Cfg.NumCores-1:0][FpuInFlagsWidth-1:0] s_apu_master_flags;
// response channel
logic [Cfg.NumCores-1:0] s_apu_master_rready;
logic [Cfg.NumCores-1:0] s_apu_master_rvalid;
logic [Cfg.NumCores-1:0][31:0] s_apu_master_rdata;
logic [Cfg.NumCores-1:0][FpuOutFlagsWidth-1:0] s_apu_master_rflags;

//----------------------------------------------------------------------//
// Interfaces between ICache - L0 - Icache_Interco and Icache_ctrl_unit //
//                                                                      //
SP_ICACHE_CTRL_UNIT_BUS                                  IC_ctrl_unit_bus_main[Cfg.iCacheNumBanks]();
PRI_ICACHE_CTRL_UNIT_BUS                                 IC_ctrl_unit_bus_pri[Cfg.NumCores]();;
logic                                 [Cfg.NumCores-1:0] s_enable_l1_l15_prefetch;
logic                                 [Cfg.NumCores-1:0] s_icache_flush_valid, s_icache_flush_ready;
snitch_icache_pkg::icache_l0_events_t [Cfg.NumCores-1:0] s_icache_l0_events;
snitch_icache_pkg::icache_l1_events_t                    s_icache_l1_events;
//----------------------------------------------------------------------//

localparam TCDM_ID_WIDTH = Cfg.NumCores + Cfg.DmaNumPlugs + 4 + Cfg.HwpeNumPorts;
localparam hci_package::hci_size_parameter_t HciMemSizeParam = '{
  DW:  DataWidth,
  AW:  AddrMemWidth+2, // AddrMemWidth is word-wise, +2 for byte-wise
  BW:  8,
  UW:  DEFAULT_UW,
  IW:  TCDM_ID_WIDTH,
  EW:  (Cfg.ECCInterco) ? ParityWidth+MetaParityWidth : DEFAULT_EW,
  EHW: DEFAULT_EHW
};

// log interconnect -> TCDM memory banks (SRAM)
hci_core_intf #(
  .DW ( HciMemSizeParam.DW ),
  .AW ( HciMemSizeParam.AW ),
  .BW ( HciMemSizeParam.BW ),
  .IW ( HciMemSizeParam.IW ),
  .EW ( HciMemSizeParam.EW )
`ifndef SYNTHESIS
  ,
  .WAIVE_RSP3_ASSERT ( 1'b1 ),
  .WAIVE_RSP5_ASSERT ( 1'b1 )
`endif
) s_tcdm_bus_sram[0:Cfg.TcdmNumBank-1] (
  .clk ( clk_i )
);

  // ***********************************************************************************************+
  // ***********************************************************************************************+
  // ***********************************************************************************************+
  // ***********************************************************************************************+
  // ***********************************************************************************************+

  //***************************************************
  /* synchronous AXI interfaces internal to the cluster */
  //***************************************************

  // SOC TO CLUSTER
  `AXI_TYPEDEF_AW_CHAN_T(s2c_in_int_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_W_CHAN_T(s2c_in_int_w_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[Cfg.AxiDataInWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_B_CHAN_T(s2c_in_int_b_chan_t,logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_AR_CHAN_T(s2c_in_int_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_R_CHAN_T(s2c_in_int_r_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

  `AXI_TYPEDEF_REQ_T(s2c_in_int_req_t,s2c_in_int_aw_chan_t,s2c_in_int_w_chan_t,s2c_in_int_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(s2c_in_int_resp_t,s2c_in_int_b_chan_t,s2c_in_int_r_chan_t)

  // CLUSTER TO SOC
  `AXI_TYPEDEF_AW_CHAN_T(c2s_out_int_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_W_CHAN_T(c2s_out_int_w_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[Cfg.AxiDataOutWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_B_CHAN_T(c2s_out_int_b_chan_t,logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_AR_CHAN_T(c2s_out_int_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
  `AXI_TYPEDEF_R_CHAN_T(c2s_out_int_r_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

  `AXI_TYPEDEF_REQ_T(c2s_out_int_req_t,c2s_out_int_aw_chan_t,c2s_out_int_w_chan_t,c2s_out_int_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(c2s_out_int_resp_t,c2s_out_int_b_chan_t,c2s_out_int_r_chan_t)

  typedef s2c_in_int_aw_chan_t c2s_in_int_aw_chan_t;
  typedef c2s_out_int_w_chan_t c2s_in_int_w_chan_t;
  typedef s2c_in_int_b_chan_t c2s_in_int_b_chan_t;
  typedef s2c_in_int_ar_chan_t c2s_in_int_ar_chan_t;

  `AXI_TYPEDEF_R_CHAN_T(c2s_in_int_r_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])


  `AXI_TYPEDEF_REQ_T(c2s_in_int_req_t, c2s_in_int_aw_chan_t, c2s_in_int_w_chan_t, c2s_in_int_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(c2s_in_int_resp_t, c2s_in_int_b_chan_t, c2s_in_int_r_chan_t)


  c2s_in_int_req_t s_data_slave_64_req;
  c2s_in_int_resp_t s_data_slave_64_resp;

  s2c_in_int_req_t s_data_slave_32_req;
  s2c_in_int_resp_t s_data_slave_32_resp;

  c2s_out_int_req_t s_data_master_req;
  c2s_out_int_resp_t s_data_master_resp;

  c2s_in_int_req_t s_core_instr_bus_req;
  c2s_in_int_resp_t s_core_instr_bus_resp;


  // core per2axi -> ext
  c2s_in_int_req_t s_core_ext_bus_req;
  c2s_in_int_resp_t s_core_ext_bus_resp;

  // DMA -> ext
  c2s_in_int_req_t s_dma_ext_bus_req;
  c2s_in_int_resp_t s_dma_ext_bus_resp;

  // ext -> axi2mem
  c2s_out_int_req_t s_ext_tcdm_bus_req;
  c2s_out_int_resp_t s_ext_tcdm_bus_resp;

  // cluster bus -> axi2per
  c2s_out_int_req_t s_ext_mperiph_bus_req;
  c2s_out_int_resp_t s_ext_mperiph_bus_resp;

  /* reset generator */
  rstgen rstgen_i (
    .clk_i      ( clk_i       ),
    .rst_ni     ( rst_ni      ),
    .test_mode_i( test_mode_i ),
    .rst_no     ( s_rst_n     ),
    .init_no    ( s_init_n    )
  );

/* fetch & busy genertion */
assign s_cluster_int_busy = s_cluster_periphs_busy | s_per2axi_busy | s_axi2per_busy | s_axi2mem_busy | s_dmac_busy | s_hwpe_busy;
assign busy_o = s_cluster_int_busy | (|core_busy);
assign fetch_en_int = fetch_enable_reg_int;

/* cluster bus and attached peripherals */
cluster_bus_wrap #(
  .NB_MASTER              ( Cfg.NumAxiOut               ),
  .NB_SLAVE               ( Cfg.NumAxiIn                ),
  .NB_CORES               ( Cfg.NumCores                ),
  .DMA_NB_OUTSND_BURSTS   ( Cfg.DmaNumOutstandingBursts ),
  .TCDM_SIZE              ( Cfg.TcdmSize                ),
  .AXI_ADDR_WIDTH         ( Cfg.AxiAddrWidth            ),
  .AXI_DATA_WIDTH         ( Cfg.AxiDataOutWidth         ),
  .AXI_USER_WIDTH         ( Cfg.AxiUserWidth            ),
  .AXI_ID_IN_WIDTH        ( AxiIdInWidth                ),
  .AXI_ID_OUT_WIDTH       ( AxiIdOutWidth               ),
  .BaseAddr               ( Cfg.ClusterBaseAddr         ),
  .ClusterPeripheralsOffs ( Cfg.ClusterPeriphOffs       ),
  .ClusterExternalOffs    ( Cfg.ClusterExternalOffs     ),
  .slave_req_t            ( c2s_in_int_req_t            ),
  .slave_resp_t           ( c2s_in_int_resp_t           ),
  .master_req_t           ( c2s_out_int_req_t           ),
  .master_resp_t          ( c2s_out_int_resp_t          ),
  .slave_aw_chan_t        ( c2s_in_int_aw_chan_t        ),
  .master_aw_chan_t       ( c2s_out_int_aw_chan_t       ),
  .w_chan_t               ( c2s_out_int_w_chan_t        ),
  .slave_b_chan_t         ( c2s_in_int_b_chan_t         ),
  .master_b_chan_t        ( c2s_out_int_b_chan_t        ),
  .slave_ar_chan_t        ( c2s_in_int_ar_chan_t        ),
  .master_ar_chan_t       ( c2s_out_int_ar_chan_t       ),
  .slave_r_chan_t         ( c2s_in_int_r_chan_t         ),
  .master_r_chan_t        ( c2s_out_int_r_chan_t        )
) cluster_bus_wrap_i (
  .clk_i         ( clk_i             ),
  .rst_ni        ( rst_ni            ),
  .test_en_i     ( test_mode_i       ),
  .cluster_id_i  ( cluster_id_i      ),
  .data_slave_req_i    ( s_core_ext_bus_req ),
  .data_slave_resp_o   ( s_core_ext_bus_resp ),
  .instr_slave_req_i   ( s_core_instr_bus_req ),
  .instr_slave_resp_o  ( s_core_instr_bus_resp ),
  .dma_slave_req_i     ( s_dma_ext_bus_req ),
  .dma_slave_resp_o    ( s_dma_ext_bus_resp ),
  .ext_slave_req_i     ( s_data_slave_64_req ),
  .ext_slave_resp_o    ( s_data_slave_64_resp ),
  .tcdm_master_req_o   ( s_ext_tcdm_bus_req ),
  .tcdm_master_resp_i  ( s_ext_tcdm_bus_resp ),
  .periph_master_req_o ( s_ext_mperiph_bus_req ),
  .periph_master_resp_i( s_ext_mperiph_bus_resp),
  .ext_master_req_o    ( s_data_master_req ),
  .ext_master_resp_i   ( s_data_master_resp )
);

axi2mem_wrap #(
  .NB_DMAS        ( Cfg.DmaNumPlugs     ),
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    ),
  .AXI_ID_WIDTH   ( AxiIdOutWidth       ),
  .axi_req_t      ( c2s_out_int_req_t   ),
  .axi_resp_t     ( c2s_out_int_resp_t  )
) axi2mem_wrap_i (
  .clk_i       ( clk_i          ),
  .rst_ni      ( rst_ni         ),
  .test_en_i   ( test_mode_i    ),
  .axi_slave_req_i   ( s_ext_tcdm_bus_req ),
  .axi_slave_resp_o   ( s_ext_tcdm_bus_resp ),
  .tcdm_master ( s_hci_ext      ),
  .busy_o      ( s_axi2mem_busy )
);

axi2per_wrap #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( AxiIdOutWidth       ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    ),
  .axi_req_t      ( c2s_out_int_req_t   ),
  .axi_resp_t     ( c2s_out_int_resp_t  )
) axi2per_wrap_i (
  .clk_i         ( clk_i             ),
  .rst_ni        ( rst_ni            ),
  .test_en_i     ( test_mode_i       ),
  .axi_slave_req_i  ( s_ext_mperiph_bus_req  ),
  .axi_slave_resp_o ( s_ext_mperiph_bus_resp ),
  .periph_master    ( s_mperiph_bus          ),
  .busy_o           ( s_axi2per_busy         )
);

if (Cfg.NumMstPeriphs > 1) begin
  XBAR_TCDM_BUS s_mperiph_demux_bus[Cfg.NumMstPeriphs-1:0]();
  per_demux_wrap #(
    .NB_MASTERS  ( Cfg.NumMstPeriphs ),
    .ADDR_OFFSET ( 20                )
  ) per_demux_wrap_i (
    .clk_i   ( clk_i               ),
    .rst_ni  ( rst_ni              ),
    .slave   ( s_mperiph_bus       ),
    .masters ( s_mperiph_demux_bus )
  );

  for (genvar i = 0; i < Cfg.NumMstPeriphs; i++) begin
    `TCDM_ASSIGN_MASTER (s_mperiph_xbar_bus[i], s_mperiph_demux_bus[i])
  end
end else begin
  `TCDM_ASSIGN_MASTER (s_mperiph_xbar_bus[0], s_mperiph_bus)
end

per2axi_wrap #(
  .NB_CORES       ( Cfg.NumCores                     ),
  .PER_ADDR_WIDTH ( AddrWidth                        ),
  .PER_ID_WIDTH   ( Cfg.NumCores + Cfg.NumMstPeriphs ),
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth                 ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth              ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth                 ),
  .AXI_ID_WIDTH   ( AxiIdInWidth                     ),
  .axi_req_t      ( c2s_in_int_req_t                 ),
  .axi_resp_t     ( c2s_in_int_resp_t                )
) per2axi_wrap_i  (
  .clk_i          ( clk_i                           ),
  .rst_ni         ( rst_ni                          ),
  .test_en_i      ( test_mode_i                     ),
  .periph_slave      ( s_xbar_speriph_bus[SPER_EXT_ID] ),
  .axi_master_req_o  ( s_core_ext_bus_req              ),
  .axi_master_resp_i ( s_core_ext_bus_resp             ),
  .busy_o            ( s_per2axi_busy                  )
);

//***************************************************
/* cluster (log + periph) interconnect and attached peripherals */
//***************************************************

cluster_interconnect_wrap #(
  .NB_CORES               ( Cfg.NumCores                    ),
  .HWPE_PRESENT           ( Cfg.HwpePresent                 ),
  .NB_HWPE_PORTS          ( Cfg.HwpeNumPorts                ),
  .NB_DMAS                ( Cfg.DmaNumPlugs                 ),
  .NB_MPERIPHS            ( Cfg.NumMstPeriphs               ),
  .NB_TCDM_BANKS          ( Cfg.TcdmNumBank                 ),
  .NB_SPERIPHS            ( Cfg.NumSlvPeriphs               ),

  .DATA_WIDTH             ( DataWidth                       ),
  .ADDR_WIDTH             ( AddrWidth                       ),
  .BE_WIDTH               ( BeWidth                         ),
  .ClusterBaseAddr        ( Cfg.ClusterBaseAddr             ),
  .ClusterPeripheralsOffs ( Cfg.ClusterPeriphOffs           ),
  .ClusterExternalOffs    ( Cfg.ClusterExternalOffs         ),

  .TEST_SET_BIT           ( TestSetBit                      ),
  .ADDR_MEM_WIDTH         ( AddrMemWidth                    ),

  .PE_ROUTING_LSB         ( PeRoutingLsb                    ),
  .CLUSTER_ALIAS          ( Cfg.ClusterAlias                ),
  .USE_HETEROGENEOUS_INTERCONNECT ( Cfg.UseHci              ),
  .USE_ECC_INTERCONNECT   ( Cfg.EnableECC && Cfg.ECCInterco ),
  .HCI_CORE_SIZE          ( HciCoreSizeParam                ),
  .HCI_HWPE_SIZE          ( HciHwpeSizeParam                ),
  .HCI_MEM_SIZE           ( HciMemSizeParam                 )

) cluster_interconnect_wrap_i (
  .clk_i              ( clk_i                                     ),
  .rst_ni             ( rst_ni                                    ),
  .cluster_id_i       ( '0                                        ),

  .hci_ecc_periph_slave ( s_periph_hwpe_hci_ecc_bus               ),

  .core_tcdm_slave    ( s_hci_core                                ),
  .hwpe_tcdm_slave    ( s_hci_hwpe                                ),
  .ext_slave          ( s_hci_ext                                 ),
  .dma_slave          ( s_hci_dma                                 ),

  .tcdm_sram_master   ( s_tcdm_bus_sram                           ),

  .core_periph_slave  ( s_core_periph_bus                         ),
  .mperiph_slave      ( s_mperiph_xbar_bus[Cfg.NumMstPeriphs-1:0] ),
  .speriph_master     ( s_xbar_speriph_bus                        ),

  .hci_ctrl_i         ( s_hci_ctrl                                ),
  .TCDM_arb_policy_i  ( s_TCDM_arb_policy                         )
);

//***************************************************
//*********************DMAC WRAP*********************
//***************************************************
dmac_wrap #(
  .NB_CORES           ( Cfg.NumCores                ),
  .NB_OUTSND_BURSTS   ( Cfg.DmaNumOutstandingBursts ),
  .AXI_ADDR_WIDTH     ( Cfg.AxiAddrWidth            ),
  .AXI_DATA_WIDTH     ( Cfg.AxiDataOutWidth         ),
  .AXI_ID_WIDTH       ( AxiIdInWidth                ),
  .AXI_USER_WIDTH     ( Cfg.AxiUserWidth            ),
  .PE_ID_WIDTH        ( Cfg.NumCores + 1            ),
  .DATA_WIDTH         ( DataWidth                   ),
  .ADDR_WIDTH         ( AddrWidth                   ),
  .BE_WIDTH           ( BeWidth                     ),
  .axi_req_t          ( c2s_in_int_req_t            ),
  .axi_resp_t         ( c2s_in_int_resp_t           ),
`ifdef TARGET_MCHAN
  .NB_CTRLS           ( Cfg.NumCores + 2            ),
  .MCHAN_BURST_LENGTH ( Cfg.DmaBurstLength          ),
  .TCDM_ADD_WIDTH     ( TcdmAddrWidth               )
`else
  .NB_PE_PORTS        ( 2                           ),
  .NUM_STREAMS        ( 4                           ),
  .TCDM_SIZE          ( Cfg.TcdmSize                ),
  .ClusterBaseAddr    ( Cfg.ClusterBaseAddr         )
`endif
) dmac_wrap_i     (
  .clk_i              ( clk_i                            ),
  .rst_ni             ( rst_ni                           ),
  .test_mode_i        ( test_mode_i                      ),
  .pe_ctrl_slave      ( s_periph_dma_bus[1:0]            ),
  .ctrl_slave         ( s_core_dmactrl_bus               ),
  .tcdm_master        ( s_hci_dma                        ),

  .ext_master_req_o   ( s_dma_ext_bus_req                ),
  .ext_master_resp_i  ( s_dma_ext_bus_resp               ),

  .term_event_o       ( s_dma_event                      ),
  .term_irq_o         ( s_dma_irq                        ),
  .term_event_pe_o    ( {s_dma_fc_event, s_dma_cl_event} ),
  .term_irq_pe_o      ( {s_dma_fc_irq, s_dma_cl_irq}     ),
  .busy_o             ( s_dmac_busy                      )
);

//***************************************************
//**************CLUSTER PERIPHERALS******************
//***************************************************
cluster_peripherals #(
  .NB_CORES       ( Cfg.NumCores      ),
  .NB_HWPES       ( MAX_NUM_HWPES     ),
  .NB_MPERIPHS    ( Cfg.NumMstPeriphs ),
  .NB_CACHE_BANKS ( Cfg.iCacheNumBanks),
  .NB_SPERIPHS    ( Cfg.NumSlvPeriphs ),
  .NB_TCDM_BANKS  ( Cfg.TcdmNumBank   ),
  .ROM_BOOT_ADDR  ( Cfg.BootRomBaseAddr),
  .BOOT_ADDR      ( Cfg.BootAddr      ),
  .EVNT_WIDTH     ( EventWidth        ),

  .NB_L1_CUTS      ( NB_L1_CUTS       ),
  .RW_MARGIN_WIDTH ( RW_MARGIN_WIDTH  )

) cluster_peripherals_i (

  .clk_i                  ( clk_i                              ),
  .rst_ni                 ( rst_ni                             ),
  .ref_clk_i              ( ref_clk_i                          ),
  .test_mode_i            ( test_mode_i                        ),
  .busy_o                 ( s_cluster_periphs_busy             ),

  .en_sa_boot_i           ( en_sa_boot_synch                   ),
  .fetch_en_i             ( fetch_en_synch                     ),
  .boot_addr_o            ( boot_addr                          ),
  .core_busy_i            ( core_busy                          ),
  .core_clk_en_o          ( clk_core_en                        ),

  .speriph_slave          ( s_xbar_speriph_bus[Cfg.NumSlvPeriphs-2:0] ),
  .core_eu_direct_link    ( s_core_euctrl_bus                         ),

  .dma_cfg_master         ( s_periph_dma_bus                   ),
  .hmr_cfg_master         ( s_periph_hmr_bus                   ),
  .tcdm_scrubber_cfg_master ( s_periph_tcdm_scrubber_bus       ),
  .hwpe_hci_ecc_cfg_master ( s_periph_hwpe_hci_ecc_bus         ),

  .dma_cl_event_i         ( s_dma_cl_event                     ),
  .dma_cl_irq_i           ( s_dma_cl_irq                       ),
  .dma_event_i            ( s_dma_event                        ),
  .dma_irq_i              ( s_dma_irq                          ),
  .mbox_irq_i             ( mbox_irq_synch                     ),

  // NEW_SIGNALS .decompr_done_evt_i     ( s_decompr_done_evt                 ),

  .dma_fc_event_i         ( s_dma_fc_event                     ),
  .dma_fc_irq_i           ( '0                                 ),

  .soc_periph_evt_ready_o ( s_events_ready                     ),
  .soc_periph_evt_valid_i ( s_events_valid                     ),
  .soc_periph_evt_data_i  ( s_events_data                      ),

  .dbg_core_halt_o        ( dbg_core_halt                      ),
  .dbg_core_halted_i      ( dbg_core_halted                    ),
  .dbg_core_resume_o      ( dbg_core_resume                    ),

  .eoc_o                  ( eoc_synch                          ),
  .cluster_cg_en_o        ( s_cluster_cg_en                    ),
  .fetch_enable_reg_o     ( fetch_enable_reg_int               ),
  .irq_id_o               ( irq_id                             ),
  .irq_ack_id_i           ( irq_ack_id                         ),
  .irq_req_o              ( irq_req                            ),
  .irq_ack_i              ( irq_ack                            ),
  .dbg_req_i              ( s_dbg_irq                          ),
  .dbg_req_o              ( s_core_dbg_irq                     ),
  .barrier_matched_o      ( hmr_barrier_matched                ),

  // HMR synch requests
  .hmr_sw_resynch_req_i   ( hmr_dmr_sw_resynch_req | hmr_tmr_sw_resynch_req ),
  .hmr_sw_synch_req_i     ( hmr_dmr_sw_synch_req | hmr_tmr_sw_synch_req ),

  .fregfile_disable_o     ( s_fregfile_disable                 ),

  .TCDM_arb_policy_o      ( s_TCDM_arb_policy                  ),

  .hwpe_cfg_master          ( s_hwpe_cfg_bus                    ),
  .hwpe_events_i            ( s_hwpe_remap_evt                  ),
  .hwpe_en_o                ( s_hwpe_en                         ),
  .hwpe_sel_o               ( s_hwpe_sel                        ),
  .hci_ctrl_o               ( s_hci_ctrl                        ),
  .enable_l1_l15_prefetch_o (  s_enable_l1_l15_prefetch         ),
  .flush_valid_o            ( s_icache_flush_valid              ),
  .flush_ready_i            ( s_icache_flush_ready              ),
  .IC_ctrl_unit_bus_main    (  IC_ctrl_unit_bus_main            ),
  .IC_ctrl_unit_bus_pri     (  IC_ctrl_unit_bus_pri             ),
  .l1_events_i              ( s_icache_l1_events                )
);

//********************************************************
//***************** CORE ISLANDS *************************
//********************************************************
//------------------------------------------------------//
//          ██████╗ ██████╗ ██████╗ ███████╗            //
//         ██╔════╝██╔═══██╗██╔══██╗██╔════╝            //
//         ██║     ██║   ██║██████╔╝█████╗              //
//         ██║     ██║   ██║██╔══██╗██╔══╝              //
//         ╚██████╗╚██████╔╝██║  ██║███████╗            //
//          ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝            //
//------------------------------------------------------//

/* cluster cores + core-coupled accelerators / shared execution units */
`REG_BUS_TYPEDEF_ALL(hmr_reg, logic[AddrWidth-1:0], logic[DataWidth-1:0], logic[BeWidth-1:0])
hmr_reg_req_t hmr_reg_req;
hmr_reg_rsp_t hmr_reg_rsp;

periph_to_reg #(
  .AW          ( AddrWidth        ),
  .DW          ( DataWidth        ),
  .BW          ( 8                ),
  .IW          ( Cfg.NumCores + 1 ),
  .req_t       ( hmr_reg_req_t    ),
  .rsp_t       ( hmr_reg_rsp_t    )
) i_periph_to_hmr (
  .clk_i          ( clk_i                    ),
  .rst_ni         ( rst_ni                   ),
  .req_i          ( s_periph_hmr_bus.req     ),
  .add_i          ( s_periph_hmr_bus.add     ),
  .wen_i          ( s_periph_hmr_bus.wen     ),
  .wdata_i        ( s_periph_hmr_bus.wdata   ),
  .be_i           ( s_periph_hmr_bus.be      ),
  .id_i           ( s_periph_hmr_bus.id      ),
  .gnt_o          ( s_periph_hmr_bus.gnt     ),
  .r_rdata_o      ( s_periph_hmr_bus.r_rdata ),
  .r_opc_o        ( s_periph_hmr_bus.r_opc   ),
  .r_id_o         ( s_periph_hmr_bus.r_id    ),
  .r_valid_o      ( s_periph_hmr_bus.r_valid ),
  .reg_req_o      ( hmr_reg_req              ),
  .reg_rsp_i      ( hmr_reg_rsp              )
);

core_data_req_t [Cfg.NumCores-1:0] core_data_req, demux_data_req;
core_data_rsp_t [Cfg.NumCores-1:0] core_data_rsp, demux_data_rsp;
core_inputs_t   [Cfg.NumCores-1:0] sys2hmr, hmr2core;
core_outputs_t  [Cfg.NumCores-1:0] hmr2sys, core2hmr;
core_backup_t   [Cfg.NumCores-1:0] backup_bus;
rapid_recovery_pkg::rapid_recovery_t [Cfg.NumCores-1:0] recovery_bus;

logic [Cfg.NumCores-1:0] clk_core;
logic [Cfg.NumCores-1:0] setback;
logic [Cfg.NumCores-1:0][4:0] ext_perf;

generate
  for (genvar i = 0; i < Cfg.NumCores; i++) begin : CORE

    pulp_sync dbg_irq_sync (
      .clk_i(clk_i),
      .rstn_i(rst_ni),
      .serial_i(dbg_irq_valid_i[i]),
      .serial_o(s_dbg_irq[i])
    );

    tc_clk_gating clock_gate_i    (
      .clk_i     ( clk_i          ),
      .en_i      ( clk_core_en[i] ),
      .test_en_i ( test_mode_i    ),
      .clk_o     ( clk_core[i]    )
    );

    core_region #(
      .CORE_TYPE_CL        ( Cfg.CoreType               ),
      .N_EXT_PERF_COUNTERS ( 5 + $bits(snitch_icache_pkg::icache_l0_events_t )                          ),
      .ADDR_WIDTH          ( AddrWidth                  ),
      .DATA_WIDTH          ( DataWidth                  ),
      .INSTR_RDATA_WIDTH   ( Cfg.iCachePrivateDataWidth ),
      .CLUSTER_ALIAS       ( Cfg.ClusterAlias           ),
      .CLUSTER_ALIAS_BASE  ( Cfg.ClusterAliasBase       ),
      .REMAP_ADDRESS       ( Cfg.EnableRemapAddress     ),
      .APU_NARGS_CPU       ( FpuNumArgs                 ),
      .APU_WOP_CPU         ( FpuOpCodeWidth             ),
      .WAPUTYPE            ( FpuTypeWidth               ),
      .APU_NDSFLAGS_CPU    ( FpuInFlagsWidth            ),
      .APU_NUSFLAGS_CPU    ( FpuOutFlagsWidth           ),
      .DEBUG_START_ADDR    ( Cfg.DmBaseAddr             ),
      .FPU                 ( Cfg.EnablePrivateFpu       ),
      .FP_DIVSQRT          ( Cfg.EnablePrivateFpDivSqrt ),
      .core_data_req_t     ( core_data_req_t            ),
      .core_data_rsp_t     ( core_data_rsp_t            )
    ) core_region_i        (
      .clk_i               ( clk_core[i]              ),
      .rst_ni              ( rst_ni                   ),
      .setback_i           ( setback[i]               ),
      .cluster_id_i        ( hmr2core[i].cluster_id   ),
      .core_id_i           ( hmr2core[i].core_id      ),
      .clock_en_i          ( hmr2core[i].clock_en     ),
      .fetch_en_i          ( fetch_en_int[i]          ),
      .boot_addr_i         ( hmr2core[i].boot_addr    ),
      .irq_id_i            ( hmr2core[i].irq_id       ),
      .irq_ack_id_o        ( core2hmr[i].irq_ack_id   ),
      .irq_req_i           ( hmr2core[i].irq_req      ),
      .irq_ack_o           ( core2hmr[i].irq_ack      ),
      .test_mode_i         ( test_mode_i              ),
      .core_busy_o         ( core2hmr[i].core_busy    ),
      //instruction cache bind
      .instr_req_o         ( core2hmr[i].instr_req    ),
      .instr_gnt_i         ( hmr2core[i].instr_gnt    ),
      .instr_addr_o        ( core2hmr[i].instr_addr   ),
      .instr_r_rdata_i     ( hmr2core[i].instr_rdata  ),
      .instr_r_valid_i     ( hmr2core[i].instr_rvalid ),
      //debug unit bind
      .debug_req_i         ( s_core_dbg_irq[i]         ),
      .debug_halted_o      ( core2hmr[i].debug_halted  ),
      .debug_havereset_o   ( dbg_core_havereset[i]     ),
      .debug_running_o     ( dbg_core_running[i]       ),
      .ext_perf_i          ( {s_icache_l0_events[i], ext_perf[i]} ),
      .core_data_req_o     ( core_data_req[i]          ),
      .core_data_rsp_i     ( core_data_rsp[i]          ),
      //HMR Recovery Bus
      .recovery_bus_i      ( recovery_bus[i]              ),
      .regfile_backup_o    ( backup_bus[i].regfile_backup ),
      .pc_backup_o         ( backup_bus[i].pc_backup      ),
      .csr_backup_o        ( backup_bus[i].csr_backup     ),
      //apu interface
      .apu_master_req_o      ( s_apu_master_req     [i] ),
      .apu_master_gnt_i      ( s_apu_master_gnt     [i] ),
      .apu_master_type_o     ( s_apu_master_type    [i] ),
      .apu_master_operands_o ( s_apu_master_operands[i] ),
      .apu_master_op_o       ( s_apu_master_op      [i] ),
      .apu_master_flags_o    ( s_apu_master_flags   [i] ),
      .apu_master_valid_i    ( s_apu_master_rvalid  [i] ),
      .apu_master_ready_o    ( s_apu_master_rready  [i] ),
      .apu_master_result_i   ( s_apu_master_rdata   [i] ),
      .apu_master_flags_i    ( s_apu_master_rflags  [i] )
    );

    assign dbg_core_halted[i] = core2hmr[i].debug_halted;

    // Binding inputs/outputs from HMR to the system and vice versa
    assign sys2hmr[i].clock_en     = clk_core_en[i];
    assign sys2hmr[i].boot_addr    = boot_addr;
    assign sys2hmr[i].core_id      = i[3:0];
    assign sys2hmr[i].cluster_id   = cluster_id_i;
    assign sys2hmr[i].instr_gnt    = instr_gnt[i];
    assign sys2hmr[i].instr_rvalid = instr_r_valid[i];
    assign sys2hmr[i].instr_rdata  = instr_r_rdata[i];
    assign sys2hmr[i].data_gnt     = demux_data_rsp[i].gnt;
    assign sys2hmr[i].data_rvalid  = demux_data_rsp[i].r_valid;
    assign sys2hmr[i].data_rdata   = demux_data_rsp[i].r_data;
    assign sys2hmr[i].irq_req      = irq_req[i];
    assign sys2hmr[i].irq_id       = irq_id[i];

    assign instr_req[i]            = hmr2sys[i].instr_req;
    assign instr_addr[i]           = hmr2sys[i].instr_addr;
    assign demux_data_req[i].req   = hmr2sys[i].data_req;
    assign demux_data_req[i].we    = hmr2sys[i].data_we;
    assign demux_data_req[i].be    = hmr2sys[i].data_be;
    assign demux_data_req[i].add   = hmr2sys[i].data_add;
    assign demux_data_req[i].data  = hmr2sys[i].data_wdata;
    assign irq_ack[i]              = hmr2sys[i].irq_ack;
    assign irq_ack_id[i]           = hmr2sys[i].irq_ack_id;
    assign core_busy[i]            = hmr2sys[i].core_busy;

    // Binding data interface from HMR to the core and vice versa
    assign core_data_rsp[i].gnt     = hmr2core[i].data_gnt;
    assign core_data_rsp[i].r_data  = hmr2core[i].data_rdata;
    assign core_data_rsp[i].r_valid = hmr2core[i].data_rvalid;

    assign core2hmr[i].data_req   = core_data_req[i].req;
    assign core2hmr[i].data_add   = core_data_req[i].add;
    assign core2hmr[i].data_we    = core_data_req[i].we;
    assign core2hmr[i].data_wdata = core_data_req[i].data;
    assign core2hmr[i].data_be    = core_data_req[i].be;

    core_demux_wrap       #(
      .AddrWidth           ( AddrWidth              ),
      .DataWidth           ( DataWidth              ),
      .RemapAddress        ( Cfg.EnableRemapAddress ),
      .ClustAlias          ( Cfg.ClusterAlias       ),
      .ClustAliasBase      ( Cfg.ClusterAliasBase   ),
      .NumExtPerf          ( 5                      ),
      .core_data_req_t     ( core_data_req_t        ),
      .core_data_rsp_t     ( core_data_rsp_t        )
    ) i_core_demux         (
      .clk_i               ( clk_core[i]           ),
      .rst_ni              ( rst_ni                ),
      .test_en_i           ( test_mode_i           ),
      .clk_en_i            ( clk_core_en[i]        ),
      .base_addr_i         ( base_addr_i           ),
      .cluster_id_i        ( '0                    ),
      .ext_perf_o          ( ext_perf[i]           ),
      .core_data_req_i     ( demux_data_req[i]     ),
      .core_data_rsp_o     ( demux_data_rsp[i]     ),
      .tcdm_bus_mst_o      ( s_hci_core[i]         ),
      .dma_ctrl_mst_o      ( s_core_dmactrl_bus[i] ),
      .eventunit_bus_mst_o ( s_core_euctrl_bus[i]  ),
      .peripheral_bus_mst_o( s_core_periph_bus[i]  )
    );
  end
endgenerate

logic [Cfg.NumCores/3-1:0] hmr_tmr_synch;
for (genvar i = 0; i < Cfg.NumCores/3; i++) begin
  if (1'b1) begin // InterleaveGrps
    assign hmr_tmr_synch[i] = hmr_barrier_matched[i + 1];
  end else begin
    assign hmr_tmr_synch[i] = hmr_barrier_matched[i + i/2 + 1];
  end
end

logic [Cfg.NumCores/3-1:0] hmr_tmr_sw_resynch_req_short;
logic [Cfg.NumCores/2-1:0] hmr_dmr_sw_resynch_req_short;
always_comb begin
  hmr_tmr_sw_resynch_req = '0;
  hmr_dmr_sw_resynch_req = '0;

  for (int i = 0; i < Cfg.NumCores/3; i++) begin
    if (1'b1) begin // InterleaveGrps
      hmr_tmr_sw_resynch_req[i] = hmr_tmr_sw_resynch_req_short[i];
    end else begin
      hmr_tmr_sw_resynch_req[3*i] = hmr_tmr_sw_resynch_req_short[i];
    end
  end

  for (int i = 0; i < Cfg.NumCores/2; i++) begin
    if (1'b1) begin // InterleaveGrps
      hmr_dmr_sw_resynch_req[i] = hmr_dmr_sw_resynch_req_short[i];
    end else begin
      hmr_dmr_sw_resynch_req[2*i] = hmr_dmr_sw_resynch_req_short[i];
    end
  end
end

generate
  if (Cfg.HMRPresent) begin : gen_hmr_unit
    hmr_unit #(
      .NumCores          ( Cfg.NumCores                         ),
      .DMRSupported      ( Cfg.HMRDmrEnabled                    ),
      .DMRFixed          ( Cfg.HMRDmrFIxed                      ),
      .TMRSupported      ( Cfg.HMRTmrEnabled                    ),
      .TMRFixed          ( Cfg.HMRTmrFIxed                      ),
      .InterleaveGrps    ( Cfg.HMRInterleaveGrps                ),
      .RapidRecovery     ( Cfg.HMREnableRapidRecovery           ),
      .SeparateData      ( Cfg.HMRSeparateDataVoters            ),
      .SeparateAxiBus    ( Cfg.HMRSeparateAxiBus                ),
      .NumBusVoters      ( Cfg.HMRNumBusVoters                  ),
      .all_inputs_t      ( core_inputs_t                        ),
      .nominal_outputs_t ( core_outputs_t                       ),
      .core_backup_t     ( core_backup_t                        ),
      .reg_req_t         ( hmr_reg_req_t                        ),
      .reg_rsp_t         ( hmr_reg_rsp_t                        ),
      // We use any axi_req_t to just let the unit not complain about
      // undeclared r_ready and b_ready signals.
      .axi_req_t         ( c2s_in_int_req_t                     ),
      .rapid_recovery_t  ( rapid_recovery_pkg::rapid_recovery_t )
    ) i_hmr_unit         (
      .clk_i                  ( clk_i        ),
      .rst_ni                 ( rst_ni       ),
      // Port to configuration unit
      .reg_request_i          ( hmr_reg_req  ),
      .reg_response_o         ( hmr_reg_rsp  ),
      // TMR signals
      .tmr_failure_o          (               ),
      .tmr_error_o            (               ), // Should this not be NumTMRCores? or NumCores?
      .tmr_resynch_req_o      ( hmr_tmr_sw_resynch_req_short ),
      .tmr_sw_synch_req_o     ( hmr_tmr_sw_synch_req         ),
      .tmr_cores_synch_i      ( hmr_tmr_synch                ),
      // DMR signals
      .dmr_failure_o          (              ),
      .dmr_error_o            (              ), // Should this not be NumDMRCores? or NumCores?
      .dmr_resynch_req_o      ( hmr_dmr_sw_resynch_req_short      ),
      .dmr_sw_synch_req_o     ( hmr_dmr_sw_synch_req              ),
      .dmr_cores_synch_i      ( hmr_barrier_matched[Cfg.NumCores/2:1] ),
      // Rapid recovery output bus
      .rapid_recovery_o       ( recovery_bus ),
      .core_backup_i          ( backup_bus   ),
      .sys_inputs_i           ( sys2hmr      ),
      .sys_nominal_outputs_o  ( hmr2sys      ),
      .sys_bus_outputs_o      (              ),
      .sys_fetch_en_i         ( fetch_en_int ),
      .enable_bus_vote_i      ( '0           ),
      .core_setback_o         ( setback      ),
      .core_inputs_o          ( hmr2core     ),
      .core_nominal_outputs_i ( core2hmr     ),
      .core_bus_outputs_i     ( '0           ),
      .core_axi_outputs_i     ( '0           )
    );
  end else begin : gen_no_hmr_unit
    assign hmr_reg_rsp                  = '0;
    assign hmr_tmr_sw_resynch_req_short = '0;
    assign hmr_tmr_sw_synch_req         = '0;
    assign hmr_dmr_sw_resynch_req_short = '0;
    assign hmr_dmr_sw_synch_req         = '0;
    assign recovery_bus                 = '0;
    assign setback                      = '0;

    for (genvar i = 0; i < Cfg.NumCores; i++) begin
      assign hmr2core[i].clock_en     = sys2hmr[i].clock_en;     
      assign hmr2core[i].boot_addr    = sys2hmr[i].boot_addr;    
      assign hmr2core[i].core_id      = sys2hmr[i].core_id;      
      assign hmr2core[i].cluster_id   = sys2hmr[i].cluster_id;   
      assign hmr2core[i].instr_gnt    = sys2hmr[i].instr_gnt;    
      assign hmr2core[i].instr_rvalid = sys2hmr[i].instr_rvalid; 
      assign hmr2core[i].instr_rdata  = sys2hmr[i].instr_rdata;  
      assign hmr2core[i].data_gnt     = sys2hmr[i].data_gnt;     
      assign hmr2core[i].data_rvalid  = sys2hmr[i].data_rvalid;  
      assign hmr2core[i].data_rdata   = sys2hmr[i].data_rdata;   
      assign hmr2core[i].irq_req      = sys2hmr[i].irq_req;      
      assign hmr2core[i].irq_id       = sys2hmr[i].irq_id;       

      assign hmr2sys[i].instr_req     = core2hmr[i].instr_req;
      assign hmr2sys[i].instr_addr    = core2hmr[i].instr_addr;
      assign hmr2sys[i].data_req      = core2hmr[i].data_req;
      assign hmr2sys[i].data_we       = core2hmr[i].data_we;
      assign hmr2sys[i].data_be       = core2hmr[i].data_be;
      assign hmr2sys[i].data_add      = core2hmr[i].data_add;
      assign hmr2sys[i].data_wdata    = core2hmr[i].data_wdata;
      assign hmr2sys[i].irq_ack       = core2hmr[i].irq_ack;
      assign hmr2sys[i].irq_ack_id    = core2hmr[i].irq_ack_id;
      assign hmr2sys[i].core_busy     = core2hmr[i].core_busy;
      assign hmr2sys[i].debug_halted  = core2hmr[i].debug_halted;
    end
  end
endgenerate

//****************************************************
//****          Shared execution units             ***
//****************************************************
// request channel
logic [Cfg.NumCores-1:0][FpuNumArgs-1:0][31:0] s_apu__operands;
logic [Cfg.NumCores-1:0][FpuOpCodeWidth-1:0] s_apu__op;
logic [Cfg.NumCores-1:0][FpuTypeWidth-1:0] s_apu__type;
logic [Cfg.NumCores-1:0][FpuInFlagsWidth-1:0] s_apu__flags;
// response channel
logic [Cfg.NumCores-1:0][FpuOutFlagsWidth-1:0] s_apu__rflags;

genvar k;
for(k=0;k<Cfg.NumCores;k++)
begin
  assign s_apu__operands[k] = s_apu_master_operands[k];
  assign s_apu__op[k] = s_apu_master_op[k];
  assign s_apu__type[k] = s_apu_master_type[k];
  assign s_apu__flags[k] = s_apu_master_flags[k];
  assign s_apu_master_rflags[k] = s_apu__rflags[k];
end

// At the moment, the cluster does not support any shared execution unit 
assign s_apu_master_gnt    = '0;
assign s_apu_master_rvalid = '0;
assign s_apu_master_rdata  = '0;
assign s_apu__rflags       = '0;
  
//**************************************************************
//**** HW Processing Engines / Cluster-Coupled Accelerators ****
//**************************************************************
generate
  if(Cfg.HwpePresent) begin: hwpe_gen
    hwpe_subsystem #(
      .HWPE_CFG      ( Cfg.HwpeCfg                      ),
      .N_CORES       ( Cfg.NumCores                     ),
      .N_MASTER_PORT ( Cfg.HwpeNumPorts                 ),
      .ID_WIDTH      ( Cfg.NumCores + Cfg.NumMstPeriphs ),
      .HCI_HWPE_SIZE ( HciHwpeSizeParam                 )
    ) hwpe_subsystem_i (
      .clk               ( clk_i          ),
      .rst_n             ( rst_ni         ),
      .test_mode         ( test_mode_i    ),
      .hwpe_en_i         ( s_hwpe_en      ),
      .hwpe_sel_i        ( s_hwpe_sel     ),
      .hwpe_xbar_master  ( s_hci_hwpe [0] ),
      .hwpe_cfg_slave    ( s_hwpe_cfg_bus ),
      .evt_o             ( s_hwpe_evt     ),
      .busy_o            ( s_hwpe_busy    )
    );
  end
  else begin : no_hwpe_gen
    assign s_hwpe_cfg_bus.r_valid = '1;
    assign s_hwpe_cfg_bus.gnt     = '1;
    assign s_hwpe_cfg_bus.r_rdata = 32'hdeadbeef;
    assign s_hwpe_cfg_bus.r_id    = '0;
    assign s_hwpe_cfg_bus.r_opc   = '0;
    assign s_hci_hwpe[0].req   = 1'b0;
    assign s_hci_hwpe[0].add   = '0;
    assign s_hci_hwpe[0].wen   = '0;
    assign s_hci_hwpe[0].data  = '0;
    assign s_hci_hwpe[0].be    = '0;
    assign s_hci_hwpe[0].user  = '0;
    assign s_hci_hwpe[0].r_ready = '0;
    assign s_hci_hwpe[0].id = '0;
    assign s_hci_hwpe[0].ecc = '0;
    assign s_hci_hwpe[0].ereq = '0;
    assign s_hci_hwpe[0].r_eready = '0;
    assign s_hwpe_busy = '0;
    assign s_hwpe_evt  = '0;
  end
endgenerate

generate
  for(genvar i=0; i<Cfg.NumCores; i++) begin : hwpe_event_interrupt_gen
    assign s_hwpe_remap_evt[i][3:2] = '0;
    assign s_hwpe_remap_evt[i][1:0] = s_hwpe_evt[i];
  end
endgenerate

if (Cfg.SnitchICache) begin : gen_snitch_icache

  pulp_icache_wrap #(
    .NumFetchPorts  ( Cfg.NumCores                                 ),
    .L0_LINE_COUNT  ( Cfg.iCachePrivateSize*8/256                  ),
    .LINE_WIDTH     ( 256                                          ), // Ideally 32*NumCores
    .LINE_COUNT     ( Cfg.iCacheSharedSize*8/256/Cfg.iCacheNumWays ),
    .SET_COUNT      ( Cfg.iCacheNumWays                            ),
    .L1DataParityWidth ( 8 ),
    .L0DataParityWidth ( 8 ),
    .FetchAddrWidth ( AddrWidth                                    ),
    .FetchDataWidth ( Cfg.iCachePrivateDataWidth                   ),
    .AxiAddrWidth   ( AddrWidth                                    ),
    .AxiDataWidth   ( Cfg.AxiDataOutWidth                          ),
    .axi_req_t      ( c2s_in_int_req_t                             ),
    .axi_rsp_t      ( c2s_in_int_resp_t                            )
  ) icache_top_i (
    .clk_i                ( clk_i                       ),
    .rst_ni               ( rst_ni                      ),

    .fetch_req_i          ( instr_req                   ),
    .fetch_addr_i         ( instr_addr                  ),
    .fetch_gnt_o          ( instr_gnt                   ),
    .fetch_rvalid_o       ( instr_r_valid               ),
    .fetch_rdata_o        ( instr_r_rdata               ),
    .fetch_rerror_o       (),

    .enable_prefetching_i ( s_enable_l1_l15_prefetch[0] ),
    .icache_l0_events_o   ( s_icache_l0_events ),
    .icache_l1_events_o   ( s_icache_l1_events ),
    .flush_valid_i        ( s_icache_flush_valid ),
    .flush_ready_o        ( s_icache_flush_ready ),

    .sram_cfg_data_i      ('0),
    .sram_cfg_tag_i       ('0),

    .axi_req_o            ( s_core_instr_bus_req  ),
    .axi_rsp_i            ( s_core_instr_bus_resp )
  );

  for (genvar i = 0; i < Cfg.NumCores; i++) begin
    assign IC_ctrl_unit_bus_pri[i].bypass_ack     = '0;
    assign IC_ctrl_unit_bus_pri[i].flush_ack      = '0;
    assign IC_ctrl_unit_bus_pri[i].sel_flush_ack  = '0;
    `ifdef FEATURE_ICACHE_STAT
      assign IC_ctrl_unit_bus_pri[i].ctrl_hit_count   = '0;
      assign IC_ctrl_unit_bus_pri[i].ctrl_trans_count = '0;
      assign IC_ctrl_unit_bus_pri[i].ctrl_miss_count  = '0;
      assign IC_ctrl_unit_bus_pri[i].ctrl_cong_count  = '0;
    `endif
  end

  for (genvar i = 0; i < Cfg.iCacheNumBanks; i++) begin
    assign IC_ctrl_unit_bus_main[i].ctrl_flush_ack     = '0;
    assign IC_ctrl_unit_bus_main[i].ctrl_ack_enable    = '0;
    assign IC_ctrl_unit_bus_main[i].ctrl_ack_disable   = '0;
    assign IC_ctrl_unit_bus_main[i].ctrl_pending_trans = '0;
    assign IC_ctrl_unit_bus_main[i].sel_flush_ack      = '0;
    `ifdef FEATURE_ICACHE_STAT
      assign IC_ctrl_unit_bus_main[i].ctrl_hit_count   = '0;
      assign IC_ctrl_unit_bus_main[i].ctrl_trans_count = '0;
      assign IC_ctrl_unit_bus_main[i].ctrl_miss_count  = '0;
    `endif
  end
end else begin : gen_hier_icache
  assign s_icache_flush_ready = '0;
  assign s_icache_l0_events = '0;
  assign s_icache_l1_events = '0;

  icache_hier_top #(
    .FETCH_ADDR_WIDTH     ( AddrWidth                  ), //= 32,
    .PRI_FETCH_DATA_WIDTH ( Cfg.iCachePrivateDataWidth ), //= 128,   // Tested for 32 and 128
    .SH_FETCH_DATA_WIDTH  ( 128                        ), //= 128,

    .NB_CORES             ( Cfg.NumCores        ), //= 8,

    .SH_NB_BANKS          ( Cfg.iCacheNumBanks  ), //= 1,
    .SH_NB_WAYS           ( Cfg.iCacheNumWays   ), //= 4,
    .SH_CACHE_SIZE        ( Cfg.iCacheSharedSize), //= 4*1024,  // in Byte
    .SH_CACHE_LINE        ( Cfg.iCacheNumLines  ), //= 1,       // in word of [SH_FETCH_DATA_WIDTH]

    .PRI_NB_WAYS          ( Cfg.iCacheNumWays   ), //= 4,
    .PRI_CACHE_SIZE       ( Cfg.iCachePrivateSize), //= 512,     // in Byte
    .PRI_CACHE_LINE       ( Cfg.iCacheNumLines  ), //= 1,       // in word of [PRI_FETCH_DATA_WIDTH]

    .AXI_ID               ( AxiIdInWidth ), //= 6,
    .AXI_ADDR             ( Cfg.AxiAddrWidth     ), //= 32,
    .AXI_USER             ( Cfg.AxiUserWidth     ), //= 6,
    .AXI_DATA             ( Cfg.AxiDataOutWidth  ), //= 64,

    .USE_REDUCED_TAG      ( Cfg.EnableReducedTag ), //= "TRUE",  // TRUE | FALSE
    .L2_SIZE              ( Cfg.L2Size            )  //= 512*1024 // Size of max(L2 ,ROM) program memory in Byte
  ) icache_top_i (
    .clk                       ( clk_i           ),
    .rst_n                     ( rst_ni          ),
    .test_en_i                 ( test_mode_i     ),

    .fetch_req_i               ( instr_req       ),
    .fetch_addr_i              ( instr_addr      ),
    .fetch_gnt_o               ( instr_gnt       ),

    .fetch_rvalid_o            ( instr_r_valid   ),
    .fetch_rdata_o             ( instr_r_rdata   ),

    .enable_l1_l15_prefetch_i  ( s_enable_l1_l15_prefetch ), // set it to 1 to use prefetch feature

    //AXI read address bus -------------------------------------------
    .axi_master_arid_o      ( s_core_instr_bus_req.ar.id     ),
    .axi_master_araddr_o    ( s_core_instr_bus_req.ar.addr   ),
    .axi_master_arlen_o     ( s_core_instr_bus_req.ar.len    ),  //burst length - 1 to 16
    .axi_master_arsize_o    ( s_core_instr_bus_req.ar.size   ),  //size of each transfer in burst
    .axi_master_arburst_o   ( s_core_instr_bus_req.ar.burst  ),  //accept only incr burst=01
    .axi_master_arlock_o    ( s_core_instr_bus_req.ar.lock   ),  //only normal access supported axs_awlock=00
    .axi_master_arcache_o   ( s_core_instr_bus_req.ar.cache  ),
    .axi_master_arprot_o    ( s_core_instr_bus_req.ar.prot   ),
    .axi_master_arregion_o  ( s_core_instr_bus_req.ar.region ), //
    .axi_master_aruser_o    ( s_core_instr_bus_req.ar.user   ),  //
    .axi_master_arqos_o     ( s_core_instr_bus_req.ar.qos    ),  //
    .axi_master_arvalid_o   ( s_core_instr_bus_req.ar_valid  ),  //master addr valid
    .axi_master_arready_i   ( s_core_instr_bus_resp.ar_ready ),  //slave ready to accept
    // ---------------------------------------------------------------

    //AXI BACKWARD read data bus ----------------------------------------------
    .axi_master_rid_i       ( s_core_instr_bus_resp.r.id     ),
    .axi_master_rdata_i     ( s_core_instr_bus_resp.r.data   ),
    .axi_master_rresp_i     ( s_core_instr_bus_resp.r.resp   ),
    .axi_master_rlast_i     ( s_core_instr_bus_resp.r.last   ), //last transfer in burst
    .axi_master_ruser_i     ( s_core_instr_bus_resp.r.user   ),
    .axi_master_rvalid_i    ( s_core_instr_bus_resp.r_valid  ), //slave data valid
    .axi_master_rready_o    ( s_core_instr_bus_req.r_ready   ), //master ready to accept

    // NOT USED ----------------------------------------------
    .axi_master_awid_o      ( s_core_instr_bus_req.aw.id     ),
    .axi_master_awaddr_o    ( s_core_instr_bus_req.aw.addr   ),
    .axi_master_awlen_o     ( s_core_instr_bus_req.aw.len    ),
    .axi_master_awsize_o    ( s_core_instr_bus_req.aw.size   ),
    .axi_master_awburst_o   ( s_core_instr_bus_req.aw.burst  ),
    .axi_master_awlock_o    ( s_core_instr_bus_req.aw.lock   ),
    .axi_master_awcache_o   ( s_core_instr_bus_req.aw.cache  ),
    .axi_master_awprot_o    ( s_core_instr_bus_req.aw.prot   ),
    .axi_master_awregion_o  ( s_core_instr_bus_req.aw.region ),
    .axi_master_awuser_o    ( s_core_instr_bus_req.aw.user   ),
    .axi_master_awqos_o     ( s_core_instr_bus_req.aw.qos    ),
    .axi_master_awvalid_o   ( s_core_instr_bus_req.aw_valid  ),
    .axi_master_awready_i   ( s_core_instr_bus_resp.aw_ready ),

    // NOT USED ----------------------------------------------
    .axi_master_wdata_o     ( s_core_instr_bus_req.w.data   ),
    .axi_master_wstrb_o     ( s_core_instr_bus_req.w.strb   ),
    .axi_master_wlast_o     ( s_core_instr_bus_req.w.last   ),
    .axi_master_wuser_o     ( s_core_instr_bus_req.w.user   ),
    .axi_master_wvalid_o    ( s_core_instr_bus_req.w_valid  ),
    .axi_master_wready_i    ( s_core_instr_bus_resp.w_ready ),
    // ---------------------------------------------------------------

    // NOT USED ----------------------------------------------
    .axi_master_bid_i       ( s_core_instr_bus_resp.b.id     ),
    .axi_master_bresp_i     ( s_core_instr_bus_resp.b.resp   ),
    .axi_master_buser_i     ( s_core_instr_bus_resp.b.user   ),
    .axi_master_bvalid_i    ( s_core_instr_bus_resp.b_valid  ),
    .axi_master_bready_o    ( s_core_instr_bus_req.b_ready   ),
    // ---------------------------------------------------------------

    .IC_ctrl_unit_bus_pri   ( IC_ctrl_unit_bus_pri      ),
    .IC_ctrl_unit_bus_main  ( IC_ctrl_unit_bus_main     )
  );
end

`REG_BUS_TYPEDEF_ALL(tcdm_scrubber_reg, logic[AddrWidth-1:0], logic[DataWidth-1:0], logic[BeWidth-1:0])

tcdm_scrubber_reg_req_t tcdm_scrubber_reg_req;
tcdm_scrubber_reg_rsp_t tcdm_scrubber_reg_rsp;

periph_to_reg #(
  .AW          ( AddrWidth               ),
  .DW          ( DataWidth               ),
  .BW          ( 8                       ),
  .IW          ( Cfg.NumCores + 1        ),
  .req_t       ( tcdm_scrubber_reg_req_t ),
  .rsp_t       ( tcdm_scrubber_reg_rsp_t )
) i_periph_to_tcdm_scrubber (
  .clk_i          ( clk_i                              ),
  .rst_ni         ( rst_ni                             ),
  .req_i          ( s_periph_tcdm_scrubber_bus.req     ),
  .add_i          ( s_periph_tcdm_scrubber_bus.add     ),
  .wen_i          ( s_periph_tcdm_scrubber_bus.wen     ),
  .wdata_i        ( s_periph_tcdm_scrubber_bus.wdata   ),
  .be_i           ( s_periph_tcdm_scrubber_bus.be      ),
  .id_i           ( s_periph_tcdm_scrubber_bus.id      ),
  .gnt_o          ( s_periph_tcdm_scrubber_bus.gnt     ),
  .r_rdata_o      ( s_periph_tcdm_scrubber_bus.r_rdata ),
  .r_opc_o        ( s_periph_tcdm_scrubber_bus.r_opc   ),
  .r_id_o         ( s_periph_tcdm_scrubber_bus.r_id    ),
  .r_valid_o      ( s_periph_tcdm_scrubber_bus.r_valid ),
  .reg_req_o      ( tcdm_scrubber_reg_req              ),
  .reg_rsp_i      ( tcdm_scrubber_reg_rsp              )
);

logic [Cfg.TcdmNumBank-1:0] bank_faults;
logic [Cfg.TcdmNumBank-1:0] ecc_single_error;
logic [Cfg.TcdmNumBank-1:0] ecc_multiple_error;
logic [Cfg.TcdmNumBank-1:0] scrubber_fix;
logic [Cfg.TcdmNumBank-1:0] scrubber_uncorrectable;
logic [Cfg.TcdmNumBank-1:0] scrubber_trigger;

generate
  if (Cfg.EnableECC) begin : gen_tcdm_scrubber
    assign bank_faults = ecc_single_error | ecc_multiple_error; // TODO: check

    ecc_manager      #(
      .NumBanks       ( Cfg.TcdmNumBank         ),
      .ecc_mgr_req_t  ( tcdm_scrubber_reg_req_t ),
      .ecc_mgr_rsp_t  ( tcdm_scrubber_reg_rsp_t )
    ) i_tcdm_scrubber (
      .clk_i                ( clk_i                  ),
      .rst_ni               ( rst_ni                 ),
      .ecc_mgr_req_i        ( tcdm_scrubber_reg_req  ),
      .ecc_mgr_rsp_o        ( tcdm_scrubber_reg_rsp  ),
      .bank_faults_i        ( bank_faults            ),
      .scrub_fix_i          ( scrubber_fix           ),
      .scrub_uncorrectable_i( scrubber_uncorrectable ),
      .scrub_trigger_o      ( scrubber_trigger       ),
      .test_write_mask_no   ( /* not used */         )
    );
  end else begin : gen_no_tcdm_scrubber
    assign bank_faults            = '0;
    assign scrubber_trigger       = '0;
    assign tcdm_scrubber_reg_rsp  = '0;
  end
endgenerate

/* TCDM banks */
tcdm_banks_wrap  #(
  .BankSize       ( TcdmNumRows        ),
  .NbBanks        ( Cfg.TcdmNumBank    ),
  .DataWidth      ( DataWidth          ),
  .AddrWidth      ( AddrWidth          ),
  .BeWidth        ( BeWidth            ),
  .IdWidth        ( TCDM_ID_WIDTH      ),
  .EnableEcc      (  Cfg.EnableECC     ),
  .EccInterco     (  Cfg.ECCInterco    ),
  .ProtectedWidth ( ProtectedTcdmWidth ),
  .HCI_MEM_SIZE   ( HciMemSizeParam    )
) tcdm_banks_i (
  .clk_i                 ( clk_i                    ),
  .rst_ni                ( rst_ni                   ),
  .test_mode_i           ( test_mode_i              ),
  // Scrubber
  .scrub_trigger_i       ( scrubber_trigger         ), // in the cluster control unit.
  .scrub_fix_o           ( scrubber_fix             ),
  .scrub_uncorrectable_o ( scrubber_uncorrectable   ),
  // ECC
  .ecc_single_error_o    ( ecc_single_error         ),
  .ecc_multiple_error_o  ( ecc_multiple_error       ),
  .tcdm_slave            ( s_tcdm_bus_sram          )  //PMU ??
);

/* AXI interconnect infrastructure (slices, size conversion) */
//********************************************************
//**************** AXI REGISTER SLICES *******************
//********************************************************
// CLUSTER TO SOC
`AXI_TYPEDEF_AW_CHAN_T(c2s_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[Cfg.AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_W_CHAN_T(c2s_w_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[Cfg.AxiDataOutWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_B_CHAN_T(c2s_b_chan_t,logic[Cfg.AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_AR_CHAN_T(c2s_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[Cfg.AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_R_CHAN_T(c2s_r_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[Cfg.AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

`AXI_TYPEDEF_REQ_T(c2s_req_t,c2s_aw_chan_t,c2s_w_chan_t,c2s_ar_chan_t)
`AXI_TYPEDEF_RESP_T(c2s_resp_t,c2s_b_chan_t,c2s_r_chan_t)

c2s_req_t   src_req, isolate_src_req ;
c2s_resp_t  src_resp, isolate_src_resp;

sync             #(
  .STAGES         ( Cfg.SyncStages ),
  .ResetValue     ( 1'b1           )
) i_isolate_synch (
  .clk_i          ( clk_i             ),
  .rst_ni         ( pwr_on_rst_ni     ),
  .serial_i       ( axi_isolate_i     ),
  .serial_o       ( axi_isolate_synch )
);

sync              #(
  .STAGES          ( Cfg.SyncStages ),
  .ResetValue      ( 1'b0           )
) i_fetch_en_synch (
  .clk_i           ( clk_i          ),
  .rst_ni          ( pwr_on_rst_ni  ),
  .serial_i        ( fetch_en_i     ),
  .serial_o        ( fetch_en_synch )
);

sync             #(
  .STAGES         ( Cfg.SyncStages ),
  .ResetValue     ( 1'b0           )
) i_sa_boot_synch (
  .clk_i          ( clk_i            ),
  .rst_ni         ( pwr_on_rst_ni    ),
  .serial_i       ( en_sa_boot_i     ),
  .serial_o       ( en_sa_boot_synch )
);

sync         #(
  .STAGES     ( Cfg.SyncStages ),
  .ResetValue ( 1'b0           )
) i_eoc_synch (
  .clk_i      ( clk_i         ),
  .rst_ni     ( pwr_on_rst_ni ),
  .serial_i   ( eoc_synch     ),
  .serial_o   ( eoc_o         )
);

sync              #(
  .STAGES          ( Cfg.SyncStages ),
  .ResetValue      ( 1'b0           )
) i_mbox_irq_synch (
  .clk_i           ( clk_i          ),
  .rst_ni          ( pwr_on_rst_ni  ),
  .serial_i        ( mbox_irq_i     ),
  .serial_o        ( mbox_irq_synch )
);

`AXI_TYPEDEF_AW_CHAN_T(c2s_remap_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_W_CHAN_T(c2s_remap_w_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[Cfg.AxiDataOutWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_B_CHAN_T(c2s_remap_b_chan_t,logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_AR_CHAN_T(c2s_remap_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_R_CHAN_T(c2s_remap_r_chan_t,logic[Cfg.AxiDataOutWidth-1:0],logic[AxiIdOutWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

`AXI_TYPEDEF_REQ_T(c2s_remap_req_t,c2s_remap_aw_chan_t,c2s_remap_w_chan_t,c2s_remap_ar_chan_t)
`AXI_TYPEDEF_RESP_T(c2s_remap_resp_t,c2s_remap_b_chan_t,c2s_remap_r_chan_t)

c2s_remap_req_t src_remap_req;
c2s_remap_resp_t src_remap_resp;

`AXI_ASSIGN_REQ_STRUCT(src_remap_req,s_data_master_req)
`AXI_ASSIGN_RESP_STRUCT(s_data_master_resp,src_remap_resp)

if (Cfg.AxiIdOutWidth != AxiIdOutWidth) begin : gen_c2s_idwremap
  axi_id_remap            #(
    .AxiSlvPortIdWidth     ( AxiIdOutWidth ),
    .AxiSlvPortMaxUniqIds  ( MaxUniqId ),
    .AxiMaxTxnsPerId       ( Cfg.AxiMaxOutTrans ),
    .AxiMstPortIdWidth     ( Cfg.AxiIdOutWidth ),
    .slv_req_t             ( c2s_remap_req_t ),
    .slv_resp_t            ( c2s_remap_resp_t ),
    .mst_req_t             ( c2s_req_t ),
    .mst_resp_t            ( c2s_resp_t )
  ) i_axi_out_id_remap (
    .clk_i       ( clk_i ),
    .rst_ni      ( rst_ni ),
    .slv_req_i   ( src_remap_req  ),
    .slv_resp_o  ( src_remap_resp ),
    .mst_req_o   ( isolate_src_req ),
    .mst_resp_i  ( isolate_src_resp )
  );
end else begin : gen_no_c2s_idwremap
  assign isolate_src_req = src_remap_req;
  assign src_remap_resp = isolate_src_resp;
end

axi_isolate            #(
  .NumPending           ( 8                   ),
  .TerminateTransaction ( 1                   ),
  .AtopSupport          ( 1                   ),
  .AxiAddrWidth         ( Cfg.AxiAddrWidth    ),
  .AxiDataWidth         ( Cfg.AxiDataOutWidth ),
  .AxiIdWidth           ( Cfg.AxiIdOutWidth   ),
  .AxiUserWidth         ( Cfg.AxiUserWidth    ),
  .axi_req_t            ( c2s_req_t           ),
  .axi_resp_t           ( c2s_resp_t          )
) i_axi_master_isolate  (
  .clk_i                ( clk_i             ),
  .rst_ni               ( rst_ni            ),
  .slv_req_i            ( isolate_src_req   ),
  .slv_resp_o           ( isolate_src_resp  ),
  .mst_req_o            ( src_req           ),
  .mst_resp_i           ( src_resp          ),
  .isolate_i            ( axi_isolate_synch ),
  .isolated_o           ( axi_isolated_o    )
);

axi_cdc_src  #(
 .aw_chan_t   ( c2s_aw_chan_t        ),
 .w_chan_t    ( c2s_w_chan_t         ),
 .b_chan_t    ( c2s_b_chan_t         ),
 .r_chan_t    ( c2s_r_chan_t         ),
 .ar_chan_t   ( c2s_ar_chan_t        ),
 .axi_req_t   ( c2s_req_t            ),
 .axi_resp_t  ( c2s_resp_t           ),
 .LogDepth    ( Cfg.AxiCdcLogDepth   ),
 .SyncStages  ( Cfg.AxiCdcSyncStages )
) axi_master_cdc_i (
 .src_rst_ni                       ( pwr_on_rst_ni               ),
 .src_clk_i                        ( clk_i                       ),
 .src_req_i                        ( src_req                     ),
 .src_resp_o                       ( src_resp                    ),
 .async_data_master_aw_wptr_o      ( async_data_master_aw_wptr_o ),
 .async_data_master_aw_rptr_i      ( async_data_master_aw_rptr_i ),
 .async_data_master_aw_data_o      ( async_data_master_aw_data_o ),
 .async_data_master_w_wptr_o       ( async_data_master_w_wptr_o  ),
 .async_data_master_w_rptr_i       ( async_data_master_w_rptr_i  ),
 .async_data_master_w_data_o       ( async_data_master_w_data_o  ),
 .async_data_master_ar_wptr_o      ( async_data_master_ar_wptr_o ),
 .async_data_master_ar_rptr_i      ( async_data_master_ar_rptr_i ),
 .async_data_master_ar_data_o      ( async_data_master_ar_data_o ),
 .async_data_master_b_wptr_i       ( async_data_master_b_wptr_i  ),
 .async_data_master_b_rptr_o       ( async_data_master_b_rptr_o  ),
 .async_data_master_b_data_i       ( async_data_master_b_data_i  ),
 .async_data_master_r_wptr_i       ( async_data_master_r_wptr_i  ),
 .async_data_master_r_rptr_o       ( async_data_master_r_rptr_o  ),
 .async_data_master_r_data_i       ( async_data_master_r_data_i  )
);

// SOC TO CLUSTER
`AXI_TYPEDEF_AW_CHAN_T(s2c_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[Cfg.AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_W_CHAN_T(s2c_w_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[Cfg.AxiDataInWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_B_CHAN_T(s2c_b_chan_t,logic[Cfg.AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_AR_CHAN_T(s2c_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[Cfg.AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_R_CHAN_T(s2c_r_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[Cfg.AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

`AXI_TYPEDEF_REQ_T(s2c_req_t,s2c_aw_chan_t,s2c_w_chan_t,s2c_ar_chan_t)
`AXI_TYPEDEF_RESP_T(s2c_resp_t,s2c_b_chan_t,s2c_r_chan_t)

s2c_req_t  dst_req;
s2c_resp_t dst_resp;

axi_cdc_dst   #(
  .aw_chan_t   ( s2c_aw_chan_t        ),
  .w_chan_t    ( s2c_w_chan_t         ),
  .b_chan_t    ( s2c_b_chan_t         ),
  .r_chan_t    ( s2c_r_chan_t         ),
  .ar_chan_t   ( s2c_ar_chan_t        ),
  .axi_req_t   ( s2c_req_t            ),
  .axi_resp_t  ( s2c_resp_t           ),
  .LogDepth    ( Cfg.AxiCdcLogDepth   ),
  .SyncStages  ( Cfg.AxiCdcSyncStages )
) axi_slave_cdc_i (
  .dst_rst_ni                       ( pwr_on_rst_ni              ),
  .dst_clk_i                        ( clk_i                      ),
  .dst_req_o                        ( dst_req                    ),
  .dst_resp_i                       ( dst_resp                   ),
  .async_data_slave_aw_wptr_i       ( async_data_slave_aw_wptr_i ),
  .async_data_slave_aw_rptr_o       ( async_data_slave_aw_rptr_o ),
  .async_data_slave_aw_data_i       ( async_data_slave_aw_data_i ),
  .async_data_slave_w_wptr_i        ( async_data_slave_w_wptr_i  ),
  .async_data_slave_w_rptr_o        ( async_data_slave_w_rptr_o  ),
  .async_data_slave_w_data_i        ( async_data_slave_w_data_i  ),
  .async_data_slave_ar_wptr_i       ( async_data_slave_ar_wptr_i ),
  .async_data_slave_ar_rptr_o       ( async_data_slave_ar_rptr_o ),
  .async_data_slave_ar_data_i       ( async_data_slave_ar_data_i ),
  .async_data_slave_b_wptr_o        ( async_data_slave_b_wptr_o  ),
  .async_data_slave_b_rptr_i        ( async_data_slave_b_rptr_i  ),
  .async_data_slave_b_data_o        ( async_data_slave_b_data_o  ),
  .async_data_slave_r_wptr_o        ( async_data_slave_r_wptr_o  ),
  .async_data_slave_r_rptr_i        ( async_data_slave_r_rptr_i  ),
  .async_data_slave_r_data_o        ( async_data_slave_r_data_o  )
);

// If the AXI ID width of the subordinate port does not match the one required, we interpose
// an AXI ID remapper. Otherwise the busses are simply assigned.
`AXI_TYPEDEF_AW_CHAN_T(s2c_remap_aw_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_W_CHAN_T(s2c_remap_w_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[Cfg.AxiDataInWidth/8-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_B_CHAN_T(s2c_remap_b_chan_t,logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_AR_CHAN_T(s2c_remap_ar_chan_t,logic[Cfg.AxiAddrWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])
`AXI_TYPEDEF_R_CHAN_T(s2c_remap_r_chan_t,logic[Cfg.AxiDataInWidth-1:0],logic[AxiIdInWidth-1:0],logic[Cfg.AxiUserWidth-1:0])

`AXI_TYPEDEF_REQ_T(s2c_remap_req_t,s2c_remap_aw_chan_t,s2c_remap_w_chan_t,s2c_remap_ar_chan_t)
`AXI_TYPEDEF_RESP_T(s2c_remap_resp_t,s2c_remap_b_chan_t,s2c_remap_r_chan_t)

s2c_remap_req_t dst_remap_req;
s2c_remap_resp_t dst_remap_resp;

if (Cfg.AxiIdInWidth != AxiIdInWidth) begin : gen_s2c_idwremap
  axi_id_remap            #(
    .AxiSlvPortIdWidth     ( Cfg.AxiIdInWidth ),
    .AxiSlvPortMaxUniqIds  ( MaxUniqId ),
    .AxiMaxTxnsPerId       ( Cfg.AxiMaxInTrans ),
    .AxiMstPortIdWidth     ( AxiIdInWidth ),
    .slv_req_t             ( s2c_req_t ),
    .slv_resp_t            ( s2c_resp_t ),
    .mst_req_t             ( s2c_remap_req_t ),
    .mst_resp_t            ( s2c_remap_resp_t )
  ) i_axi_in_id_remap (
    .clk_i       ( clk_i ),
    .rst_ni      ( rst_ni ),
    .slv_req_i   ( dst_req  ),
    .slv_resp_o  ( dst_resp ),
    .mst_req_o   ( dst_remap_req ),
    .mst_resp_i  ( dst_remap_resp )
  );
end else begin : gen_no_s2c_idwremap
  assign dst_remap_req = dst_req;   //TODO CHECK
  assign dst_resp = dst_remap_resp;
end

// If the external and internal data widths do not match, we interpose an AXI
// data width converter, otherwise the buses are simply assigned.
if (Cfg.AxiDataInWidth != Cfg.AxiDataOutWidth) begin
  `AXI_ASSIGN_REQ_STRUCT(s_data_slave_32_req,dst_remap_req)
  `AXI_ASSIGN_RESP_STRUCT(dst_remap_resp,s_data_slave_32_resp)

  axi_dw_converter_intf #(
    .AXI_ID_WIDTH            ( AxiIdInWidth         ),
    .AXI_ADDR_WIDTH          ( Cfg.AxiAddrWidth     ),
    .AXI_SLV_PORT_DATA_WIDTH ( Cfg.AxiDataInWidth   ),
    .AXI_MST_PORT_DATA_WIDTH ( Cfg.AxiDataOutWidth  ),
    .AXI_USER_WIDTH          ( Cfg.AxiUserWidth     ),
    .AXI_MAX_READS           ( 1                    ),
    .aw_chan_t               ( s2c_in_int_aw_chan_t ),
    .mst_w_chan_t            ( c2s_w_chan_t         ),
    .slv_w_chan_t            ( s2c_in_int_w_chan_t  ),
    .b_chan_t                ( s2c_in_int_b_chan_t  ),
    .ar_chan_t               ( s2c_in_int_ar_chan_t ),
    .mst_r_chan_t            ( c2s_in_int_r_chan_t  ),
    .slv_r_chan_t            ( s2c_in_int_r_chan_t  ),
    .axi_mst_req_t           ( c2s_in_int_req_t     ),
    .axi_mst_resp_t          ( c2s_in_int_resp_t    ),
    .axi_slv_req_t           ( s2c_in_int_req_t     ),
    .axi_slv_resp_t          ( s2c_in_int_resp_t    )
  ) axi_dw_UPSIZE_32_64_wrap_i (
    .clk_i     ( clk_i                ),
    .rst_ni    ( s_rst_n              ),
    .slv_req_i ( s_data_slave_32_req  ),
    .slv_resp_o( s_data_slave_32_resp ),
    .mst_req_o ( s_data_slave_64_req  ),
    .mst_resp_i( s_data_slave_64_resp )
  );
end else begin
  `AXI_ASSIGN_REQ_STRUCT(s_data_slave_64_req,dst_remap_req)
  `AXI_ASSIGN_RESP_STRUCT(dst_remap_resp,s_data_slave_64_resp)
end

/* event synchronizers */
cdc_fifo_gray_dst #(
  .T(logic[EventWidth-1:0]),
  .LOG_DEPTH(Cfg.AxiCdcLogDepth),
  .SYNC_STAGES(2)
) u_event_dc (
  .dst_clk_i                ( clk_i                       ),
  .dst_rst_ni               ( rst_ni                      ),
  .dst_data_o               ( s_events_data               ),
  .dst_valid_o              ( s_events_valid              ),
  .dst_ready_i              ( s_events_ready              ),
  (* async *) .async_data_i ( async_cluster_events_data_i ),
  (* async *) .async_wptr_i ( async_cluster_events_wptr_i ),
  (* async *) .async_rptr_o ( async_cluster_events_rptr_o )
);
assign s_events_async = s_events_valid;

edge_propagator_tx ep_dma_pe_evt_i (
  .clk_i   ( clk_i              ),
  .rstn_i  ( rst_ni             ),
  .valid_i ( s_dma_fc_event     ),
  .ack_i   ( dma_pe_evt_ack_i   ),
  .valid_o ( dma_pe_evt_valid_o )
);

edge_propagator_tx ep_dma_pe_irq_i (
  .clk_i   ( clk_i              ),
  .rstn_i  ( rst_ni             ),
  .valid_i ( s_dma_fc_irq       ),
  .ack_i   ( dma_pe_irq_ack_i   ),
  .valid_o ( dma_pe_irq_valid_o )
);

endmodule
