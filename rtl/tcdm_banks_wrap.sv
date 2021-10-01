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
  parameter BankSize  = 256,         //- -> OVERRIDE
  parameter NbBanks   = 1,           // --> OVERRIDE
  parameter DataWidth = 32,
  parameter AddrWidth = 32,
  parameter BeWidth   = DataWidth/8,
  parameter IdWidth   = 1,
  parameter EccSram   = 0,
  parameter EccIntc   = 0
) (
  input logic        clk_i,
  input logic        rst_ni,
  input logic        test_mode_i,

  hci_mem_intf.slave tcdm_slave[NbBanks-1:0]
);
   
  for(genvar i=0; i<NbBanks; i++) begin : banks_gen

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

    assign tcdm_slave[i].gnt    =  1'b1;
 

    if (!EccSram) begin
      tc_sram #(
        .NumWords   (BankSize ), // Number of Words in data array
        .DataWidth  (DataWidth), // Data signal width
        .ByteWidth  (8        ), // Width of a data byte
        .NumPorts   (1        ), // Number of read and write ports
        .Latency    (1        ), // Latency when the read data is available
        .SimInit    ("ones"   ), // Simulation initialization
        .PrintSimCfg(0        )  // Print configuration
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
    end else if (!EccIntc) begin
      ecc_sram_wrap #(
        .BankSize         ( BankSize ),
        .InputECC         ( EccIntc  ),
        .UnprotectedWidth ( 32       ),
        .ProtectedWidth   ( 39       )
      ) i_ecc_bank (
        .clk_i        ( clk_i                ),
        .rst_ni       ( rst_ni               ),

        .tcdm_wdata_i ( tcdm_slave[i].data   ),
        .tcdm_add_i   ( tcdm_slave[i].add    ),
        .tcdm_req_i   ( tcdm_slave[i].req    ),
        .tcdm_wen_i   ( tcdm_slave[i].wen    ),
        .tcdm_be_i    ( tcdm_slave[i].be     ),
        .tcdm_rdata_o ( tcdm_slave[i].r_data ),
        .tcdm_gnt_o   ( tcdm_slave[i].gnt    )
      );
    end else begin
      ecc_sram_wrap #(
        .BankSize         ( BankSize ),
        .InputECC         ( EccIntc  ),
        .UnprotectedWidth ( 32       ),
        .ProtectedWidth   ( 39       )
      ) i_ecc_bank (
        .clk_i        ( clk_i                                        ),
        .rst_ni       ( rst_ni                                       ),

        .tcdm_wdata_i ( {tcdm_slave[i].user, tcdm_slave[i].data}     ),
        .tcdm_add_i   ( tcdm_slave[i].add                            ),
        .tcdm_req_i   ( tcdm_slave[i].req                            ),
        .tcdm_wen_i   ( tcdm_slave[i].wen                            ),
        .tcdm_be_i    ( tcdm_slave[i].be                             ),
        .tcdm_rdata_o ( {tcdm_slave[i].r_user, tcdm_slave[i].r_data} ),
        .tcdm_gnt_o   ( tcdm_slave[i].gnt                            )
      );
    end

  end

endmodule
