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
  parameter BANK_SIZE = 256,   //- -> OVERRIDE
  parameter NB_BANKS  = 1,     // --> OVERRIDE
  parameter RM_SIZE   = 1,     // only for SRAM
  parameter WM_SIZE   = 1      // only for SRAM
)
(
  input  logic               clk_i,
  input  logic               rst_ni,
  input  logic               init_ni,
  input  logic               pwdn_i,
  input  logic               test_mode_i,
    
  TCDM_BANK_MEM_BUS.Slave    tcdm_slave[NB_BANKS-1:0]
);
   
  generate
    for(genvar i=0; i<NB_BANKS; i++) begin : banks_gen

      logic                  [31:0] wdata;
      logic [$clog2(BANK_SIZE)-1:0] add;
      logic                         csn;
      logic                         wen;
      logic                   [3:0] be;
      logic                  [31:0] rdata;

      assign wdata =  tcdm_slave[i].wdata;
      assign add   =  tcdm_slave[i].add[$clog2(BANK_SIZE)-1:0];
      assign csn   = ~tcdm_slave[i].req;
      assign wen   =  tcdm_slave[i].wen;
      assign be    =  tcdm_slave[i].be;

      SyncSpRamBeNx32 #(
        .ADDR_WIDTH ( $clog2(BANK_SIZE) ),
        .DATA_DEPTH (        BANK_SIZE  ),
        .OUT_REGS   (                0  )
      ) SyncSpRamBeNx32_i (
       .Clk_CI    ( clk_i  ),
       .Rst_RBI   ( rst_ni ),
       .CSel_SI   ( ~csn   ),
       .WrEn_SI   ( ~wen   ),
       .BEn_SI    ( be     ),
       .Addr_DI   ( add    ),
       .WrData_DI ( wdata  ),
       .RdData_DO ( rdata  )
      );

      assign tcdm_slave[i].rdata = rdata;

    end
  endgenerate
   
endmodule
