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
 */

`include "pulp_soc_defines.sv"

import pulp_cluster_package::*;
import apu_package::*;

module pulp_cluster
#(
  // cluster parameters
  parameter NB_CORES           = `NB_CORES,
  parameter NB_HWACC_PORTS     = 4,
  parameter NB_DMAS            = 4,
  parameter NB_MPERIPHS        = 1,
  parameter NB_SPERIPHS        = 8,
  parameter CLUSTER_ALIAS_BASE = 12'h000,
  parameter TCDM_SIZE          = `TCDM_SIZE,              // [B], must be 2**N
  parameter NB_TCDM_BANKS      = `NB_TCDM_BANKS,          // must be 2**N
  parameter TCDM_BANK_SIZE     = TCDM_SIZE/NB_TCDM_BANKS, // [B]
  parameter TCDM_NUM_ROWS      = TCDM_BANK_SIZE/4,        // [words]
  parameter XNE_PRESENT        = 0,                       // set to 1 if XNE is present in the cluster

  // I$ parameters
  parameter SET_ASSOCIATIVE       = 4,
  parameter NB_CACHE_BANKS        = `NB_CACHE_BANKS,
  parameter CACHE_LINE            = 1,
  parameter CACHE_SIZE            = `CACHE_SIZE,
  parameter ICACHE_DATA_WIDTH     = 128,
  parameter L0_BUFFER_FEATURE     = "DISABLED",
  parameter MULTICAST_FEATURE     = "DISABLED",
  parameter SHARED_ICACHE         = "ENABLED",
  parameter DIRECT_MAPPED_FEATURE = "DISABLED",
  parameter L2_SIZE               = `L2_SIZE,
  parameter USE_REDUCED_TAG       = "TRUE",

  // core parameters
  parameter ROM_BOOT_ADDR     = 32'h1A000000,
  parameter BOOT_ADDR         = 32'h1C000000,
  parameter INSTR_RDATA_WIDTH = 128,
  
  // AXI parameters
  parameter AXI_ADDR_WIDTH        = 32,
  parameter AXI_DATA_C2S_WIDTH    = 64,
  parameter AXI_DATA_S2C_WIDTH    = 32,
  parameter AXI_USER_WIDTH        = 6,
  parameter AXI_ID_IN_WIDTH       = 4,
  parameter AXI_ID_OUT_WIDTH      = `AXI_ID_SOC_S_WIDTH,
  parameter AXI_STRB_C2S_WIDTH    = AXI_DATA_C2S_WIDTH/8,
  parameter AXI_STRB_S2C_WIDTH    = AXI_DATA_S2C_WIDTH/8,
  parameter DC_SLICE_BUFFER_WIDTH = 8,
  
  // TCDM and log interconnect parameters
  parameter DATA_WIDTH     = 32,
  parameter ADDR_WIDTH     = 32,
  parameter BE_WIDTH       = DATA_WIDTH/8,
  parameter TEST_SET_BIT   = 20, // bits used to indicate a test and set opration during a load in TCDM
  parameter ADDR_MEM_WIDTH = $clog2(TCDM_BANK_SIZE/4), // Memory datawidth is 4 byte (32bit) --> bits used to address a single bank in SRAM TCDM
  
  // DMA parameters
  parameter TCDM_ADD_WIDTH     = ADDR_MEM_WIDTH + $clog2(NB_TCDM_BANKS),
  parameter NB_OUTSND_BURSTS   = `NB_OUTSND_BURSTS,
  parameter MCHAN_BURST_LENGTH = `MCHAN_BURST_LENGTH,

  // peripheral and periph interconnect parameters
  parameter LOG_CLUSTER    = 5,  // unused
  parameter PE_ROUTING_LSB = 10, // LSB used as routing BIT in periph interco
  parameter PE_ROUTING_MSB = 13, // MSB used as routing BIT in periph interco
  parameter EVNT_WIDTH     = 8,  // size of the event bus
  parameter REMAP_ADDRESS  = 0   // for cluster virtualization
)
(
  input  logic                             clk_i,
  input  logic                             rst_ni,
  input  logic                             ref_clk_i,
  input  logic                             pmu_mem_pwdn_i,
  
  input logic [3:0]                        base_addr_i,

  input logic                              test_mode_i,

  input logic                              en_sa_boot_i,

  input logic [5:0]                        cluster_id_i,

  input logic                              fetch_en_i,
 
  output logic                             eoc_o,
  
  output logic                             busy_o,
 
  input  logic [DC_SLICE_BUFFER_WIDTH-1:0] ext_events_writetoken_i,
  output logic [DC_SLICE_BUFFER_WIDTH-1:0] ext_events_readpointer_o,
  input  logic            [EVNT_WIDTH-1:0] ext_events_dataasync_i,
  
  input  logic                             dma_pe_evt_ack_i,
  output logic                             dma_pe_evt_valid_o,

  input  logic                             dma_pe_irq_ack_i,
  output logic                             dma_pe_irq_valid_o,
  
  input  logic                             pf_evt_ack_i,
  output logic                             pf_evt_valid_o,
   
  // AXI4 SLAVE
  //***************************************
  // WRITE ADDRESS CHANNEL
  input  logic [7:0]                       data_slave_aw_writetoken_i,
  input  logic [31:0]                      data_slave_aw_addr_i,
  input  logic [2:0]                       data_slave_aw_prot_i,
  input  logic [3:0]                       data_slave_aw_region_i,
  input  logic [7:0]                       data_slave_aw_len_i,
  input  logic [2:0]                       data_slave_aw_size_i,
  input  logic [1:0]                       data_slave_aw_burst_i,
  input  logic                             data_slave_aw_lock_i,
  input  logic [3:0]                       data_slave_aw_cache_i,
  input  logic [3:0]                       data_slave_aw_qos_i,
  input  logic [AXI_ID_IN_WIDTH-1:0]       data_slave_aw_id_i,
  input  logic [AXI_USER_WIDTH-1:0]        data_slave_aw_user_i,
  output logic [7:0]                       data_slave_aw_readpointer_o,
   
  // READ ADDRESS CHANNEL
  input  logic [7:0]                       data_slave_ar_writetoken_i,
  input  logic [31:0]                      data_slave_ar_addr_i,
  input  logic [2:0]                       data_slave_ar_prot_i,
  input  logic [3:0]                       data_slave_ar_region_i,
  input  logic [7:0]                       data_slave_ar_len_i,
  input  logic [2:0]                       data_slave_ar_size_i,
  input  logic [1:0]                       data_slave_ar_burst_i,
  input  logic                             data_slave_ar_lock_i,
  input  logic [3:0]                       data_slave_ar_cache_i,
  input  logic [3:0]                       data_slave_ar_qos_i,
  input  logic [AXI_ID_IN_WIDTH-1:0]       data_slave_ar_id_i,
  input  logic [AXI_USER_WIDTH-1:0]        data_slave_ar_user_i,
  output logic [7:0]                       data_slave_ar_readpointer_o,
   
  // WRITE DATA CHANNEL
  input  logic [7:0]                       data_slave_w_writetoken_i,
  input  logic [AXI_DATA_S2C_WIDTH-1:0]    data_slave_w_data_i,
  input  logic [AXI_STRB_S2C_WIDTH-1:0]    data_slave_w_strb_i,
  input  logic [AXI_USER_WIDTH-1:0]        data_slave_w_user_i,
  input  logic                             data_slave_w_last_i,
  output logic [7:0]                       data_slave_w_readpointer_o,
   
  // READ DATA CHANNEL
  output logic [7:0]                       data_slave_r_writetoken_o,
  output logic [AXI_DATA_S2C_WIDTH-1:0]    data_slave_r_data_o,
  output logic [1:0]                       data_slave_r_resp_o,
  output logic                             data_slave_r_last_o,
  output logic [AXI_ID_IN_WIDTH-1:0]       data_slave_r_id_o,
  output logic [AXI_USER_WIDTH-1:0]        data_slave_r_user_o,
  input  logic [7:0]                       data_slave_r_readpointer_i,
  
  // WRITE RESPONSE CHANNEL
  output logic [7:0]                       data_slave_b_writetoken_o,
  output logic [1:0]                       data_slave_b_resp_o,
  output logic [AXI_ID_IN_WIDTH-1:0]       data_slave_b_id_o,
  output logic [AXI_USER_WIDTH-1:0]        data_slave_b_user_o,
  input  logic [7:0]                       data_slave_b_readpointer_i,
   
  // AXI4 MASTER
  //***************************************
  // WRITE ADDRESS CHANNEL
  output logic [7:0]                       data_master_aw_writetoken_o,
  output logic [AXI_ADDR_WIDTH-1:0]        data_master_aw_addr_o,
  output logic [2:0]                       data_master_aw_prot_o,
  output logic [3:0]                       data_master_aw_region_o,
  output logic [7:0]                       data_master_aw_len_o,
  output logic [2:0]                       data_master_aw_size_o,
  output logic [1:0]                       data_master_aw_burst_o,
  output logic                             data_master_aw_lock_o,
  output logic [3:0]                       data_master_aw_cache_o,
  output logic [3:0]                       data_master_aw_qos_o,
  output logic [AXI_ID_OUT_WIDTH-1:0]      data_master_aw_id_o,
  output logic [AXI_USER_WIDTH-1:0]        data_master_aw_user_o,
  input  logic [7:0]                       data_master_aw_readpointer_i,
  
  // READ ADDRESS CHANNEL
  output logic [7:0]                       data_master_ar_writetoken_o,
  output logic [AXI_ADDR_WIDTH-1:0]        data_master_ar_addr_o,
  output logic [2:0]                       data_master_ar_prot_o,
  output logic [3:0]                       data_master_ar_region_o,
  output logic [7:0]                       data_master_ar_len_o,
  output logic [2:0]                       data_master_ar_size_o,
  output logic [1:0]                       data_master_ar_burst_o,
  output logic                             data_master_ar_lock_o,
  output logic [3:0]                       data_master_ar_cache_o,
  output logic [3:0]                       data_master_ar_qos_o,
  output logic [AXI_ID_OUT_WIDTH-1:0]      data_master_ar_id_o,
  output logic [AXI_USER_WIDTH-1:0]        data_master_ar_user_o,
  input  logic [7:0]                       data_master_ar_readpointer_i,
   
  // WRITE DATA CHANNEL
  output logic [7:0]                       data_master_w_writetoken_o,
  output logic [AXI_DATA_C2S_WIDTH-1:0]    data_master_w_data_o,
  output logic [AXI_STRB_C2S_WIDTH-1:0]    data_master_w_strb_o,
  output logic [AXI_USER_WIDTH-1:0]        data_master_w_user_o,
  output logic                             data_master_w_last_o,
  input  logic [7:0]                       data_master_w_readpointer_i,
  
  // READ DATA CHANNEL
  input  logic [7:0]                       data_master_r_writetoken_i,
  input  logic [AXI_DATA_C2S_WIDTH-1:0]    data_master_r_data_i,
  input  logic [1:0]                       data_master_r_resp_i,
  input  logic                             data_master_r_last_i,
  input  logic [AXI_ID_OUT_WIDTH-1:0]      data_master_r_id_i,
  input  logic [AXI_USER_WIDTH-1:0]        data_master_r_user_i,
  output logic [7:0]                       data_master_r_readpointer_o,
  
  // WRITE RESPONSE CHANNEL
  input  logic [7:0]                       data_master_b_writetoken_i,
  input  logic [1:0]                       data_master_b_resp_i,
  input  logic [AXI_ID_OUT_WIDTH-1:0]      data_master_b_id_i,
  input  logic [AXI_USER_WIDTH-1:0]        data_master_b_user_i,
  output logic [7:0]                       data_master_b_readpointer_o
   
);
  
  logic [NB_CORES-1:0]                fetch_enable_reg_int;
  logic [NB_CORES-1:0]                fetch_en_int;
  logic                               s_rst_n;
  logic                               s_init_n;
  logic [NB_CORES-1:0][31:0]          boot_addr;
  logic [NB_CORES-1:0]                dbg_core_halt;
  logic [NB_CORES-1:0]                dbg_core_resume;
  logic [NB_CORES-1:0]                dbg_core_halted;
  logic                               hwpe_sel;
  logic                               hwpe_en;

  logic                s_cluster_periphs_busy;
  logic                s_axi2mem_busy;
  logic                s_per2axi_busy;
  logic                s_axi2per_busy;
  logic                s_dmac_busy;
  logic                s_cluster_cg_en;
  logic [NB_CORES-1:0] s_dma_event;
  logic [NB_CORES-1:0] s_dma_irq;
  logic [NB_CORES-1:0][3:0]  s_hwacc_events;
  logic [NB_CORES-1:0][1:0]  s_xne_evt;
  logic                      s_xne_busy;

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

  logic               s_dma_pe_event;
  logic               s_dma_pe_irq;
  logic               s_pf_event;
  
  logic[NB_CORES-1:0][4:0] irq_id;
  logic[NB_CORES-1:0][4:0] irq_ack_id;
  logic[NB_CORES-1:0]      irq_req;
  logic[NB_CORES-1:0]      irq_ack;
   
   
  /* asynchronous AXI interfaces at CLUSTER/SOC interface */
  AXI_BUS_ASYNC #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_S2C_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH    ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_data_slave_async();

  AXI_BUS_ASYNC #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_data_master_async();
    
  /* synchronous AXI interfaces at CLUSTER/SOC interface */
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

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) s_core_instr_bus();

  /* synchronous AXI interfaces internal to the cluster */
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

  /* logarithmic and peripheral interconnect interfaces */
  // ext -> log interconnect 
  XBAR_TCDM_BUS s_ext_xbar_bus[NB_DMAS-1:0]();

  // periph interconnect -> slave peripherals
  XBAR_PERIPH_BUS s_xbar_speriph_bus[NB_SPERIPHS-1:0]();

  // periph interconnect -> XNE
  XBAR_PERIPH_BUS s_xne_cfg_bus();

  // DMA -> log interconnect
  XBAR_TCDM_BUS s_dma_xbar_bus[NB_DMAS-1:0]();

  // ext -> xbar periphs FIXME
  XBAR_TCDM_BUS s_mperiph_xbar_bus[NB_MPERIPHS-1:0]();

  // periph demux
  XBAR_TCDM_BUS s_mperiph_bus();
  XBAR_TCDM_BUS s_mperiph_demux_bus[1:0]();
  
  // cores & accelerators -> log interconnect
  XBAR_TCDM_BUS s_core_xbar_bus[NB_CORES+NB_HWACC_PORTS-1:0]();
  
  // cores -> periph interconnect
  XBAR_PERIPH_BUS s_core_periph_bus[NB_CORES-1:0]();
  
  // periph interconnect -> DMA
  XBAR_PERIPH_BUS s_periph_dma_bus();
  
  // debug
  XBAR_TCDM_BUS s_debug_bus[NB_CORES-1:0]();
  
  /* other interfaces */
  // cores -> DMA ctrl
  XBAR_TCDM_BUS s_core_dmactrl_bus[NB_CORES-1:0]();
  
  // cores -> event unit ctrl
  XBAR_PERIPH_BUS s_core_euctrl_bus[NB_CORES-1:0]();
  
  // I$ ctrl unit <-> I$, L0, I$ interconnect
  MP_PF_ICACHE_CTRL_UNIT_BUS  IC_ctrl_unit_bus();

  // log interconnect -> TCDM memory banks (SRAM)
  TCDM_BANK_MEM_BUS s_tcdm_bus_sram[NB_TCDM_BANKS-1:0]();

  // cores -> APU
  cpu_marx_if #(
    .WOP_CPU      ( WOP_CPU      ),
    .WAPUTYPE     ( WAPUTYPE     ),
    .NUSFLAGS_CPU ( NUSFLAGS_CPU ),
    .NDSFLAGS_CPU ( NDSFLAGS_CPU ),
    .NARGS_CPU    ( NARGS_CPU    )
  ) apu_cluster_bus [NB_CORES-1:0] ();

  /* reset generator */
  rstgen rstgen_i (
    .clk_i      ( clk_i       ),
    .rst_ni     ( rst_ni      ),
    .test_mode_i( test_mode_i ),
    .rst_no     ( s_rst_n     ),
    .init_no    ( s_init_n    )
  );
  
  /* fetch & busy genertion */
  assign s_cluster_int_busy = s_cluster_periphs_busy | s_per2axi_busy | s_axi2per_busy | s_axi2mem_busy | s_dmac_busy | s_xne_busy;
  assign busy_o = s_cluster_int_busy | (|core_busy);
  assign fetch_en_int = fetch_enable_reg_int;

  /* cluster bus and attached peripherals */
  cluster_bus_wrap #(
    .NB_CORES         ( NB_CORES           ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH   ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH     ),
    .AXI_ID_IN_WIDTH  ( AXI_ID_IN_WIDTH    ),
    .AXI_ID_OUT_WIDTH ( AXI_ID_OUT_WIDTH   )
  ) cluster_bus_wrap_i (
    .clk_i         ( clk_cluster       ),
    .rst_ni        ( rst_ni            ),
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
    .rst_ni      ( rst_ni         ),
    .test_en_i   ( test_mode_i    ),
    .axi_slave   ( s_ext_tcdm_bus ),
    .tcdm_master ( s_ext_xbar_bus ),
    .busy_o      ( s_axi2mem_busy )
  );

  axi2per_wrap #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_C2S_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
  ) axi2per_wrap_i (
    .clk_i         ( clk_cluster       ),
    .rst_ni        ( rst_ni            ),
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
    .rst_ni  ( rst_ni              ),
    .slave   ( s_mperiph_bus       ),
    .masters ( s_mperiph_demux_bus )
  );
    
  assign s_mperiph_xbar_bus[NB_MPERIPHS-1].req   = s_mperiph_demux_bus[0].req;
  assign s_mperiph_xbar_bus[NB_MPERIPHS-1].add   = s_mperiph_demux_bus[0].add;
  assign s_mperiph_xbar_bus[NB_MPERIPHS-1].wen   = s_mperiph_demux_bus[0].wen;
  assign s_mperiph_xbar_bus[NB_MPERIPHS-1].wdata = s_mperiph_demux_bus[0].wdata;
  assign s_mperiph_xbar_bus[NB_MPERIPHS-1].be    = s_mperiph_demux_bus[0].be;
                                        
  assign s_mperiph_demux_bus[0].gnt       = s_mperiph_xbar_bus[NB_MPERIPHS-1].gnt;
  assign s_mperiph_demux_bus[0].r_valid   = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_valid;
  assign s_mperiph_demux_bus[0].r_opc     = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_opc;
  assign s_mperiph_demux_bus[0].r_rdata   = s_mperiph_xbar_bus[NB_MPERIPHS-1].r_rdata;
    
  per_demux_wrap #(
    .NB_MASTERS  ( NB_CORES ),
    .ADDR_OFFSET ( 15       )
  ) debug_interconect_i (
    .clk_i   ( clk_cluster            ),
    .rst_ni  ( rst_ni                 ),
    .slave   ( s_mperiph_demux_bus[1] ),
    .masters ( s_debug_bus            )
  );
    
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
    .rst_ni         ( rst_ni                          ),
    .test_en_i      ( test_mode_i                     ),
    .periph_slave   ( s_xbar_speriph_bus[SPER_EXT_ID] ),
    .axi_master     ( s_core_ext_bus                  ),
    .busy_o         ( s_per2axi_busy                  )
  );
    
  /* cluster (log + periph) interconnect and attached peripherals */
  cluster_interconnect_wrap #(
    .NB_CORES           ( NB_CORES           ),
    .NB_HWACC_PORTS     ( NB_HWACC_PORTS     ),
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
    .PE_ROUTING_MSB     ( PE_ROUTING_MSB     ),
    .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE )
  ) cluster_interconnect_wrap_i (
    .clk_i              ( clk_cluster                         ),
    .rst_ni             ( rst_ni                              ),
    .core_tcdm_slave    ( s_core_xbar_bus                     ),
    .core_periph_slave  ( s_core_periph_bus                   ),
    .ext_slave          ( s_ext_xbar_bus                      ),
    .dma_slave          ( s_dma_xbar_bus                      ),
    .mperiph_slave      ( s_mperiph_xbar_bus[NB_MPERIPHS-1:0] ),
    .tcdm_sram_master   ( s_tcdm_bus_sram                     ),
    .speriph_master     ( s_xbar_speriph_bus                  ),
    .TCDM_arb_policy_i  ( s_TCDM_arb_policy                   )
  );

  dmac_wrap #(
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
    .clk_i          ( clk_cluster        ),
    .rst_ni         ( rst_ni             ),
    .test_mode_i    ( test_mode_i        ),
    .ctrl_slave     ( s_core_dmactrl_bus ),
    .pe_ctrl_slave  ( s_periph_dma_bus   ),
    .tcdm_master    ( s_dma_xbar_bus     ),
    .ext_master     ( s_dma_ext_bus      ),
    .term_event_o   ( s_dma_event        ),
    .term_irq_o     ( s_dma_irq          ),
    .term_event_pe_o( s_dma_pe_event     ),
    .term_irq_pe_o  ( s_dma_pe_irq       ),
    .busy_o         ( s_dmac_busy        )
  );

  cluster_peripherals #(
    .NB_CORES       ( NB_CORES       ),
    .NB_MPERIPHS    ( NB_MPERIPHS    ),
    .NB_CACHE_BANKS ( NB_CACHE_BANKS ),
    .NB_SPERIPHS    ( NB_SPERIPHS    ),
    .NB_TCDM_BANKS  ( NB_TCDM_BANKS  ),
    .NB_HWPE_PORTS  ( 1              ),
    .ROM_BOOT_ADDR  ( ROM_BOOT_ADDR  ),
    .BOOT_ADDR      ( BOOT_ADDR      ),
    .EVNT_WIDTH     ( EVNT_WIDTH     )
  ) cluster_peripherals_i (
    .clk_i                  ( clk_cluster                        ),
    .rst_ni                 ( rst_ni                             ),
    .ref_clk_i              ( ref_clk_i                          ),
    .test_mode_i            ( test_mode_i                        ),
    .busy_o                 ( s_cluster_periphs_busy             ),
    .dma_events_i           ( s_dma_event                        ),
    .dma_irq_i              ( s_dma_irq                          ),
    .en_sa_boot_i           ( en_sa_boot_i                       ),
    .fetch_en_i             ( fetch_en_i                         ),
    .boot_addr_o            ( boot_addr                          ),
    .core_busy_i            ( core_busy                          ),
    .core_clk_en_o          ( clk_core_en                        ),
    .fregfile_disable_o     ( s_fregfile_disable                 ),
    .speriph_slave          ( s_xbar_speriph_bus[NB_SPERIPHS-2:0]),
    .core_eu_direct_link    ( s_core_euctrl_bus                  ),
    .dma_cfg_master         ( s_periph_dma_bus                   ),
    .dma_pe_irq_i           ( s_dma_pe_irq                       ),
    .pf_event_o             ( s_pf_event                         ),
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
    .TCDM_arb_policy_o      ( s_TCDM_arb_policy                  ),
    .hwce_cfg_master        ( s_xne_cfg_bus                      ),
    .hwacc_events_i         ( s_hwacc_events                     ),
    .hwpe_sel_o             ( hwpe_sel                           ),
    .hwpe_en_o              ( hwpe_en                            ),
    .IC_ctrl_unit_bus       (  IC_ctrl_unit_bus                  )    
  );
  
  /* cluster cores + core-coupled accelerators / shared execution units */
  generate
    for (genvar i=0; i<NB_CORES; i++) begin : CORE
      core_region #(
        .CORE_ID             ( i                  ),
        .ADDR_WIDTH          ( 32                 ),
        .DATA_WIDTH          ( 32                 ),
        .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH  ),
        .CLUSTER_ALIAS_BASE  ( CLUSTER_ALIAS_BASE ),
        .REMAP_ADDRESS       ( REMAP_ADDRESS      )
      ) core_region_i (
        .clk_i               ( clk_cluster           ),
        .rst_ni              ( s_rst_n               ),
        .base_addr_i         ( base_addr_i           ),
        .init_ni             ( s_init_n              ),
        .cluster_id_i        ( cluster_id_i          ),
        .clock_en_i          ( clk_core_en[i]        ),
        .fetch_en_i          ( fetch_en_int[i]       ),
        .fregfile_disable_i  ( s_fregfile_disable    ),
        .boot_addr_i         ( boot_addr[i]          ),
        .irq_id_i            ( irq_id[i]             ),
	.irq_ack_id_o        ( irq_ack_id[i]         ),
        .irq_req_i           ( irq_req[i]            ),
        .irq_ack_o           ( irq_ack[i]            ),
	
        .test_mode_i         ( test_mode_i           ),
        .core_busy_o         ( core_busy[i]          ),
        .instr_req_o         ( instr_req[i]          ),
        .instr_gnt_i         ( instr_gnt[i]          ),
        .instr_addr_o        ( instr_addr[i]         ),
        .instr_r_rdata_i     ( instr_r_rdata[i]      ),
        .instr_r_valid_i     ( instr_r_valid[i]      ),
        .debug_bus           ( s_debug_bus[i]        ),
        .debug_core_halted_o ( dbg_core_halted[i]    ),
        .debug_core_halt_i   ( dbg_core_halt[i]      ),
        .debug_core_resume_i ( dbg_core_resume[i]    ),
        .tcdm_data_master    ( s_core_xbar_bus[i]    ),
        .dma_ctrl_master     ( s_core_dmactrl_bus[i] ),
        .eu_ctrl_master      ( s_core_euctrl_bus[i]  ),
        .periph_data_master  ( s_core_periph_bus[i]  ),
        .apu_master          ( apu_cluster_bus[i]    )
      );
    end
  endgenerate

  generate
    if(APU_CLUSTER) begin : apu_cluster_gen
      apu_cluster #(
        .C_NB_CORES         ( NB_CORES          ),
        .NDSFLAGS_CPU       ( NDSFLAGS_CPU      ),
        .NUSFLAGS_CPU       ( NUSFLAGS_CPU      ),
        .WOP_CPU            ( WOP_CPU           ),
        .NARGS_CPU          ( NARGS_CPU         ),
        .WAPUTYPE           ( WAPUTYPE          ),
        .SHARED_FP          ( SHARED_FP         ),
        .SHARED_DSP_MULT    ( SHARED_DSP_MULT   ),
        .SHARED_INT_MULT    ( SHARED_INT_MULT   ),
        .SHARED_INT_DIV     ( SHARED_INT_DIV    ),
        .SHARED_FP_DIVSQRT  ( SHARED_FP_DIVSQRT )
      ) apu_cluster_i (
        .clk_i  ( clk_cluster     ),
        .rst_ni ( s_rst_n         ),
        .cpus   ( apu_cluster_bus )
      );
    end
    else begin : no_apu_cluster_gen
      for(genvar i=0; i<NB_CORES; i++) begin
        assign apu_cluster_bus[i].ack_ds_s    = '1;
        assign apu_cluster_bus[i].valid_us_s  = '0;
        assign apu_cluster_bus[i].result_us_d = '0;
        assign apu_cluster_bus[i].flags_us_d  = '0;
      end
    end
  endgenerate
   
  /* cluster-coupled accelerators / HW processing engines */
  generate
    if(XNE_PRESENT == 1) begin : xne_gen
      xne_wrap #(
        .N_CORES       ( NB_CORES             ),
        .N_MASTER_PORT ( 4                    ),
        .ID_WIDTH      ( NB_CORES+NB_MPERIPHS )
      ) xne_wrap_i (
        .clk               ( clk_cluster                                         ),
        .rst_n             ( s_rst_n                                             ),
        .test_mode         ( test_mode_i                                         ),
        .hwacc_xbar_master ( s_core_xbar_bus[NB_CORES+NB_HWACC_PORTS-1:NB_CORES] ),
        .hwacc_cfg_slave   ( s_xne_cfg_bus                                       ),
        .evt_o             ( s_xne_evt                                           ),
        .busy_o            ( s_xne_busy                                          )
      );
    end
    else begin : no_xne_gen
      assign s_xne_cfg_bus.r_valid = '1;
      assign s_xne_cfg_bus.gnt = '1;
      assign s_xne_cfg_bus.r_rdata = 32'hdeadbeef;
      assign s_xne_cfg_bus.r_id = '0;
      for (genvar i=NB_CORES; i<NB_CORES+NB_HWACC_PORTS; i++) begin : no_xne_bias
        assign s_core_xbar_bus[i].req = '0;
        assign s_core_xbar_bus[i].wen = '0;
        assign s_core_xbar_bus[i].be  = '0;
        assign s_core_xbar_bus[i].wdata = '0;
      end
      assign s_xne_busy = '0;
      assign s_xne_evt  = '0;
       
    end
  endgenerate
  
  generate
    for(genvar i=0; i<NB_CORES; i++) begin : hwacc_event_interrupt_gen
      assign s_hwacc_events[i][3:2] = '0;
      assign s_hwacc_events[i][1:0] = s_xne_evt[i];
    end
  endgenerate

  /* instruction cache */
  icache_top_mp_128_PF #(
    .FETCH_ADDR_WIDTH ( 32                 ),
    .FETCH_DATA_WIDTH ( 128                ),
    .NB_CORES         ( NB_CORES           ),
    .NB_BANKS         ( NB_CACHE_BANKS     ),
    .NB_WAYS          ( SET_ASSOCIATIVE    ),
    .CACHE_SIZE       ( CACHE_SIZE         ),
    .CACHE_LINE       ( 1                  ),
    .AXI_ID           ( AXI_ID_OUT_WIDTH   ),
    .AXI_ADDR         ( AXI_ADDR_WIDTH     ),
    .AXI_USER         ( AXI_USER_WIDTH     ),
    .AXI_DATA         ( AXI_DATA_C2S_WIDTH ),
    .USE_REDUCED_TAG  ( USE_REDUCED_TAG    ),
    .L2_SIZE          ( L2_SIZE            ) 
  ) icache_top_i (
    .clk                    ( clk_cluster                ),
    .rst_n                  ( s_rst_n                    ),
    .test_en_i              ( test_mode_i                ),
    .fetch_req_i            ( instr_req                  ),
    .fetch_addr_i           ( instr_addr                 ),
    .fetch_gnt_o            ( instr_gnt                  ),
    .fetch_rvalid_o         ( instr_r_valid              ),
    .fetch_rdata_o          ( instr_r_rdata              ), 
    .axi_master_arid_o      ( s_core_instr_bus.ar_id     ),
    .axi_master_araddr_o    ( s_core_instr_bus.ar_addr   ),
    .axi_master_arlen_o     ( s_core_instr_bus.ar_len    ), 
    .axi_master_arsize_o    ( s_core_instr_bus.ar_size   ), 
    .axi_master_arburst_o   ( s_core_instr_bus.ar_burst  ), 
    .axi_master_arlock_o    ( s_core_instr_bus.ar_lock   ), 
    .axi_master_arcache_o   ( s_core_instr_bus.ar_cache  ),
    .axi_master_arprot_o    ( s_core_instr_bus.ar_prot   ),
    .axi_master_arregion_o  ( s_core_instr_bus.ar_region ),
    .axi_master_aruser_o    ( s_core_instr_bus.ar_user   ), 
    .axi_master_arqos_o     ( s_core_instr_bus.ar_qos    ), 
    .axi_master_arvalid_o   ( s_core_instr_bus.ar_valid  ), 
    .axi_master_arready_i   ( s_core_instr_bus.ar_ready  ),
    .axi_master_rid_i       ( s_core_instr_bus.r_id      ),
    .axi_master_rdata_i     ( s_core_instr_bus.r_data    ),
    .axi_master_rresp_i     ( s_core_instr_bus.r_resp    ),
    .axi_master_rlast_i     ( s_core_instr_bus.r_last    ),
    .axi_master_ruser_i     ( s_core_instr_bus.r_user    ),
    .axi_master_rvalid_i    ( s_core_instr_bus.r_valid   ),
    .axi_master_rready_o    ( s_core_instr_bus.r_ready   ),
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
    .axi_master_wdata_o     ( s_core_instr_bus.w_data    ),
    .axi_master_wstrb_o     ( s_core_instr_bus.w_strb    ),
    .axi_master_wlast_o     ( s_core_instr_bus.w_last    ),
    .axi_master_wuser_o     ( s_core_instr_bus.w_user    ),
    .axi_master_wvalid_o    ( s_core_instr_bus.w_valid   ),
    .axi_master_wready_i    ( s_core_instr_bus.w_ready   ),
    .axi_master_bid_i       ( s_core_instr_bus.b_id      ),
    .axi_master_bresp_i     ( s_core_instr_bus.b_resp    ),
    .axi_master_buser_i     ( s_core_instr_bus.b_user    ),
    .axi_master_bvalid_i    ( s_core_instr_bus.b_valid   ),
    .axi_master_bready_o    ( s_core_instr_bus.b_ready   ),
    .IC_ctrl_unit_slave_if  ( IC_ctrl_unit_bus           )
  );

  /* TCDM banks */
  tcdm_banks_wrap #(
    .BANK_SIZE ( TCDM_NUM_ROWS ),
    .NB_BANKS  ( NB_TCDM_BANKS )
  ) tcdm_banks_i (
    .clk_i       ( clk_cluster     ),
    .rst_ni      ( s_rst_n         ),
    .init_ni     ( s_init_n        ),
    .test_mode_i ( test_mode_i     ),
    .pwdn_i      ( 1'b0            ),
    .tcdm_slave  ( s_tcdm_bus_sram )
  );
  
  /* AXI interconnect infrastructure (slices, size conversion) */ 
  axi_slice_dc_slave_wrap #(
    .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH         ),
    .AXI_DATA_WIDTH  ( AXI_DATA_C2S_WIDTH     ),
    .AXI_USER_WIDTH  ( AXI_USER_WIDTH         ),
    .AXI_ID_WIDTH    ( AXI_ID_OUT_WIDTH       ),
    .BUFFER_WIDTH    ( DC_SLICE_BUFFER_WIDTH  )
  ) data_master_slice_i (
    .clk_i            ( clk_cluster         ),
    .rst_ni           ( s_rst_n             ),
    .test_cgbypass_i  ( 1'b0                ),
    .isolate_i        ( 1'b0                ),
    .axi_slave        ( s_data_master       ),
    .axi_master_async ( s_data_master_async )
  );

  axi_slice_dc_master_wrap #(
    .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH  ( AXI_DATA_S2C_WIDTH    ),
    .AXI_USER_WIDTH  ( AXI_USER_WIDTH        ),
    .AXI_ID_WIDTH    ( AXI_ID_IN_WIDTH       ),
    .BUFFER_WIDTH    ( DC_SLICE_BUFFER_WIDTH )
  ) data_slave_slice_i (
    .clk_i           ( clk_i              ),
    .rst_ni          ( s_rst_n            ),
    .test_cgbypass_i ( 1'b0               ),
    .isolate_i       ( 1'b0               ),
    .clock_down_i    ( s_isolate_cluster  ),
    .incoming_req_o  ( s_incoming_req     ),
    .axi_slave_async ( s_data_slave_async ),
    .axi_master      ( s_data_slave_32    )
  );

  axi_size_UPSIZE_32_64_wrap #(
    .AXI_ADDR_WIDTH      ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH_IN   ( AXI_DATA_S2C_WIDTH ),
    .AXI_USER_WIDTH_IN   ( AXI_USER_WIDTH     ),
    .AXI_ID_WIDTH_IN     ( AXI_ID_IN_WIDTH    ),
    .AXI_DATA_WIDTH_OUT  ( AXI_DATA_C2S_WIDTH ),
    .AXI_USER_WIDTH_OUT  ( AXI_USER_WIDTH     ),
    .AXI_ID_WIDTH_OUT    ( AXI_ID_IN_WIDTH    )
  ) axi_size_UPSIZE_32_64_wrap_i (
    .clk_i       ( clk_i           ),
    .rst_ni      ( s_rst_n         ),
    .test_mode_i ( test_mode_i     ),
    .axi_slave   ( s_data_slave_32 ),
    .axi_master  ( s_data_slave_64 )
  );
   
  /* event synchronizers */
  dc_token_ring_fifo_dout #(
    .DATA_WIDTH   ( EVNT_WIDTH            ),
    .BUFFER_DEPTH ( DC_SLICE_BUFFER_WIDTH )
  ) u_event_dc (
    .clk          ( clk_i                    ),
    .rstn         ( s_rst_n                  ),
    .data         ( s_events_data            ),
    .valid        ( s_events_valid           ),
    .ready        ( s_events_ready           ),
    .write_token  ( ext_events_writetoken_i  ),
    .read_pointer ( ext_events_readpointer_o ),
    .data_async   ( ext_events_dataasync_i   )
  ); 
  assign s_events_async = s_events_valid;
    
  edge_propagator_tx ep_dma_pe_evt_i (
    .clk_i   ( clk_i              ),
    .rstn_i  ( s_rst_n            ),
    .valid_i ( s_dma_pe_event     ),
    .ack_i   ( dma_pe_evt_ack_i   ),
    .valid_o ( dma_pe_evt_valid_o )
  );
   
  edge_propagator_tx ep_dma_pe_irq_i (
    .clk_i   ( clk_i              ),
    .rstn_i  ( s_rst_n            ),
    .valid_i ( s_dma_pe_irq       ),
    .ack_i   ( dma_pe_irq_ack_i   ),
    .valid_o ( dma_pe_irq_valid_o )
  );
   
  edge_propagator_tx ep_pf_evt_i (
    .clk_i   ( clk_i          ),
    .rstn_i  ( s_rst_n        ),
    .valid_i ( s_pf_event     ),
    .ack_i   ( pf_evt_ack_i   ),
    .valid_o ( pf_evt_valid_o )
  );
   
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
    
  /* binding of AXI SV interfaces to external Verilog buses */    
  assign s_data_slave_async.aw_writetoken   = data_slave_aw_writetoken_i;
  assign s_data_slave_async.aw_addr         = data_slave_aw_addr_i;
  assign s_data_slave_async.aw_prot         = data_slave_aw_prot_i;
  assign s_data_slave_async.aw_region       = data_slave_aw_region_i;
  assign s_data_slave_async.aw_len          = data_slave_aw_len_i;
  assign s_data_slave_async.aw_size         = data_slave_aw_size_i;
  assign s_data_slave_async.aw_burst        = data_slave_aw_burst_i;
  assign s_data_slave_async.aw_lock         = data_slave_aw_lock_i;
  assign s_data_slave_async.aw_cache        = data_slave_aw_cache_i;
  assign s_data_slave_async.aw_qos          = data_slave_aw_qos_i;
  assign s_data_slave_async.aw_id           = data_slave_aw_id_i;
  assign s_data_slave_async.aw_user         = data_slave_aw_user_i;
  assign data_slave_aw_readpointer_o        = s_data_slave_async.aw_readpointer;
  
  assign s_data_slave_async.ar_writetoken   = data_slave_ar_writetoken_i;
  assign s_data_slave_async.ar_addr         = data_slave_ar_addr_i;
  assign s_data_slave_async.ar_prot         = data_slave_ar_prot_i;
  assign s_data_slave_async.ar_region       = data_slave_ar_region_i;
  assign s_data_slave_async.ar_len          = data_slave_ar_len_i;
  assign s_data_slave_async.ar_size         = data_slave_ar_size_i;
  assign s_data_slave_async.ar_burst        = data_slave_ar_burst_i;
  assign s_data_slave_async.ar_lock         = data_slave_ar_lock_i;
  assign s_data_slave_async.ar_cache        = data_slave_ar_cache_i;
  assign s_data_slave_async.ar_qos          = data_slave_ar_qos_i;
  assign s_data_slave_async.ar_id           = data_slave_ar_id_i;
  assign s_data_slave_async.ar_user         = data_slave_ar_user_i;
  assign data_slave_ar_readpointer_o        = s_data_slave_async.ar_readpointer;
  
  assign s_data_slave_async.w_writetoken    = data_slave_w_writetoken_i;
  assign s_data_slave_async.w_data          = data_slave_w_data_i;
  assign s_data_slave_async.w_strb          = data_slave_w_strb_i;
  assign s_data_slave_async.w_user          = data_slave_w_user_i;
  assign s_data_slave_async.w_last          = data_slave_w_last_i; 
  assign data_slave_w_readpointer_o         = s_data_slave_async.w_readpointer;
  
  assign data_slave_r_writetoken_o          = s_data_slave_async.r_writetoken;
  assign data_slave_r_data_o                = s_data_slave_async.r_data;
  assign data_slave_r_resp_o                = s_data_slave_async.r_resp;
  assign data_slave_r_last_o                = s_data_slave_async.r_last;
  assign data_slave_r_id_o                  = s_data_slave_async.r_id;
  assign data_slave_r_user_o                = s_data_slave_async.r_user;
  assign s_data_slave_async.r_readpointer   = data_slave_r_readpointer_i;
  
  assign data_slave_b_writetoken_o          = s_data_slave_async.b_writetoken;
  assign data_slave_b_resp_o                = s_data_slave_async.b_resp;
  assign data_slave_b_id_o                  = s_data_slave_async.b_id;
  assign data_slave_b_user_o                = s_data_slave_async.b_user;
  assign s_data_slave_async.b_readpointer   = data_slave_b_readpointer_i;
  
  assign data_master_aw_writetoken_o        = s_data_master_async.aw_writetoken;
  assign data_master_aw_addr_o              = s_data_master_async.aw_addr;
  assign data_master_aw_prot_o              = s_data_master_async.aw_prot;
  assign data_master_aw_region_o            = s_data_master_async.aw_region;
  assign data_master_aw_len_o               = s_data_master_async.aw_len;
  assign data_master_aw_size_o              = s_data_master_async.aw_size;
  assign data_master_aw_burst_o             = s_data_master_async.aw_burst;
  assign data_master_aw_lock_o              = s_data_master_async.aw_lock;
  assign data_master_aw_cache_o             = s_data_master_async.aw_cache;
  assign data_master_aw_qos_o               = s_data_master_async.aw_qos;
  assign data_master_aw_id_o                = s_data_master_async.aw_id;
  assign data_master_aw_user_o              = s_data_master_async.aw_user;
  assign s_data_master_async.aw_readpointer = data_master_aw_readpointer_i;

  assign data_master_ar_writetoken_o        = s_data_master_async.ar_writetoken;
  assign data_master_ar_addr_o              = s_data_master_async.ar_addr;
  assign data_master_ar_prot_o              = s_data_master_async.ar_prot;
  assign data_master_ar_region_o            = s_data_master_async.ar_region;
  assign data_master_ar_len_o               = s_data_master_async.ar_len;
  assign data_master_ar_size_o              = s_data_master_async.ar_size;
  assign data_master_ar_burst_o             = s_data_master_async.ar_burst;
  assign data_master_ar_lock_o              = s_data_master_async.ar_lock;
  assign data_master_ar_cache_o             = s_data_master_async.ar_cache;
  assign data_master_ar_qos_o               = s_data_master_async.ar_qos;
  assign data_master_ar_id_o                = s_data_master_async.ar_id;
  assign data_master_ar_user_o              = s_data_master_async.ar_user;
  assign s_data_master_async.ar_readpointer = data_master_ar_readpointer_i;

  assign data_master_w_writetoken_o         = s_data_master_async.w_writetoken;
  assign data_master_w_data_o               = s_data_master_async.w_data;
  assign data_master_w_strb_o               = s_data_master_async.w_strb;
  assign data_master_w_user_o               = s_data_master_async.w_user;
  assign data_master_w_last_o               = s_data_master_async.w_last;
  assign s_data_master_async.w_readpointer  = data_master_w_readpointer_i;

  assign s_data_master_async.r_writetoken   = data_master_r_writetoken_i;
  assign s_data_master_async.r_data         = data_master_r_data_i;
  assign s_data_master_async.r_resp         = data_master_r_resp_i;
  assign s_data_master_async.r_last         = data_master_r_last_i;
  assign s_data_master_async.r_id           = data_master_r_id_i;
  assign s_data_master_async.r_user         = data_master_r_user_i;
  assign data_master_r_readpointer_o        = s_data_master_async.r_readpointer;

  assign s_data_master_async.b_writetoken   = data_master_b_writetoken_i;
  assign s_data_master_async.b_resp         = data_master_b_resp_i;
  assign s_data_master_async.b_id           = data_master_b_id_i;
  assign s_data_master_async.b_user         = data_master_b_user_i;
  assign data_master_b_readpointer_o        = s_data_master_async.b_readpointer;
   
endmodule
