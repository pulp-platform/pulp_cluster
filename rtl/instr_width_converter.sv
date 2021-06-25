// Copyright 2020 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
// 
// Converts 128-bit instruction data from cache to 32-bit instruction data for core.

module instr_width_converter (
  input logic             clk_i,
  input logic             rst_ni,

  output logic            cache_req_o,
  input logic             cache_gnt_i,
  output logic [31:0]     cache_addr_o,
  input logic [127:0]     cache_r_rdata_i,
  input logic             cache_r_valid_i,

  input logic             core_req_i,
  output logic            core_gnt_o,
  input logic [31:0]      core_addr_i,
  output logic [31:0]     core_r_rdata_o,
  output logic            core_r_valid_o
  );

  logic       busy_d, busy_q;
  logic       cache_req_gnt;
  logic [1:0] word_sel_d, word_sel_q;
  logic [1:0] unused_addr;

  assign cache_req_gnt  = cache_req_o && cache_gnt_i;
  assign core_gnt_o     = cache_req_gnt;
  assign cache_req_o    = cache_r_valid_i && busy_q ? core_req_i :              // request passes if old instruction is available
                                             busy_q ? 1'b0       : core_req_i;  // or not processing any new instructions

  assign cache_addr_o = {core_addr_i[31:4], 4'b0000};
  assign unused_addr  = core_addr_i[1:0];

  assign busy_d =   cache_req_gnt ? 1'b1 : 
                  cache_r_valid_i ? 1'b0 : busy_q;                    // Core will be busy if request is granted and not available yet

  assign word_sel_d = cache_req_gnt ? core_addr_i[3:2] : word_sel_q;  // Select address portion based on previous request

  always_comb begin : mux_r_data
    unique case (word_sel_q)
      2'b00   : core_r_rdata_o = cache_r_rdata_i[31:0];
      2'b01   : core_r_rdata_o = cache_r_rdata_i[63:32];
      2'b10   : core_r_rdata_o = cache_r_rdata_i[95:64];
      2'b11   : core_r_rdata_o = cache_r_rdata_i[127:96];
      default : core_r_rdata_o = cache_r_rdata_i[31:0];
    endcase // word_sel_q
  end

  assign core_r_valid_o = cache_r_valid_i;


  always_ff @(posedge clk_i or negedge rst_ni) begin : reg_control
    if(~rst_ni) begin
      busy_q      <= 1'b0;
      word_sel_q  <= '0;
    end else begin
      busy_q      <= busy_d;
      word_sel_q  <= word_sel_d;
    end
  end

endmodule
