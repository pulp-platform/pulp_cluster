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
 * cluster_peripherals.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

`include "register_interface/typedef.svh"

module cluster_peripherals
  import pulp_cluster_package::*;
#(
  parameter int unsigned  NB_CORES              = 8,
  parameter int unsigned  NB_HWPES              = 8,
  parameter int unsigned  NB_MPERIPHS           = 1,
  parameter int unsigned  NB_CACHE_BANKS        = 4,
  parameter int unsigned  NB_SPERIPHS           = 8,
  parameter int unsigned  NB_TCDM_BANKS         = 8,
  parameter int unsigned  ROM_BOOT_ADDR         = 32'h1A000000,
  parameter int unsigned  BOOT_ADDR             = 32'h1C000000,
  parameter int unsigned  SNITCH_ICACHE         = 0,
  parameter int unsigned  EVNT_WIDTH            = 8,
  parameter int unsigned  FEATURE_DEMUX_MAPPED  = 1,
  parameter int unsigned  NB_L1_CUTS            = 16,
  parameter int unsigned  RW_MARGIN_WIDTH       = 4,
  parameter int unsigned  NB_BARRIERS           = NB_CORES
)
(
  input  logic                        clk_i,
  input  logic                        rst_ni,
  input  logic                        ref_clk_i,
  input  logic                        test_mode_i,

  input  logic                        en_sa_boot_i,
  input  logic                        fetch_en_i,
  input  logic [NB_CORES-1:0]         core_busy_i,
  output logic [NB_CORES-1:0]         core_clk_en_o,
  output logic                        fregfile_disable_o,

  output logic [NB_CORES-1:0][31:0]   boot_addr_o,

  output logic                        cluster_cg_en_o,

  output logic                        busy_o,

  XBAR_PERIPH_BUS.Slave               speriph_slave[NB_SPERIPHS-2:0], // SPER_EXT_ID NOT PLUGGED HERE
  XBAR_PERIPH_BUS.Slave               core_eu_direct_link[NB_CORES-1:0],

  input  logic [NB_CORES-1:0]         dma_event_i,
  input  logic [NB_CORES-1:0]         dma_irq_i,
  input  logic                        mbox_irq_i,

  XBAR_PERIPH_BUS.Master              dma_cfg_master[1:0],
  input logic                         dma_cl_event_i,
  input logic                         dma_cl_irq_i,
  input logic                         dma_fc_event_i,
  input logic                         dma_fc_irq_i,

  output logic                        soc_periph_evt_ready_o,
  input  logic                        soc_periph_evt_valid_i,
  input  logic [EVNT_WIDTH-1:0]       soc_periph_evt_data_i,


  input  logic [NB_CORES-1:0]         dbg_core_halted_i,
  output logic [NB_CORES-1:0]         dbg_core_halt_o,
  output logic [NB_CORES-1:0]         dbg_core_resume_o,


  output logic                        eoc_o,
  output logic [NB_CORES-1:0]         fetch_enable_reg_o, //fetch enable driven by the internal register
  output logic [NB_CORES-1:0][4:0]    irq_id_o,
  input  logic [NB_CORES-1:0][4:0]    irq_ack_id_i,
  output logic [NB_CORES-1:0]         irq_req_o,
  input  logic [NB_CORES-1:0]         irq_ack_i,

  input  logic [NB_CORES-1:0]         dbg_req_i,
  output logic [NB_CORES-1:0]         dbg_req_o,
  output logic [NB_BARRIERS-1:0]      barrier_matched_o,

  // HMR synch requests
  input  logic [NB_CORES-1:0]         hmr_sw_resynch_req_i,
  input  logic [NB_CORES-1:0]         hmr_sw_synch_req_i,

  // SRAM SPEED REGULATION --> TCDM
  output logic [1:0]                  TCDM_arb_policy_o,

  XBAR_PERIPH_BUS.Master              hwpe_cfg_master,
  XBAR_PERIPH_BUS.Master              hmr_cfg_master,
  XBAR_PERIPH_BUS.Master              tcdm_scrubber_cfg_master,
  XBAR_PERIPH_BUS.Master              hwpe_hci_ecc_cfg_master,
  input logic [NB_CORES-1:0][3:0]     hwpe_events_i,
  output logic                        hwpe_en_o,
  output logic [$clog2(NB_HWPES)-1:0] hwpe_sel_o,
  output hci_package::hci_interconnect_ctrl_t hci_ctrl_o,

  // Control ports
  SP_ICACHE_CTRL_UNIT_BUS.Master       IC_ctrl_unit_bus_main[NB_CACHE_BANKS-1:0],
  PRI_ICACHE_CTRL_UNIT_BUS.Master      IC_ctrl_unit_bus_pri[NB_CORES-1:0],
  output logic [NB_CORES-1:0]          enable_l1_l15_prefetch_o,
  output logic [NB_CORES-1:0]          flush_valid_o,
  input  logic [NB_CORES-1:0]          flush_ready_i,
  input  snitch_icache_pkg::icache_l1_events_t l1_events_i
);

  logic                      s_timer_out_lo_event;
  logic                      s_timer_out_hi_event;
  logic                      s_timer_in_lo_event;
  logic                      s_timer_in_hi_event;

  logic [NB_CORES-1:0][31:0] s_cluster_events;
  logic [NB_CORES-1:0][3:0]  s_acc_events;
  logic [NB_CORES-1:0][1:0]  s_timer_events;
  logic [NB_CORES-1:0][1:0]  s_dma_events;

  logic [NB_CORES-1:0]  s_fetch_en_cc;

  MESSAGE_BUS eu_message_master();

  logic [NB_SPERIPH_PLUGS_EU-1:0]             eu_speriph_plug_req;
  logic [NB_SPERIPH_PLUGS_EU-1:0][31:0]       eu_speriph_plug_add;
  logic [NB_SPERIPH_PLUGS_EU-1:0]             eu_speriph_plug_wen;
  logic [NB_SPERIPH_PLUGS_EU-1:0][31:0]       eu_speriph_plug_wdata;
  logic [NB_SPERIPH_PLUGS_EU-1:0][3:0]        eu_speriph_plug_be;
  logic [NB_SPERIPH_PLUGS_EU-1:0][NB_CORES:0] eu_speriph_plug_id;

  logic soc_periph_evt_valid, soc_periph_evt_ready;
  logic [7:0] soc_periph_evt_data;

  // internal speriph bus to combine multiple plugs to new event unit
  XBAR_PERIPH_BUS speriph_slave_eu_comb();

`ifdef FEATURE_ICACHE_STAT
  localparam bit          FEATURE_STAT    = 1'b1;
