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
	 
	 logic                         bank_ce_n;
	 logic                         bank_rdwe_n;
	 logic [3:0]                   bank_be_n;
	 logic [$clog2(BANK_SIZE)-1:0] bank_a;
	 logic [32-1:0]                bank_d;
	 logic [32-1:0]                bank_q;
	 
	 assign bank_a              = tcdm_slave[i].add[$clog2(BANK_SIZE)-1:0];
	 assign bank_d              = tcdm_slave[i].wdata;
	 assign bank_be_n           = ~tcdm_slave[i].be;
	 assign bank_ce_n           = ~tcdm_slave[i].req;
	 assign bank_rdwe_n         = tcdm_slave[i].wen;
	 assign tcdm_slave[i].rdata = bank_q;
	 
	 generic_memory
	   #(
	     .ADDR_WIDTH($clog2(BANK_SIZE))
	     )
	 i_bank 
	   (
	    .CLK       ( clk_i       ),
	    .INITN     ( rst_ni      ),
	    .CEN       ( bank_ce_n   ),
	    .WEN       ( bank_rdwe_n ),
	    .BEN       ( bank_be_n   ),
	    .A         ( bank_a      ),
            .D         ( bank_d      ),
            .Q         ( bank_q      )
	    );
	 
      end
   endgenerate
   
endmodule
