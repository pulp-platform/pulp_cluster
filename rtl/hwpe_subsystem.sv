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
  parameter N_HWPES       = 1,
  parameter N_MASTER_PORT = 9,
  parameter ID_WIDTH      = 8,
  parameter USE_RBE       = 0,
  parameter DW            = DEFAULT_DW,
  parameter AW            = DEFAULT_AW,
  parameter OW            = AW
)
(
  input  logic                       clk,
  input  logic                       rst_n,
  input  logic                       test_mode,
  input  logic                       hwpe_en_i,
  input  logic [$clog2(N_HWPES)-1:0] hwpe_sel_i,

  hci_core_intf.master               hwpe_xbar_master,
  XBAR_PERIPH_BUS.Slave              hwpe_cfg_slave,

  output logic [N_CORES-1:0][1:0]    evt_o,
  output logic                       busy_o
);

  logic [N_HWPES-1:0] busy;
  logic [N_HWPES-1:0][N_CORES-1:0][1:0] evt;

  logic [N_HWPES-1:0] hwpe_clk;
  logic [N_HWPES-1:0] hwpe_en_int;

  hwpe_ctrl_intf_periph #(
    .ID_WIDTH ( ID_WIDTH )
  ) periph [N_HWPES-1:0] (.clk(clk));

  hci_core_intf #(
    .DW ( DW ),
    .AW ( AW ),
    .OW ( OW )
  ) tcdm [N_HWPES-1:0] (.clk(clk));

  for (genvar i = 0; i < N_HWPES; i++) begin
    // HWPE specific enable
    assign hwpe_en_int[i] = hwpe_en_i && (hwpe_sel_i == i);
    // Clock gating cell
    tc_clk_gating i_hwpe_clock_gate (
      .clk_i     ( clk            ),
      .en_i      ( hwpe_en_int[i] ),
      .test_en_i ( test_mode      ),
      .clk_o     ( hwpe_clk[i]    )
    );
  end

  /////////////
  // REDMULE //
  /////////////

  redmule_top   #(
    .ID_WIDTH    ( ID_WIDTH         ),
    .N_CORES     ( N_CORES          ),
    .DW          ( N_MASTER_PORT*32 )
  ) i_redmule    (
    .clk_i       ( hwpe_clk[0]      ),
    .rst_ni      ( rst_n            ),
    .test_mode_i ( test_mode        ),
    .busy_o      ( busy[0]          ),
    .evt_o       ( evt[0]           ),
    .tcdm        ( tcdm[0]          ),
    .periph      ( periph[0]        )
  );

  /////////////
  // NEUREKA //
  /////////////

  // TODO: specify params in package
  neureka_top #(
    .PE_H    ( 4        ),
    .PE_W    ( 4        ),
    .ID      ( ID_WIDTH ),
    .N_CORES ( N_CORES  )
  ) i_neureka (
    // global signals
    .clk_i       ( hwpe_clk[1] ),
    .rst_ni      ( rst_n       ),
    .test_mode_i ( test_mode   ),
    // events
    .evt_o       ( evt[1]      ),
    .busy_o      ( busy[1]     ),
    // tcdm master ports
    .tcdm        ( tcdm[1]     ),
    // periph slave port
    .periph      ( periph[1]   )
  );

  //////////////////
  // HWPE CFG BUS //
  //////////////////

  // Initiator signals decoded according to `hwpe_sel_i`
  for (genvar i = 0; i < N_HWPES; i++) begin
    always_comb begin
      periph[i].req  = (hwpe_sel_i == i) ? hwpe_cfg_slave.req   : '0;
      periph[i].add  = (hwpe_sel_i == i) ? hwpe_cfg_slave.add   : '0;
      periph[i].wen  = (hwpe_sel_i == i) ? hwpe_cfg_slave.wen   : '0;
      periph[i].be   = (hwpe_sel_i == i) ? hwpe_cfg_slave.be    : '0;
      periph[i].data = (hwpe_sel_i == i) ? hwpe_cfg_slave.wdata : '0;
      periph[i].id   = (hwpe_sel_i == i) ? hwpe_cfg_slave.id    : '0;
    end
  end

  // Target signals muxed according to `hwpe_sel_i`
  logic [N_HWPES-1:0]               periph_gnt;
  logic [N_HWPES-1:0][31:0]         periph_r_rdata;
  logic [N_HWPES-1:0]               periph_r_valid;
  logic [N_HWPES-1:0][ID_WIDTH-1:0] periph_r_id;

  for (genvar i = 0; i < N_HWPES; i++) begin
      assign periph_gnt     [i] = periph[i].gnt;
      assign periph_r_rdata [i] = periph[i].r_data;
      assign periph_r_valid [i] = periph[i].r_valid;
      assign periph_r_id    [i] = periph[i].r_id;
  end

  always_comb begin
    hwpe_cfg_slave.gnt     = periph_gnt     [0];
    hwpe_cfg_slave.r_rdata = periph_r_rdata [0];
    hwpe_cfg_slave.r_valid = periph_r_valid [0];
    hwpe_cfg_slave.r_id    = periph_r_id    [0];
    for (int i = 1; i < N_HWPES; i++) begin
      if (hwpe_sel_i == i) begin
        hwpe_cfg_slave.gnt     = periph_gnt     [i];
        hwpe_cfg_slave.r_rdata = periph_r_rdata [i];
        hwpe_cfg_slave.r_valid = periph_r_valid [i];
        hwpe_cfg_slave.r_id    = periph_r_id    [i];
      end
    end
  end

  //////////////////////
  // HWPE XBAR MASTER //
  //////////////////////

  hci_core_mux_static #(
    .NB_CHAN ( N_HWPES ),
    .DW      ( DW      ),
    .AW      ( AW      ),
    .OW      ( OW      )
  ) i_hwpe_hci_mux (

    /* Internally unused */
    .clk_i   ( clk             ),
    .rst_ni  ( rst_n           ),
    .clear_i ( '0              ),
    /*********************/

    .sel_i  ( hwpe_sel_i       ),

    .in     ( tcdm             ),
    .out    ( hwpe_xbar_master )
);

//////////////////
// EVT AND BUSY //
//////////////////

always_comb begin
  evt_o  = evt[0];
  busy_o = busy[0];
  for (int i = 1; i < N_HWPES; i++) begin
    if (hwpe_sel_i == i) begin
      evt_o  = evt[i];
      busy_o = busy[i];
    end
  end
end

endmodule
