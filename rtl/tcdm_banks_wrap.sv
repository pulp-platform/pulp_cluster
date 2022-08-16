// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
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

module tcdm_banks_wrap
  #(
    parameter int unsigned BANK_SIZE = 256,   //- -> OVERRIDE
    parameter int unsigned NB_BANKS  = 1,     // --> OVERRIDE
    parameter int unsigned RM_SIZE   = 1,     // only for SRAM
    parameter int unsigned WM_SIZE   = 1,     // only for SRAM
    parameter int unsigned BEHAV_MEM = 1,
    parameter int unsigned FPGA_MEM  = 0
    )
   (
    input  logic               clk_i,
    input  logic               rst_ni,
    input  logic               pwdn_i,
    input  logic               test_mode_i,

    TCDM_BANK_MEM_BUS.Slave    tcdm_slave[NB_BANKS-1:0]
    );



   generate
      for (genvar i=0; i<NB_BANKS; i++) begin : l1_tcdm_banks_gen

        tcdm_bank #(
          .BehavMem(BEHAV_MEM),
          .FPGAMem(FPGA_MEM),
          .NumWords(BANK_SIZE), //1024 words
          .DataWidth(32)
        ) i_l1_tcdm_bank (
          .clk_i,
          .rst_ni,
          .req_i (tcdm_slave[i].req),
          .we_i  (~tcdm_slave[i].wen),
          .addr_i(tcdm_slave[i].add[$clog2(BANK_SIZE)-1:0]),
          .wdata_i(tcdm_slave[i].wdata),
          .be_i   (tcdm_slave[i].be),
          .rdata_o(tcdm_slave[i].rdata)
        );
      end
   endgenerate

endmodule
