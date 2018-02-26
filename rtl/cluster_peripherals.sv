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

import pulp_cluster_package::*;

module cluster_peripherals
#(
  parameter NB_CORES       = 4,
  parameter NB_MPERIPHS    = 1,
  parameter NB_CACHE_BANKS = 4,
  parameter NB_SPERIPHS    = 8,
  parameter NB_TCDM_BANKS  = 8,
  parameter NB_HWPE_PORTS  = 1,
  parameter ROM_BOOT_ADDR  = 32'h1A000000,
  parameter BOOT_ADDR      = 32'h1C000000,
  parameter EVNT_WIDTH     = 8,
  parameter FEATURE_DEMUX_MAPPED = 1
)
(
  input  logic                        clk_i,
  input  logic                        rst_ni,
  input  logic                        ref_clk_i,
  input  logic                         test_mode_i,

  input  logic [NB_CORES-1:0]         dma_events_i,
  input  logic [NB_CORES-1:0]         dma_irq_i,
  input  logic                        en_sa_boot_i,
  input  logic                        fetch_en_i,
  input  logic [NB_CORES-1:0]         core_busy_i,
  output logic [NB_CORES-1:0]         core_clk_en_o,
  output logic                        fregfile_disable_o,
  
  output logic [NB_CORES-1:0][31:0]   boot_addr_o,
  
  output logic                        cluster_cg_en_o,
  
  output logic                        busy_o,
  
  XBAR_PERIPH_BUS.Slave               speriph_slave[NB_SPERIPHS-2:0],
  XBAR_PERIPH_BUS.Slave               core_eu_direct_link[NB_CORES-1:0],
  
  XBAR_PERIPH_BUS.Master              dma_cfg_master,
  input  logic                        dma_pe_irq_i,
  output logic                        pf_event_o,
  
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
  
  // SRAM SPEED REGULATION --> TCDM
  output logic [1:0]                  TCDM_arb_policy_o,

  XBAR_PERIPH_BUS.Master              hwce_cfg_master,
  input logic [NB_CORES-1:0][3:0]     hwacc_events_i,
  output logic                        hwpe_sel_o,
  output logic                        hwpe_en_o,

  // Control ports
  MP_PF_ICACHE_CTRL_UNIT_BUS.Master      IC_ctrl_unit_bus
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
  MESSAGE_BUS eu_message_master();  
  
  // decide between common or core-specific event sources
  generate
    for (genvar I=0; I<NB_CORES; I++) begin
      assign s_cluster_events[I] = {30'd0,pf_event_o,dma_pe_irq_i};
      assign s_acc_events[I]     = hwacc_events_i[I];
      assign s_timer_events[I]   = {s_timer_out_hi_event,s_timer_out_lo_event};
      assign s_dma_events[I]     = {dma_irq_i[I],dma_events_i[I]};
    end
  endgenerate
  
  assign fetch_enable_reg_o = s_fetch_en_cc;
  
  cluster_control_unit #(
    .PER_ID_WIDTH  ( NB_CORES+NB_MPERIPHS        ),
    .NB_CORES      ( NB_CORES                    ),
    .ROM_BOOT_ADDR ( ROM_BOOT_ADDR               ),
    .BOOT_ADDR     ( BOOT_ADDR                   )
  ) cluster_control_unit_i (
    .clk_i              ( clk_i                      ),
    .rst_ni             ( rst_ni                     ),
    .en_sa_boot_i       ( en_sa_boot_i               ),
    .fetch_en_i         ( fetch_en_i                 ),
    .cluster_cg_en_o    ( cluster_cg_en_o            ),
    .boot_addr_o        ( boot_addr_o                ),
    .speriph_slave      ( speriph_slave[SPER_EOC_ID] ),
    .eoc_o              ( eoc_o                      ),
    .event_o            (                            ),
    .hwpe_sel_o         ( hwpe_sel_o                 ),
    .hwpe_en_o          ( hwpe_en_o                  ),
    .core_halted_i      ( dbg_core_halted_i          ),
    .core_halt_o        ( dbg_core_halt_o            ),
    .core_resume_o      ( dbg_core_resume_o          ),
    .fetch_enable_o     ( s_fetch_en_cc              ),
    .TCDM_arb_policy_o  ( TCDM_arb_policy_o          ),
    .fregfile_disable_o ( fregfile_disable_o         )
  );
  
  cluster_timer_wrap #(
    .ID_WIDTH(NB_CORES+NB_MPERIPHS)
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
    .core_busy_i            ( core_busy_i            ),
    .core_clock_en_o        ( core_clk_en_o          ),
    .speriph_slave          ( speriph_slave_eu_comb  ),
    .eu_direct_link         ( core_eu_direct_link    ),
    .soc_periph_evt_valid_i ( soc_periph_evt_valid_i ),
    .soc_periph_evt_ready_o ( soc_periph_evt_ready_o ),
    .soc_periph_evt_data_i  ( soc_periph_evt_data_i  ),  
    .message_master         ( eu_message_master      )
  );

  // event unit binding
  assign eu_message_master.r_valid = 1'b1;
  assign eu_message_master.r_id    = '0;
  assign eu_message_master.r_rdata = 32'b0;
  assign eu_message_master.r_opc   = 1'b0;
  assign eu_message_master.gnt     = 1'b1;

  // combine number of required slave ports for event unit
  generate
    for (genvar I = 0; I < NB_SPERIPH_PLUGS_EU; I++ ) begin
      assign speriph_slave[SPER_EVENT_U_ID+I].gnt     = speriph_slave_eu_comb.gnt;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_valid = speriph_slave_eu_comb.r_valid;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_opc   = speriph_slave_eu_comb.r_opc;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_id    = speriph_slave_eu_comb.r_id;
      assign speriph_slave[SPER_EVENT_U_ID+I].r_rdata = speriph_slave_eu_comb.r_rdata;
      assign eu_speriph_plug_req[I]   = speriph_slave[SPER_EVENT_U_ID+I].req;
      assign eu_speriph_plug_add[I]   = speriph_slave[SPER_EVENT_U_ID+I].add;
      assign eu_speriph_plug_wen[I]   = speriph_slave[SPER_EVENT_U_ID+I].wen;
      assign eu_speriph_plug_wdata[I] = speriph_slave[SPER_EVENT_U_ID+I].wdata;
      assign eu_speriph_plug_be[I]    = speriph_slave[SPER_EVENT_U_ID+I].be;
      assign eu_speriph_plug_id[I]    = speriph_slave[SPER_EVENT_U_ID+I].id;
    end
  endgenerate

  assign speriph_slave_eu_comb.req   = |eu_speriph_plug_req;
  assign speriph_slave_eu_comb.add   = (eu_speriph_plug_req == 2'b10) ? eu_speriph_plug_add[1]   : eu_speriph_plug_add[0];
  assign speriph_slave_eu_comb.wen   = (eu_speriph_plug_req == 2'b10) ? eu_speriph_plug_wen[1]   : eu_speriph_plug_wen[0];
  assign speriph_slave_eu_comb.wdata = (eu_speriph_plug_req == 2'b10) ? eu_speriph_plug_wdata[1] : eu_speriph_plug_wdata[0];
  assign speriph_slave_eu_comb.be    = (eu_speriph_plug_req == 2'b10) ? eu_speriph_plug_be[1]    : eu_speriph_plug_be[0];
  assign speriph_slave_eu_comb.id    = (eu_speriph_plug_req == 2'b10) ? eu_speriph_plug_id[1]    : eu_speriph_plug_id[0];

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
     
  mp_pf_icache_ctrl_unit #(
    .NB_CACHE_BANKS ( NB_CACHE_BANKS       ),
    .NB_CORES       ( NB_CORES             ),
    .ID_WIDTH       ( NB_CORES+NB_MPERIPHS )
  ) icache_ctrl_unit_i (
    .clk_i                  ( clk_i                           ),
    .rst_ni                 ( rst_ni                          ),
    .speriph_slave          ( speriph_slave[SPER_ICACHE_CTRL] ),
    .IC_ctrl_unit_master_if ( IC_ctrl_unit_bus                ),
    .pf_event_o             ( pf_event_o                      )
  );

  // dma binding
  assign speriph_slave[SPER_DMA_ID].gnt     = dma_cfg_master.gnt;
  assign speriph_slave[SPER_DMA_ID].r_rdata = dma_cfg_master.r_rdata;
  assign speriph_slave[SPER_DMA_ID].r_opc   = dma_cfg_master.r_opc;
  assign speriph_slave[SPER_DMA_ID].r_id    = dma_cfg_master.r_id;
  assign speriph_slave[SPER_DMA_ID].r_valid = dma_cfg_master.r_valid;
  
  assign dma_cfg_master.req   = speriph_slave[SPER_DMA_ID].req;
  assign dma_cfg_master.add   = speriph_slave[SPER_DMA_ID].add;
  assign dma_cfg_master.wen   = speriph_slave[SPER_DMA_ID].wen;
  assign dma_cfg_master.wdata = speriph_slave[SPER_DMA_ID].wdata;
  assign dma_cfg_master.be    = speriph_slave[SPER_DMA_ID].be;
  assign dma_cfg_master.id    = speriph_slave[SPER_DMA_ID].id;
    
  // accelerator binding
  assign speriph_slave[SPER_HWPE_ID].gnt     = hwce_cfg_master.gnt;
  assign speriph_slave[SPER_HWPE_ID].r_rdata = hwce_cfg_master.r_rdata;
  assign speriph_slave[SPER_HWPE_ID].r_opc   = hwce_cfg_master.r_opc;
  assign speriph_slave[SPER_HWPE_ID].r_id    = hwce_cfg_master.r_id;
  assign speriph_slave[SPER_HWPE_ID].r_valid = hwce_cfg_master.r_valid;
  
  assign hwce_cfg_master.req   = speriph_slave[SPER_HWPE_ID].req;
  assign hwce_cfg_master.add   = speriph_slave[SPER_HWPE_ID].add;
  assign hwce_cfg_master.wen   = speriph_slave[SPER_HWPE_ID].wen;
  assign hwce_cfg_master.wdata = speriph_slave[SPER_HWPE_ID].wdata;
  assign hwce_cfg_master.be    = speriph_slave[SPER_HWPE_ID].be;
  assign hwce_cfg_master.id    = speriph_slave[SPER_HWPE_ID].id;
   
endmodule // cluster_peripherals
