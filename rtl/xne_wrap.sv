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
 * xne_wrap.sv
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module xne_wrap
#(
  parameter N_CORES = 8,
  parameter N_MASTER_PORT = 4,
  parameter ID_WIDTH = 8
)
(
  input  logic               clk,
  input  logic               rst_n,
  input  logic               test_mode,
  
  XBAR_TCDM_BUS.Master       hwacc_xbar_master[N_MASTER_PORT-1:0],
  XBAR_PERIPH_BUS.Slave      hwacc_cfg_slave,

  output logic [N_CORES-1:0][1:0] evt_o,
  output logic               busy_o
);

  logic [4-1:0]          tcdm_req;
  logic [4-1:0]          tcdm_gnt;
  logic [4-1:0] [32-1:0] tcdm_add;
  logic [4-1:0]          tcdm_type;
  logic [4-1:0] [4 -1:0] tcdm_be;
  logic [4-1:0] [32-1:0] tcdm_wdata;
  logic [4-1:0] [32-1:0] tcdm_r_rdata;
  logic [4-1:0]          tcdm_r_valid;

  xne_top_wrap #(
    .TP  ( 128      ),
    .AP  ( 128      ),
    .ACC ( 16       ),
    .CNT ( 16       ),
    .ID  ( ID_WIDTH )
  ) xne_top_wrap_i (
    .clk_i            (clk                     ),
    .rst_ni           (rst_n                   ),
    .test_mode_i      (test_mode               ),
    .tcdm_req         (tcdm_req                ),
    .tcdm_gnt         (tcdm_gnt                ),
    .tcdm_add         (tcdm_add                ),
    .tcdm_wen         (tcdm_type               ),
    .tcdm_be          (tcdm_be                 ),
    .tcdm_data        (tcdm_wdata              ),
    .tcdm_r_data      (tcdm_r_rdata            ),
    .tcdm_r_valid     (tcdm_r_valid            ),
    .periph_req       (hwacc_cfg_slave.req     ),
    .periph_gnt       (hwacc_cfg_slave.gnt     ),
    .periph_add       (hwacc_cfg_slave.add     ),
    .periph_wen       (~hwacc_cfg_slave.wen    ),
    .periph_be        (hwacc_cfg_slave.be      ),
    .periph_data      (hwacc_cfg_slave.wdata   ),
    .periph_id        (hwacc_cfg_slave.id      ),
    .periph_r_data    (hwacc_cfg_slave.r_rdata ),
    .periph_r_valid   (hwacc_cfg_slave.r_valid ),
    .periph_r_id      (hwacc_cfg_slave.r_id    ),
    .evt_o            (evt_o                   )
  );
  assign busy_o = 1'b1;

  genvar i;
  generate
    for (i=0;i<4;i++) begin : hwacc_binding
      assign hwacc_xbar_master[i].req   = tcdm_req   [i];
      assign hwacc_xbar_master[i].add   = tcdm_add   [i];
      assign hwacc_xbar_master[i].wen   = tcdm_type  [i];
      assign hwacc_xbar_master[i].wdata = tcdm_wdata [i];
      assign hwacc_xbar_master[i].be    = tcdm_be    [i];
      // response channel
      assign tcdm_gnt     [i] = hwacc_xbar_master[i].gnt;
      assign tcdm_r_rdata [i] = hwacc_xbar_master[i].r_rdata;
      assign tcdm_r_valid [i] = hwacc_xbar_master[i].r_valid;
    end
  endgenerate

endmodule
