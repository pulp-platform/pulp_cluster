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

import pulp_cluster_package::*;
import hci_package::*;

`include "pulp_soc_defines.sv"
`include "cluster_bus_defines.sv"
`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"


module pulp_cluster
#(
  // cluster parameters
  parameter CORE_TYPE_CL            = 0, // 0 for RISCY, 1 for IBEX RV32IMC (formerly ZERORISCY), 2 for IBEX RV32EC (formerly MICRORISCY)
  parameter NB_CORES           = 8,
  parameter NB_HWPE_PORTS      = 9,
  // number of DMA TCDM plugs, NOT number of DMA slave peripherals!
  // Everything will go to hell if you change this!
  parameter NB_DMAS            = 4,
  parameter NB_MPERIPHS        = NB_MPERIPHS,
  parameter NB_SPERIPHS        = NB_SPERIPHS,
  
  parameter CLUSTER_ALIAS_BASE      = 12'h000,
  
  parameter TCDM_SIZE               = 64*1024,                 // [B], must be 2**N
  parameter NB_TCDM_BANKS           = 16,                      // must be 2**N
  parameter TCDM_BANK_SIZE          = TCDM_SIZE/NB_TCDM_BANKS, // [B]
  parameter TCDM_NUM_ROWS           = TCDM_BANK_SIZE/4,        // [words]
  parameter HWPE_PRESENT            = 1,                       // set to 1 if HW Processing Engines are present in the cluster
  parameter USE_HETEROGENEOUS_INTERCONNECT = 1,                // set to 1 to connect HWPEs via heterogeneous interconnect; to 0 for larger LIC

  // I$ parameters
  parameter SET_ASSOCIATIVE         = 4,
  parameter NB_CACHE_BANKS          = 8,
  parameter CACHE_LINE              = 1,
  parameter CACHE_SIZE              = 4096,
  parameter ICACHE_DATA_WIDTH       = 128,
  parameter L0_BUFFER_FEATURE       = "DISABLED",
  parameter MULTICAST_FEATURE       = "DISABLED",
  parameter SHARED_ICACHE           = "ENABLED",
  parameter DIRECT_MAPPED_FEATURE   = "DISABLED",
  parameter L2_SIZE                 = 512*1024,
  parameter USE_REDUCED_TAG         = "TRUE",

  // core parameters
  parameter ROM_BOOT_ADDR           = 32'h1A000000,
  parameter BOOT_ADDR               = 32'h1C000000,
  parameter INSTR_RDATA_WIDTH       = 32,

  parameter CLUST_FPU               = 1,
  parameter CLUST_FP_DIVSQRT        = 1,
  parameter CLUST_SHARED_FP         = 2,
  parameter CLUST_SHARED_FP_DIVSQRT = 2,
  
  // AXI parameters
  parameter AXI_ADDR_WIDTH          = 32,
  parameter AXI_DATA_C2S_WIDTH      = 64,
  parameter AXI_DATA_S2C_WIDTH      = 32,
  parameter AXI_USER_WIDTH          = 6,
  parameter AXI_ID_IN_WIDTH         = 5,
  parameter AXI_ID_OUT_WIDTH        = 7, 
  parameter AXI_STRB_C2S_WIDTH      = AXI_DATA_C2S_WIDTH/8,
  parameter AXI_STRB_S2C_WIDTH      = AXI_DATA_S2C_WIDTH/8,
  parameter DC_SLICE_BUFFER_WIDTH   = 8,
  parameter LOG_DEPTH               = 3,
  // CLUSTER TO SOC CDC AXI PARAMETER
  parameter C2S_AW_WIDTH             = 80, 
  parameter C2S_W_WIDTH              = 79,
  parameter C2S_B_WIDTH              = 15,
  parameter C2S_AR_WIDTH             = 74,
  parameter C2S_R_WIDTH              = 80,
  // CLUSTER TO SOC CDC AXI PARAMETERS
  parameter S2C_AW_WIDTH             = 78, 
  parameter S2C_W_WIDTH              = 43,
  parameter S2C_B_WIDTH              = 13,
  parameter S2C_AR_WIDTH             = 72,
  parameter S2C_R_WIDTH              = 46,

  localparam ASYNC_C2S_AW_DATA_WIDTH = (2**LOG_DEPTH)*C2S_AW_WIDTH,
  localparam ASYNC_C2S_W_DATA_WIDTH  = (2**LOG_DEPTH)*C2S_W_WIDTH,
  localparam ASYNC_C2S_B_DATA_WIDTH  = (2**LOG_DEPTH)*C2S_B_WIDTH,
  localparam ASYNC_C2S_AR_DATA_WIDTH = (2**LOG_DEPTH)*C2S_AR_WIDTH,
  localparam ASYNC_C2S_R_DATA_WIDTH  = (2**LOG_DEPTH)*C2S_R_WIDTH,
  
  localparam ASYNC_S2C_AW_DATA_WIDTH = (2**LOG_DEPTH)*S2C_AW_WIDTH,
  localparam ASYNC_S2C_W_DATA_WIDTH  = (2**LOG_DEPTH)*S2C_W_WIDTH,
  localparam ASYNC_S2C_B_DATA_WIDTH  = (2**LOG_DEPTH)*S2C_B_WIDTH,
  localparam ASYNC_S2C_AR_DATA_WIDTH = (2**LOG_DEPTH)*S2C_AR_WIDTH,
  localparam ASYNC_S2C_R_DATA_WIDTH  = (2**LOG_DEPTH)*S2C_R_WIDTH,
 
  // TCDM and log interconnect parameters
  parameter DATA_WIDTH              = 32,
  parameter ADDR_WIDTH              = 32,
  parameter BE_WIDTH                = DATA_WIDTH/8,
  parameter TEST_SET_BIT            = 20,                       // bit used to indicate a test-and-set operation during a load in TCDM
  parameter ADDR_MEM_WIDTH          = $clog2(TCDM_BANK_SIZE/4), // WORD address width per TCDM bank (the word width is 32 bits)
  
  // DMA parameters
  parameter TCDM_ADD_WIDTH          = ADDR_MEM_WIDTH + $clog2(NB_TCDM_BANKS) + 2, // BYTE address width TCDM
  parameter NB_OUTSND_BURSTS        = 8,
  parameter MCHAN_BURST_LENGTH      = 256,


  // peripheral and periph interconnect parameters
  parameter LOG_CLUSTER             = 5,  // unused
  parameter PE_ROUTING_LSB          = 10, // LSB used as routing BIT in periph interco
  // parameter PE_ROUTING_MSB          = 13, // MSB used as routing BIT in periph interco
  parameter EVNT_WIDTH              = 8,  // size of the event bus
  parameter REMAP_ADDRESS           = 1,  // for cluster virtualization

  localparam ASYNC_EVENT_DATA_WIDTH = (2**LOG_DEPTH)*EVNT_WIDTH,
  // FPU PARAMETERS
  parameter APU_NARGS_CPU           = 3,
  parameter APU_WOP_CPU             = 6,
  parameter WAPUTYPE                = 3,
  parameter APU_NDSFLAGS_CPU        = 15,
  parameter APU_NUSFLAGS_CPU        = 5
)
(
  input logic                                    clk_i,
  input logic                                    rst_ni,
  input logic                                    ref_clk_i,
  input logic                                    pmu_mem_pwdn_i,

  
  input logic [3:0]                              base_addr_i,

  input logic                                    test_mode_i,

  input logic                                    en_sa_boot_i,

  input logic [5:0]                              cluster_id_i,

  input logic                                    fetch_en_i,
 
  output logic                                   eoc_o,
  
  output logic                                   busy_o,
 
 
  input logic                                    dma_pe_evt_ack_i,
  output logic                                   dma_pe_evt_valid_o,

  input logic                                    dma_pe_irq_ack_i,
  output logic                                   dma_pe_irq_valid_o,
  
  input logic                                    pf_evt_ack_i,
  output logic                                   pf_evt_valid_o,

  input logic [NB_CORES-1:0]                     dbg_irq_valid_i,

  input logic [LOG_DEPTH:0]                      async_cluster_events_wptr_i,
  output logic [LOG_DEPTH:0]                     async_cluster_events_rptr_o,
  input logic [ASYNC_EVENT_DATA_WIDTH-1:0]       async_cluster_events_data_i,

 
  // AXI4 SLAVE
  //***************************************
  // WRITE ADDRESS CHANNEL
  input logic [LOG_DEPTH:0]                      async_data_slave_aw_wptr_i,
  input logic [ASYNC_S2C_AW_DATA_WIDTH-1:0]      async_data_slave_aw_data_i, 
  output logic [LOG_DEPTH:0]                     async_data_slave_aw_rptr_o,
                                           
  // READ ADDRESS CHANNEL                  
  input logic [LOG_DEPTH:0]                      async_data_slave_ar_wptr_i,
  input logic [ASYNC_S2C_AR_DATA_WIDTH-1:0]      async_data_slave_ar_data_i,
  output logic [LOG_DEPTH:0]                     async_data_slave_ar_rptr_o,
                                           
  // WRITE DATA CHANNEL                    
  input logic [LOG_DEPTH:0]                      async_data_slave_w_wptr_i,
  input logic [ASYNC_S2C_W_DATA_WIDTH-1:0]       async_data_slave_w_data_i,
  output logic [LOG_DEPTH:0]                     async_data_slave_w_rptr_o,
                                                   
  // READ DATA CHANNEL                             
  output logic [LOG_DEPTH:0]                     async_data_slave_r_wptr_o,
  output logic [ASYNC_S2C_R_DATA_WIDTH-1:0]      async_data_slave_r_data_o,
  input logic [LOG_DEPTH:0]                      async_data_slave_r_rptr_i,
                                                   
  // WRITE RESPONSE CHANNEL                        
  output logic [LOG_DEPTH:0]                     async_data_slave_b_wptr_o,
  output logic [ASYNC_S2C_B_DATA_WIDTH-1:0]      async_data_slave_b_data_o,
  input logic [LOG_DEPTH:0]                      async_data_slave_b_rptr_i,
  // AXI4 MASTER
  //***************************************
  // WRITE ADDRESS CHANNEL
  output logic [LOG_DEPTH:0]                     async_data_master_aw_wptr_o,
  output logic [ASYNC_C2S_AW_DATA_WIDTH-1:0]     async_data_master_aw_data_o, 
  input logic [LOG_DEPTH:0]                      async_data_master_aw_rptr_i,
                                           
  // READ ADDRESS CHANNEL                  
  output logic [LOG_DEPTH:0]                     async_data_master_ar_wptr_o,
  output logic [ASYNC_C2S_AR_DATA_WIDTH-1:0]     async_data_master_ar_data_o,
  input logic [LOG_DEPTH:0]                      async_data_master_ar_rptr_i,
                                           
  // WRITE DATA CHANNEL                    
  output logic [LOG_DEPTH:0]                     async_data_master_w_wptr_o,
  output logic [ASYNC_C2S_W_DATA_WIDTH-1:0]      async_data_master_w_data_o,
  input logic [LOG_DEPTH:0]                      async_data_master_w_rptr_i,
                                                   
  // READ DATA CHANNEL                             
  input logic [LOG_DEPTH:0]                      async_data_master_r_wptr_i,
  input logic [ASYNC_C2S_R_DATA_WIDTH-1:0]       async_data_master_r_data_i,
  output logic [LOG_DEPTH:0]                     async_data_master_r_rptr_o,
                                                   
  // WRITE RESPONSE CHANNEL                        
  input logic [LOG_DEPTH:0]                      async_data_master_b_wptr_i,
  input logic [ASYNC_C2S_B_DATA_WIDTH-1:0]       async_data_master_b_data_i,
  output logic [LOG_DEPTH:0]                     async_data_master_b_rptr_o
   
);

  //Ensure that the input AXI ID width is big enough to accomodate the accomodate the IDs of internal wiring
  if (AXI_ID_IN_WIDTH < 1 + $clog2(NB_CACHE_BANKS))
           $error("AXI input ID width must be larger than 1+$clog2(NB_CACHE_BANKS) which is %d but was %d", 1 + $clog2(NB_CACHE_BANKS), AXI_ID_IN_WIDTH);

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
   
    
  logic [NB_CORES-1:0]                fetch_enable_reg_int;
  logic [NB_CORES-1:0]                fetch_en_int;
  logic                               s_rst_n;
  logic                               s_init_n;
  logic [NB_CORES-1:0][31:0]          boot_addr;
  logic [NB_CORES-1:0]                dbg_core_halt;
  logic [NB_CORES-1:0]                dbg_core_resume;
  logic [NB_CORES-1:0]                dbg_core_halted;
  logic [NB_CORES-1:0]                s_dbg_irq;
  logic                               s_hwpe_en;

  logic                     s_cluster_periphs_busy;
  logic                     s_axi2mem_busy;
  logic                     s_per2axi_busy;
  logic                     s_axi2per_busy;
  logic                     s_dmac_busy;
  logic                     s_cluster_cg_en;
  logic [NB_CORES-1:0]      s_dma_event;
  logic [NB_CORES-1:0]      s_dma_irq;
  logic [NB_CORES-1:0][3:0] s_hwpe_remap_evt;
  logic [NB_CORES-1:0][1:0] s_hwpe_evt;
  logic                     s_hwpe_busy;
  hci_package::hci_interconnect_ctrl_t s_hci_ctrl;

  logic [NB_CORES-1:0]               clk_core_en;
  logic                              clk_cluster;

  // CLK reset, and other control signals

  logic                              s_cluster_int_busy;
  logic                              s_fregfile_disable;

  logic [NB_CORES-1:0]               core_busy;

  logic                              s_incoming_req;
  logic                              s_isolate_cluster;
  logic                              s_events_async;

  logic                              s_events_valid;
  logic                              s_events_ready;
  logic [EVNT_WIDTH-1:0]             s_events_data;

  // Signals Between CORE_ISLAND and INSTRUCTION CACHES
  logic [NB_CORES-1:0]                        instr_req;
  logic [NB_CORES-1:0][31:0]                  instr_addr;
  logic [NB_CORES-1:0]                        instr_gnt;
  logic [NB_CORES-1:0]                        instr_r_valid;
  logic [NB_CORES-1:0][INSTR_RDATA_WIDTH-1:0] instr_r_rdata;

  logic [1:0]                                 s_TCDM_arb_policy;
  logic                                       tcdm_sleep;
  
  logic[NB_CORES-1:0][4:0] irq_id;
  logic[NB_CORES-1:0][4:0] irq_ack_id;
  logic[NB_CORES-1:0]      irq_req;
  logic[NB_CORES-1:0]      irq_ack;

  logic [NB_CORES-1:0]                s_core_dbg_irq;

  
  logic [NB_L1_CUTS-1:0][RW_MARGIN_WIDTH-1:0] s_rw_margin_L1;

  logic                                       s_dma_cl_event;
  logic                                       s_dma_cl_irq;
  logic                                       s_dma_fc_event;
  logic                                       s_dma_fc_irq;



  /* logarithmic and peripheral interconnect interfaces */
  // ext -> log interconnect
  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1  )
  ) s_hci_ext[NB_DMAS-1:0] (
    .clk ( clk_cluster )
  );

  // periph interconnect -> slave peripherals
  XBAR_PERIPH_BUS s_xbar_speriph_bus[NB_SPERIPHS-1:0]();

  // periph interconnect -> HWPE subsystem
  XBAR_PERIPH_BUS s_hwpe_cfg_bus();

  // DMA -> log interconnect
  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1  )
  ) s_hci_dma[NB_DMAS-1:0] (
    .clk ( clk_cluster )
  );
  XBAR_TCDM_BUS    s_dma_plugin_xbar_bus[NB_DMAS-1:0]();

  // ext -> xbar periphs FIXME
  XBAR_TCDM_BUS s_mperiph_xbar_bus[NB_MPERIPHS-1:0]();

  // periph demux
  XBAR_TCDM_BUS s_mperiph_bus();
  XBAR_TCDM_BUS s_mperiph_demux_bus[1:0]();
  
  // cores & accelerators -> log interconnect
  hci_core_intf #(
    .DW ( NB_HWPE_PORTS*DATA_WIDTH ),
    .AW ( ADDR_WIDTH               ),
    .OW ( 1                )
  ) s_hci_hwpe [0:0] (
    .clk ( clk_cluster )
  );
  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1  )
  ) s_hci_core [NB_CORES-1:0] (
    .clk ( clk_cluster )
  );

  // cores -> periph interconnect
  XBAR_PERIPH_BUS s_core_periph_bus[NB_CORES-1:0]();
  
  // periph interconnect -> DMA
  XBAR_PERIPH_BUS s_periph_dma_bus[1:0]();

  // Extra bus
  XBAR_PERIPH_BUS s_extra_periph_bus();
  
  // debug
  XBAR_TCDM_BUS s_debug_bus[NB_CORES-1:0]();
  
  /* other interfaces */
  // cores -> DMA ctrl
  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1 )
  ) s_core_dmactrl_bus[NB_CORES-1:0](
    .clk ( clk_cluster )
  );
  
  // cores -> event unit ctrl
  XBAR_PERIPH_BUS s_core_euctrl_bus[NB_CORES-1:0]();


`ifdef SHARED_FPU_CLUSTER
      // apu-interconnect
      // handshake signals
      logic [NB_CORES-1:0]                           s_apu_master_req;
      logic [NB_CORES-1:0]                           s_apu_master_gnt;
      // request channel
      logic [NB_CORES-1:0][APU_NARGS_CPU-1:0][31:0]  s_apu_master_operands;
      logic [NB_CORES-1:0][APU_WOP_CPU-1:0]          s_apu_master_op;
      logic [NB_CORES-1:0][WAPUTYPE-1:0]             s_apu_master_type;
      logic [NB_CORES-1:0][APU_NDSFLAGS_CPU-1:0]     s_apu_master_flags;
      // response channel
      logic [NB_CORES-1:0]                           s_apu_master_rready;
      logic [NB_CORES-1:0]                           s_apu_master_rvalid;
      logic [NB_CORES-1:0][31:0]                     s_apu_master_rdata;
      logic [NB_CORES-1:0][APU_NUSFLAGS_CPU-1:0]     s_apu_master_rflags;
