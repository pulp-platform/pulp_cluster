// Copyright 2021 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
// 
// Module to assist cluster cores and demux data bus

`include "pulp_soc_defines.sv"

module cluster_core_assist #(
  parameter ADDR_WIDTH         = 32,
  parameter DATA_WIDTH         = 32,
  parameter BE_WIDTH           = DATA_WIDTH/8,
  parameter CLUSTER_ALIAS_BASE = 12'h000,

  parameter N_EXT_PERF_COUNTERS  = 5,
  parameter bit ECC_INTC           = 0
) (
  input  logic                           clk_i,
  input  logic                           rst_ni,

  input  logic                           clock_en_i,
  input  logic                           test_mode_i,

  input  logic [5:0]                     cluster_id_i,
  input  logic [3:0]                     base_addr_i,

  output logic [N_EXT_PERF_COUNTERS-1:0] perf_counters_o,
  
  hci_core_intf.slave                    core_bus_slave,

  hci_core_intf.master                   tcdm_data_master,
  hci_core_intf.master                   dma_ctrl_master,
  XBAR_PERIPH_BUS.Master                 eu_ctrl_master,
  XBAR_PERIPH_BUS.Master                 periph_data_master
);

  localparam EccDataWidth = ECC_INTC ? DATA_WIDTH+7 : DATA_WIDTH;

  logic clk_int;

  logic [EccDataWidth-1:0] core_bus_data, core_bus_r_data, tcdm_data, tcdm_r_data, eu_data, eu_r_data, periph_data, periph_r_data, demux_data, demux_r_data, dma_data, dma_r_data;

  hci_core_intf #(
    .DW(DATA_WIDTH),
    .AW(ADDR_WIDTH),
    .OW(1),
    .UW(ECC_INTC ? 7 : 0)
  ) periph_demux_bus (
    .clk(clk_i)
  );

  if ( ECC_INTC ) begin
    assign core_bus_data = {core_bus_slave.user, core_bus_slave.data};
    assign {core_bus_slave.r_user, core_bus_slave.r_data} = core_bus_r_data;
    assign {tcdm_data_master.user, tcdm_data_master.data} = tcdm_data;
    assign tcdm_r_data = {tcdm_data_master.r_user, tcdm_data_master.r_data};
    assign eu_ctrl_master.wdata = eu_data[31:0];
    prim_secded_39_32_enc eu_rdata_enc_i (
      .in (eu_ctrl_master.r_rdata),
      .out(eu_r_data)
    );
    assign periph_data_master.wdata = periph_data[31:0];
    prim_secded_39_32_enc periph_rdata_enc_i (
      .in (periph_data_master.r_rdata),
      .out(periph_r_data)
    );

    assign {dma_ctrl_master.user, dma_ctrl_master.data} = dma_data;
    assign dma_r_data = {dma_ctrl_master.r_user, dma_ctrl_master.r_data};
  end else begin
    assign core_bus_data = core_bus_slave.data;
    assign core_bus_slave.r_data = core_bus_r_data;
    assign tcdm_data_master.data = tcdm_data;
    assign tcdm_r_data = tcdm_data_master.r_data;
    assign eu_ctrl_master.wdata = eu_data;
    assign eu_r_data = eu_ctrl_master.r_rdata;
    assign periph_data_master.wdata = periph_data;
    assign periph_r_data = periph_data_master.r_rdata;

    assign dma_ctrl_master.data = dma_data;
    assign dma_ctrl_master.user = '0;
    assign dma_r_data = dma_ctrl_master.r_data;
  end

  tc_clk_gating clock_gate_i (
    .clk_i    (clk_i),
    .en_i     (clock_en_i),
    .test_en_i(test_mode_i),
    .clk_o    (clk_int)
  );

  assign tcdm_data_master.boffs = '0;
  assign tcdm_data_master.lrdy  = '0;
  assign dma_ctrl_master.boffs = '0;
  assign dma_ctrl_master.lrdy = '0;
  assign periph_demux_bus.boffs = '0;
  assign periph_demux_bus.lrdy = '0;
  assign periph_demux_bus.user = '0;
  assign periph_demux_bus.data = '0; // done with demux_data
  assign periph_demux_bus.r_user = '0;
  assign periph_demux_bus.r_data = '0; // done with demux_r_data

  assign perf_counters_o[4] = tcdm_data_master.req & (~tcdm_data_master.gnt);

  core_demux #(
    .ADDR_WIDTH         ( ADDR_WIDTH         ),
    .DATA_WIDTH         ( EccDataWidth       ),
    .BYTE_ENABLE_BIT    ( BE_WIDTH           ),
    .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE )
  ) core_demux_i (
    .clk                ( clk_int                    ),
    .rst_ni             ( rst_ni                     ),
    .test_en_i          ( test_mode_i                ),
`ifdef REMAP_ADDRESS
    .base_addr_i        ( base_addr_i                ),
