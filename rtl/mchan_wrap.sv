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
 * dmac_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module dmac_wrap
#(
  parameter int unsigned NB_CTRLS           = 2,
  parameter int unsigned NB_CORES           = 8,
  parameter int unsigned NB_OUTSND_BURSTS   = 8,
  parameter int unsigned MCHAN_BURST_LENGTH = 256,
  parameter int unsigned AXI_ADDR_WIDTH     = 32,
  parameter int unsigned AXI_DATA_WIDTH     = 64,
  parameter int unsigned AXI_USER_WIDTH     = 6,
  parameter int unsigned AXI_ID_WIDTH       = 4,
  parameter int unsigned PE_ID_WIDTH        = 1,
  parameter int unsigned TCDM_ADD_WIDTH     = 13,
  parameter int unsigned DATA_WIDTH         = 32,
  parameter int unsigned ADDR_WIDTH         = 32,
  parameter int unsigned BE_WIDTH           = DATA_WIDTH/8,
  parameter type         axi_req_t          = logic,
  parameter type         axi_resp_t         = logic
)
(
  input logic  clk_i,
  input logic  rst_ni,
  input logic  test_mode_i,

  hci_core_intf.target        ctrl_slave[0:NB_CORES-1],
  XBAR_PERIPH_BUS.Slave       pe_ctrl_slave[1:0],

  hci_core_intf.initiator     tcdm_master[3:0],
  output axi_req_t            ext_master_req_o,
  input  axi_resp_t           ext_master_resp_i,
  output logic [1:0]          term_event_pe_o,
  output logic [1:0]          term_irq_pe_o,
  output logic [NB_CORES-1:0] term_event_o,
  output logic [NB_CORES-1:0] term_irq_o,
  output logic                busy_o
);

  //   CORE --> MCHAN CTRL INTERFACE BUS SIGNALS
  logic [NB_CTRLS-1:0][DATA_WIDTH-1:0]  s_ctrl_bus_wdata;
  logic [NB_CTRLS-1:0][ADDR_WIDTH-1:0]  s_ctrl_bus_add;
  logic [NB_CTRLS-1:0]                  s_ctrl_bus_req;
  logic [NB_CTRLS-1:0]                  s_ctrl_bus_wen;
  logic [NB_CTRLS-1:0][BE_WIDTH-1:0]    s_ctrl_bus_be;
  logic [NB_CTRLS-1:0][PE_ID_WIDTH-1:0] s_ctrl_bus_id;
  logic [NB_CTRLS-1:0]                  s_ctrl_bus_gnt;
  logic [NB_CTRLS-1:0][DATA_WIDTH-1:0]  s_ctrl_bus_r_rdata;
  logic [NB_CTRLS-1:0]                  s_ctrl_bus_r_valid;
  logic [NB_CTRLS-1:0]                  s_ctrl_bus_r_opc;
  logic [NB_CTRLS-1:0][PE_ID_WIDTH-1:0] s_ctrl_bus_r_id;


  // MCHAN TCDM INIT --> TCDM MEMORY BUS SIGNALS
  logic [3:0][DATA_WIDTH-1:0] s_tcdm_bus_wdata;
  logic [3:0][ADDR_WIDTH-1:0] s_tcdm_bus_add;
  logic [3:0]                 s_tcdm_bus_req;
  logic [3:0]                 s_tcdm_bus_wen;
  logic [3:0][BE_WIDTH-1:0]   s_tcdm_bus_be;
  logic [3:0]                 s_tcdm_bus_gnt;
  logic [3:0][DATA_WIDTH-1:0] s_tcdm_bus_r_rdata;
  logic [3:0]                 s_tcdm_bus_r_valid;

  // CLUSTER CORE PORT BINDING
  generate
    for (genvar i=0; i<NB_CORES; i++) begin

     assign s_ctrl_bus_add[i]     = ctrl_slave[i].add;
     assign s_ctrl_bus_req[i]     = ctrl_slave[i].req;
     assign s_ctrl_bus_wdata[i]   = ctrl_slave[i].data;
     assign s_ctrl_bus_wen[i]     = ctrl_slave[i].wen;
     assign s_ctrl_bus_be[i]      = ctrl_slave[i].be;
     assign s_ctrl_bus_id[i]      = i;


     assign ctrl_slave[i].gnt     = s_ctrl_bus_gnt[i];
     assign ctrl_slave[i].r_opc   = s_ctrl_bus_r_opc[i];
     assign ctrl_slave[i].r_valid = s_ctrl_bus_r_valid[i];
     assign ctrl_slave[i].r_data = s_ctrl_bus_r_rdata[i];

    end // for (genvar i=0; i<NB_CORES; i++)
  endgenerate

  // // CL CTRL PORT BINDING
  assign s_ctrl_bus_add[NB_CORES]     = pe_ctrl_slave[0].add;
  assign s_ctrl_bus_req[NB_CORES]     = pe_ctrl_slave[0].req;
  assign s_ctrl_bus_wdata[NB_CORES]   = pe_ctrl_slave[0].wdata;
  assign s_ctrl_bus_wen[NB_CORES]     = pe_ctrl_slave[0].wen;
  assign s_ctrl_bus_be[NB_CORES]      = pe_ctrl_slave[0].be;
  assign s_ctrl_bus_id[NB_CORES]      = pe_ctrl_slave[0].id;
  assign pe_ctrl_slave[0].gnt     = s_ctrl_bus_gnt[NB_CORES];
  assign pe_ctrl_slave[0].r_opc   = s_ctrl_bus_r_opc[NB_CORES];
  assign pe_ctrl_slave[0].r_valid = s_ctrl_bus_r_valid[NB_CORES];
  assign pe_ctrl_slave[0].r_rdata = s_ctrl_bus_r_rdata[NB_CORES];
  assign pe_ctrl_slave[0].r_id    = s_ctrl_bus_r_id[NB_CORES];

  // FC CTRL PORT BINDING
  assign s_ctrl_bus_add[NB_CORES+1]     = pe_ctrl_slave[1].add;
  assign s_ctrl_bus_req[NB_CORES+1]     = pe_ctrl_slave[1].req;
  assign s_ctrl_bus_wdata[NB_CORES+1]   = pe_ctrl_slave[1].wdata;
  assign s_ctrl_bus_wen[NB_CORES+1]     = pe_ctrl_slave[1].wen;
  assign s_ctrl_bus_be[NB_CORES+1]      = pe_ctrl_slave[1].be;
  assign s_ctrl_bus_id[NB_CORES+1]      = pe_ctrl_slave[1].id;
  assign pe_ctrl_slave[1].gnt     = s_ctrl_bus_gnt[NB_CORES+1];
  assign pe_ctrl_slave[1].r_opc   = s_ctrl_bus_r_opc[NB_CORES+1];
  assign pe_ctrl_slave[1].r_valid = s_ctrl_bus_r_valid[NB_CORES+1];
  assign pe_ctrl_slave[1].r_rdata = s_ctrl_bus_r_rdata[NB_CORES+1];
  assign pe_ctrl_slave[1].r_id    = s_ctrl_bus_r_id[NB_CORES+1];

  generate
    for (genvar i=0; i<4; i++) begin : TCDM_MASTER_BIND
      assign tcdm_master[i].add      = s_tcdm_bus_add[i];
      assign tcdm_master[i].req      = s_tcdm_bus_req[i];
      assign tcdm_master[i].data     = s_tcdm_bus_wdata[i];
      assign tcdm_master[i].wen      = s_tcdm_bus_wen[i];
      assign tcdm_master[i].be       = s_tcdm_bus_be[i];
      assign tcdm_master[i].r_ready  = '1;
      assign tcdm_master[i].user     = '0;
      assign tcdm_master[i].ecc      = '0;
      assign tcdm_master[i].id       = '0;
      assign tcdm_master[i].ereq     = '0;
      assign tcdm_master[i].r_eready = '1;

      assign s_tcdm_bus_gnt[i]       = tcdm_master[i].gnt;
      assign s_tcdm_bus_r_valid[i]   = tcdm_master[i].r_valid;
      assign s_tcdm_bus_r_rdata[i]   = tcdm_master[i].r_data;
    end
  endgenerate

  mchan #(

    .NB_CTRLS                 ( NB_CTRLS              ),    // NUMBER OF CONTROL PORTS : 8 CORES, CL, FC
    .NB_TRANSFERS             ( 16                    ),
    .GLOBAL_TRANS_QUEUE_DEPTH ( 2*NB_CORES            ),    // DEPTH OF GLOBAL COMMAND QUEUE (CTRL_UNIT)
    .TCDM_ADD_WIDTH           ( TCDM_ADD_WIDTH        ),    // WIDTH OF TCDM ADDRESS
    .EXT_ADD_WIDTH            ( AXI_ADDR_WIDTH        ),    // WIDTH OF GLOBAL EXTERNAL ADDRESS
    .NB_OUTSND_TRANS          ( NB_OUTSND_BURSTS      ),    // NUMBER OF OUTSTANDING TRANSACTIONS
    .MCHAN_BURST_LENGTH       ( MCHAN_BURST_LENGTH    ),    // ANY POWER OF 2 VALUE FROM 32 TO 2048
    .AXI_ADDR_WIDTH           ( AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH           ( AXI_DATA_WIDTH        ),
    .AXI_USER_WIDTH           ( AXI_USER_WIDTH        ),
    .AXI_ID_WIDTH             ( AXI_ID_WIDTH          ),
    .PE_ID_WIDTH              ( PE_ID_WIDTH           )
  ) mchan_i (
    .clk_i                     ( clk_i                              ),
    .rst_ni                    ( rst_ni                             ),
    .test_mode_i               ( test_mode_i                        ),

    .ctrl_targ_req_i           ( s_ctrl_bus_req                     ),
    .ctrl_targ_add_i           ( s_ctrl_bus_add                     ),
    .ctrl_targ_type_i          ( s_ctrl_bus_wen                     ),
    .ctrl_targ_be_i            ( s_ctrl_bus_be                      ),
    .ctrl_targ_data_i          ( s_ctrl_bus_wdata                   ),
    .ctrl_targ_id_i            ( s_ctrl_bus_id                      ),
    .ctrl_targ_gnt_o           ( s_ctrl_bus_gnt                     ),
    .ctrl_targ_r_opc_o         ( s_ctrl_bus_r_opc                   ),
    .ctrl_targ_r_id_o          ( s_ctrl_bus_r_id                    ),

    .ctrl_targ_r_valid_o       ( s_ctrl_bus_r_valid                 ),
    .ctrl_targ_r_data_o        ( s_ctrl_bus_r_rdata                 ),


    // TCDM INITIATOR
      //***************************************
    .tcdm_init_req_o           ( s_tcdm_bus_req                     ),
    .tcdm_init_add_o           ( s_tcdm_bus_add                     ),
    .tcdm_init_type_o          ( s_tcdm_bus_wen                     ),
    .tcdm_init_be_o            ( s_tcdm_bus_be                      ),
    .tcdm_init_data_o          ( s_tcdm_bus_wdata                   ),
    .tcdm_init_sid_o           (                                    ),
    .tcdm_init_gnt_i           ( s_tcdm_bus_gnt                     ),
    .tcdm_init_r_valid_i       ( s_tcdm_bus_r_valid                 ),
    .tcdm_init_r_data_i        ( s_tcdm_bus_r_rdata                 ),

    // EXTERNAL INITIATOR
    //***************************************

    .axi_master_aw_valid_o     ( ext_master_req_o.aw_valid                ),
    .axi_master_aw_addr_o      ( ext_master_req_o.aw.addr                 ),
    .axi_master_aw_prot_o      ( ext_master_req_o.aw.prot                 ),
    .axi_master_aw_region_o    ( ext_master_req_o.aw.region               ),
    .axi_master_aw_len_o       ( ext_master_req_o.aw.len                  ),
    .axi_master_aw_size_o      ( ext_master_req_o.aw.size                 ),
    .axi_master_aw_burst_o     ( ext_master_req_o.aw.burst                ),
    .axi_master_aw_lock_o      ( ext_master_req_o.aw.lock                 ),
    .axi_master_aw_cache_o     ( ext_master_req_o.aw.cache                ),
    .axi_master_aw_qos_o       ( ext_master_req_o.aw.qos                  ),
    .axi_master_aw_id_o        ( ext_master_req_o.aw.id[AXI_ID_WIDTH-1:0] ),
    .axi_master_aw_user_o      ( ext_master_req_o.aw.user                 ),
    .axi_master_aw_ready_i     ( ext_master_resp_i.aw_ready               ),

    .axi_master_ar_valid_o     ( ext_master_req_o.ar_valid                ),
    .axi_master_ar_addr_o      ( ext_master_req_o.ar.addr                 ),
    .axi_master_ar_prot_o      ( ext_master_req_o.ar.prot                 ),
    .axi_master_ar_region_o    ( ext_master_req_o.ar.region               ),
    .axi_master_ar_len_o       ( ext_master_req_o.ar.len                  ),
    .axi_master_ar_size_o      ( ext_master_req_o.ar.size                 ),
    .axi_master_ar_burst_o     ( ext_master_req_o.ar.burst                ),
    .axi_master_ar_lock_o      ( ext_master_req_o.ar.lock                 ),
    .axi_master_ar_cache_o     ( ext_master_req_o.ar.cache                ),
    .axi_master_ar_qos_o       ( ext_master_req_o.ar.qos                  ),
    .axi_master_ar_id_o        ( ext_master_req_o.ar.id[AXI_ID_WIDTH-1:0] ),
    .axi_master_ar_user_o      ( ext_master_req_o.ar.user                 ),
    .axi_master_ar_ready_i     ( ext_master_resp_i.ar_ready               ),

    .axi_master_w_valid_o      ( ext_master_req_o.w_valid                 ),
    .axi_master_w_data_o       ( ext_master_req_o.w.data                  ),
    .axi_master_w_strb_o       ( ext_master_req_o.w.strb                  ),
    .axi_master_w_user_o       ( ext_master_req_o.w.user                  ),
    .axi_master_w_last_o       ( ext_master_req_o.w.last                  ),
    .axi_master_w_ready_i      ( ext_master_resp_i.w_ready                ),

    .axi_master_r_valid_i      ( ext_master_resp_i.r_valid                ),
    .axi_master_r_data_i       ( ext_master_resp_i.r.data                 ),
    .axi_master_r_resp_i       ( ext_master_resp_i.r.resp                 ),
    .axi_master_r_last_i       ( ext_master_resp_i.r.last                 ),
    .axi_master_r_id_i         ( ext_master_resp_i.r.id[AXI_ID_WIDTH-1:0] ),
    .axi_master_r_user_i       ( ext_master_resp_i.r.user                 ),
    .axi_master_r_ready_o      ( ext_master_req_o.r_ready                 ),

    .axi_master_b_valid_i      ( ext_master_resp_i.b_valid                ),
    .axi_master_b_resp_i       ( ext_master_resp_i.b.resp                 ),
    .axi_master_b_id_i         ( ext_master_resp_i.b.id[AXI_ID_WIDTH-1:0] ),
    .axi_master_b_user_i       ( ext_master_resp_i.b.user                 ),
    .axi_master_b_ready_o      ( ext_master_req_o.b_ready                 ),

    .term_evt_o                ( {term_event_pe_o[1],term_event_pe_o[0],term_event_o}     ),
    .term_int_o                ( {term_irq_pe_o[1],term_irq_pe_o[0],term_irq_o      }     ),

    .busy_o                    ( busy_o                             )
  );

  assign ext_master_req_o.aw.atop = '0; 

endmodule
