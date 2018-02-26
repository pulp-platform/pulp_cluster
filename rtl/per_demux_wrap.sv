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
 * per_demux_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module per_demux_wrap
#(
  parameter NB_MASTERS  = 2,
  parameter ADDR_OFFSET = 10
)
(
  input logic           clk_i,
  input logic           rst_ni,
  XBAR_TCDM_BUS.Slave  slave,
  XBAR_TCDM_BUS.Master masters[NB_MASTERS-1:0]
);

  localparam NB_MASTERS_LOG = $clog2(NB_MASTERS);

  logic [NB_MASTERS_LOG-1:0]  dest_q, dest_n;

  // need to explode the interfaces here because SystemVerilog does not allow
  // to use it directly......
  logic [NB_MASTERS-1:0]       masters_gnt;
  logic [NB_MASTERS-1:0]       masters_r_valid;
  logic [NB_MASTERS-1:0]       masters_r_opc;
  logic [NB_MASTERS-1:0][31:0] masters_r_data;

  generate
    for (genvar i = 0; i < NB_MASTERS; i++) begin
      assign masters[i].req   = (dest_n == i) ? slave.req : 1'b0;
      assign masters[i].add   = slave.add;
      assign masters[i].wen   = slave.wen;
      assign masters[i].wdata = slave.wdata;
      assign masters[i].be    = slave.be;

      // for exploded interface
      assign masters_gnt[i]     = masters[i].gnt;
      assign masters_r_valid[i] = masters[i].r_valid;
      assign masters_r_opc[i]   = masters[i].r_opc;
      assign masters_r_data[i]  = masters[i].r_rdata;
    end
  endgenerate

  assign slave.gnt     = masters_gnt[dest_n];
  assign slave.r_valid = masters_r_valid[dest_q];
  assign slave.r_opc   = masters_r_opc[dest_q];
  assign slave.r_rdata = masters_r_data[dest_q];

  assign dest_n = slave.add[NB_MASTERS_LOG-1+ADDR_OFFSET:ADDR_OFFSET];

  always_ff @(posedge clk_i, negedge rst_ni)
  begin
    if (~rst_ni) begin
      dest_q <= '0;
    end
    else begin
      dest_q <= dest_n;
    end
  end

endmodule
