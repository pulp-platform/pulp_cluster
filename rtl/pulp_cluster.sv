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
  localparam int unsigned FpuOutFlagsWidth = 5
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
  $error("AXI input ID width must be larger than 1+$clog2(Cfg.iCacheNumBanks) which is %d but was %d", 1 + $clog2(Cfg.iCacheNumBanks), Cfg.AxiIdInWidth);

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
logic [Cfg.NumCores-1:0][31:0]          boot_addr;
logic [Cfg.NumCores-1:0]                dbg_core_halt;
logic [Cfg.NumCores-1:0]                dbg_core_resume;
logic [Cfg.NumCores-1:0]                dbg_core_halted;
logic [Cfg.NumCores-1:0]                dbg_core_havereset;
logic [Cfg.NumCores-1:0]                dbg_core_running;
logic [Cfg.NumCores-1:0]                s_dbg_irq;
logic                               s_hwpe_en;

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

logic [Cfg.NumCores-1:0]               core_busy;

logic                              s_incoming_req;
logic                              s_isolate_cluster;
logic                              s_events_async;

logic                              s_events_valid;
logic                              s_events_ready;
logic [EventWidth-1:0]             s_events_data;

// Signals Between CORE_ISLAND and INSTRUCTION CACHES
logic [Cfg.NumCores-1:0]                        instr_req;
logic [Cfg.NumCores-1:0][31:0]                  instr_addr;
logic [Cfg.NumCores-1:0]                        instr_gnt;
logic [Cfg.NumCores-1:0]                        instr_r_valid;
logic [Cfg.NumCores-1:0][Cfg.iCachePrivateDataWidth-1:0] instr_r_rdata;

logic [1:0]                                 s_TCDM_arb_policy;
logic                                       tcdm_sleep;

// FIXME: iDMA
// logic               s_dma_pe_event;
// logic               s_dma_pe_irq;
// logic               s_pf_event;

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
 
// FIXME: iDMA
// logic                                       s_dma_decompr_event;
// logic                                       s_dma_decompr_irq;

// logic                                       s_decompr_done_evt;

// assign s_dma_fc_irq = s_decompr_done_evt;

/* logarithmic and peripheral interconnect interfaces */
// ext -> log interconnect
hci_core_intf #(
  .DW ( DataWidth ),
  .AW ( AddrWidth ),
  .OW ( 1  )
) s_hci_ext[Cfg.DmaNumPlugs-1:0] (
  .clk ( clk_i )
);

// periph interconnect -> slave peripherals
XBAR_PERIPH_BUS s_xbar_speriph_bus[Cfg.NumSlvPeriphs-1:0]();

// periph interconnect -> HWPE subsystem
XBAR_PERIPH_BUS s_hwpe_cfg_bus();

// DMA -> log interconnect
hci_core_intf #(
  .DW ( DataWidth ),
  .AW ( AddrWidth ),
  .OW ( 1  )
) s_hci_dma[Cfg.DmaNumPlugs-1:0] (
  .clk ( clk_i )
);
XBAR_TCDM_BUS s_dma_plugin_xbar_bus[Cfg.DmaNumPlugs-1:0]();

// ext -> xbar periphs FIXME
XBAR_TCDM_BUS s_mperiph_xbar_bus[Cfg.NumMstPeriphs-1:0]();

// periph demux
XBAR_TCDM_BUS s_mperiph_bus();

// cores & accelerators -> log interconnect
hci_core_intf #(
  .DW ( Cfg.HwpeNumPorts * DataWidth ),
  .AW ( AddrWidth               ),
  .OW ( 1                )
) s_hci_hwpe [0:0] (
  .clk ( clk_i )
);
hci_core_intf #(
  .DW ( DataWidth ),
  .AW ( AddrWidth ),
  .OW ( 1  )
) s_hci_core [Cfg.NumCores-1:0] (
  .clk ( clk_i )
);

// cores -> periph interconnect
XBAR_PERIPH_BUS s_core_periph_bus[Cfg.NumCores-1:0]();

// periph interconnect -> DMA
XBAR_PERIPH_BUS s_periph_dma_bus[1:0]();