`endif // REMAP_ADDRESS
    .data_req_i         ( core_bus_slave.req         ),
    .data_add_i         ( core_bus_slave.add         ),
    .data_wen_i         ( core_bus_slave.wen         ),
    .data_wdata_i       ( core_bus_data              ),
    .data_be_i          ( core_bus_slave.be          ),
    .data_gnt_o         ( core_bus_slave.gnt         ),
    .data_r_valid_o     ( core_bus_slave.r_valid     ),
    .data_r_rdata_o     ( core_bus_r_data            ),
    .data_r_opc_o       ( core_bus_slave.r_opc       ),

    .data_req_o_SH      ( tcdm_data_master.req       ),
    .data_add_o_SH      ( tcdm_data_master.add       ),
    .data_wen_o_SH      ( tcdm_data_master.wen       ),
    .data_wdata_o_SH    ( tcdm_data      ),
    .data_be_o_SH       ( tcdm_data_master.be        ),
    .data_gnt_i_SH      ( tcdm_data_master.gnt       ),
    .data_r_valid_i_SH  ( tcdm_data_master.r_valid   ),
    .data_r_rdata_i_SH  ( tcdm_r_data   ),

    .data_req_o_EXT     ( periph_demux_bus.req         ),
    .data_add_o_EXT     ( periph_demux_bus.add         ),
    .data_wen_o_EXT     ( periph_demux_bus.wen         ),
    .data_wdata_o_EXT   ( demux_data                   ),
    .data_be_o_EXT      ( periph_demux_bus.be          ),
    .data_gnt_i_EXT     ( periph_demux_bus.gnt         ),
    .data_r_valid_i_EXT ( periph_demux_bus.r_valid     ),
    .data_r_rdata_i_EXT ( demux_r_data                 ),
    .data_r_opc_i_EXT   ( periph_demux_bus.r_opc       ),
    // What happens to eu_ctrl_master.id, .r_id?

    .data_req_o_PE      ( periph_data_master.req     ),
    .data_add_o_PE      ( periph_data_master.add     ),
    .data_wen_o_PE      ( periph_data_master.wen     ),
    .data_wdata_o_PE    ( periph_data                ),
    .data_be_o_PE       ( periph_data_master.be      ),
    .data_gnt_i_PE      ( periph_data_master.gnt     ),
    .data_r_valid_i_PE  ( periph_data_master.r_valid ),
    .data_r_opc_i_PE    ( periph_data_master.r_opc   ),
    .data_r_rdata_i_PE  ( periph_r_data              ),
    // What happens to periph_ctrl_master.id, .r_id?

    .perf_l2_ld_o       ( perf_counters_o[0]         ),
    .perf_l2_st_o       ( perf_counters_o[1]         ),
    .perf_l2_ld_cyc_o   ( perf_counters_o[2]         ),
    .perf_l2_st_cyc_o   ( perf_counters_o[3]         ),
    .CLUSTER_ID         ( cluster_id_i               )
  );


  periph_demux #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(EccDataWidth),
    .BE_WIDTH  (BE_WIDTH)
  ) periph_demux_i (
    .clk               ( clk_int                  ),
    .rst_ni            ( rst_ni                   ),

    .data_req_i        ( periph_demux_bus.req     ),
    .data_add_i        ( periph_demux_bus.add     ),
    .data_wen_i        ( periph_demux_bus.wen     ),
    .data_wdata_i      ( demux_data               ),
    .data_be_i         ( periph_demux_bus.be      ),
    .data_gnt_o        ( periph_demux_bus.gnt     ),

    .data_r_valid_o    ( periph_demux_bus.r_valid ),
    .data_r_opc_o      ( periph_demux_bus.r_opc   ),
    .data_r_rdata_o    ( demux_r_data             ),

    .data_req_o_MH     ( dma_ctrl_master.req      ),
    .data_add_o_MH     ( dma_ctrl_master.add      ),
    .data_wen_o_MH     ( dma_ctrl_master.wen      ),
    .data_wdata_o_MH   ( dma_data                 ),
    .data_be_o_MH      ( dma_ctrl_master.be       ),
    .data_gnt_i_MH     ( dma_ctrl_master.gnt      ),

    .data_r_valid_i_MH ( dma_ctrl_master.r_valid  ),
    .data_r_rdata_i_MH ( dma_r_data               ),
    .data_r_opc_i_MH   ( dma_ctrl_master.r_opc    ),

    .data_req_o_EU     ( eu_ctrl_master.req       ),
    .data_add_o_EU     ( eu_ctrl_master.add       ),
    .data_wen_o_EU     ( eu_ctrl_master.wen       ),
    .data_wdata_o_EU   ( eu_data                  ),
    .data_be_o_EU      ( eu_ctrl_master.be        ),
    .data_gnt_i_EU     ( eu_ctrl_master.gnt       ),

    .data_r_valid_i_EU ( eu_ctrl_master.r_valid   ),
    .data_r_rdata_i_EU ( eu_r_data                ),
    .data_r_opc_i_EU   ( eu_ctrl_master.r_opc     )
  );

endmodule
