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
 * per2axi_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module per2axi_wrap
#(
  parameter int unsigned NB_CORES       = 4,
  parameter int unsigned PER_ADDR_WIDTH = 32,
  parameter int unsigned PER_ID_WIDTH   = 5,
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 64,
  parameter int unsigned AXI_USER_WIDTH = 6,
  parameter int unsigned AXI_ID_WIDTH   = 4,
  parameter int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH/8,
  parameter int unsigned ID_WIDTH       = PER_ID_WIDTH // required for XBAR_PERIPH_BUS interface
)
(
  input logic	          clk_i,
  input logic	          rst_ni,
  input logic           test_en_i,
  XBAR_PERIPH_BUS.Slave periph_slave,
  AXI_BUS.Master        axi_master,
  output logic          busy_o
);

  per2axi #(
    .NB_CORES           ( NB_CORES        ),
    .PER_ADDR_WIDTH     ( PER_ADDR_WIDTH  ),
    .PER_ID_WIDTH       ( PER_ID_WIDTH    ),
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH  ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH  ),
    .AXI_ID_WIDTH       ( AXI_ID_WIDTH    )
  ) per2axi_i (
    .clk_i                  ( clk_i                               ),
    .rst_ni                 ( rst_ni                              ),
    .test_en_i              ( test_en_i                           ),

    .per_slave_req_i        ( periph_slave.req                    ),
    .per_slave_add_i        ( periph_slave.add                    ),
    .per_slave_we_i         ( periph_slave.wen                    ),
    .per_slave_wdata_i      ( periph_slave.wdata                  ),
    .per_slave_be_i         ( periph_slave.be                     ),
    .per_slave_id_i         ( periph_slave.id[PER_ID_WIDTH-1:0]   ),
    .per_slave_gnt_o        ( periph_slave.gnt                    ),

    .per_slave_r_valid_o    ( periph_slave.r_valid                ),
    .per_slave_r_opc_o      ( periph_slave.r_opc                  ),
    .per_slave_r_id_o       ( periph_slave.r_id[PER_ID_WIDTH-1:0] ),
    .per_slave_r_rdata_o    ( periph_slave.r_rdata                ),

    .axi_master_aw_valid_o  ( axi_master.aw_valid                 ),
    .axi_master_aw_addr_o   ( axi_master.aw_addr                  ),
    .axi_master_aw_prot_o   ( axi_master.aw_prot                  ),
    .axi_master_aw_region_o ( axi_master.aw_region                ),
    .axi_master_aw_len_o    ( axi_master.aw_len                   ),
    .axi_master_aw_size_o   ( axi_master.aw_size                  ),
    .axi_master_aw_burst_o  ( axi_master.aw_burst                 ),
    .axi_master_aw_lock_o   ( axi_master.aw_lock                  ),
    .axi_master_aw_cache_o  ( axi_master.aw_cache                 ),
    .axi_master_aw_qos_o    ( axi_master.aw_qos                   ),
    .axi_master_aw_id_o     ( axi_master.aw_id[AXI_ID_WIDTH-1:0]  ),
    .axi_master_aw_user_o   ( axi_master.aw_user                  ),
    .axi_master_aw_ready_i  ( axi_master.aw_ready                 ),
                                                                  
    .axi_master_ar_valid_o  ( axi_master.ar_valid                 ),
    .axi_master_ar_addr_o   ( axi_master.ar_addr                  ),
    .axi_master_ar_prot_o   ( axi_master.ar_prot                  ),
    .axi_master_ar_region_o ( axi_master.ar_region                ),
    .axi_master_ar_len_o    ( axi_master.ar_len                   ),
    .axi_master_ar_size_o   ( axi_master.ar_size                  ),
    .axi_master_ar_burst_o  ( axi_master.ar_burst                 ),
    .axi_master_ar_lock_o   ( axi_master.ar_lock                  ),
    .axi_master_ar_cache_o  ( axi_master.ar_cache                 ),
    .axi_master_ar_qos_o    ( axi_master.ar_qos                   ),
    .axi_master_ar_id_o     ( axi_master.ar_id[AXI_ID_WIDTH-1:0]  ),
    .axi_master_ar_user_o   ( axi_master.ar_user                  ),
    .axi_master_ar_ready_i  ( axi_master.ar_ready                 ),

    .axi_master_w_valid_o   ( axi_master.w_valid                  ),
    .axi_master_w_data_o    ( axi_master.w_data                   ),
    .axi_master_w_strb_o    ( axi_master.w_strb                   ),
    .axi_master_w_user_o    ( axi_master.w_user                   ),
    .axi_master_w_last_o    ( axi_master.w_last                   ),
    .axi_master_w_ready_i   ( axi_master.w_ready                  ),

    .axi_master_r_valid_i   ( axi_master.r_valid                  ),
    .axi_master_r_data_i    ( axi_master.r_data                   ),
    .axi_master_r_resp_i    ( axi_master.r_resp                   ),
    .axi_master_r_last_i    ( axi_master.r_last                   ),
    .axi_master_r_id_i      ( axi_master.r_id[AXI_ID_WIDTH-1:0]   ),
    .axi_master_r_user_i    ( axi_master.r_user                   ),
    .axi_master_r_ready_o   ( axi_master.r_ready                  ),

    .axi_master_b_valid_i   ( axi_master.b_valid                  ),
    .axi_master_b_resp_i    ( axi_master.b_resp                   ),
    .axi_master_b_id_i      ( axi_master.b_id[AXI_ID_WIDTH-1:0]   ),
    .axi_master_b_user_i    ( axi_master.b_user                   ),
    .axi_master_b_ready_o   ( axi_master.b_ready                  ),

    .busy_o                 ( busy_o                              )
  );

  assign axi_master.aw_atop = '0; 

endmodule
