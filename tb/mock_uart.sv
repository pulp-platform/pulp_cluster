// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 28/09/2018
// Description: Mock replacement for UART in testbench (not synthesiesable!)
   
module mock_uart  #(
  parameter int  UART_IDX = 0
 )(
    input  logic          clk_i,
    input  logic          rst_ni,
    input  logic          penable_i,
    input  logic          pwrite_i,
    input  logic [31:0]   paddr_i,
    input  logic          psel_i,
    input  logic [31:0]   pwdata_i,
    output logic [31:0]   prdata_o,
    output logic          pready_o,
    output logic          pslverr_o
);
    localparam RBR = 0;
    localparam THR = 0;
    localparam IER = 1;
    localparam IIR = 2;
    localparam FCR = 2;
    localparam LCR = 3;
    localparam MCR = 4;
    localparam LSR = 5;
    localparam MSR = 6;
    localparam SCR = 7;
    localparam DLL = 0;
    localparam DLM = 1;

    localparam THRE = 5; // transmit holding register empty
    localparam TEMT = 6; // transmit holding register empty

    byte lcr = 0;
    byte dlm = 0;
    byte dll = 0;
    byte mcr = 0;
    byte lsr = 0;
    byte ier = 0;
    byte msr = 0;
    byte scr = 0;
    logic fifo_enabled = 1'b0;

    integer charnum = 0;
    logic [256*8-1:0] stringa = '0;

    assign pready_o = 1'b1;
    assign pslverr_o = 1'b0;

    function void uart_tx(byte ch);
        if(ch==8'h0A) begin
          $display("[TB UART %2d] %s", UART_IDX, stringa);        
          charnum = 0;
          stringa = '0;
        end else begin
          stringa[(255-charnum)*8 +: 8] = ch;
          charnum = charnum + 1;
        end
    endfunction : uart_tx

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (rst_ni) begin
            if (psel_i & penable_i & pwrite_i) begin
                case ((paddr_i >> 'h2) & 'h7)
                    THR: begin
                        if (lcr & 'h80) dll <= byte'(pwdata_i[7:0]);
                        else begin
                           uart_tx(byte'(pwdata_i[7:0]));
                        end
                    end
                    IER: begin
                        if (lcr & 'h80) dlm <= byte'(pwdata_i[7:0]);
                        else ier <= byte'(pwdata_i[7:0] & 'hF);
                    end
                    FCR: begin
                        if (pwdata_i[0]) fifo_enabled <= 1'b1;
                        else fifo_enabled <= 1'b0;
                    end
                    LCR: lcr <= byte'(pwdata_i[7:0]);
                    MCR: mcr <= byte'(pwdata_i[7:0] & 'h1F);
                    LSR: lsr <= byte'(pwdata_i[7:0]);
                    MSR: msr <= byte'(pwdata_i[7:0]);
                    SCR: scr <= byte'(pwdata_i[7:0]);
                    default:;
                endcase
            end
        end
    end

    always_comb begin
        prdata_o = '0;
        if (psel_i & penable_i & ~pwrite_i) begin
            case ((paddr_i >> 'h2) & 'h7)
                THR: begin
                    if (lcr & 'h80) prdata_o = {24'b0, dll};
                end
                IER: begin
                    if (lcr & 'h80) prdata_o = {24'b0, dlm};
                    else prdata_o = {24'b0, ier};
                end
                IIR: begin
                    if (fifo_enabled) prdata_o = {24'b0, 8'hc0};
                    else prdata_o = {24'b0, 8'b0};
                end
                LCR: prdata_o = {24'b0, lcr};
                MCR: prdata_o = {24'b0, mcr};
                LSR: prdata_o = {24'b0, (lsr | (1 << THRE) | (1 << TEMT))};
                MSR: prdata_o = {24'b0, msr};
                SCR: prdata_o = {24'b0, scr};
                default:;
            endcase
        end
    end
endmodule