`endif

   //----------------------------------------------------------------------//
   // Interfaces between ICache - L0 - Icache_Interco and Icache_ctrl_unit //
   //                                                                      //
      SP_ICACHE_CTRL_UNIT_BUS      IC_ctrl_unit_bus_main[NB_CACHE_BANKS]();
      PRI_ICACHE_CTRL_UNIT_BUS     IC_ctrl_unit_bus_pri[NB_CORES]();
      logic                        s_special_core_icache_cfg;
      logic[NB_CORES-1:0]          s_enable_l1_l15_prefetch;

   //----------------------------------------------------------------------//

  localparam TCDM_ID_WIDTH = NB_CORES+NB_DMAS+4+NB_HWPE_PORTS;

  // log interconnect -> TCDM memory banks (SRAM)
  hci_mem_intf #(
    .AW (ADDR_WIDTH     ),
    .DW ( DATA_WIDTH    ),
    .BW ( 8      ),
    .IW ( TCDM_ID_WIDTH )
  ) s_tcdm_bus_sram[NB_TCDM_BANKS-1:0] (
    .clk ( clk_cluster )
  );

  //***************************************************
  /* synchronous AXI interfaces at CLUSTER/SOC interface */
  //*************************************************** 
    
  
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_data_slave_64(); 

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_S2C_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_data_slave_32(); 

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_data_master(); 

  //assign s_data_master.aw_atop = 6'b0;

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
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
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_core_ext_bus(); 

  // DMA -> ext
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_dma_ext_bus(); 

  // ext -> axi2mem
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_ext_tcdm_bus(); 

  // cluster bus -> axi2per 
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_ext_mperiph_bus();

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
    .NB_CORES             ( NB_CORES           ),
    .DMA_NB_OUTSND_BURSTS ( NB_OUTSND_BURSTS   ),
    .TCDM_SIZE            ( TCDM_SIZE          ),
    .AXI_ADDR_WIDTH       ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH       ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH       ( AXI_USER_WIDTH     ),
    .AXI_ID_IN_WIDTH      ( AXI_ID_IN_WIDTH    ),
    .AXI_ID_OUT_WIDTH     ( AXI_ID_OUT_WIDTH   )
  ) cluster_bus_wrap_i (
    .clk_i         ( clk_cluster       ),
    .rst_ni        ( s_rst_n           ),
    .test_en_i     ( test_mode_i       ),
    .cluster_id_i  ( cluster_id_i      ),
    .instr_slave   ( s_core_instr_bus  ),
    .data_slave    ( s_core_ext_bus    ),
    .dma_slave     ( s_dma_ext_bus     ),
    .ext_slave     ( s_data_slave_64   ),
    .tcdm_master   ( s_ext_tcdm_bus    ),
    .periph_master ( s_ext_mperiph_bus ),
    .ext_master    ( s_data_master     )
  );

  axi2mem_wrap #(
    .NB_DMAS        ( NB_DMAS            ),
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   )
  ) axi2mem_wrap_i (
    .clk_i       ( clk_cluster    ),
    .rst_ni      ( s_rst_n        ),
    .test_en_i   ( test_mode_i    ),
    .axi_slave   ( s_ext_tcdm_bus ),
    .tcdm_master ( s_hci_ext      ),
    .busy_o      ( s_axi2mem_busy )
  );

  axi2per_wrap #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) axi2per_wrap_i (
    .clk_i         ( clk_cluster       ),
    .rst_ni        ( s_rst_n           ),
    .test_en_i     ( test_mode_i       ),
    .axi_slave     ( s_ext_mperiph_bus ),
    .periph_master ( s_mperiph_bus     ),
    .busy_o        ( s_axi2per_busy    )
  );

  per_demux_wrap #(
    .NB_MASTERS  (  2 ),
    .ADDR_OFFSET ( 20 )
  ) per_demux_wrap_i (
    .clk_i   ( clk_cluster         ),
    .rst_ni  ( s_rst_n             ),
    .slave   ( s_mperiph_bus       ),
    .masters ( s_mperiph_demux_bus )
  );

  `TCDM_ASSIGN_MASTER (s_mperiph_xbar_bus[`NB_MPERIPHS-1], s_mperiph_demux_bus[0])
    
  // assign s_mperiph_xbar_bus[NB_MPERIPHS-1].req   = s_mperiph_demux_bus[0].req;
  // assign s_mperiph_xbar_bus[NB_MPERIPHS-1].add   = s_mperiph_demux_bus[0].add;
  // assign s_mperiph_xbar_bus[NB_MPERIPHS-1].wen   = s_mperiph_demux_bus[0].wen;
  // assign s_mperiph_xbar_bus[NB_MPERIPHS-1].wdata = s_mperiph_demux_bus[0].wdata;
  // assign s_mperiph_xbar_bus[NB_MPERIPHS-1].be    = s_mperiph_demux_bus[0].be;
                                        
  // assign s_mperiph_demux_bus[0].gnt       = s_mperiph_xbar_bus[NB_MPERIPHS-1].gnt;
  // assign s_mperiph_demux_bus[0].r_valid   = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_valid;
  // assign s_mperiph_demux_bus[0].r_opc     = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_opc;
  // assign s_mperiph_demux_bus[0].r_rdata   = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_rdata;
 
/* not used in vega   
  per_demux_wrap #(
    .NB_MASTERS  ( NB_CORES ),
    .ADDR_OFFSET ( 15       )
  ) debug_interconect_i (
    .clk_i   ( clk_cluster            ),
    .rst_ni  ( rst_ni                 ),
    .slave   ( s_mperiph_demux_bus[1] ),
    .masters ( s_debug_bus            )
  );
    */
  per2axi_wrap #(
    .NB_CORES       ( NB_CORES             ),
    .PER_ADDR_WIDTH ( 32                   ),
    .PER_ID_WIDTH   ( NB_CORES+NB_MPERIPHS ),
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH       ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH      )
  ) per2axi_wrap_i (
    .clk_i          ( clk_cluster                     ),
    .rst_ni         ( s_rst_n                         ),
    .test_en_i      ( test_mode_i                     ),
    .periph_slave   ( s_xbar_speriph_bus[SPER_EXT_ID] ),
    .axi_master     ( s_core_ext_bus                  ),
    .busy_o         ( s_per2axi_busy                  )
  );
    

  //***************************************************
  /* cluster (log + periph) interconnect and attached peripherals */
  //*************************************************** 
  
  cluster_interconnect_wrap #(
    .NB_CORES           ( NB_CORES           ),
    .HWPE_PRESENT       ( HWPE_PRESENT       ),
    .NB_HWPE_PORTS      ( NB_HWPE_PORTS      ),
    .NB_DMAS            ( NB_DMAS            ),
    .NB_MPERIPHS        ( NB_MPERIPHS        ),
    .NB_TCDM_BANKS      ( NB_TCDM_BANKS      ),
    .NB_SPERIPHS        ( NB_SPERIPHS        ),

    .DATA_WIDTH         ( DATA_WIDTH         ),
    .ADDR_WIDTH         ( ADDR_WIDTH         ),
    .BE_WIDTH           ( BE_WIDTH           ),

    .TEST_SET_BIT       ( TEST_SET_BIT       ),
    .ADDR_MEM_WIDTH     ( ADDR_MEM_WIDTH     ),

    .LOG_CLUSTER        ( LOG_CLUSTER        ),
    .PE_ROUTING_LSB     ( PE_ROUTING_LSB     ),
    .USE_HETEROGENEOUS_INTERCONNECT ( USE_HETEROGENEOUS_INTERCONNECT )

  ) cluster_interconnect_wrap_i (
    .clk_i              ( clk_cluster                         ),
    .rst_ni             ( s_rst_n                             ),

    .core_tcdm_slave    ( s_hci_core                          ),
    .hwpe_tcdm_slave    ( s_hci_hwpe                          ),
    .ext_slave          ( s_hci_ext                           ),
    .dma_slave          ( s_hci_dma                           ),

    .tcdm_sram_master   ( s_tcdm_bus_sram                     ),

    .core_periph_slave  ( s_core_periph_bus                   ),
    .mperiph_slave      ( s_mperiph_xbar_bus[NB_MPERIPHS-1:0] ),
    .speriph_master     ( s_xbar_speriph_bus                  ),

    .hci_ctrl_i         ( s_hci_ctrl                          ),
    .TCDM_arb_policy_i  ( s_TCDM_arb_policy                   )
  );

  //***************************************************
  //*********************DMAC WRAP*********************
  //*************************************************** 

`ifdef TARGET_MCHAN
  dmac_wrap #(
    .NB_CTRLS           ( 10                 ),
    .NB_CORES           ( NB_CORES           ),
    .NB_OUTSND_BURSTS   ( NB_OUTSND_BURSTS   ),
    .MCHAN_BURST_LENGTH ( MCHAN_BURST_LENGTH ),
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH     ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH       ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH     ),
    .PE_ID_WIDTH        ( NB_CORES + 1       ),
    .TCDM_ADD_WIDTH     ( TCDM_ADD_WIDTH     ),
    .DATA_WIDTH         ( DATA_WIDTH         ),
    .ADDR_WIDTH         ( ADDR_WIDTH         ),
    .BE_WIDTH           ( BE_WIDTH           )
  ) dmac_wrap_i (
    .clk_i             ( clk_cluster        ),
    .rst_ni            ( s_rst_n            ),
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
`else // TARGET_MCHAN

  dmac_wrap #(
    .NB_CORES         ( NB_CORES           ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH   ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH     ),
    .AXI_ID_WIDTH     ( AXI_ID_IN_WIDTH    ),
    .PE_ID_WIDTH      ( NB_CORES + 1       ),
    .NB_PE_PORTS      ( 2                  ),
    .DATA_WIDTH       ( DATA_WIDTH         ),
    .ADDR_WIDTH       ( ADDR_WIDTH         ),
    .BE_WIDTH         ( BE_WIDTH           ),
    .NUM_STREAMS      ( 1                  ),
    .TCDM_SIZE        ( TCDM_SIZE          ),
    .NB_OUTSND_BURSTS ( NB_OUTSND_BURSTS   )
) dmac_wrap_i (
    .clk_i          (clk_cluster                     ),
    .rst_ni         (s_rst_n                         ),
    .test_mode_i    (test_mode_i                     ),
    .pe_ctrl_slave  (s_periph_dma_bus[1:0]           ),
    .ctrl_slave     (s_core_dmactrl_bus              ),
    .tcdm_master    (s_hci_dma                       ),
    .ext_master     (s_dma_ext_bus                   ),
    .term_event_o   (s_dma_event                     ),
    .term_irq_o     (s_dma_irq                       ),
    .term_event_pe_o({s_dma_fc_event, s_dma_cl_event}),
    .term_irq_pe_o  ({s_dma_fc_irq, s_dma_cl_irq}    ),
    .busy_o         (s_dmac_busy                     )
  );

`endif // TARGET_MCHAN

  //***************************************************
  //**************CLUSTER PERIPHERALS******************
  //*************************************************** 

  cluster_peripherals #(
    .NB_CORES       ( NB_CORES       ),
    .NB_MPERIPHS    ( NB_MPERIPHS    ),
    .NB_CACHE_BANKS ( NB_CACHE_BANKS ),
    .NB_SPERIPHS    ( NB_SPERIPHS    ),
    .NB_TCDM_BANKS  ( NB_TCDM_BANKS  ),
    .ROM_BOOT_ADDR  ( ROM_BOOT_ADDR  ),
    .BOOT_ADDR      ( BOOT_ADDR      ),
    .EVNT_WIDTH     ( EVNT_WIDTH     ),

    .NB_L1_CUTS      ( NB_L1_CUTS       ),
    .RW_MARGIN_WIDTH ( RW_MARGIN_WIDTH  ),
    .NB_BARRIERS         (NB_CORES)
  
  ) cluster_peripherals_i (

    .clk_i                  ( clk_cluster                        ),
    .rst_ni                 ( s_rst_n                            ),
    .ref_clk_i              ( ref_clk_i                          ),
    .test_mode_i            ( test_mode_i                        ),
    .busy_o                 ( s_cluster_periphs_busy             ),

    .en_sa_boot_i           ( en_sa_boot_i                       ),
    .fetch_en_i             ( fetch_en_i                         ),
    .boot_addr_o            ( boot_addr                          ),
    .core_busy_i            ( core_busy                          ),
    .core_clk_en_o          ( clk_core_en                        ),

    .speriph_slave          ( s_xbar_speriph_bus[NB_SPERIPHS-2:0]),
    .core_eu_direct_link    ( s_core_euctrl_bus                  ), 

    .dma_cfg_master         ( s_periph_dma_bus                   ),

    .dma_cl_event_i         ( s_dma_cl_event                     ),
    .dma_cl_irq_i           ( s_dma_cl_irq                       ),
    .dma_event_i            ( s_dma_event                        ),
    .dma_irq_i              ( s_dma_irq                          ),

    // NEW_SIGNALS .decompr_done_evt_i     ( s_decompr_done_evt                 ),

    .dma_fc_event_i         ( s_dma_fc_event                     ),
    .dma_fc_irq_i           (                                    ),

    .soc_periph_evt_ready_o ( s_events_ready                     ),
    .soc_periph_evt_valid_i ( s_events_valid                     ),
    .soc_periph_evt_data_i  ( s_events_data                      ),

    .dbg_core_halt_o        ( dbg_core_halt                      ),
    .dbg_core_halted_i      ( dbg_core_halted                    ),
    .dbg_core_resume_o      ( dbg_core_resume                    ),

    .eoc_o                  ( eoc_o                              ), 
    .cluster_cg_en_o        ( s_cluster_cg_en                    ),
    .fetch_enable_reg_o     ( fetch_enable_reg_int               ),
    .irq_id_o               ( irq_id                             ),
    .irq_ack_id_i           ( irq_ack_id                         ),
    .irq_req_o              ( irq_req                            ),
    .irq_ack_i              ( irq_ack                            ),
    .dbg_req_i              ( s_dbg_irq                          ),
    .dbg_req_o              ( s_core_dbg_irq                     ),

    .fregfile_disable_o     ( s_fregfile_disable                 ),   
    
    .TCDM_arb_policy_o      ( s_TCDM_arb_policy                  ),
    
    .hwpe_cfg_master        ( s_hwpe_cfg_bus                     ),
    .hwpe_events_i          ( s_hwpe_remap_evt                   ),
    .hwpe_en_o              ( s_hwpe_en                          ),
    .hci_ctrl_o             ( s_hci_ctrl                         ),
    .IC_ctrl_unit_bus_main  (  IC_ctrl_unit_bus_main              ),
    .IC_ctrl_unit_bus_pri   (  IC_ctrl_unit_bus_pri               ),
    .enable_l1_l15_prefetch_o (  s_enable_l1_l15_prefetch         ),
    .extra_periph_bus       ( s_extra_periph_bus                  ),
    .barrier_matched_o       ()
    //.rw_margin_L1_o         ( s_rw_margin_L1                      )
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

  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1 )
  ) core_data_intf[NB_CORES-1:0] (
    .clk ( clk_cluster )
  );
  logic [NB_CORES-1:0][4:0] perf_counters;

  /* cluster cores + core-coupled accelerators / shared execution units */
  for (genvar i=0; i<NB_CORES; i++) begin : CORE_ASSIST

    pulp_sync dbg_irq_sync (
      .clk_i(clk_cluster),
      .rstn_i(s_rst_n),
      .serial_i(dbg_irq_valid_i[i]),
      .serial_o(s_dbg_irq[i])
    );

    core_assist_region #(
      .AddrWidth ( 32 ),
      .DataWidth ( 32 ),
      .ClusterAliasBase ( CLUSTER_ALIAS_BASE ),
      .NExtPerfCounters(5)
    ) i_core_assist (
      .clk_i             ( clk_cluster ),
      .rst_ni            ( s_rst_n ),
      .clock_en_i        ( clk_core_en[i] ),
      .test_mode_i       ( test_mode_i ),
      .cluster_id_i      ( cluster_id_i ),
      .base_addr_i       ( base_addr_i ),
      .perf_counters_o   ( perf_counters[i] ),
      .core_bus_slave    ( core_data_intf[i] ),
      .tcdm_data_master    ( s_hci_core[i]         ),
      .dma_ctrl_master     ( s_core_dmactrl_bus[i] ),
      .eu_ctrl_master      ( s_core_euctrl_bus[i]  ),
      .periph_data_master  ( s_core_periph_bus[i]  )
    );

  end

  `REG_BUS_TYPEDEF_ALL(reg, logic[31:0], logic[31:0], logic[3:0])

  reg_req_t hmr_req;
  reg_rsp_t hmr_rsp;

  periph_to_reg #(
    .AW   (ADDR_WIDTH),
    .DW   (DATA_WIDTH),
    .BW   (8),
    .IW   ( NB_CORES+1 ),
    .req_t(reg_req_t),
    .rsp_t(reg_rsp_t)
  ) i_periph_to_hmr (
    .clk_i    ( clk_cluster ),
    .rst_ni   ( s_rst_n ),
    .req_i    ( s_extra_periph_bus.req     ),
    .add_i    ( s_extra_periph_bus.add     ),
    .wen_i    ( s_extra_periph_bus.wen     ),
    .wdata_i  ( s_extra_periph_bus.wdata   ),
    .be_i     ( s_extra_periph_bus.be      ),
    .id_i     ( s_extra_periph_bus.id      ),
    .gnt_o    ( s_extra_periph_bus.gnt     ),
    .r_rdata_o( s_extra_periph_bus.r_rdata ),
    .r_opc_o  ( s_extra_periph_bus.r_opc   ),
    .r_id_o   ( s_extra_periph_bus.r_id    ),
    .r_valid_o( s_extra_periph_bus.r_valid ),
    .reg_req_o( hmr_req ),
    .reg_rsp_i( hmr_rsp )
  );

  // Additional signals for HMR
  logic [NB_CORES-1:0][3:0]            sys_core_id;
  logic [NB_CORES-1:0]                 core_data_req;
  logic [NB_CORES-1:0][ADDR_WIDTH-1:0] core_data_add;
  logic [NB_CORES-1:0]                 core_data_wen;
  logic [NB_CORES-1:0][DATA_WIDTH-1:0] core_data_wdata;
  logic [NB_CORES-1:0][  BE_WIDTH-1:0] core_data_be;
  logic [NB_CORES-1:0]                 core_data_gnt;
  logic [NB_CORES-1:0][DATA_WIDTH-1:0] core_data_r_data;
  logic [NB_CORES-1:0]                 core_data_r_valid;
  logic [NB_CORES-1:0]                 core_data_r_opc;

  logic [NB_CORES-1:0]                 hmr_data_req;
  logic [NB_CORES-1:0][ADDR_WIDTH-1:0] hmr_data_add;
  logic [NB_CORES-1:0]                 hmr_data_wen;
  logic [NB_CORES-1:0][DATA_WIDTH-1:0] hmr_data_wdata;
  logic [NB_CORES-1:0][  BE_WIDTH-1:0] hmr_data_be;
  logic [NB_CORES-1:0]                 hmr_data_gnt;
  logic [NB_CORES-1:0][DATA_WIDTH-1:0] hmr_data_r_rdata;
  logic [NB_CORES-1:0]                 hmr_data_r_valid;
  logic [NB_CORES-1:0]                 hmr_data_r_opc;

  // Additional signals for direct access recovery
  // Program counter ports
  logic [NB_CORES-1:0] pc_recover,
                       backup_branch,
                       recovery_branch;

  logic [NB_CORES-1:0][DATA_WIDTH-1:0] backup_program_counter,
                                       recovery_program_counter,
                                       backup_branch_addr,
                                       recovery_branch_addr;
  
  // Recovery Ports for RF
  recovery_pkg::regfile_write_t [NB_CORES-1:0] backup_regfile_wport,
                                               core_recovery_regfile_wport;
  recovery_pkg::regfile_rdata_t [NB_CORES-1:0] core_regfile_rdata;
  // CSRs ports
  recovery_pkg::csrs_intf_t [NB_CORES-1:0] core_backup_csr,
                                           core_recovery_csr;

  hci_core_intf #(
    .DW ( DATA_WIDTH ),
    .AW ( ADDR_WIDTH ),
    .OW ( 1 )
  ) hmr_data_intf[NB_CORES-1:0] (
    .clk ( clk_cluster )
  );

  for (genvar i = 0; i < NB_CORES; i++) begin
    assign sys_core_id[i]           = i[3:0];

    assign core_data_intf[i].req    = core_data_req  [i];
    assign core_data_intf[i].add    = core_data_add  [i];
    assign core_data_intf[i].wen    = core_data_wen  [i];
    assign core_data_intf[i].data   = core_data_wdata[i];
    assign core_data_intf[i].be     = core_data_be   [i];
    assign core_data_intf[i].user   = '0;
    assign core_data_intf[i].boffs  = '0;
    assign core_data_intf[i].lrdy   = '0;
    assign core_data_intf[i].r_user = '0;
    assign core_data_gnt        [i] = core_data_intf[i].gnt;
    assign core_data_r_data     [i] = core_data_intf[i].r_data;
    assign core_data_r_valid    [i] = core_data_intf[i].r_valid;
    assign core_data_r_opc      [i] = core_data_intf[i].r_opc;

    assign hmr_data_req         [i] = hmr_data_intf[i].req;
    assign hmr_data_add         [i] = hmr_data_intf[i].add;
    assign hmr_data_wen         [i] = hmr_data_intf[i].wen;
    assign hmr_data_wdata       [i] = hmr_data_intf[i].data;
    assign hmr_data_be          [i] = hmr_data_intf[i].be;
    assign hmr_data_intf[i].user    = '0;
    assign hmr_data_intf[i].boffs   = '0;
    assign hmr_data_intf[i].lrdy    = '0;
    assign hmr_data_intf[i].r_user  = '0;
    assign hmr_data_intf[i].gnt     = hmr_data_gnt[i];
    assign hmr_data_intf[i].r_data  = hmr_data_r_rdata[i];
    assign hmr_data_intf[i].r_valid = hmr_data_r_valid[i];
  end

  logic [NB_CORES-1:0] hmr_setback;
  logic [NB_CORES-1:0][3:0] hmr_core_id;
  logic [NB_CORES-1:0][5:0] hmr_cluster_id;
  logic [NB_CORES-1:0] hmr_clock_en;
  logic [NB_CORES-1:0] hmr_fetch_en;
  logic [NB_CORES-1:0][ADDR_WIDTH-1:0] hmr_boot_addr;
  logic [NB_CORES-1:0] hmr_core_busy;
  logic [NB_CORES-1:0] hmr_irq_req;
  logic [NB_CORES-1:0] hmr_irq_ack;
  logic [NB_CORES-1:0][4:0] hmr_irq_id;
  logic [NB_CORES-1:0][4:0] hmr_irq_ack_id;

  logic [NB_CORES-1:0] hmr_instr_req;
  logic [NB_CORES-1:0] hmr_instr_gnt;
  logic [NB_CORES-1:0][ADDR_WIDTH-1:0] hmr_instr_addr;
  logic [NB_CORES-1:0][INSTR_RDATA_WIDTH-1:0] hmr_instr_r_rdata;
  logic [NB_CORES-1:0] hmr_instr_r_valid;

  logic [NB_CORES-1:0] hmr_debug_req;
  logic [NB_CORES-1:0] hmr_debug_halted;
  logic [NB_CORES-1:0] hmr_debug_resume;

  logic [NB_CORES-1:0] hmr_instr_lock;
  logic [NB_CORES-1:0] hmr_recover;

  logic [NB_CORES-1:0][4:0] hmr_perf_counters;


  HMR_wrap #(
    .NumCores       ( NB_CORES          ),
    .DMRSupported   ( 1'b1              ),
    .DMRFixed       ( 1'b0              ),
    .TMRSupported   ( 1'b1              ),
    .TMRFixed       ( 1'b0              ),
    .RapidRecovery  ( 1'b1              ),
    .SeparateData   ( 1'b1              ),
    .InterleaveGrps ( 1'b1              ),

    .InstrDataWidth ( INSTR_RDATA_WIDTH ),
    .DataWidth      ( DATA_WIDTH        ),
    .BeWidth        ( BE_WIDTH          ),
    .UserWidth      ( 0                 ),
    .NumExtPerf     ( 5                 ),

    .reg_req_t      ( reg_req_t         ),
    .reg_resp_t     ( reg_rsp_t         )
  ) i_hmr_wrap (
    .clk_i               ( clk_cluster              ),
    .rst_ni              ( s_rst_n                  ),
    
    .reg_request_i       (hmr_req),
    .reg_response_o      (hmr_rsp),

    .tmr_failure_o       (),
    .tmr_error_o         (),
    .tmr_resynch_req_o   (),
    .tmr_cores_synch_i   ('0),

    .dmr_failure_o       (),
    .dmr_error_o         (),
    .dmr_resynch_req_o   (),
    .dmr_cores_synch_i   ('0),

    // Backup Port from CSRs
    .backup_csr_i ( core_backup_csr ),
    // Recovery Port to CSRs
    .recovery_csr_o ( core_recovery_csr ),
    .backup_program_counter_i   ( backup_program_counter ),
    .pc_recover_o               ( pc_recover ),
    .recovery_program_counter_o ( recovery_program_counter ),
    .backup_branch_i            ( backup_branch ),
    .backup_branch_addr_i       ( backup_branch_addr ),
    .recovery_branch_o          ( recovery_branch ),
    .recovery_branch_addr_o     ( recovery_branch_addr ),

    .backup_regfile_wport_i        ( backup_regfile_wport ),
    .core_recovery_regfile_wport_o ( core_recovery_regfile_wport ),

    .sys_core_id_i       ( sys_core_id              ),
    .sys_cluster_id_i    ( {NB_CORES{cluster_id_i}} ),

    .sys_clock_en_i      ( clk_core_en              ),
    .sys_fetch_en_i      ( fetch_en_int             ),
    .sys_boot_addr_i     ( boot_addr                ),
    .sys_core_busy_o     ( core_busy                ),

    .sys_irq_req_i       ( irq_req                  ),
    .sys_irq_ack_o       ( irq_ack                  ),
    .sys_irq_id_i        ( irq_id                   ),
    .sys_irq_ack_id_o    ( irq_ack_id               ),

    .sys_instr_req_o     ( instr_req                ),
    .sys_instr_gnt_i     ( instr_gnt                ),
    .sys_instr_addr_o    ( instr_addr               ),
    .sys_instr_r_rdata_i ( instr_r_rdata            ),
    .sys_instr_r_valid_i ( instr_r_valid            ),
    .sys_instr_err_i     ('0),

    .sys_debug_req_i     ( s_core_dbg_irq           ),

    .sys_data_req_o      ( core_data_req            ),
    .sys_data_add_o      ( core_data_add            ),
    .sys_data_wen_o      ( core_data_wen            ),
    .sys_data_wdata_o    ( core_data_wdata          ),
    .sys_data_user_o     (),
    .sys_data_be_o       ( core_data_be             ),
    .sys_data_gnt_i      ( core_data_gnt            ),
    .sys_data_r_opc_i    ( core_data_r_opc          ),
    .sys_data_r_rdata_i  ( core_data_r_data         ),
    .sys_data_r_user_i   ('0),
    .sys_data_r_valid_i  ( core_data_r_valid        ),
    .sys_data_err_i      ('0),

    .sys_perf_counters_i ( perf_counters            ),

    .core_setback_o       ( hmr_setback       ),

    .core_core_id_o       ( hmr_core_id       ),
    .core_cluster_id_o    ( hmr_cluster_id    ),

    .core_clock_en_o      ( hmr_clock_en      ),
    .core_fetch_en_o      ( hmr_fetch_en      ),
    .core_boot_addr_o     ( hmr_boot_addr     ),
    .core_core_busy_i     ( hmr_core_busy     ),

    .core_irq_req_o       ( hmr_irq_req       ),
    .core_irq_ack_i       ( hmr_irq_ack       ),
    .core_irq_id_o        ( hmr_irq_id        ),
    .core_irq_ack_id_i    ( hmr_irq_ack_id    ),

    .core_instr_req_i     ( hmr_instr_req     ),
    .core_instr_gnt_o     ( hmr_instr_gnt     ),
    .core_instr_addr_i    ( hmr_instr_addr    ),
    .core_instr_r_rdata_o ( hmr_instr_r_rdata ),
    .core_instr_r_valid_o ( hmr_instr_r_valid ),
    .core_instr_err_o     (),

    .core_debug_req_o     ( hmr_debug_req     ),
    .core_debug_halted_i  ( hmr_debug_halted  ),
    .core_debug_resume_o  ( hmr_debug_resume  ),

    .core_data_req_i      ( hmr_data_req      ),
    .core_data_add_i      ( hmr_data_add      ),
    .core_data_wen_i      ( hmr_data_wen      ),
    .core_data_wdata_i    ( hmr_data_wdata    ),
    .core_data_user_i     ('0),
    .core_data_be_i       ( hmr_data_be       ),
    .core_data_gnt_o      ( hmr_data_gnt      ),
    .core_data_r_opc_o    ( hmr_data_r_opc    ),
    .core_data_r_rdata_o  ( hmr_data_r_rdata  ),
    .core_data_r_user_o   (),
    .core_data_r_valid_o  ( hmr_data_r_valid  ),
    .core_data_err_o      (),

    .core_perf_counters_o ( hmr_perf_counters ),

    .core_instr_lock_o    ( hmr_instr_lock    ),
    .core_recover_o       ( hmr_recover       )
  );

  for (genvar i=0; i<NB_CORES; i++) begin : CORE

    core_region #(
      .CORE_TYPE_CL        ( CORE_TYPE_CL       ),
      .N_EXT_PERF_COUNTERS( 5 ),
      // .CORE_ID             ( i                  ),
      .ADDR_WIDTH          ( 32                 ),
      .DATA_WIDTH          ( 32                 ),
      .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH  ),
      .CLUSTER_ALIAS_BASE  ( CLUSTER_ALIAS_BASE ),
      .REMAP_ADDRESS       ( REMAP_ADDRESS      ),
      .APU_NARGS_CPU       ( APU_NARGS_CPU      ), //= 2,
      .APU_WOP_CPU         ( APU_WOP_CPU        ), //= 1,
      .WAPUTYPE            ( WAPUTYPE           ), //= 3,
      .APU_NDSFLAGS_CPU    ( APU_NDSFLAGS_CPU   ), //= 3,
      .APU_NUSFLAGS_CPU    ( APU_NUSFLAGS_CPU   ), //= 5,

      .FPU                 ( CLUST_FPU               ),
      .FP_DIVSQRT          ( CLUST_FP_DIVSQRT        ),
      .SHARED_FP           ( CLUST_SHARED_FP         ),
      .SHARED_FP_DIVSQRT   ( CLUST_SHARED_FP_DIVSQRT )
    ) core_region_i (
      .clk_i               ( clk_cluster           ),
      .rst_ni              ( s_rst_n               ),
      .setback_i           ( hmr_setback [i]       ),
      .test_mode_i         ( test_mode_i           ),

      .cluster_id_i        ( hmr_cluster_id[i]     ),
      .core_id_i           ( hmr_core_id[i]        ),
      .clock_en_i          ( hmr_clock_en[i]       ),
      .fetch_en_i          ( hmr_fetch_en[i]       ),
     
      .boot_addr_i         ( hmr_boot_addr[i]          ),
      .irq_id_i            ( hmr_irq_id[i]             ),
      .irq_ack_id_o        ( hmr_irq_ack_id[i]         ),
      .irq_req_i           ( hmr_irq_req[i]            ),
      .irq_ack_o           ( hmr_irq_ack[i]            ),

      .core_busy_o         ( hmr_core_busy[i]          ),

      //instruction cache bind 
      .instr_req_o         ( hmr_instr_req[i]          ),
      .instr_gnt_i         ( hmr_instr_gnt[i]          ),
      .instr_addr_o        ( hmr_instr_addr[i]         ),
      .instr_r_rdata_i     ( hmr_instr_r_rdata[i]      ),
      .instr_r_valid_i     ( hmr_instr_r_valid[i]      ),

      //debug unit bind
      .debug_req_i         ( hmr_debug_req[i]     ),
      .debug_halted_o      ( hmr_debug_halted[i] ),
      .debug_resume_i      ( hmr_debug_resume [i] ),

      // Program Counter Backup
      .backup_program_counter_o  ( backup_program_counter[i] ),
      .backup_branch_o           ( backup_branch         [i] ),
      .backup_branch_addr_o      ( backup_branch_addr    [i] ),
      // Program Counter Recovery
      .pc_recover_i               ( pc_recover [i]               ),
      .recovery_program_counter_i ( recovery_program_counter [i] ),
      .recovery_branch_i          ( recovery_branch [i]          ),
      .recovery_branch_addr_i     ( recovery_branch_addr [i]     ),
      // Recovery Ports for RF
      .recover_i           ( hmr_recover[i]         ),
      .instr_lock_i        ( hmr_instr_lock[i]      ),
      // Write Port A
      .regfile_waddr_a_i   ( core_recovery_regfile_wport[i].waddr_a ),
      .regfile_wdata_a_i   ( core_recovery_regfile_wport[i].wdata_a ),
      .regfile_we_a_i      ( core_recovery_regfile_wport[i].we_a ),
   
      // Write Port B
      .regfile_waddr_b_i   ( core_recovery_regfile_wport[i].waddr_b ),
      .regfile_wdata_b_i   ( core_recovery_regfile_wport[i].wdata_b ),
      .regfile_we_b_i      ( core_recovery_regfile_wport[i].we_b ),
      // Outputs from RF
      // Port A
      .regfile_we_a_o      ( backup_regfile_wport[i].we_a ),
      .regfile_waddr_a_o   ( backup_regfile_wport[i].waddr_a ),
      .regfile_wdata_a_o   ( backup_regfile_wport[i].wdata_a ),
      // Port B
      .regfile_we_b_o      ( backup_regfile_wport[i].we_b ),
      .regfile_waddr_b_o   ( backup_regfile_wport[i].waddr_b ),
      .regfile_wdata_b_o   ( backup_regfile_wport[i].wdata_b ),
      // Backup ports to the RF
      .regfile_backup_i    ( '0 ),
      .regfile_raddr_ra_i  ( '0 ),
      .regfile_raddr_rb_i  ( '0 ),
      .regfile_raddr_rc_i  ( '0   ),
      .regfile_rdata_ra_o  ( core_regfile_rdata[i].rdata_a ),
      .regfile_rdata_rb_o  ( core_regfile_rdata[i].rdata_b ),
      .regfile_rdata_rc_o  (    ),
      // CSRs Backup
      .backup_mstatus_o  ( core_backup_csr[i].csr_mstatus  ),
      .backup_mie_o      ( core_backup_csr[i].csr_mie      ),
      .backup_mtvec_o    ( core_backup_csr[i].csr_mtvec    ),
      .backup_mscratch_o ( core_backup_csr[i].csr_mscratch ),
      .backup_mip_o      ( core_backup_csr[i].csr_mip      ),
      .backup_mepc_o     ( core_backup_csr[i].csr_mepc     ),
      .backup_mcause_o   ( core_backup_csr[i].csr_mcause   ),
      // CSRs Recovery
      .recovery_mstatus_i  ( core_recovery_csr[i].csr_mstatus  ),
      .recovery_mie_i      ( core_recovery_csr[i].csr_mie      ),
      .recovery_mtvec_i    ( core_recovery_csr[i].csr_mtvec    ),
      .recovery_mscratch_i ( core_recovery_csr[i].csr_mscratch ),
      .recovery_mip_i      ( core_recovery_csr[i].csr_mip      ),
      .recovery_mepc_i     ( core_recovery_csr[i].csr_mepc     ),
      .recovery_mcause_i   ( core_recovery_csr[i].csr_mcause   ),

      //tcdm, dma ctrl unit, periph interco interfaces
      .core_data_bus        ( hmr_data_intf[i] ),
      // .tcdm_data_master    ( s_hci_core[i]         ),
      // .dma_ctrl_master     ( s_core_dmactrl_bus[i] ),
      // .eu_ctrl_master      ( s_core_euctrl_bus[i]  ),
      // .periph_data_master  ( s_core_periph_bus[i]  ),
    
      .perf_counters_i ( hmr_perf_counters[i] )
`ifdef SHARED_FPU_CLUSTER
      ,        
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
`endif
    );
  end


//**********************************************
//**** APU cluster - Shared execution units ****
//**********************************************

`ifdef APU_CLUSTER

  apu_cluster #(
    .C_NB_CORES         ( NB_CORES                ),
    .NDSFLAGS_CPU       ( APU_NDSFLAGS_CPU        ),
    .NUSFLAGS_CPU       ( APU_NUSFLAGS_CPU        ),
    .WOP_CPU            ( APU_WOP_CPU             ),
    .NARGS_CPU          ( APU_NARGS_CPU           ),
    .WAPUTYPE           ( WAPUTYPE                ),
    .SHARED_FP          ( CLUST_SHARED_FP         ),
    .SHARED_DSP_MULT    ( 0                       ),
    .SHARED_INT_MULT    ( 0                       ),
    .SHARED_INT_DIV     ( 0                       ),
    .SHARED_FP_DIVSQRT  ( CLUST_SHARED_FP_DIVSQRT )
  ) apu_cluster_i (
    .clk_i  ( clk_cluster       ),
    .rst_ni ( s_rst_n           ),
    .cpus   ( s_apu_cluster_bus )
  );