// periph interconnect -> HMR unit
XBAR_PERIPH_BUS s_periph_hmr_bus ();

// debug
XBAR_TCDM_BUS s_debug_bus[Cfg.NumCores-1:0]();

/* other interfaces */
// cores -> DMA ctrl
// FIXME: iDMA
// XBAR_TCDM_BUS s_core_dmactrl_bus[NB_CORES-1:0]();
hci_core_intf #(
  .DW ( DataWidth ),
  .AW ( AddrWidth ),
  .OW ( 1          ),
  .UW ( 0          )
) s_core_dmactrl_bus [Cfg.NumCores-1:0] (
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
SP_ICACHE_CTRL_UNIT_BUS      IC_ctrl_unit_bus_main[Cfg.iCacheNumBanks]();
PRI_ICACHE_CTRL_UNIT_BUS     IC_ctrl_unit_bus_pri[Cfg.NumCores]();
logic                        s_special_core_icache_cfg;
logic[Cfg.NumCores-1:0]          s_enable_l1_l15_prefetch;
//----------------------------------------------------------------------//

localparam TCDM_ID_WIDTH = Cfg.NumCores + Cfg.DmaNumPlugs + 4 + Cfg.HwpeNumPorts;

// log interconnect -> TCDM memory banks (SRAM)
hci_mem_intf #(
  .AW ( AddrWidth    ),
  .DW ( DataWidth    ),
  .BW ( 8      ),
  .IW ( TCDM_ID_WIDTH )
) s_tcdm_bus_sram[Cfg.TcdmNumBank-1:0] (
  .clk ( clk_i )
);

//***************************************************
/* synchronous AXI interfaces at CLUSTER/SOC interface */
//*************************************************** 
AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth    ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_data_slave_int();

AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth   ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataInWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth   ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth   )
) s_data_slave_ext();

AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdOutWidth   ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_data_master(); 

AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth    ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_core_instr_bus(); 

// ***********************************************************************************************+
// ***********************************************************************************************+
// ***********************************************************************************************+
// ***********************************************************************************************+
// ***********************************************************************************************+
 
//***************************************************
/* synchronous AXI interfaces internal to the cluster */
//*************************************************** 

// core per2axi -> ext
AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth    ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_core_ext_bus(); 

// DMA -> ext
AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth    ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_dma_ext_bus(); 

// ext -> axi2mem
AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdOutWidth   ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_ext_tcdm_bus(); 

// cluster bus -> axi2per 
AXI_BUS #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdOutWidth   ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) s_ext_mperiph_bus();

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
  .AXI_ID_IN_WIDTH        ( Cfg.AxiIdInWidth            ),
  .AXI_ID_OUT_WIDTH       ( Cfg.AxiIdOutWidth           ),
  .BaseAddr               ( Cfg.ClusterBaseAddr         ),
  .ClusterPeripheralsOffs ( Cfg.ClusterPeriphOffs       ),
  .ClusterExternalOffs    ( Cfg.ClusterExternalOffs     )
) cluster_bus_wrap_i (
  .clk_i         ( clk_i             ),
  .rst_ni        ( rst_ni            ),
  .test_en_i     ( test_mode_i       ),
  .cluster_id_i  ( '0                ),
  .instr_slave   ( s_core_instr_bus  ),
  .data_slave    ( s_core_ext_bus    ),
  .dma_slave     ( s_dma_ext_bus     ),
  .ext_slave     ( s_data_slave_int  ),
  .tcdm_master   ( s_ext_tcdm_bus    ),
  .periph_master ( s_ext_mperiph_bus ),
  .ext_master    ( s_data_master     )
);

axi2mem_wrap #(
  .NB_DMAS        ( Cfg.DmaNumPlugs     ),
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdOutWidth   )
) axi2mem_wrap_i (
  .clk_i       ( clk_i          ),
  .rst_ni      ( rst_ni         ),
  .test_en_i   ( test_mode_i    ),
  .axi_slave   ( s_ext_tcdm_bus ),
  .tcdm_master ( s_hci_ext      ),
  .busy_o      ( s_axi2mem_busy )
);

