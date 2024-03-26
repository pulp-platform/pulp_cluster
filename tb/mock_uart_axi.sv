// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 28/09/2018
// Description: Mock replacement for UART in testbench (not synthesiesable!)

module mock_uart_axi #(
  parameter int unsigned AxiIw = 0,
  parameter int unsigned AxiAw = 0,
  parameter int unsigned AxiDw = 0,
  parameter int unsigned AxiUw = 0
  )(
    input logic      clk_i,
    input logic      rst_ni,
    input logic      test_i,
    AXI_BUS.Slave    uart
 );
   
  logic         uart_penable;
  logic         uart_pwrite;
  logic [AxiAw-1:0]  uart_paddr;
  logic         uart_psel;
  logic [31:0]  uart_pwdata;
  logic [31:0]  uart_prdata;
  logic         uart_pready;
  logic         uart_pslverr;

  AXI_LITE #(
    .AXI_DATA_WIDTH(AxiDw),
    .AXI_ADDR_WIDTH(AxiAw)
  ) uart_lite_wide();

  AXI_LITE #(
    .AXI_DATA_WIDTH(32),
    .AXI_ADDR_WIDTH(AxiAw)
  ) uart_lite();

  axi_to_axi_lite_intf #(
    .AXI_ADDR_WIDTH    ( AxiAw ),
    .AXI_DATA_WIDTH    ( AxiDw ),
    .AXI_ID_WIDTH      ( AxiIw ),
    .AXI_USER_WIDTH    ( AxiUw ),
    .AXI_MAX_WRITE_TXNS(1),
    .AXI_MAX_READ_TXNS (1),
    .FALL_THROUGH      (1'b1),
    .FULL_BW           (1'b1)
  ) i_axi_to_axi_lite_intf (
    .clk_i,
    .rst_ni,
    .testmode_i(test_i),
    .slv       (uart),
    .mst       (uart_lite_wide)
  );

  axi_lite_dw_converter_intf #(
    .AXI_ADDR_WIDTH         (AxiAw),
    .AXI_SLV_PORT_DATA_WIDTH(AxiDw),
    .AXI_MST_PORT_DATA_WIDTH(32)
  ) i_axi_lite_dw_converter_intf (
    .clk_i ( clk_i ),
    .rst_ni( rst_ni ),
    .slv   ( uart_lite_wide ),
    .mst   ( uart_lite )
  );

  typedef struct packed {
    int unsigned      idx;
    logic [AxiAw-1:0] start_addr;
    logic [AxiAw-1:0] end_addr;
  } rule_t;

  rule_t [0:0] rule;
  assign rule[0] = '{0, '0, '1};
  
  axi_lite_to_apb_intf #(
    .NoApbSlaves     (1),
    .NoRules         (1),
    .AddrWidth       (AxiAw),
    .DataWidth       (32),
    .PipelineRequest (1'b0),
    .PipelineResponse(1'b0),
    .rule_t          (rule_t)
  ) i_axi_lite_to_apb_intf (
    .clk_i,
    .rst_ni,
    .slv        ( uart_lite ),
    .paddr_o   ( uart_paddr ),
    .pprot_o   ( ),
    .pselx_o   ( uart_psel ),
    .penable_o ( uart_penable ),
    .pwrite_o  ( uart_pwrite ),
    .pwdata_o  ( uart_pwdata ),
    .pstrb_o   ( ),
    .pready_i  ( uart_pready ),
    .prdata_i  ( uart_prdata ),
    .pslverr_i ( uart_pslverr ),
    .addr_map_i(rule)
  );

  /* pragma translate_off */
  mock_uart i_mock_uart0 (
      .clk_i     ( clk_i        ),
      .rst_ni    ( rst_ni       ),
      .penable_i ( uart_penable ),
      .pwrite_i  ( uart_pwrite  ),
      .paddr_i   ( uart_paddr[31:0]   ),
      .psel_i    ( uart_psel    ),
      .pwdata_i  ( uart_pwdata  ),
      .prdata_o  ( uart_prdata  ),
      .pready_o  ( uart_pready  ),
      .pslverr_o ( uart_pslverr )
 );

endmodule