`endif


  //****************************************************
  //**** Shared FPU cluster - Shared execution units ***
  //****************************************************

`ifdef SHARED_FPU_CLUSTER

  // request channel
  logic [NB_CORES-1:0][2:0][31:0]                s_apu__operands;
  logic [NB_CORES-1:0][5:0]                      s_apu__op;
  logic [NB_CORES-1:0][2:0]                      s_apu__type;
  logic [NB_CORES-1:0][14:0]                     s_apu__flags;
  // response channel
  logic [NB_CORES-1:0][4:0]                      s_apu__rflags;

  genvar k;
  for(k=0;k<NB_CORES;k++)
  begin
    assign s_apu__operands[k][2:0] = s_apu_master_operands[k][2:0];
    assign s_apu__op[k][5:0]       = s_apu_master_op[k][5:0];
    assign s_apu__type[k][2:0]     = s_apu_master_type[k][2:0];
    assign s_apu__flags[k][14:0]   = s_apu_master_flags[k][14:0];
    assign s_apu_master_rflags[k][4:0] = s_apu__rflags[k][4:0];
  end

  shared_fpu_cluster #(
    .NB_CORES         ( NB_CORES          ),
    .NB_APUS          ( 1                 ),
    .NB_FPNEW         ( 4                 ),
    .FP_TYPE_WIDTH    ( 3                 ),

    .NB_CORE_ARGS      ( 3                ),
    .CORE_DATA_WIDTH   ( 32               ),
    .CORE_OPCODE_WIDTH ( 6                ),
    .CORE_DSFLAGS_CPU  ( 15               ),
    .CORE_USFLAGS_CPU  ( 5                ),

    .NB_APU_ARGS      ( 2                 ),
    .APU_OPCODE_WIDTH ( 6                 ),
    .APU_DSFLAGS_CPU  ( 15                ),
    .APU_USFLAGS_CPU  ( 5                 ),

    .NB_FPNEW_ARGS        ( 3             ), //= 3,
    .FPNEW_OPCODE_WIDTH   ( 6             ), //= 6,
    .FPNEW_DSFLAGS_CPU    ( 15            ), //= 15,
    .FPNEW_USFLAGS_CPU    ( 5             ), //= 5,

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
    .clk                   ( clk_cluster                               ),
    .rst_n                 ( s_rst_n                                   ),
    .test_mode_i           ( test_mode_i                               ),
    .core_slave_req_i      ( s_apu_master_req                          ),
    .core_slave_gnt_o      ( s_apu_master_gnt                          ),
    .core_slave_type_i     ( s_apu__type                               ),
    .core_slave_operands_i ( s_apu__operands                           ),
    .core_slave_op_i       ( s_apu__op                                 ),
    .core_slave_flags_i    ( s_apu__flags                              ),
    .core_slave_rready_i   ( s_apu_master_rready                       ),
    .core_slave_rvalid_o   ( s_apu_master_rvalid                       ),
    .core_slave_rdata_o    ( s_apu_master_rdata                        ),
    .core_slave_rflags_o   ( s_apu__rflags                             )
  );
