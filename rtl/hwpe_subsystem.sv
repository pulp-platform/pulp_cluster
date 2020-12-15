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
 * hwpe_subsystem.sv
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

import hci_package::*;

module hwpe_subsystem
#(
  parameter N_CORES       = 8,
  parameter N_MASTER_PORT = 4,
  parameter ID_WIDTH      = 8
)
(
  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    test_mode,
  
  hci_core_intf.master            hwpe_xbar_master,
  XBAR_PERIPH_BUS.Slave           hwpe_cfg_slave,
  output hci_interconnect_ctrl_t  hci_ctrl_o,

  output logic [N_CORES-1:0][1:0] evt_o,
  output logic                    busy_o
);

  hwpe_ctrl_intf_periph #(
    .ID_WIDTH ( ID_WIDTH )
  ) periph (
    .clk ( clk )
  );

  rbe_top #(
    .ID      ( ID_WIDTH ),
    .N_CORES ( N_CORES  ),
    .BW      ( 288      )
  ) hwpe_top_wrap_i (
    .clk_i       ( clk              ),
    .rst_ni      ( rst_n            ),
    .test_mode_i ( test_mode        ),
    .evt_o       ( evt_o            ),
    .tcdm        ( hwpe_xbar_master ),
    .hci_ctrl_o  ( hci_ctrl_o       ),
    .periph      ( periph           )
  );
  assign busy_o = 1'b1;

  always_comb
  begin
    periph.req  = hwpe_cfg_slave.req;
    periph.add  = hwpe_cfg_slave.add;
    periph.wen  = hwpe_cfg_slave.wen;
    periph.be   = hwpe_cfg_slave.be;
    periph.data = hwpe_cfg_slave.wdata;
    periph.id   = hwpe_cfg_slave.id;
  end
  assign hwpe_cfg_slave.gnt     = periph.gnt;
  assign hwpe_cfg_slave.r_rdata = periph.r_data;
  assign hwpe_cfg_slave.r_valid = periph.r_valid;
  assign hwpe_cfg_slave.r_id    = periph.r_id;

endmodule
