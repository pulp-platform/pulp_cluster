/* Copyright 2023 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 * 
 * Core Assist: contains the demultiplexers that split the RISCV core request towards
 * the TCDM memory and the peripherals.
 * 
 * Authors:
 * Yvan Tortorella <yvan.tortorella@unibo.it>
 */

module core_assist #(
  parameter ADDR_WIDTH         = 32          ,
  parameter DATA_WIDTH         = 32          ,
  parameter BYTE_ENABLE_BIT    = DATA_WIDTH/8,
  parameter NUM_EXT_PERF_CNTRS = 5           ,
  parameter CLUSTER_ALIAS_BASE = 12'h000
)(
  input  logic                          clk_i             ,
  input  logic                          rst_ni            ,
  input  logic                          clock_en_i        ,
  input  logic                          test_mode_i       ,
  input  logic [3:0]                    base_addr_i       ,
  input  logic [5:0]                    cluster_id_i      ,
  output logic [NUM_EXT_PERF_CNTRS-1:0] ext_perf_cntrs_o  ,
  hci_core_intf.slave                   core_bus_slave    , // Slave BUS from Core Region
  hci_core_intf.master                  tcdm_data_master  , // Master BUS to TCDM Interconnect
  XBAR_TCDM_BUS.Master                  dma_ctrl_master   , // Master BUS to DMA Controller
  XBAR_PERIPH_BUS.Master                eu_ctrl_master    , // Master BUS to Event Unit
  XBAR_PERIPH_BUS.Master                periph_data_master  // Master BUS to XBAR PE
);

/******************** Signals and BUSes ********************/
logic clk_assist;

hci_core_intf #(
  .DW ( DATA_WIDTH ),
  .AW ( ADDR_WIDTH ),
  .OW ( 1          ),
  .UW ( 0          )
) periph_demux_bus ( // CORE_DEMUX <--> PERIPHERAL DEMUX interface
  .clk ( clk_i )
);

/******************** Core region's clock gating cell ********************/
cluster_clock_gating clock_gate_i (
  .clk_i     ( clk_i       ),
  .en_i      ( clock_en_i  ),
  .test_en_i ( test_mode_i ),
  .clk_o     ( clk_assist  )
);

/******************** Core Demux to TCDM and Periph Demux ********************/
core_demux           #(
  .ADDR_WIDTH         ( ADDR_WIDTH         ),
  .DATA_WIDTH         ( DATA_WIDTH         ),
  .BYTE_ENABLE_BIT    ( BYTE_ENABLE_BIT    ),
  .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE )
) core_demux_i        (
  .clk                (  clk_assist        ),
  .rst_ni             (  rst_ni            ),
  .test_en_i          (  test_mode_i       ),
`ifdef REMAP_ADDRESS
  .base_addr_i        (  base_addr_i       ),
`endif
  // Slave Bus from Core
  .data_req_i         (  core_bus_slave.req     ),
  .data_add_i         (  core_bus_slave.add     ),
  .data_wen_i         (  core_bus_slave.wen     ),
  .data_wdata_i       (  core_bus_slave.data    ),
  .data_be_i          (  core_bus_slave.be      ),
  .data_gnt_o         (  core_bus_slave.gnt     ),
  .data_r_gnt_i       (  core_bus_slave.gnt     ),
  .data_r_valid_o     (  core_bus_slave.r_valid ),
  .data_r_rdata_o     (  core_bus_slave.r_data  ),
  .data_r_opc_o       (  core_bus_slave.r_opc   ),
  // Master BUS to TCDM Interconnect
  .data_req_o_SH      (  tcdm_data_master.req     ),
  .data_add_o_SH      (  tcdm_data_master.add     ),
  .data_wen_o_SH      (  tcdm_data_master.wen     ),
  .data_wdata_o_SH    (  tcdm_data_master.data    ),
  .data_be_o_SH       (  tcdm_data_master.be      ),
  .data_gnt_i_SH      (  tcdm_data_master.gnt     ),
  .data_r_valid_i_SH  (  tcdm_data_master.r_valid ),
  .data_r_rdata_i_SH  (  tcdm_data_master.r_data  ),
  // Master BUS to Periph Demux
  .data_req_o_EXT     (  periph_demux_bus.req     ),
  .data_add_o_EXT     (  periph_demux_bus.add     ),
  .data_wen_o_EXT     (  periph_demux_bus.wen     ),
  .data_wdata_o_EXT   (  periph_demux_bus.data    ),
  .data_be_o_EXT      (  periph_demux_bus.be      ),
  .data_gnt_i_EXT     (  periph_demux_bus.gnt     ),
  .data_r_valid_i_EXT (  periph_demux_bus.r_valid ),
  .data_r_rdata_i_EXT (  periph_demux_bus.r_data  ),
  .data_r_opc_i_EXT   (  periph_demux_bus.r_opc   ),
  // Master BUS to XBAR PE
  .data_req_o_PE      (  periph_data_master.req     ),
  .data_add_o_PE      (  periph_data_master.add     ),
  .data_wen_o_PE      (  periph_data_master.wen     ),
  .data_wdata_o_PE    (  periph_data_master.wdata   ),
  .data_be_o_PE       (  periph_data_master.be      ),
  .data_gnt_i_PE      (  periph_data_master.gnt     ),
  .data_r_valid_i_PE  (  periph_data_master.r_valid ),
  .data_r_rdata_i_PE  (  periph_data_master.r_rdata ),
  .data_r_opc_i_PE    (  periph_data_master.r_opc   ),
  // Performance Counters
  .perf_l2_ld_o       (  ext_perf_cntrs_o [0] ),
  .perf_l2_st_o       (  ext_perf_cntrs_o [1] ),
  .perf_l2_ld_cyc_o   (  ext_perf_cntrs_o [2] ),
  .perf_l2_st_cyc_o   (  ext_perf_cntrs_o [3] ),
  .CLUSTER_ID         (  cluster_id_i         )
);
assign tcdm_data_master.boffs = '0;
assign tcdm_data_master.lrdy  = '1;
// One preformance counter keeps cycles lost due to contention
assign ext_perf_cntrs_o [4] = tcdm_data_master.req & (~tcdm_data_master.gnt);

