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
 * axi2per_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module axi2per_wrap
#(
  parameter int unsigned PER_ADDR_WIDTH = 32,
  parameter int unsigned PER_ID_WIDTH   = 5,
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 64,
  parameter int unsigned AXI_USER_WIDTH = 6,
  parameter int unsigned AXI_ID_WIDTH   = 6,
  parameter int unsigned BUFFER_DEPTH   = 2,
  parameter int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH/8,
  parameter type         axi_req_t      = logic,
  parameter type         axi_resp_t     = logic
)
(
  input  logic         clk_i,
  input  logic         rst_ni,
  input  logic         test_en_i,
  input  axi_req_t     axi_slave_req_i,
  output axi_resp_t    axi_slave_resp_o,
  XBAR_TCDM_BUS.Master periph_master,
  output logic         busy_o
);

  axi2per #(
    .PER_ADDR_WIDTH        ( PER_ADDR_WIDTH        ),
    .PER_ID_WIDTH          ( PER_ID_WIDTH          ),
    .AXI_ADDR_WIDTH        ( AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH        ( AXI_DATA_WIDTH        ),
    .AXI_USER_WIDTH        ( AXI_USER_WIDTH        ),
    .AXI_ID_WIDTH          ( AXI_ID_WIDTH          ),
    .BUFFER_DEPTH          ( BUFFER_DEPTH          )
  ) axi2per_i (
    .clk_i                 ( clk_i                 ),
    .rst_ni                ( rst_ni                ),
    .test_en_i             ( test_en_i             ),

    .axi_slave_aw_valid_i  ( axi_slave_req_i.aw_valid    ),
    .axi_slave_aw_addr_i   ( axi_slave_req_i.aw.addr     ),
    .axi_slave_aw_prot_i   ( axi_slave_req_i.aw.prot     ),
    .axi_slave_aw_region_i ( axi_slave_req_i.aw.region   ),
    .axi_slave_aw_len_i    ( axi_slave_req_i.aw.len      ),
    .axi_slave_aw_size_i   ( axi_slave_req_i.aw.size     ),
    .axi_slave_aw_burst_i  ( axi_slave_req_i.aw.burst    ),
    .axi_slave_aw_lock_i   ( axi_slave_req_i.aw.lock     ),
    .axi_slave_aw_cache_i  ( axi_slave_req_i.aw.cache    ),
    .axi_slave_aw_qos_i    ( axi_slave_req_i.aw.qos      ),
    .axi_slave_aw_id_i     ( axi_slave_req_i.aw.id       ),
    .axi_slave_aw_user_i   ( axi_slave_req_i.aw.user     ),
    .axi_slave_aw_ready_o  ( axi_slave_resp_o.aw_ready   ),

    .axi_slave_ar_valid_i  ( axi_slave_req_i.ar_valid    ),
    .axi_slave_ar_addr_i   ( axi_slave_req_i.ar.addr     ),
    .axi_slave_ar_prot_i   ( axi_slave_req_i.ar.prot     ),
    .axi_slave_ar_region_i ( axi_slave_req_i.ar.region   ),
    .axi_slave_ar_len_i    ( axi_slave_req_i.ar.len      ),
    .axi_slave_ar_size_i   ( axi_slave_req_i.ar.size     ),
    .axi_slave_ar_burst_i  ( axi_slave_req_i.ar.burst    ),
    .axi_slave_ar_lock_i   ( axi_slave_req_i.ar.lock     ),
    .axi_slave_ar_cache_i  ( axi_slave_req_i.ar.cache    ),
    .axi_slave_ar_qos_i    ( axi_slave_req_i.ar.qos      ),
    .axi_slave_ar_id_i     ( axi_slave_req_i.ar.id       ),
    .axi_slave_ar_user_i   ( axi_slave_req_i.ar.user     ),
    .axi_slave_ar_ready_o  ( axi_slave_resp_o.ar_ready   ),

    .axi_slave_w_valid_i   ( axi_slave_req_i.w_valid     ),
    .axi_slave_w_data_i    ( axi_slave_req_i.w.data      ),
    .axi_slave_w_strb_i    ( axi_slave_req_i.w.strb      ),
    .axi_slave_w_user_i    ( axi_slave_req_i.w.user      ),
    .axi_slave_w_last_i    ( axi_slave_req_i.w.last      ),
    .axi_slave_w_ready_o   ( axi_slave_resp_o.w_ready    ),

    .axi_slave_r_valid_o   ( axi_slave_resp_o.r_valid    ),
    .axi_slave_r_data_o    ( axi_slave_resp_o.r.data     ),
    .axi_slave_r_resp_o    ( axi_slave_resp_o.r.resp     ),
    .axi_slave_r_last_o    ( axi_slave_resp_o.r.last     ),
    .axi_slave_r_id_o      ( axi_slave_resp_o.r.id       ),
    .axi_slave_r_user_o    ( axi_slave_resp_o.r.user     ),
    .axi_slave_r_ready_i   ( axi_slave_req_i.r_ready     ),

    .axi_slave_b_valid_o   ( axi_slave_resp_o.b_valid    ),
    .axi_slave_b_resp_o    ( axi_slave_resp_o.b.resp     ),
    .axi_slave_b_id_o      ( axi_slave_resp_o.b.id       ),
    .axi_slave_b_user_o    ( axi_slave_resp_o.b.user     ),
    .axi_slave_b_ready_i   ( axi_slave_req_i.b_ready     ),

    .per_master_req_o      ( periph_master.req     ),
    .per_master_add_o      ( periph_master.add     ),
    .per_master_we_no      ( periph_master.wen     ),
    .per_master_wdata_o    ( periph_master.wdata   ),
    .per_master_be_o       ( periph_master.be      ),
    .per_master_gnt_i      ( periph_master.gnt     ),

    .per_master_r_valid_i  ( periph_master.r_valid ),
    .per_master_r_opc_i    ( periph_master.r_opc   ),
    .per_master_r_rdata_i  ( periph_master.r_rdata ),

    .busy_o(busy_o)
  );
  
endmodule
