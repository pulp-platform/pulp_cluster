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

`define XILINX_BRAM_BANK_INSTANCE \
tcdm_bank_i \
( \
  .clka  ( clk_i ), \
  .rsta  ( rsta  ), \
  .ena   ( ena   ), \
  .wea   ( wea   ), \
  .addra ( add   ), \
  .dina  ( wdata ), \
  .douta ( rdata )  \
)

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
    
    hci_mem_intf.slave    tcdm_slave[NB_BANKS-1:0]
   );
   
   generate
      for(genvar i=0; i<NB_BANKS; i++) begin : banks_gen

         `ifndef PULP_FPGA_EMUL
	 logic                         bank_ce_n;
	 logic                         bank_rdwe_n;
	 logic [3:0]                   bank_be_n;
	 logic [$clog2(BANK_SIZE)-1:0] bank_a;
	 logic [32-1:0]                bank_d;
	 logic [32-1:0]                bank_q;

	 assign bank_a              =  tcdm_slave[i].add[$clog2(BANK_SIZE)+2-1:2];
	 assign bank_d              =  tcdm_slave[i].data;
	 assign bank_be_n           = ~tcdm_slave[i].be;
	 assign bank_ce_n           = ~tcdm_slave[i].req;
	 assign bank_rdwe_n         =  tcdm_slave[i].wen;
	 assign tcdm_slave[i].r_data = bank_q;
         assign tcdm_slave[i].gnt    = 1'b1;
         assign tcdm_slave[i].r_id   = '0;
	 
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
         `else // !`ifndef PULP_EMU_FPGA
         /////////////////////////////////////////////////////////////////////////////////////////

         /////////////////////////////////////////////////////////////////////////////////////////
         logic                         rsta;
         logic                         ena;
         logic [31:0]                  wdata;
         logic [$clog2(BANK_SIZE)-1:0] add;
         logic [3:0]                   wea;
         logic [31:0]                  rdata;

         assign rsta  = ~rst_ni;
         assign ena   = 1'b1;
         assign wdata = tcdm_slave[i].wdata;
         assign add   = tcdm_slave[i].add[$clog2(BANK_SIZE)-1:0];
         assign wea   = {4{tcdm_slave[i].req}} & {4{~tcdm_slave[i].wen}} & tcdm_slave[i].be;
         assign tcdm_slave[i].rdata = rdata;

         case(BANK_SIZE)
           128:
             begin : bank_128_gen
                xilinx_tcdm_bank_128x32 `XILINX_BRAM_BANK_INSTANCE;
             end

           256:
             begin : bank_256_gen
                xilinx_tcdm_bank_256x32 `XILINX_BRAM_BANK_INSTANCE;
             end

           512:
             begin : bank_512_gen
                xilinx_tcdm_bank_512x32 `XILINX_BRAM_BANK_INSTANCE;
             end

           1024:
             begin : bank_1024_gen
                xilinx_tcdm_bank_1024x32 `XILINX_BRAM_BANK_INSTANCE;
             end

           2048:
             begin : bank_2048_gen
                xilinx_tcdm_bank_2048x32 `XILINX_BRAM_BANK_INSTANCE;
             end
         endcase // BANK_SIZE
         `endif
      end
   endgenerate

endmodule
