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
 * tcdm_banks_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module tcdm_banks_wrap #(
  parameter int unsigned BankSize   = 256,         //- -> OVERRIDE
  parameter int unsigned NbBanks    = 1,           // --> OVERRIDE
  parameter int unsigned DataWidth  = 32,
  parameter int unsigned AddrWidth  = 32,
  parameter int unsigned BeWidth    = DataWidth/8,
  parameter int unsigned IdWidth    = 1,
  parameter bit          EnableEcc  = 1,
  parameter bit          EccInterco = 0
) (
  input  logic         clk_i,
  input  logic         rst_ni,
  input  logic         test_mode_i,
  // Scrubber
  input  logic         scrub_trigger_i,
  output logic         scrub_fix_o,
  output logic         scrub_uncorrectable_o,
  // ECC
  output logic         ecc_single_error_o,
  output logic         ecc_multile_error_o,
  hci_core_intf.target tcdm_slave[0:NbBanks-1]
);

logic [NbBanks-1:0] ecc_single_error, ecc_multiple_error,
                    scrub_fix, scrub_uncorrectable;

assign ecc_single_error_o = |ecc_single_error;
assign ecc_multiple_error_o = |ecc_multiple_error;
assign scrub_fix_o = |scrub_fix;
assign scrub_uncorrectable_o = |scrub_uncorrectable;
   
for(genvar i=0; i<NbBanks; i++) begin : banks_gen

  // tie r_valid to '1, as HCI interconnect will generate this anyways
  assign tcdm_slave[i].r_valid = '1;

  // tie r_user, r_ecc signals to 0
  assign tcdm_slave[i].r_user = '0;
  assign tcdm_slave[i].r_ecc = '0;

  // tie egnt, r_evalid
  assign tcdm_slave[i].egnt = '1;
  assign tcdm_slave[i].r_evalid = '0;

  // r_id is same as request id -> Don't know if this is needed, but OBI protocol requires it
  logic [IdWidth-1:0] resp_id_d, resp_id_q;
  assign resp_id_d = tcdm_slave[i].id;
  assign tcdm_slave[i].r_id = resp_id_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin : proc_resp_id
    if(~rst_ni) begin
      resp_id_q <= '0;
    end else begin
      resp_id_q <= resp_id_d;
    end
  end

  if (EnableEcc) begin: gen_ecc_banks
    if (EccInterco) begin: gen_ecc_banks_and_connection
    /* TODO: blank for the moment */
    end else begin: gen_ecc_banks_only

      // ecc_sram_wrap assumes a 32-bit address
      logic [31:0] tcdm_slave_add_unroll;
      assign tcdm_slave_add_unroll = 32'b0 | tcdm_slave[i].add;

      ecc_sram_wrap      #(
        .BankSize         ( BankSize   ),
        .InputECC         ( EccInterco ),
        .UnprotectedWidth ( 32         ),
        .ProtectedWidth   ( 39         )
      ) i_ecc_bank             (
        .clk_i                 ( clk_i                  ),
        .rst_ni                ( rst_ni                 ),
        .test_enable_i         ( test_mode_i            ),
        // Scrubber
        .scrub_trigger_i       ( scrub_trigger_i        ),
        .scrubber_fix_o        ( scrub_fix[i]           ),
        .scrub_uncorrectable_o ( scrub_uncorrectable[i] ),
        // TCDM interface
        .tcdm_wdata_i          ( tcdm_slave[i].data     ),
        .tcdm_add_i            ( tcdm_slave_add_unroll  ),
        .tcdm_req_i            ( tcdm_slave[i].req      ),
        .tcdm_wen_i            ( tcdm_slave[i].wen      ),
        .tcdm_be_i             ( tcdm_slave[i].be       ),
        .tcdm_rdata_o          ( tcdm_slave[i].r_data   ),
        .tcdm_gnt_o            ( tcdm_slave[i].gnt      ),
        // ECC
        .single_error_o        ( ecc_single_error[i]    ),
        .multi_error_o         ( ecc_multiple_error[i]  ),
        .test_write_mask_ni    ( '0                     ) // TODO: needed?
      );
    end
  end else begin: gen_standard_banks

    assign tcdm_slave[i].gnt    =  1'b1;
    assign ecc_single_error[i] = 1'b0;
    assign ecc_multiple_error[i] = 1'b0;
    assign scrub_fix[i] = 1'b0;
    assign scrub_uncorrectable[i] = 1'b0;

    tc_sram #(
      .NumWords   (BankSize ), // Number of Words in data array
      .DataWidth  (DataWidth), // Data signal width
      .NumPorts   (1        ), // Number of read and write ports
    `ifndef SYNTHESIS
      .ByteWidth  (8        ), // Width of a data byte
      .SimInit    ("ones"   ), // Simulation initialization
      .PrintSimCfg(0        ),  // Print configuration
    `endif
      .Latency    (1        ) // Latency when the read data is available
    ) i_bank (
      .clk_i  (clk_i                                    ), // Clock
      .rst_ni (rst_ni                                   ), // Asynchronous reset active low
      .req_i  (tcdm_slave[i].req                        ), // request
      .we_i   (~tcdm_slave[i].wen                       ), // write enable
      .addr_i (tcdm_slave[i].add[$clog2(BankSize)+2-1:2]), // request address
      .wdata_i(tcdm_slave[i].data                       ), // write data
      .be_i   (tcdm_slave[i].be                         ), // write byte enable
      .rdata_o(tcdm_slave[i].r_data                     )  // read data
    );
  end

end

endmodule: tcdm_banks_wrap