axi2per_wrap #(
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth    ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdOutWidth   ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth    )
) axi2per_wrap_i (
  .clk_i         ( clk_i             ),
  .rst_ni        ( rst_ni            ),
  .test_en_i     ( test_mode_i       ),
  .axi_slave     ( s_ext_mperiph_bus ),
  .periph_master ( s_mperiph_bus     ),
  .busy_o        ( s_axi2per_busy    )
);

if (Cfg.NumMstPeriphs > 1) begin
  XBAR_TCDM_BUS s_mperiph_demux_bus[Cfg.NumMstPeriphs-1:0]();
  per_demux_wrap #(
    .NB_MASTERS  ( Cfg.NumMstPeriphs ),
    .ADDR_OFFSET ( 20          )
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
  .PER_ADDR_WIDTH ( 32                               ),
  .PER_ID_WIDTH   ( Cfg.NumCores + Cfg.NumMstPeriphs ),
  .AXI_ADDR_WIDTH ( Cfg.AxiAddrWidth                 ),
  .AXI_DATA_WIDTH ( Cfg.AxiDataOutWidth              ),
  .AXI_USER_WIDTH ( Cfg.AxiUserWidth                 ),
  .AXI_ID_WIDTH   ( Cfg.AxiIdInWidth                 )
) per2axi_wrap_i  (
  .clk_i          ( clk_i                           ),
  .rst_ni         ( rst_ni                          ),
  .test_en_i      ( test_mode_i                     ),
  .periph_slave   ( s_xbar_speriph_bus[SPER_EXT_ID] ),
  .axi_master     ( s_core_ext_bus                  ),
  .busy_o         ( s_per2axi_busy                  )
);

//***************************************************
/* cluster (log + periph) interconnect and attached peripherals */
//*************************************************** 

