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

`include "hci_helpers.svh"

module hwpe_subsystem
  import hci_package::*;
  import pulp_cluster_package::*;
#(
  parameter  hwpe_subsystem_cfg_t HWPE_CFG = hwpe_subsystem_cfg_t'{'0, '0},
  parameter  int unsigned N_CORES          = 8,
  parameter  int unsigned N_MASTER_PORT    = 9,
  parameter  int unsigned ID_WIDTH         = 8,
  parameter  hci_package::hci_size_parameter_t HCI_HWPE_SIZE = '0
)
(
  input  logic                             clk,
  input  logic                             rst_n,
  input  logic                             test_mode,
  input  logic                             hwpe_en_i,
  input  logic [$clog2(MAX_NUM_HWPES)-1:0] hwpe_sel_i,

  hci_core_intf.initiator                  hwpe_xbar_master,
  XBAR_PERIPH_BUS.Slave                    hwpe_cfg_slave,

  output logic [N_CORES-1:0][1:0]          evt_o,
  output logic                             busy_o
);

  localparam int unsigned DW = HCI_HWPE_SIZE.DW;
  localparam int unsigned AW = HCI_HWPE_SIZE.AW;
  localparam int unsigned EW = HCI_HWPE_SIZE.EW;
  localparam int unsigned EHW = HCI_HWPE_SIZE.EHW;

  // TEMP: localparam used by softex since it doesn't support yet ECC-HCI interface
  localparam hci_package::hci_size_parameter_t `HCI_SIZE_PARAM(tcdm_softex) = '{
    DW:  DW,
    AW:  AW,
    BW:  DEFAULT_BW,
    UW:  DEFAULT_UW,
    IW:  DEFAULT_IW,
    EW:  DEFAULT_EW,
    EHW: DEFAULT_EHW
  };
  `HCI_INTF(tcdm_softex, clk);

  localparam int unsigned N_HWPES = HWPE_CFG.NumHwpes;

  logic [N_HWPES-1:0] busy;
  logic [N_HWPES-1:0][N_CORES-1:0][1:0] evt;

  logic [N_HWPES-1:0] hwpe_clk;
  logic [N_HWPES-1:0] hwpe_en_int;

  logic [$clog2(N_HWPES)-1:0] hwpe_sel_int;

  assign hwpe_sel_int = hwpe_sel_i[0+:$clog2(N_HWPES)];

  hwpe_ctrl_intf_periph #(
    .ID_WIDTH ( ID_WIDTH )
  ) periph [N_HWPES-1:0] (.clk(clk));

  hci_core_intf #(
    .DW   ( DW  ),
    .AW   ( AW  ),
    .EW   ( EW  ),
    .EHW  ( EHW )
  ) tcdm [0:N_HWPES-1] (.clk(clk));

  for (genvar i = 0; i < N_HWPES; i++) begin : gen_hwpe

    // HWPE specific enable
    assign hwpe_en_int[i] = hwpe_en_i && (hwpe_sel_int == i);

    // Clock gating cell
    tc_clk_gating i_hwpe_clock_gate (
      .clk_i     ( clk            ),
      .en_i      ( hwpe_en_int[i] ),
      .test_en_i ( test_mode      ),
      .clk_o     ( hwpe_clk[i]    )
    );

    // Generate desired HWPEs
    if (HWPE_CFG.HwpeList[i] == REDMULE) begin : gen_redmule

      /////////////
      // REDMULE //
      /////////////

      redmule_top   #(
        .ID_WIDTH    ( ID_WIDTH         ),
        .N_CORES     ( N_CORES          ),
        .DW          ( N_MASTER_PORT*32 ),
        .`HCI_SIZE_PARAM(tcdm) ( HCI_HWPE_SIZE )
      ) i_redmule    (
        .clk_i       ( hwpe_clk[i] ),
        .rst_ni      ( rst_n       ),
        .test_mode_i ( test_mode   ),
        .busy_o      ( busy[i]     ),
        .evt_o       ( evt[i]      ),
        .tcdm        ( tcdm[i]     ),
        .periph      ( periph[i]   )
      );

    end else if (HWPE_CFG.HwpeList[i] == NEUREKA) begin : gen_neureka

      /////////////
      // NEUREKA //
      /////////////

      neureka_top   #(
        .PE_H        ( 4        ),
        .PE_W        ( 4        ),
        .ID          ( ID_WIDTH ),
        .N_CORES     ( N_CORES  ),
        .`HCI_SIZE_PARAM(tcdm) ( HCI_HWPE_SIZE )
      ) i_neureka    (
        // global signals
        .clk_i       ( hwpe_clk[i] ),
        .rst_ni      ( rst_n       ),
        .test_mode_i ( test_mode   ),
        // events
        .evt_o       ( evt[i]      ),
        .busy_o      ( busy[i]     ),
        // tcdm master ports
        .tcdm        ( tcdm[i]     ),
        // periph slave port
        .periph      ( periph[i]   )
      );

    end else if (HWPE_CFG.HwpeList[i] == SOFTEX) begin : gen_softex

      ////////////
      // SOFTEX //
      ////////////

      softex_top #(
        .N_CORES    ( N_CORES           ),
        .`HCI_SIZE_PARAM(Tcdm) ( `HCI_SIZE_PARAM(tcdm_softex) )
      ) i_softex (
        .clk_i  ( hwpe_clk[i] ),
        .rst_ni ( rst_n       ),
        .busy_o ( busy[i]     ),
        .evt_o  ( evt[i]      ),
        .tcdm   ( tcdm_softex ),
        .periph ( periph[i]   )
      );

      // TEMP: softex doesn't yet support ECC-HCI internally
      hci_ecc_enc #(
        .`HCI_SIZE_PARAM(tcdm_target)    ( `HCI_SIZE_PARAM(tcdm_softex) ),
        .`HCI_SIZE_PARAM(tcdm_initiator) ( HCI_HWPE_SIZE )
      ) i_ecc_softex_enc (
        .r_data_single_err_o (  ),
        .r_data_multi_err_o  (  ),
        .r_meta_single_err_o (  ),
        .r_meta_multi_err_o  (  ),
        .tcdm_target         ( tcdm_softex ),
        .tcdm_initiator      ( tcdm[i]     )
      );

    end
  end

  //////////////////
  // HWPE CFG BUS //
  //////////////////

  // Target signals muxed according to `hwpe_sel_int`
  logic [N_HWPES-1:0]               periph_gnt;
  logic [N_HWPES-1:0][31:0]         periph_r_rdata;
  logic [N_HWPES-1:0]               periph_r_valid;
  logic [N_HWPES-1:0][ID_WIDTH-1:0] periph_r_id;

  for (genvar i = 0; i < N_HWPES; i++) begin
    always_comb begin
      // Initiator signals decoded according to `hwpe_sel_int`
      periph[i].req  = (hwpe_sel_int == i) ? hwpe_cfg_slave.req : '0;
      // No muxing needed
      periph[i].add  = hwpe_cfg_slave.add;
      periph[i].wen  = hwpe_cfg_slave.wen;
      periph[i].be   = hwpe_cfg_slave.be;
      periph[i].data = hwpe_cfg_slave.wdata;
      periph[i].id   = hwpe_cfg_slave.id;
      // Split interface signals into packed vectors
      periph_gnt     [i] = periph[i].gnt;
      periph_r_rdata [i] = periph[i].r_data;
      periph_r_valid [i] = periph[i].r_valid;
      periph_r_id    [i] = periph[i].r_id;
    end
  end

  always_comb begin
    // Config bus
    hwpe_cfg_slave.gnt     = periph_gnt     [0];
    hwpe_cfg_slave.r_rdata = periph_r_rdata [0];
    hwpe_cfg_slave.r_valid = periph_r_valid [0];
    hwpe_cfg_slave.r_id    = periph_r_id    [0];
    // evt and busy
    evt_o  = evt[0];
    busy_o = busy[0];
    for (int i = 1; i < N_HWPES; i++) begin
      if (hwpe_sel_int == i) begin
        // Config bus
        hwpe_cfg_slave.gnt     = periph_gnt     [i];
        hwpe_cfg_slave.r_rdata = periph_r_rdata [i];
        hwpe_cfg_slave.r_valid = periph_r_valid [i];
        hwpe_cfg_slave.r_id    = periph_r_id    [i];
        // evt and busy
        evt_o  = evt[i];
        busy_o = busy[i];
      end
    end
  end

  //////////////////////
  // HWPE XBAR MASTER //
  //////////////////////

  hci_core_mux_static #(
    .NB_CHAN             ( N_HWPES       ),
    .`HCI_SIZE_PARAM(in) ( HCI_HWPE_SIZE )
  ) i_hwpe_hci_mux (

    /* Internally unused */
    .clk_i   ( clk             ),
    .rst_ni  ( rst_n           ),
    .clear_i ( '0              ),
    /*********************/

    .sel_i  ( hwpe_sel_int     ),

    .in     ( tcdm             ),
    .out    ( hwpe_xbar_master )
);

endmodule
