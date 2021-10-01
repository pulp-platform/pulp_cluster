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
 * cluster_clock_gate.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

 module cluster_clock_gate
#(
  parameter NB_CORES = 4
) (
  input  logic                clk_i,
  input  logic                rstn_i,
  input  logic                test_mode_i,
  input  logic                cluster_cg_en_i,
  input  logic                cluster_int_busy_i,
  input  logic [NB_CORES-1:0] cores_busy_i,
  input  logic                events_i,
  input  logic                incoming_req_i,
  output logic                isolate_cluster_o,
  output logic                cluster_clk_o

);

  logic s_somebusy;
  logic [3:0] r_clockgate;
  logic       s_clockenable;
  logic [1:0] r_events_sync;
  logic       s_events_sync;

  assign isolate_cluster_o = r_clockgate;

  assign s_somebusy = cluster_int_busy_i | ( |cores_busy_i);

  assign s_clockenable = ~(&r_clockgate);

  always_ff @(posedge clk_i or negedge rstn_i) begin : proc_evnt_sync
    if(~rstn_i) begin
      r_events_sync <= 0;
    end else begin
      r_events_sync <= {r_events_sync[0],events_i};
    end
  end

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if(~rstn_i) begin
      r_clockgate <= 0;
    end else begin
      if(!s_somebusy && !incoming_req_i && !r_events_sync[1]) begin
        r_clockgate <= {r_clockgate[2:0],cluster_cg_en_i}; 
      end else begin
        r_clockgate <= {r_clockgate[2:0],1'b0};
      end
    end
  end

  tc_clk_gating u_clkgate_cluster (
    .clk_o     ( cluster_clk_o ),
    .clk_i     ( clk_i         ),
    .en_i      ( s_clockenable ),
    .test_en_i ( test_mode_i   )
  );

endmodule
