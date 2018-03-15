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
 * tryx_ctrl.sv
 * Pirmin Vogel <vogelpi@iis.ee.ethz.ch>
 */

`define TRYX_CTRL_BASE_ADDR 32'h1020_0BFC

module tryx_ctrl
  #(
    parameter NB_CORES       = 4,
    parameter AXI_USER_WIDTH = 6
    )
   (
    // clock and reset
    input logic                                     clk_i,
    input logic                                     rst_ni,

    // signals of interest
    output logic [NB_CORES-1:0][AXI_USER_WIDTH-1:0] axi_axuser_o,
    input  logic [NB_CORES-1:0]                     axi_xresp_slverr_i,
    input  logic [NB_CORES-1:0]                     axi_xresp_valid_i,

    // master and slave
    XBAR_PERIPH_BUS.Slave  periph_data_slave[NB_CORES-1:0],
    XBAR_PERIPH_BUS.Master periph_data_master[NB_CORES-1:0]
    );

   // signals
   logic [NB_CORES-1:0][AXI_USER_WIDTH-1:0]         axi_axuser_DN, axi_axuser_DP;
   logic [NB_CORES-1:0]                             axi_xresp_slverr_DN, axi_xresp_slverr_DP;

   logic [NB_CORES-1:0]                             reg_wen_SN, reg_wen_SP; // active low as for the bus
   logic [NB_CORES-1:0]                             reg_re_SN, reg_re_SP;   // active high

   logic [NB_CORES-1:0]                             wait_SN, wait_SP;   // wait for resp

   generate
      for (genvar i=0; i<NB_CORES; i++)
        begin: _TRYX_CTRL_

           // outputs
           assign axi_axuser_o[i] = axi_axuser_DP[i];

           always_comb
             begin: _REQ_ARBITER_

                // PE output
                periph_data_master[i].add   = periph_data_slave[i].add;
                periph_data_master[i].wdata = periph_data_slave[i].wdata;
                periph_data_master[i].be    = periph_data_slave[i].be;

                // reg ctrl
                reg_wen_SN[i] = 1'b1;
                reg_re_SN[i]  = 1'b0;

                if ( periph_data_slave[i].add != `TRYX_CTRL_BASE_ADDR )
                  begin
                     // PE output
                     periph_data_master[i].wen = periph_data_slave[i].wen;
                     periph_data_master[i].req = periph_data_slave[i].req;

                     // PE input
                     periph_data_slave[i].gnt  = periph_data_master[i].gnt;
                  end
                else
                  begin
                     // PE output
                     periph_data_master[i].wen = 1'b1;
                     periph_data_master[i].req = 1'b0;

                     // PE input
                     periph_data_slave[i].gnt  = 1'b1;

                     // reg ctrl
                     if ( periph_data_slave[i].req & !periph_data_slave[i].wen )
                       reg_wen_SN[i] = 1'b0;
                     else if ( periph_data_slave[i].req & periph_data_slave[i].wen & !reg_re_SP[i] )
                       reg_re_SN[i] = 1'b1;
                  end
             end // block: _REQ_ARBITER_

           always_comb
             begin: _RESP_ARBITER_
                if ( !reg_re_SP[i] & reg_wen_SP[i] )
                  begin
                     periph_data_slave[i].r_valid = periph_data_master[i].r_valid;
                     periph_data_slave[i].r_opc   = periph_data_master[i].r_opc;
                     periph_data_slave[i].r_rdata = periph_data_master[i].r_rdata;
                  end
                else
                  begin
                     periph_data_slave[i].r_valid = 1'b1;
                     periph_data_slave[i].r_opc   = 1'b0;
                     periph_data_slave[i].r_rdata = {axi_axuser_DP[i], {(32-AXI_USER_WIDTH-1){1'b0}}, axi_xresp_slverr_DP[i]};
                  end
             end // block: _RESP_ARBITER_

           always_comb
             begin: _TRYX_CTRL_REG_COMB_
                // axi_xresp_slverr
                axi_xresp_slverr_DN[i] = axi_xresp_slverr_DP[i];
                if ( axi_xresp_valid_i[i] == 1'b1 )
                  axi_xresp_slverr_DN[i] = axi_xresp_slverr_i[i];
                else if ( reg_re_SP[i] == 1'b1 ) // clear-on-read
                  axi_xresp_slverr_DN[i] = 1'b0;

                // wait
                wait_SN[i] = wait_SP[i];
                if ( periph_data_master[i].req & periph_data_master[i].gnt ) // request sent
                  wait_SN[i] = 1'b1;
                else if ( wait_SP[i] & periph_data_master[i].r_valid ) // got response
                  wait_SN[i] = 1'b0;

                // axi_axuser
                axi_axuser_DN[i] = axi_axuser_DP[i];
                if ( reg_wen_SN[i] == 1'b0 )
                  axi_axuser_DN[i] = periph_data_slave[i].wdata[31:31-(AXI_USER_WIDTH-1)];
                else if ( wait_SP[i] & !wait_SN[i] ) // valid for one request only
                  axi_axuser_DN[i] = '0;
             end // block: _TRYX_CTRL_REG_COMB_

           always_ff @(posedge clk_i, negedge rst_ni)
             begin: _TRYX_CTRL_REG_SEQ_
                if (rst_ni == 1'b0)
                  begin
                     axi_axuser_DP[i]       <=   '0;
                     axi_xresp_slverr_DP[i] <= 1'b0;
                  end
                else
                  begin
                     axi_axuser_DP[i]       <= axi_axuser_DN[i];
                     axi_xresp_slverr_DP[i] <= axi_xresp_slverr_DN[i];
                  end
             end // block: _TRYX_CTRL_REG_SEQ_

           always_ff @(posedge clk_i, negedge rst_ni)
             begin: _TRYX_CTRL_REG_CTRL_
                if (rst_ni == 1'b0)
                  begin
                     reg_re_SP[i]  <= 1'b0;
                     reg_wen_SP[i] <= 1'b1;
                     wait_SP[i]    <= 1'b0;
                  end
                else
                  begin
                     reg_re_SP[i]  <= reg_re_SN[i];
                     reg_wen_SP[i] <= reg_wen_SN[i];
                     wait_SP[i]    <= wait_SN[i];
                  end
             end
        end // block: _TRYX_CTRL_

   endgenerate

endmodule