/******************** Periph Demux to DMAC and Event Unit and  ********************/
periph_demux periph_demux_i (
  .clk               ( clk_assist               ),
  .rst_ni            ( rst_ni                   ),
  // Slave BUS from Core Demux
  .data_req_i        ( periph_demux_bus.req     ),
  .data_add_i        ( periph_demux_bus.add     ),
  .data_wen_i        ( periph_demux_bus.wen     ),
  .data_wdata_i      ( periph_demux_bus.data    ),
  .data_be_i         ( periph_demux_bus.be      ),
  .data_gnt_o        ( periph_demux_bus.gnt     ),
  .data_r_valid_o    ( periph_demux_bus.r_valid ),
  .data_r_opc_o      ( periph_demux_bus.r_opc   ),
  .data_r_rdata_o    ( periph_demux_bus.r_data  ),
  // Master BUS to DMA Controller
  .data_req_o_MH     ( dma_ctrl_master.req      ),
  .data_add_o_MH     ( dma_ctrl_master.add      ),
  .data_wen_o_MH     ( dma_ctrl_master.wen      ),
  .data_wdata_o_MH   ( dma_ctrl_master.wdata    ),
  .data_be_o_MH      ( dma_ctrl_master.be       ),
  .data_gnt_i_MH     ( dma_ctrl_master.gnt      ),
  .data_r_valid_i_MH ( dma_ctrl_master.r_valid  ),
  .data_r_rdata_i_MH ( dma_ctrl_master.r_rdata  ),
  .data_r_opc_i_MH   ( dma_ctrl_master.r_opc    ),
  // Master BUS to Event Unit
  .data_req_o_EU     ( eu_ctrl_master.req       ),
  .data_add_o_EU     ( eu_ctrl_master.add       ),
  .data_wen_o_EU     ( eu_ctrl_master.wen       ),
  .data_wdata_o_EU   ( eu_ctrl_master.wdata     ),
  .data_be_o_EU      ( eu_ctrl_master.be        ),
  .data_gnt_i_EU     ( eu_ctrl_master.gnt       ),
  .data_r_valid_i_EU ( eu_ctrl_master.r_valid   ),
  .data_r_rdata_i_EU ( eu_ctrl_master.r_rdata   ),
  .data_r_opc_i_EU   ( eu_ctrl_master.r_opc     )
);
assign periph_demux_bus.user   = '0;
assign periph_demux_bus.r_user = '0;
assign periph_demux_bus.lrdy   = '0;
assign periph_demux_bus.boffs  = '0;

endmodule: core_assist
