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
 * axi2mem_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module axi2mem_wrap
#(
  parameter int unsigned NB_DMAS        = 4,
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 64,
  parameter int unsigned AXI_USER_WIDTH = 6,
  parameter int unsigned AXI_ID_WIDTH   = 6,
  parameter type         axi_req_t      = logic,
  parameter type         axi_resp_t     = logic
)
(
  input  logic            clk_i,
  input  logic            rst_ni,
  input  logic            test_en_i,
  input axi_req_t         axi_slave_req_i,
  output axi_resp_t       axi_slave_resp_o,
  hci_core_intf.initiator tcdm_master[0:NB_DMAS-1],
  output logic            busy_o
);

  logic [NB_DMAS-1:0][31:0] s_tcdm_bus_wdata;
  logic [NB_DMAS-1:0][31:0] s_tcdm_bus_add;
  logic [NB_DMAS-1:0]       s_tcdm_bus_req;
  logic [NB_DMAS-1:0]       s_tcdm_bus_wen;
  logic [NB_DMAS-1:0][3:0]  s_tcdm_bus_be;
  logic [NB_DMAS-1:0]       s_tcdm_bus_gnt;
  logic [NB_DMAS-1:0][31:0] s_tcdm_bus_r_rdata;
  logic [NB_DMAS-1:0]       s_tcdm_bus_r_valid;

  generate
    for (genvar i=0; i<NB_DMAS; i++) begin : TCDM_BIND
      assign tcdm_master[i].add    = s_tcdm_bus_add[i];
      assign tcdm_master[i].req    = s_tcdm_bus_req[i];
      assign tcdm_master[i].data   = s_tcdm_bus_wdata[i];
      assign tcdm_master[i].wen    = s_tcdm_bus_wen[i];
      assign tcdm_master[i].be     = s_tcdm_bus_be[i];
      assign tcdm_master[i].r_ready  = '1;
      assign tcdm_master[i].user     = '0;
      assign tcdm_master[i].ecc      = '0;
      assign tcdm_master[i].id       = '0;
      assign tcdm_master[i].ereq     = '0;
      assign tcdm_master[i].r_eready = '1;

      assign s_tcdm_bus_gnt[i]     = tcdm_master[i].gnt;
      assign s_tcdm_bus_r_valid[i] = tcdm_master[i].r_valid;
      assign s_tcdm_bus_r_rdata[i] = tcdm_master[i].r_data;
    end
  endgenerate

  axi2mem #(
    .AXI_ADDR_WIDTH       ( AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH       ( AXI_DATA_WIDTH        ),
    .AXI_USER_WIDTH       ( AXI_USER_WIDTH        ),
    .AXI_ID_WIDTH         ( AXI_ID_WIDTH          )
  ) axi2mem_i (
    .clk_i                 ( clk_i                ),
    .rst_ni                ( rst_ni               ),

    .tcdm_master_req_o     ( s_tcdm_bus_req       ),
    .tcdm_master_add_o     ( s_tcdm_bus_add       ),
    .tcdm_master_type_o    ( s_tcdm_bus_wen       ),
    .tcdm_master_data_o    ( s_tcdm_bus_wdata     ),
    .tcdm_master_be_o      ( s_tcdm_bus_be        ),
    .tcdm_master_gnt_i     ( s_tcdm_bus_gnt       ),

    .tcdm_master_r_valid_i ( s_tcdm_bus_r_valid   ),
    .tcdm_master_r_data_i  ( s_tcdm_bus_r_rdata   ),

    .busy_o                ( busy_o               ),
    .test_en_i             ( test_en_i            ),

    .axi_slave_aw_valid_i  ( axi_slave_req_i.aw_valid   ),
    .axi_slave_aw_addr_i   ( axi_slave_req_i.aw.addr    ),
    .axi_slave_aw_prot_i   ( axi_slave_req_i.aw.prot    ),
    .axi_slave_aw_region_i ( axi_slave_req_i.aw.region  ),
    .axi_slave_aw_len_i    ( axi_slave_req_i.aw.len     ),
    .axi_slave_aw_size_i   ( axi_slave_req_i.aw.size    ),
    .axi_slave_aw_burst_i  ( axi_slave_req_i.aw.burst   ),
    .axi_slave_aw_lock_i   ( axi_slave_req_i.aw.lock    ),
    .axi_slave_aw_cache_i  ( axi_slave_req_i.aw.cache   ),
    .axi_slave_aw_qos_i    ( axi_slave_req_i.aw.qos     ),
    .axi_slave_aw_id_i     ( axi_slave_req_i.aw.id      ),
    .axi_slave_aw_user_i   ( axi_slave_req_i.aw.user    ),
    .axi_slave_aw_ready_o  ( axi_slave_resp_o.aw_ready  ),

    .axi_slave_ar_valid_i  ( axi_slave_req_i.ar_valid   ),
    .axi_slave_ar_addr_i   ( axi_slave_req_i.ar.addr    ),
    .axi_slave_ar_prot_i   ( axi_slave_req_i.ar.prot    ),
    .axi_slave_ar_region_i ( axi_slave_req_i.ar.region  ),
    .axi_slave_ar_len_i    ( axi_slave_req_i.ar.len     ),
    .axi_slave_ar_size_i   ( axi_slave_req_i.ar.size    ),
    .axi_slave_ar_burst_i  ( axi_slave_req_i.ar.burst   ),
    .axi_slave_ar_lock_i   ( axi_slave_req_i.ar.lock    ),
    .axi_slave_ar_cache_i  ( axi_slave_req_i.ar.cache   ),
    .axi_slave_ar_qos_i    ( axi_slave_req_i.ar.qos     ),
    .axi_slave_ar_id_i     ( axi_slave_req_i.ar.id      ),
    .axi_slave_ar_user_i   ( axi_slave_req_i.ar.user    ),
    .axi_slave_ar_ready_o  ( axi_slave_resp_o.ar_ready  ),

    .axi_slave_w_valid_i   ( axi_slave_req_i.w_valid    ),
    .axi_slave_w_data_i    ( axi_slave_req_i.w.data     ),
    .axi_slave_w_strb_i    ( axi_slave_req_i.w.strb     ),
    .axi_slave_w_user_i    ( axi_slave_req_i.w.user     ),
    .axi_slave_w_last_i    ( axi_slave_req_i.w.last     ),
    .axi_slave_w_ready_o   ( axi_slave_resp_o.w_ready   ),

    .axi_slave_r_valid_o   ( axi_slave_resp_o.r_valid   ),
    .axi_slave_r_data_o    ( axi_slave_resp_o.r.data    ),
    .axi_slave_r_resp_o    ( axi_slave_resp_o.r.resp    ),
    .axi_slave_r_last_o    ( axi_slave_resp_o.r.last    ),
    .axi_slave_r_id_o      ( axi_slave_resp_o.r.id      ),
    .axi_slave_r_user_o    ( axi_slave_resp_o.r.user    ),
    .axi_slave_r_ready_i   ( axi_slave_req_i.r_ready    ),

    .axi_slave_b_valid_o   ( axi_slave_resp_o.b_valid   ),
    .axi_slave_b_resp_o    ( axi_slave_resp_o.b.resp    ),
    .axi_slave_b_id_o      ( axi_slave_resp_o.b.id      ),
    .axi_slave_b_user_o    ( axi_slave_resp_o.b.user    ),
    .axi_slave_b_ready_i   ( axi_slave_req_i.b_ready    )
  );

endmodule
