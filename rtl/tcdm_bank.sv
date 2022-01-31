// Copyright 2021 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


`define XILINX_BRAM_BANK_INSTANCE \
i_tcdm_bank_fpga \
( \
  .clka  ( clk_i ), \
  .rsta  ( rsta  ), \
  .ena   ( ena   ), \
  .wea   ( wea   ), \
  .addra ( add   ), \
  .dina  ( wdata ), \
  .douta ( rdata )  \
)

module tcdm_bank #(
    parameter int unsigned BehavMem  = 1,
    parameter int unsigned NumWords  = 0,
    parameter int unsigned DataWidth = 0
) (
    input logic clk_i,
    input logic rst_ni,
    input logic req_i,
    input logic we_i,
    input logic [$clog2(NumWords)-1:0] addr_i,
    input logic [DataWidth-1:0] wdata_i,
    input logic [((DataWidth+8-1)/8)-1:0] be_i,
    output logic [DataWidth-1:0] rdata_o
);


`ifdef PULP_FPGA_EMUL

  logic                        rsta;
  logic                        ena;
  logic [                31:0] wdata;
  logic [$clog2(NumWords)-1:0] add;
  logic [                 3:0] wea;
  logic [                31:0] rdata;

  assign rsta = ~rst_ni;
  assign ena = 1'b1;
  assign wdata = wdata_i;
  assign add = addr_i;
  assign wea = {4{req_i}} & {4{we_i}} & be_i;
  assign rdata_o = rdata;

  if (NumWords == 128) begin : bank_128_gen
    xilinx_tcdm_bank_128x32 `XILINX_BRAM_BANK_INSTANCE;
  end else if (NumWords == 256) begin : bank_256_gen
    xilinx_tcdm_bank_256x32 `XILINX_BRAM_BANK_INSTANCE;
  end else if (NumWords == 512) begin : bank_512_gen
    xilinx_tcdm_bank_512x32 `XILINX_BRAM_BANK_INSTANCE;
  end else if (NumWords == 1024) begin : bank_1024_gen
    xilinx_tcdm_bank_1024x32 `XILINX_BRAM_BANK_INSTANCE;
  end else if (NumWords == 2048) begin : bank_2048_gen
    xilinx_tcdm_bank_2048x32 `XILINX_BRAM_BANK_INSTANCE;
  end else $fatal(1, "NumWords does not match the supported values.");

`else  // !`ifdef PULP_FPGA_EMUL
  if (BehavMem) begin : l1_tcdm_bank_behav
    tc_sram #(
        .NumWords (NumWords),
        .DataWidth(32),
        .NumPorts (1)
    ) i_bank_l1_behav (
        .clk_i,
        .rst_ni,
        .req_i(req_i),
        .we_i(we_i),
        .addr_i(addr_i),
        .wdata_i(wdata_i),
        .be_i(be_i),
        .rdata_o(rdata_o)
    );
  end else begin : l1_tcdm_bank_macro  // block: l1_tcdm_bank_behav
    l1_sram_macro_wrap #(
        .NumWords (NumWords),
        .DataWidth(32)
    ) i_bank_l1_macro (
        .clk_i,
        .rst_ni,
        .req_i,
        .we_i,
        .addr_i,
        .wdata_i,
        .be_i,
        .rdata_o
    );
  end  // block: l1_tcdm_bank_macro

`endif  // !`ifdef PULP_FPGA_EMUL

endmodule
