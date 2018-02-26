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
 * cluster_timer_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module cluster_timer_wrap
  #(
    parameter ID_WIDTH  = 2
    )
   (
    input  logic          clk_i,
    input  logic          rst_ni,
    input  logic          ref_clk_i,
    
    XBAR_PERIPH_BUS.Slave periph_slave,
    
    input  logic          event_lo_i,
    input  logic          event_hi_i,
    
    output logic          irq_lo_o,
    output logic          irq_hi_o,
    
    output logic          busy_o
    );
   
   timer_unit
     #(
       .ID_WIDTH        ( ID_WIDTH             )
       )
   timer_unit_i
     (
      .clk_i            ( clk_i                ),
      .rst_ni           ( rst_ni               ),
      .ref_clk_i        ( ref_clk_i            ),
      
      .req_i            ( periph_slave.req     ),
      .addr_i           ( periph_slave.add     ),
      .wen_i            ( periph_slave.wen     ),
      .wdata_i          ( periph_slave.wdata   ),
      .be_i             ( periph_slave.be      ),
      .id_i             ( periph_slave.id      ),
      .gnt_o            ( periph_slave.gnt     ),
      
      .r_valid_o        ( periph_slave.r_valid ),
      .r_opc_o          ( periph_slave.r_opc   ),
      .r_id_o           ( periph_slave.r_id    ),
      .r_rdata_o        ( periph_slave.r_rdata ),
      
      .event_lo_i       ( event_lo_i           ),
      .event_hi_i       ( event_hi_i           ),
      
      .irq_lo_o         ( irq_lo_o             ),
      .irq_hi_o         ( irq_hi_o             ),
      
      .busy_o           ( busy_o               )
      );
   
endmodule