`else
  localparam bit          FEATURE_STAT    = 1'b0;
`endif

  // decide between common or core-specific event sources
  generate
    for (genvar I=0; I<NB_CORES; I++) begin
      assign s_cluster_events[I][31:3] = '0;
      assign s_cluster_events[I][2] = hmr_sw_resynch_req_i[I];
      assign s_cluster_events[I][1] = hmr_sw_synch_req_i[I];
      assign s_cluster_events[I][0] = mbox_irq_i;
      assign s_acc_events[I]     = hwpe_events_i[I];
      assign s_timer_events[I]   = {s_timer_out_hi_event,s_timer_out_lo_event};
      assign s_dma_events[I][0] = dma_event_i[I];
      assign s_dma_events[I][1] = dma_irq_i[I];
    end
  endgenerate

  assign fetch_enable_reg_o = s_fetch_en_cc;

  //********************************************************
  //************ END OF COMPUTATION UNIT *******************
  //********************************************************
  cluster_control_unit #(
    .PER_ID_WIDTH  ( NB_CORES+NB_MPERIPHS         ),
    .NB_CORES      ( NB_CORES                     ),
    .NB_HWPES      ( NB_HWPES                     ),
    .ROM_BOOT_ADDR ( ROM_BOOT_ADDR                ),
    .BOOT_ADDR     ( BOOT_ADDR                    )
    //.NB_L1_CUTS      ( NB_L1_CUTS                 ),
    //.RW_MARGIN_WIDTH ( RW_MARGIN_WIDTH            )
  ) cluster_control_unit_i (
    .clk_i          ( clk_i                        ),
    .rst_ni         ( rst_ni                       ),

    .en_sa_boot_i   ( en_sa_boot_i                 ),
    .fetch_en_i     ( fetch_en_i                   ),
    .speriph_slave  ( speriph_slave[SPER_EOC_ID]  ),

    .event_o        (                              ),
    .eoc_o          ( eoc_o                        ),

    .cluster_cg_en_o( cluster_cg_en_o              ),
    .boot_addr_o    ( boot_addr_o                  ),

    // SRAM SPEED REGULATION --> TCDM
    .hwpe_en_o      ( hwpe_en_o                    ),
    .hwpe_sel_o     ( hwpe_sel_o                   ),
    .hci_ctrl_o     ( hci_ctrl_o                   ),

    .fregfile_disable_o ( fregfile_disable_o       ),


    .core_halted_i  ( dbg_core_halted_i            ),
    .core_halt_o    ( dbg_core_halt_o              ),
    .core_resume_o  ( dbg_core_resume_o            ),

    .fetch_enable_o ( s_fetch_en_cc                ),
    .TCDM_arb_policy_o (TCDM_arb_policy_o          )
    //.rw_margin_L1_o    ( rw_margin_L1_o            )
  );

  //********************************************************
  //******************** TIMER *****************************
  //********************************************************

  cluster_timer_wrap #(
    .ID_WIDTH     ( NB_CORES+NB_MPERIPHS         )
  ) cluster_timer_wrap_i (
    .clk_i        ( clk_i                        ),
    .rst_ni       ( rst_ni                       ),
    .ref_clk_i    ( ref_clk_i                    ),
    .periph_slave ( speriph_slave[SPER_TIMER_ID] ),
    .event_lo_i   ( 1'b0                         ),
    .event_hi_i   ( 1'b0                         ),
    .irq_lo_o     ( s_timer_out_lo_event         ),
    .irq_hi_o     ( s_timer_out_hi_event         ),
    .busy_o       ( busy_o                       )
  );

  //********************************************************
  //******************** NEW EVENT UNIT ********************
  //********************************************************

  // event unit binding
  assign eu_message_master.r_valid = 1'b1;
  assign eu_message_master.r_id    = '0;
  assign eu_message_master.r_rdata = 32'b0;
  assign eu_message_master.r_opc   = 1'b0;
  assign eu_message_master.gnt     = 1'b1;

  // With new interconnect xbar_pe, all requests to EU pass through SPER_EVENT_U_ID speriph_slave. The other plugs are tied to 0.
  generate
    for (genvar I = 1; I < NB_SPERIPH_PLUGS_EU; I++ ) begin
      assign speriph_slave[SPER_EVENT_U_ID+I].gnt     =  '0;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_valid =  '0;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_opc   =  '0;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_id    =  '0;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_rdata =  32'hDEADB33F;
    end
  endgenerate

  event_unit_top #(
    .NB_CORES     ( NB_CORES   ),
    .NB_BARR      ( NB_CORES   ),
    .PER_ID_WIDTH ( NB_CORES+1 ),
    .EVNT_WIDTH   ( EVNT_WIDTH )
  ) event_unit_flex_i (
    .clk_i                  ( clk_i                  ),
    .rst_ni                 ( rst_ni                 ),
    .test_mode_i            ( test_mode_i            ),

    .acc_events_i           ( s_acc_events           ),
    .dma_events_i           ( s_dma_events           ),
    .timer_events_i         ( s_timer_events         ),
    .cluster_events_i       ( s_cluster_events       ),


    .core_irq_id_o          ( irq_id_o               ),
    .core_irq_ack_id_i      ( irq_ack_id_i           ),
    .core_irq_req_o         ( irq_req_o              ),
    .core_irq_ack_i         ( irq_ack_i              ),
    .dbg_req_i              ( dbg_req_i              ),
    .core_dbg_req_o         ( dbg_req_o              ),

    .barrier_matched_o      ( barrier_matched_o      ),
    .core_busy_i            ( core_busy_i            ),
    .core_clock_en_o        ( core_clk_en_o          ),

    .speriph_slave          ( speriph_slave[SPER_EVENT_U_ID]  ),
    .eu_direct_link         ( core_eu_direct_link    ),

    .soc_periph_evt_valid_i ( soc_periph_evt_valid_i ),
    .soc_periph_evt_ready_o ( soc_periph_evt_ready_o ),
    .soc_periph_evt_data_i  ( soc_periph_evt_data_i  ),

    .message_master         ( eu_message_master      )
  );

  //********************************************************
  //******************** icache_ctrl_unit ******************
  //********************************************************

if (SNITCH_ICACHE) begin: gen_snitch_icache_ctrl
  //For an explanation of this macro refer to https://github.com/pulp-platform/register_interface/blob/master/include/register_interface/typedef.svh#L34
  `REG_BUS_TYPEDEF_ALL(icache, logic[31:0], logic[31:0], logic[3:0])
  icache_req_t icache_req;
  icache_rsp_t icache_rsp;

  periph_to_reg #(
    .AW    ( 32 ),
    .DW    ( 32 ),
    .BW    (  8 ),
    .IW    ( NB_CORES+1 ),
    .req_t ( icache_req_t ),
    .rsp_t ( icache_rsp_t )
  ) i_icache_bus_converter (
    .clk_i,
    .rst_ni,

    .req_i     ( speriph_slave[SPER_ICACHE_CTRL].req     ),
    .add_i     ( speriph_slave[SPER_ICACHE_CTRL].add     ),
    .wen_i     ( speriph_slave[SPER_ICACHE_CTRL].wen     ),
    .wdata_i   ( speriph_slave[SPER_ICACHE_CTRL].wdata   ),
    .be_i      ( speriph_slave[SPER_ICACHE_CTRL].be      ),
    .id_i      ( speriph_slave[SPER_ICACHE_CTRL].id      ),
    .gnt_o     ( speriph_slave[SPER_ICACHE_CTRL].gnt     ),
    .r_rdata_o ( speriph_slave[SPER_ICACHE_CTRL].r_rdata ),
    .r_opc_o   ( speriph_slave[SPER_ICACHE_CTRL].r_opc   ),
    .r_id_o    ( speriph_slave[SPER_ICACHE_CTRL].r_id    ),
    .r_valid_o ( speriph_slave[SPER_ICACHE_CTRL].r_valid ),

    .reg_req_o ( icache_req ),
    .reg_rsp_i ( icache_rsp )
  );

  cluster_icache_ctrl_perfctr_unit #(
    .NR_FETCH_PORTS ( NB_CORES ),
    .reg_req_t ( icache_req_t ),
    .reg_rsp_t ( icache_rsp_t )
  ) i_icache_ctrl_unit (
    .clk_i,
    .rst_ni,

    .reg_req_i            ( icache_req ),
    .reg_rsp_o            ( icache_rsp ),

    .enable_prefetching_o ( enable_l1_l15_prefetch_o[0]),
    .flush_valid_o,
    .flush_ready_i,

    // .l0_events_i,
    .l1_events_i
  );

  assign enable_l1_l15_prefetch_o[NB_CORES-1:1] = '0;

  for (genvar i = 0; i < NB_CORES; i++) begin
    assign IC_ctrl_unit_bus_pri[i].bypass_req     = '0;
    assign IC_ctrl_unit_bus_pri[i].flush_req      = '0;
    assign IC_ctrl_unit_bus_pri[i].sel_flush_req  = '0;
    assign IC_ctrl_unit_bus_pri[i].sel_flush_addr = '0;
    `ifdef FEATURE_ICACHE_STAT
      assign IC_ctrl_unit_bus_pri[i].ctrl_clear_regs  = '0;
      assign IC_ctrl_unit_bus_pri[i].ctrl_enable_regs = '0;
    `endif
  end

  for (genvar i = 0; i < NB_CACHE_BANKS; i++) begin
    assign IC_ctrl_unit_bus_main[i].ctrl_req_enable   = '0;
    assign IC_ctrl_unit_bus_main[i].ctrl_req_disable  = '0;
    assign IC_ctrl_unit_bus_main[i].ctrl_flush_req    = '0;
    assign IC_ctrl_unit_bus_main[i].icache_is_private = '0;
    assign IC_ctrl_unit_bus_main[i].sel_flush_req     = '0;
    assign IC_ctrl_unit_bus_main[i].sel_flush_addr    = '0;
    `ifdef FEATURE_ICACHE_STAT
      assign IC_ctrl_unit_bus_main[i].ctrl_clear_regs  = '0;
      assign IC_ctrl_unit_bus_main[i].ctrl_enable_regs = '0;
    `endif
  end
end else begin: gen_hier_icache_ctrl
  assign flush_valid_o = '0;
  hier_icache_ctrl_unit_wrap #(
    .NB_CACHE_BANKS ( NB_CACHE_BANKS       ),
    .NB_CORES       ( NB_CORES             ),
    .ID_WIDTH       ( NB_CORES+NB_MPERIPHS )
  ) icache_ctrl_unit_i (
    .clk_i                       (  clk_i                           ),
    .rst_ni                      (  rst_ni                          ),

    .speriph_slave               (  speriph_slave[SPER_ICACHE_CTRL] ),
    .IC_ctrl_unit_bus_pri        (  IC_ctrl_unit_bus_pri            ),
    .IC_ctrl_unit_bus_main       (  IC_ctrl_unit_bus_main           ),
    .enable_l1_l15_prefetch_o    (  enable_l1_l15_prefetch_o        )
  );
end

  //********************************************************
  //******************** DMA CL CONFIG PORT ****************
  //********************************************************

  assign speriph_slave[SPER_DMA_CL_ID].gnt     = dma_cfg_master[0].gnt;
  assign speriph_slave[SPER_DMA_CL_ID].r_rdata = dma_cfg_master[0].r_rdata;
  assign speriph_slave[SPER_DMA_CL_ID].r_opc   = dma_cfg_master[0].r_opc;
  assign speriph_slave[SPER_DMA_CL_ID].r_id    = dma_cfg_master[0].r_id;
  assign speriph_slave[SPER_DMA_CL_ID].r_valid = dma_cfg_master[0].r_valid;

  assign dma_cfg_master[0].req   = speriph_slave[SPER_DMA_CL_ID].req;
  assign dma_cfg_master[0].add   = speriph_slave[SPER_DMA_CL_ID].add;
  assign dma_cfg_master[0].wen   = speriph_slave[SPER_DMA_CL_ID].wen;
  assign dma_cfg_master[0].wdata = speriph_slave[SPER_DMA_CL_ID].wdata;
  assign dma_cfg_master[0].be    = speriph_slave[SPER_DMA_CL_ID].be;
  assign dma_cfg_master[0].id    = speriph_slave[SPER_DMA_CL_ID].id;

  //********************************************************
  //******************** DMA FC CONFIG PORT ****************
  //********************************************************

  assign speriph_slave[SPER_DMA_FC_ID].gnt     = dma_cfg_master[1].gnt;
  assign speriph_slave[SPER_DMA_FC_ID].r_rdata = dma_cfg_master[1].r_rdata;
  assign speriph_slave[SPER_DMA_FC_ID].r_opc   = dma_cfg_master[1].r_opc;
  assign speriph_slave[SPER_DMA_FC_ID].r_id    = dma_cfg_master[1].r_id;
  assign speriph_slave[SPER_DMA_FC_ID].r_valid = dma_cfg_master[1].r_valid;

  assign dma_cfg_master[1].req   = speriph_slave[SPER_DMA_FC_ID].req;
  assign dma_cfg_master[1].add   = speriph_slave[SPER_DMA_FC_ID].add;
  assign dma_cfg_master[1].wen   = speriph_slave[SPER_DMA_FC_ID].wen;
  assign dma_cfg_master[1].wdata = speriph_slave[SPER_DMA_FC_ID].wdata;
  assign dma_cfg_master[1].be    = speriph_slave[SPER_DMA_FC_ID].be;
  assign dma_cfg_master[1].id    = speriph_slave[SPER_DMA_FC_ID].id;

  //********************************************************
  //******************** HW ACC  ***************************
  //********************************************************

  assign speriph_slave[SPER_HWPE_ID].gnt     = hwpe_cfg_master.gnt;
  assign speriph_slave[SPER_HWPE_ID].r_rdata = hwpe_cfg_master.r_rdata;
  assign speriph_slave[SPER_HWPE_ID].r_opc   = hwpe_cfg_master.r_opc;
  assign speriph_slave[SPER_HWPE_ID].r_id    = hwpe_cfg_master.r_id;
  assign speriph_slave[SPER_HWPE_ID].r_valid = hwpe_cfg_master.r_valid;

  assign hwpe_cfg_master.req   = speriph_slave[SPER_HWPE_ID].req;
  assign hwpe_cfg_master.add   = speriph_slave[SPER_HWPE_ID].add;
  assign hwpe_cfg_master.wen   = speriph_slave[SPER_HWPE_ID].wen;
  assign hwpe_cfg_master.wdata = speriph_slave[SPER_HWPE_ID].wdata;
  assign hwpe_cfg_master.be    = speriph_slave[SPER_HWPE_ID].be;
  assign hwpe_cfg_master.id    = speriph_slave[SPER_HWPE_ID].id;

  //********************************************************
  //******************** HMR UNIT **************************
  //********************************************************

  assign speriph_slave[SPER_HMR_UNIT_ID].gnt     = hmr_cfg_master.gnt;
  assign speriph_slave[SPER_HMR_UNIT_ID].r_rdata = hmr_cfg_master.r_rdata;
  assign speriph_slave[SPER_HMR_UNIT_ID].r_opc   = hmr_cfg_master.r_opc;
  assign speriph_slave[SPER_HMR_UNIT_ID].r_id    = hmr_cfg_master.r_id;
  assign speriph_slave[SPER_HMR_UNIT_ID].r_valid = hmr_cfg_master.r_valid;

  assign hmr_cfg_master.req   = speriph_slave[SPER_HMR_UNIT_ID].req;
  assign hmr_cfg_master.add   = speriph_slave[SPER_HMR_UNIT_ID].add;
  assign hmr_cfg_master.wen   = speriph_slave[SPER_HMR_UNIT_ID].wen;
  assign hmr_cfg_master.wdata = speriph_slave[SPER_HMR_UNIT_ID].wdata;
  assign hmr_cfg_master.be    = speriph_slave[SPER_HMR_UNIT_ID].be;
  assign hmr_cfg_master.id    = speriph_slave[SPER_HMR_UNIT_ID].id;

  //********************************************************
  //******************** TCDM Scrubber *********************
  //********************************************************

  assign speriph_slave[SPER_TCDM_SCRUBBER_ID].gnt     = tcdm_scrubber_cfg_master.gnt;
  assign speriph_slave[SPER_TCDM_SCRUBBER_ID].r_rdata = tcdm_scrubber_cfg_master.r_rdata;
  assign speriph_slave[SPER_TCDM_SCRUBBER_ID].r_opc   = tcdm_scrubber_cfg_master.r_opc;
  assign speriph_slave[SPER_TCDM_SCRUBBER_ID].r_id    = tcdm_scrubber_cfg_master.r_id;
  assign speriph_slave[SPER_TCDM_SCRUBBER_ID].r_valid = tcdm_scrubber_cfg_master.r_valid;

  assign tcdm_scrubber_cfg_master.req   = speriph_slave[SPER_TCDM_SCRUBBER_ID].req;
  assign tcdm_scrubber_cfg_master.add   = speriph_slave[SPER_TCDM_SCRUBBER_ID].add;
  assign tcdm_scrubber_cfg_master.wen   = speriph_slave[SPER_TCDM_SCRUBBER_ID].wen;
  assign tcdm_scrubber_cfg_master.wdata = speriph_slave[SPER_TCDM_SCRUBBER_ID].wdata;
  assign tcdm_scrubber_cfg_master.be    = speriph_slave[SPER_TCDM_SCRUBBER_ID].be;
  assign tcdm_scrubber_cfg_master.id    = speriph_slave[SPER_TCDM_SCRUBBER_ID].id;

  //********************************************************
  //******************** HWPE HCI with ECC *********************
  //********************************************************

  assign speriph_slave[SPER_HWPE_HCI_ECC_ID].gnt     = hwpe_hci_ecc_cfg_master.gnt;
  assign speriph_slave[SPER_HWPE_HCI_ECC_ID].r_rdata = hwpe_hci_ecc_cfg_master.r_rdata;
  assign speriph_slave[SPER_HWPE_HCI_ECC_ID].r_opc   = hwpe_hci_ecc_cfg_master.r_opc;
  assign speriph_slave[SPER_HWPE_HCI_ECC_ID].r_id    = hwpe_hci_ecc_cfg_master.r_id;
  assign speriph_slave[SPER_HWPE_HCI_ECC_ID].r_valid = hwpe_hci_ecc_cfg_master.r_valid;

  assign hwpe_hci_ecc_cfg_master.req   = speriph_slave[SPER_HWPE_HCI_ECC_ID].req;
  assign hwpe_hci_ecc_cfg_master.add   = speriph_slave[SPER_HWPE_HCI_ECC_ID].add;
  assign hwpe_hci_ecc_cfg_master.wen   = speriph_slave[SPER_HWPE_HCI_ECC_ID].wen;
  assign hwpe_hci_ecc_cfg_master.wdata = speriph_slave[SPER_HWPE_HCI_ECC_ID].wdata;
  assign hwpe_hci_ecc_cfg_master.be    = speriph_slave[SPER_HWPE_HCI_ECC_ID].be;
  assign hwpe_hci_ecc_cfg_master.id    = speriph_slave[SPER_HWPE_HCI_ECC_ID].id;

  generate
    if(FEATURE_DEMUX_MAPPED == 0) begin : eu_not_demux_mapped_gen
      for(genvar i=0;i< NB_CORES; i++) begin
        assign core_eu_direct_link[i].gnt     = 1'b0;
        assign core_eu_direct_link[i].r_rdata = 32'h0000_0000;
        assign core_eu_direct_link[i].r_valid = 1'b0;
        assign core_eu_direct_link[i].r_opc   = 1'b0;
      end
    end
  endgenerate

endmodule // cluster_peripherals