`endif

  //**************************************************************
  //**** HW Processing Engines / Cluster-Coupled Accelerators ****
  //**************************************************************
  generate
    if(HWPE_PRESENT == 1) begin : hwpe_gen
      hwpe_subsystem #(
        .N_CORES       ( NB_CORES             ),
        .N_MASTER_PORT ( NB_HWPE_PORTS        ),
        .ID_WIDTH      ( NB_CORES+NB_MPERIPHS )
      ) hwpe_subsystem_i (
        .clk               ( clk_cluster    ),
        .rst_n             ( s_rst_n        ),
        .test_mode         ( test_mode_i    ),
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
      assign s_hci_hwpe[0].req   = 1'b0;
      assign s_hci_hwpe[0].add   = '0;
      assign s_hci_hwpe[0].wen   = '0;
      assign s_hci_hwpe[0].data  = '0;
      assign s_hci_hwpe[0].be    = '0;
      assign s_hci_hwpe[0].boffs = '0;
      assign s_hci_hwpe[0].lrdy  = '1;
      assign s_hwpe_busy = '0;
      assign s_hwpe_evt  = '0;
    end
  endgenerate
  
  generate
    for(genvar i=0; i<NB_CORES; i++) begin : hwpe_event_interrupt_gen
      assign s_hwpe_remap_evt[i][3:2] = '0;
      assign s_hwpe_remap_evt[i][1:0] = s_hwpe_evt[i];
    end
  endgenerate

  icache_hier_top #(
    .FETCH_ADDR_WIDTH     ( 32                  ), //= 32,
    .PRI_FETCH_DATA_WIDTH ( INSTR_RDATA_WIDTH   ), //= 128,   // Tested for 32 and 128
    .SH_FETCH_DATA_WIDTH  ( 128                 ), //= 128,

    .NB_CORES             ( NB_CORES            ), //= 8,

    .SH_NB_BANKS          ( NB_CACHE_BANKS      ), //= 1,
    .SH_NB_WAYS           ( 4                   ), //= 4,
    .SH_CACHE_SIZE        ( 4*1024              ), //= 4*1024,  // in Byte
    .SH_CACHE_LINE        ( 1                   ), //= 1,       // in word of [SH_FETCH_DATA_WIDTH]

    .PRI_NB_WAYS          ( 4                   ), //= 4,
    .PRI_CACHE_SIZE       ( 512                 ), //= 512,     // in Byte
    .PRI_CACHE_LINE       ( 1                   ), //= 1,       // in word of [PRI_FETCH_DATA_WIDTH]

    .AXI_ID               ( AXI_ID_IN_WIDTH     ), //= 6,
    .AXI_ADDR             ( AXI_ADDR_WIDTH      ), //= 32,
    .AXI_USER             ( AXI_USER_WIDTH      ), //= 6,
    .AXI_DATA             ( AXI_DATA_C2S_WIDTH  ), //= 64,

    .USE_REDUCED_TAG      ( USE_REDUCED_TAG     ), //= "TRUE",  // TRUE | FALSE
    .L2_SIZE              ( L2_SIZE             )  //= 512*1024 // Size of max(L2 ,ROM) program memory in Byte
  ) icache_top_i (
    .clk                       ( clk_cluster     ),
    .rst_n                     ( s_rst_n         ),
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
   
  /* TCDM banks */
  tcdm_banks_wrap #(
    .BankSize (TCDM_NUM_ROWS),
    .NbBanks  (NB_TCDM_BANKS),
    .DataWidth(DATA_WIDTH   ),
    .AddrWidth(ADDR_WIDTH   ),
    .BeWidth  (BE_WIDTH     ),
    .IdWidth  (TCDM_ID_WIDTH)
  ) tcdm_banks_i (
    .clk_i      (clk_cluster    ),
    .rst_ni     (s_rst_n        ),
    .test_mode_i(test_mode_i    ),
    
    .tcdm_slave (s_tcdm_bus_sram)  //PMU ??
  );
  
  /* AXI interconnect infrastructure (slices, size conversion) */ 
   //********************************************************
   //**************** AXI REGISTER SLICES *******************
   //********************************************************
   // CLUSTER TO SOC

   `AXI_TYPEDEF_AW_CHAN_T(c2s_aw_chan_t,logic[AXI_ADDR_WIDTH-1:0],logic[AXI_ID_OUT_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_W_CHAN_T(c2s_w_chan_t,logic[AXI_DATA_C2S_WIDTH-1:0],logic[AXI_DATA_C2S_WIDTH/8-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_B_CHAN_T(c2s_b_chan_t,logic[AXI_ID_OUT_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_AR_CHAN_T(c2s_ar_chan_t,logic[AXI_ADDR_WIDTH-1:0],logic[AXI_ID_OUT_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_R_CHAN_T(c2s_r_chan_t,logic[AXI_DATA_C2S_WIDTH-1:0],logic[AXI_ID_OUT_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   
  `AXI_TYPEDEF_REQ_T(c2s_req_t,c2s_aw_chan_t,c2s_w_chan_t,c2s_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(c2s_resp_t,c2s_b_chan_t,c2s_r_chan_t)

   c2s_req_t   src_req ;
   c2s_resp_t  src_resp;   
   
  `AXI_ASSIGN_TO_REQ(src_req,s_data_master)
  `AXI_ASSIGN_FROM_RESP(s_data_master,src_resp)

  axi_cdc_src #(
     .aw_chan_t (c2s_aw_chan_t),
     .w_chan_t  (c2s_w_chan_t),
     .b_chan_t  (c2s_b_chan_t),     
     .r_chan_t  (c2s_r_chan_t),
     .ar_chan_t (c2s_ar_chan_t),
     .axi_req_t (c2s_req_t    ),
     .axi_resp_t(c2s_resp_t   ),
    .LogDepth        ( LOG_DEPTH              )
    ) axi_master_cdc_i (
     .src_rst_ni                       ( s_rst_n                     ),
     .src_clk_i                        ( clk_cluster                 ),
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

      
   `AXI_TYPEDEF_AW_CHAN_T(s2c_aw_chan_t,logic[AXI_ADDR_WIDTH-1:0],logic[AXI_ID_IN_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_W_CHAN_T(s2c_w_chan_t,logic[AXI_DATA_S2C_WIDTH-1:0],logic[AXI_DATA_S2C_WIDTH/8-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_B_CHAN_T(s2c_b_chan_t,logic[AXI_ID_IN_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_AR_CHAN_T(s2c_ar_chan_t,logic[AXI_ADDR_WIDTH-1:0],logic[AXI_ID_IN_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   `AXI_TYPEDEF_R_CHAN_T(s2c_r_chan_t,logic[AXI_DATA_S2C_WIDTH-1:0],logic[AXI_ID_IN_WIDTH-1:0],logic[AXI_USER_WIDTH-1:0])
   
  `AXI_TYPEDEF_REQ_T(s2c_req_t,s2c_aw_chan_t,s2c_w_chan_t,s2c_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(s2c_resp_t,s2c_b_chan_t,s2c_r_chan_t)

   s2c_req_t      dst_req;
   s2c_resp_t     dst_resp;
   
  `AXI_ASSIGN_FROM_REQ(s_data_slave_32,dst_req)
  `AXI_ASSIGN_TO_RESP(dst_resp,s_data_slave_32)
   
  axi_cdc_dst #(
     .aw_chan_t (s2c_aw_chan_t),
     .w_chan_t  (s2c_w_chan_t ),
     .b_chan_t  (s2c_b_chan_t ),     
     .r_chan_t  (s2c_r_chan_t ),
     .ar_chan_t (s2c_ar_chan_t),
     .axi_req_t (s2c_req_t    ),
     .axi_resp_t(s2c_resp_t   ),
     .LogDepth        ( LOG_DEPTH              )
    ) axi_slave_cdc_i (
     .dst_rst_ni                       ( s_rst_n                    ),
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

  axi_dw_converter_intf #(
    .AXI_ID_WIDTH            ( AXI_ID_IN_WIDTH    ),
    .AXI_ADDR_WIDTH          ( AXI_ADDR_WIDTH     ),
    .AXI_SLV_PORT_DATA_WIDTH ( AXI_DATA_S2C_WIDTH ),
    .AXI_MST_PORT_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH          ( AXI_USER_WIDTH     ),
    .AXI_MAX_READS           ( 1                  )
  ) axi_dw_UPSIZE_32_64_wrap_i (
    .clk_i  ( clk_i           ),
    .rst_ni ( s_rst_n         ),
    .slv    ( s_data_slave_32 ),
    .mst    ( s_data_slave_64 )
  );
   
  /* event synchronizers */
  cdc_fifo_gray_dst #(
    .T(logic[EVNT_WIDTH-1:0]),
    .LOG_DEPTH(LOG_DEPTH),
    .SYNC_STAGES(2)
  ) u_event_dc (
    .dst_clk_i                ( clk_i                       ),
    .dst_rst_ni               ( s_rst_n                     ),
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
    .rstn_i  ( s_rst_n            ),
    .valid_i ( s_dma_fc_event     ),
    .ack_i   ( dma_pe_evt_ack_i   ),
    .valid_o ( dma_pe_evt_valid_o )
  );
   
  edge_propagator_tx ep_dma_pe_irq_i (
    .clk_i   ( clk_i              ),
    .rstn_i  ( s_rst_n            ),
    .valid_i ( s_dma_fc_irq       ),
    .ack_i   ( dma_pe_irq_ack_i   ),
    .valid_o ( dma_pe_irq_valid_o )
  );
   
  // edge_propagator_tx ep_pf_evt_i (
  //   .clk_i   ( clk_i          ),
  //   .rstn_i  ( s_rst_n        ),
  //   .valid_i ( s_pf_event     ),
  //   .ack_i   ( pf_evt_ack_i   ),
  //   .valid_o ( pf_evt_valid_o )
  // );
   
  /* centralized gating */
  cluster_clock_gate #(
    .NB_CORES ( NB_CORES )
  ) u_clustercg (
    .clk_i              ( clk_i              ),
    .rstn_i             ( s_rst_n            ),
    .test_mode_i        ( test_mode_i        ),
    .cluster_cg_en_i    ( s_cluster_cg_en    ),
    .cluster_int_busy_i ( s_cluster_int_busy ),
    .cores_busy_i       ( core_busy          ),
    .events_i           ( s_events_async     ),
    .incoming_req_i     ( s_incoming_req     ),
    .isolate_cluster_o  ( s_isolate_cluster  ),
    .cluster_clk_o      ( clk_cluster        )
  );

endmodule