cluster_interconnect_wrap #(
  .NB_CORES               ( Cfg.NumCores           ),
  .HWPE_PRESENT           ( Cfg.HwpePresent        ),
  .NB_HWPE_PORTS          ( Cfg.HwpeNumPorts       ),
  .NB_DMAS                ( Cfg.DmaNumPlugs        ),
  .NB_MPERIPHS            ( Cfg.NumMstPeriphs      ),
  .NB_TCDM_BANKS          ( Cfg.TcdmNumBank        ),
  .NB_SPERIPHS            ( Cfg.NumSlvPeriphs      ),

  .DATA_WIDTH             ( DataWidth              ),
  .ADDR_WIDTH             ( AddrWidth              ),
  .BE_WIDTH               ( BeWidth                ),
  .ClusterBaseAddr        ( Cfg.ClusterBaseAddr    ),
  .ClusterPeripheralsOffs ( Cfg.ClusterPeriphOffs  ),
  .ClusterExternalOffs    ( Cfg.ClusterExternalOffs),

  .TEST_SET_BIT           ( TestSetBit             ),
  .ADDR_MEM_WIDTH         ( AddrMemWidth           ),

  .PE_ROUTING_LSB         ( PeRoutingLsb           ),
  .CLUSTER_ALIAS          ( Cfg.ClusterAlias       ),
  .USE_HETEROGENEOUS_INTERCONNECT ( Cfg.UseHci )

) cluster_interconnect_wrap_i (
  .clk_i              ( clk_i                                     ),
  .rst_ni             ( rst_ni                                    ),
  .cluster_id_i       ( '0                                        ),

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
`ifdef TARGET_MCHAN
  dmac_wrap #(
    .NB_CTRLS           ( Cfg.NumCores + 2            ),
    .NB_CORES           ( Cfg.NumCores                ),
    .NB_OUTSND_BURSTS   ( Cfg.DmaNumOutstandingBursts ),
    .MCHAN_BURST_LENGTH ( Cfg.DmaBurstLength          ),
    .AXI_ADDR_WIDTH     ( Cfg.AxiAddrWidth            ),
    .AXI_DATA_WIDTH     ( Cfg.AxiDataOutWidth         ),
    .AXI_ID_WIDTH       ( Cfg.AxiIdInWidth            ),
    .AXI_USER_WIDTH     ( Cfg.AxiUserWidth            ),
    .PE_ID_WIDTH        ( Cfg.NumCores + 1            ),
    .TCDM_ADD_WIDTH     ( TcdmAddrWidth               ),
    .DATA_WIDTH         ( DataWidth                   ),
    .ADDR_WIDTH         ( AddrWidth                   ),
    .BE_WIDTH           ( BeWidth                     )
  ) dmac_wrap_i        (
    .clk_i             ( clk_i              ),
    .rst_ni            ( rst_ni             ),
    .test_mode_i       ( test_mode_i        ),
    .ctrl_slave        ( s_core_dmactrl_bus ),
    .cl_ctrl_slave     ( s_periph_dma_bus[0]),
    .fc_ctrl_slave     ( s_periph_dma_bus[1]),
    .tcdm_master       ( s_hci_dma          ),
    .ext_master        ( s_dma_ext_bus      ),
    .term_event_cl_o   ( s_dma_cl_event     ),
    .term_irq_cl_o     ( s_dma_cl_irq       ),
    .term_event_pe_o   ( s_dma_fc_event     ),
    .term_irq_pe_o     ( s_dma_fc_irq       ),
    .term_event_o      ( s_dma_event        ),
    .term_irq_o        ( s_dma_irq          ),
    .busy_o            ( s_dmac_busy        )
  );
`else
  dmac_wrap #(
    .NB_CORES         ( Cfg.NumCores                ),
    .AXI_ADDR_WIDTH   ( Cfg.AxiAddrWidth            ),
    .AXI_DATA_WIDTH   ( Cfg.AxiDataOutWidth         ),
    .AXI_USER_WIDTH   ( Cfg.AxiUserWidth            ),
    .AXI_ID_WIDTH     ( Cfg.AxiIdInWidth            ),
    .PE_ID_WIDTH      ( Cfg.NumCores + 1            ),
    .NB_PE_PORTS      ( 2                           ),
    .DATA_WIDTH       ( DataWidth                   ),
    .ADDR_WIDTH       ( AddrWidth                   ),
    .BE_WIDTH         ( BE_WIDTH                    ),
    .NUM_STREAMS      ( 4                           ),
    .TCDM_SIZE        ( Cfg.TcdmSize                ),
    .NB_OUTSND_BURSTS ( Cfg.DmaNumOutstandingBursts ),
    .ClusterBaseAddr  ( Cfg.ClusterBaseAddr         )
  ) dmac_wrap_i     (
    .clk_i          ( clk_i                            ),
    .rst_ni         ( rst_ni                           ),
    .test_mode_i    ( test_mode_i                      ),
    .pe_ctrl_slave  ( s_periph_dma_bus[1:0]            ),
    .ctrl_slave     ( s_core_dmactrl_bus               ),
    .tcdm_master    ( s_hci_dma                        ),
    .ext_master     ( s_dma_ext_bus                    ),
    .term_event_o   ( s_dma_event                      ),
    .term_irq_o     ( s_dma_irq                        ),
    .term_event_pe_o( {s_dma_fc_event, s_dma_cl_event} ),
    .term_irq_pe_o  ( {s_dma_fc_irq, s_dma_cl_irq}     ),
    .busy_o         ( s_dmac_busy                      )
  );
`endif

//***************************************************
//**************CLUSTER PERIPHERALS******************
//***************************************************
cluster_peripherals #(
  .NB_CORES       ( Cfg.NumCores      ),
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
  .hci_ctrl_o               ( s_hci_ctrl                        ),
  .IC_ctrl_unit_bus_main    (  IC_ctrl_unit_bus_main            ),
  .IC_ctrl_unit_bus_pri     (  IC_ctrl_unit_bus_pri             ),
  .enable_l1_l15_prefetch_o (  s_enable_l1_l15_prefetch         )
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
`REG_BUS_TYPEDEF_ALL(hmr_reg, logic[31:0], logic[31:0], logic[3:0])
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
      .N_EXT_PERF_COUNTERS ( 5                          ),
      .ADDR_WIDTH          ( 32                         ),
      .DATA_WIDTH          ( 32                         ),
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
      .SHARED_FP           ( Cfg.EnableSharedFpu        ),
      .SHARED_FP_DIVSQRT   ( Cfg.EnableSharedFpDivSqrt  ),
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
      .ext_perf_i          ( ext_perf[i]               ),
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

hmr_unit #(
  .NumCores          ( Cfg.NumCores                         ),
  .DMRSupported      ( 1                                    ),
  .DMRFixed          ( 0                                    ),
  .TMRSupported      ( 1                                    ),
  .TMRFixed          ( 0                                    ),
  .InterleaveGrps    ( 1                                    ),
  .RapidRecovery     ( 1                                    ),
  .SeparateData      ( 1                                    ),
  .NumBusVoters      ( 1                                    ),
  .all_inputs_t      ( core_inputs_t                        ),
  .nominal_outputs_t ( core_outputs_t                       ),
  .core_backup_t     ( core_backup_t                        ),
  .reg_req_t         ( hmr_reg_req_t                        ),
  .reg_rsp_t         ( hmr_reg_rsp_t                        ),
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
  .core_bus_outputs_i     ( '0           )
);

//****************************************************
//**** Shared FPU cluster - Shared execution units ***
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

generate
  if (Cfg.EnableSharedFpu) begin
    shared_fpu_cluster #(
      .NB_CORES         ( Cfg.NumCores      ),
      .NB_APUS          ( 1                 ), // Number of shared FpuDivSqrt
      .NB_FPNEW         ( Cfg.NumSharedFpu  ),
      .FP_TYPE_WIDTH    ( FpuTypeWidth      ),

      .NB_CORE_ARGS      ( FpuNumArgs       ),
      .CORE_DATA_WIDTH   ( 32               ),
      .CORE_OPCODE_WIDTH ( FpuOpCodeWidth   ),
      .CORE_DSFLAGS_CPU  ( FpuInFlagsWidth  ),
      .CORE_USFLAGS_CPU  ( FpuOutFlagsWidth ),

      .NB_APU_ARGS      ( FpuNumArgs        ),
      .APU_OPCODE_WIDTH ( FpuOpCodeWidth    ),
      .APU_DSFLAGS_CPU  ( FpuInFlagsWidth   ),
      .APU_USFLAGS_CPU  ( FpuOutFlagsWidth  ),

      .NB_FPNEW_ARGS        ( FpuNumArgs       ),
      .FPNEW_OPCODE_WIDTH   ( FpuOutFlagsWidth ),
      .FPNEW_DSFLAGS_CPU    ( FpuInFlagsWidth  ),
      .FPNEW_USFLAGS_CPU    ( FpuOutFlagsWidth ),

      .APUTYPE_ID       ( 1                 ),
      .FPNEWTYPE_ID     ( 0                 ),

      .C_FPNEW_FMTBITS     (fpnew_pkg::FP_FORMAT_BITS  ),
      .C_FPNEW_IFMTBITS    (fpnew_pkg::INT_FORMAT_BITS ),
      .C_ROUND_BITS        (3                          ),
      .C_FPNEW_OPBITS      (fpnew_pkg::OP_BITS         ),
      .USE_FPU_OPT_ALLOC   ("FALSE"),
      .USE_FPNEW_OPT_ALLOC ("TRUE"),
      .FPNEW_INTECO_TYPE   ("SINGLE_INTERCO")
    ) i_shared_fpu_cluster (
      .clk                   ( clk_i                   ),
      .rst_n                 ( rst_ni                  ),
      .test_mode_i           ( test_mode_i             ),
      .core_slave_req_i      ( s_apu_master_req        ),
      .core_slave_gnt_o      ( s_apu_master_gnt        ),
      .core_slave_type_i     ( s_apu__type             ),
      .core_slave_operands_i ( s_apu__operands         ),
      .core_slave_op_i       ( s_apu__op               ),
      .core_slave_flags_i    ( s_apu__flags            ),
      .core_slave_rready_i   ( s_apu_master_rready     ),
      .core_slave_rvalid_o   ( s_apu_master_rvalid     ),
      .core_slave_rdata_o    ( s_apu_master_rdata      ),
      .core_slave_rflags_o   ( s_apu__rflags           )
    );
  end else begin
    assign s_apu_master_gnt    = '0;
    assign s_apu_master_rvalid = '0;
    assign s_apu_master_rdata  = '0;
    assign s_apu__rflags       = '0;
  end
endgenerate

//**************************************************************
//**** HW Processing Engines / Cluster-Coupled Accelerators ****
//**************************************************************
generate
  if(Cfg.HwpePresent) begin: hwpe_gen
    hwpe_subsystem #(
      .N_CORES       ( Cfg.NumCores                     ),
      .N_MASTER_PORT ( Cfg.HwpeNumPorts                 ),
      .ID_WIDTH      ( Cfg.NumCores + Cfg.NumMstPeriphs )
    ) hwpe_subsystem_i (
      .clk               ( clk_i          ),
      .rst_n             ( rst_ni         ),
      .test_mode         ( test_mode_i    ),
      .hwpe_en_i         ( s_hwpe_en      ),
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
    assign s_hci_hwpe[0].boffs = '0;
    assign s_hci_hwpe[0].lrdy  = '1;
    assign s_hci_hwpe[0].user  = '0;
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

icache_hier_top #(
  .FETCH_ADDR_WIDTH     ( 32                         ), //= 32,
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

  .AXI_ID               ( Cfg.AxiIdInWidth     ), //= 6,
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
  .axi_master_arid_o      ( s_core_instr_bus.ar_id     ),
  .axi_master_araddr_o    ( s_core_instr_bus.ar_addr   ),
  .axi_master_arlen_o     ( s_core_instr_bus.ar_len    ),  //burst length - 1 to 16
  .axi_master_arsize_o    ( s_core_instr_bus.ar_size   ),  //size of each transfer in burst
  .axi_master_arburst_o   ( s_core_instr_bus.ar_burst  ),  //accept only incr burst=01
  .axi_master_arlock_o    ( s_core_instr_bus.ar_lock   ),  //only normal access supported axs_awlock=00
  .axi_master_arcache_o   ( s_core_instr_bus.ar_cache  ),
  .axi_master_arprot_o    ( s_core_instr_bus.ar_prot   ),
  .axi_master_arregion_o  ( s_core_instr_bus.ar_region ), //
  .axi_master_aruser_o    ( s_core_instr_bus.ar_user   ),  //
  .axi_master_arqos_o     ( s_core_instr_bus.ar_qos    ),  //
  .axi_master_arvalid_o   ( s_core_instr_bus.ar_valid  ),  //master addr valid
  .axi_master_arready_i   ( s_core_instr_bus.ar_ready  ),  //slave ready to accept
  // ---------------------------------------------------------------

  //AXI BACKWARD read data bus ----------------------------------------------
  .axi_master_rid_i       ( s_core_instr_bus.r_id     ),
  .axi_master_rdata_i     ( s_core_instr_bus.r_data   ),
  .axi_master_rresp_i     ( s_core_instr_bus.r_resp   ),
  .axi_master_rlast_i     ( s_core_instr_bus.r_last   ), //last transfer in burst
  .axi_master_ruser_i     ( s_core_instr_bus.r_user   ),
  .axi_master_rvalid_i    ( s_core_instr_bus.r_valid  ), //slave data valid
  .axi_master_rready_o    ( s_core_instr_bus.r_ready  ), //master ready to accept

  // NOT USED ----------------------------------------------
  .axi_master_awid_o      ( s_core_instr_bus.aw_id     ),
  .axi_master_awaddr_o    ( s_core_instr_bus.aw_addr   ),
  .axi_master_awlen_o     ( s_core_instr_bus.aw_len    ),
  .axi_master_awsize_o    ( s_core_instr_bus.aw_size   ),
  .axi_master_awburst_o   ( s_core_instr_bus.aw_burst  ),
  .axi_master_awlock_o    ( s_core_instr_bus.aw_lock   ),
  .axi_master_awcache_o   ( s_core_instr_bus.aw_cache  ),
  .axi_master_awprot_o    ( s_core_instr_bus.aw_prot   ),
  .axi_master_awregion_o  ( s_core_instr_bus.aw_region ),
  .axi_master_awuser_o    ( s_core_instr_bus.aw_user   ),
  .axi_master_awqos_o     ( s_core_instr_bus.aw_qos    ),
  .axi_master_awvalid_o   ( s_core_instr_bus.aw_valid  ),
  .axi_master_awready_i   ( s_core_instr_bus.aw_ready  ),

  // NOT USED ----------------------------------------------
  .axi_master_wdata_o     ( s_core_instr_bus.w_data   ),
  .axi_master_wstrb_o     ( s_core_instr_bus.w_strb   ),
  .axi_master_wlast_o     ( s_core_instr_bus.w_last   ),
  .axi_master_wuser_o     ( s_core_instr_bus.w_user   ),
  .axi_master_wvalid_o    ( s_core_instr_bus.w_valid  ),
  .axi_master_wready_i    ( s_core_instr_bus.w_ready  ),
  // ---------------------------------------------------------------

  // NOT USED ----------------------------------------------
  .axi_master_bid_i       ( s_core_instr_bus.b_id     ),
  .axi_master_bresp_i     ( s_core_instr_bus.b_resp   ),
  .axi_master_buser_i     ( s_core_instr_bus.b_user   ),
  .axi_master_bvalid_i    ( s_core_instr_bus.b_valid  ),
  .axi_master_bready_o    ( s_core_instr_bus.b_ready  ),
  // ---------------------------------------------------------------

  .IC_ctrl_unit_bus_pri   ( IC_ctrl_unit_bus_pri      ),
  .IC_ctrl_unit_bus_main  ( IC_ctrl_unit_bus_main     )
);

assign s_core_instr_bus.aw_atop = '0; 

/* TCDM banks */
tcdm_banks_wrap #(
  .BankSize    ( TcdmNumRows     ),
  .NbBanks     ( Cfg.TcdmNumBank ),
  .DataWidth   ( DataWidth       ),
  .AddrWidth   ( AddrWidth       ),
  .BeWidth     ( BeWidth         ),
  .IdWidth     ( TCDM_ID_WIDTH   ),
  .EnableEcc   (  1              ),
  .EccInterco  (  0              ) // Not supported at the moment
) tcdm_banks_i (
  .clk_i                 ( clk_i                    ),
  .rst_ni                ( rst_ni                   ),
  .test_mode_i           ( test_mode_i              ),
  // Scrubber
  .scrub_trigger_i       ( '0                       ), // TODO: to be connected to a register
                                                       // in the cluster control unit.
  .scrub_fix_o           ( /* TODO: left pending */ ),
  .scrub_uncorrectable_o ( /* TODO: left pending */ ),
  // ECC
  .ecc_single_error_o    ( /* TODO: left pending */ ),
  .ecc_multile_error_o   ( /* TODO: left pending */ ),
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
 
`AXI_ASSIGN_TO_REQ(isolate_src_req,s_data_master)
`AXI_ASSIGN_FROM_RESP(s_data_master,isolate_src_resp)

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

s2c_req_t  dst_req , isolate_dst_req;
s2c_resp_t dst_resp, isolate_dst_resp;

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

if (Cfg.AxiDataInWidth != Cfg.AxiDataOutWidth) begin
  `AXI_ASSIGN_FROM_REQ(s_data_slave_ext,dst_req)
  `AXI_ASSIGN_TO_RESP(dst_resp,s_data_slave_ext)

  axi_dw_converter_intf #(
    .AXI_ID_WIDTH            ( Cfg.AxiIdInWidth   ),
    .AXI_ADDR_WIDTH          ( Cfg.AxiAddrWidth   ),
    .AXI_SLV_PORT_DATA_WIDTH ( Cfg.AxiDataInWidth ),
    .AXI_MST_PORT_DATA_WIDTH ( Cfg.AxiDataOutWidth),
    .AXI_USER_WIDTH          ( Cfg.AxiUserWidth   ),
    .AXI_MAX_READS           ( 1                  )
  ) axi_dw_UPSIZE_32_64_wrap_i (
    .clk_i  ( clk_i            ),
    .rst_ni ( rst_ni           ),
    .slv    ( s_data_slave_ext ),
    .mst    ( s_data_slave_int )
  );
end else begin
  `AXI_ASSIGN_FROM_REQ(s_data_slave_int,dst_req)
  `AXI_ASSIGN_TO_RESP(dst_resp,s_data_slave_int)
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
