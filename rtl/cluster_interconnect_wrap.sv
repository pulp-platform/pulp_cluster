/*
 * Copyright (C) 2013-2017 ETH Zurich, University of Bologna
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished 
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Bug fixes and contributions will eventually be released under the
 * SolderPad open hardware license in the context of the PULP platform
 * (http://www.pulp-platform.org), under the copyright of ETH Zurich and the
 * University of Bologna.
 */
 
`include "pulp_soc_defines.sv"

module cluster_interconnect_wrap
#(
    parameter NB_CORES        = 8,
    parameter NB_HWACC_PORTS  = 4,
    parameter NB_DMAS         = 4,
    parameter NB_MPERIPHS     = 1,
    parameter NB_TCDM_BANKS   = 16,
    parameter NB_SPERIPHS     = 8, //differ

    parameter DATA_WIDTH      = 32,
    parameter ADDR_WIDTH      = 32,
    parameter BE_WIDTH        = DATA_WIDTH/8,

    //TCDM PARAMETERS
    parameter TEST_SET_BIT    = 20,
    parameter ADDR_MEM_WIDTH  = 11,   
    parameter LOG_CLUSTER     = 5,
    parameter PE_ROUTING_LSB  = 16,
    parameter PE_ROUTING_MSB  = PE_ROUTING_LSB+$clog2(NB_SPERIPHS)-1, //differ
    parameter CLUSTER_ALIAS_BASE = 12'h000
)
(
    input logic                          clk_i,
    input logic                          rst_ni,
    XBAR_TCDM_BUS.Slave                  core_tcdm_slave[NB_CORES+NB_HWACC_PORTS-1:0],
    XBAR_PERIPH_BUS.Slave                core_periph_slave[NB_CORES-1:0],
    XBAR_TCDM_BUS.Slave                  ext_slave[NB_DMAS-1:0],
    XBAR_TCDM_BUS.Slave                  dma_slave[NB_DMAS-1:0], //FIXME IGOR --> check NB_CORES depend ASK DAVIDE
    XBAR_TCDM_BUS.Slave                  mperiph_slave[NB_MPERIPHS-1:0],
    TCDM_BANK_MEM_BUS.Master             tcdm_sram_master[NB_TCDM_BANKS-1:0],
    XBAR_PERIPH_BUS.Master               speriph_master[NB_SPERIPHS-1:0],
    input logic [1:0]                    TCDM_arb_policy_i
);

   localparam TCDM_ID_WIDTH  = NB_CORES+NB_DMAS+4+NB_HWACC_PORTS;

   // DMA --> LOGARITHMIC INTERCONNECT BUS SIGNALS
   logic [4+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_wdata;
   logic [4+NB_DMAS-1:0][ADDR_WIDTH-1:0]              s_dma_bus_add;
   logic [4+NB_DMAS-1:0]                              s_dma_bus_req;
   logic [4+NB_DMAS-1:0]                              s_dma_bus_wen;
   logic [4+NB_DMAS-1:0][BE_WIDTH-1:0]                s_dma_bus_be;
   logic [4+NB_DMAS-1:0]                              s_dma_bus_gnt;
   logic [4+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_r_rdata;
   logic [4+NB_DMAS-1:0]                              s_dma_bus_r_valid;

   // MASTER PRTIPHERALS --> PERIPHERAL INTERCONNECT BUS SIGNALS
   logic [NB_MPERIPHS-1:0][DATA_WIDTH-1:0]            s_mperiph_bus_wdata;
   logic [NB_MPERIPHS-1:0][ADDR_WIDTH-1:0]            s_mperiph_bus_add;
   logic [NB_MPERIPHS-1:0]                            s_mperiph_bus_req;
   logic [NB_MPERIPHS-1:0]                            s_mperiph_bus_wen;
   logic [NB_MPERIPHS-1:0][BE_WIDTH-1:0]              s_mperiph_bus_be;
   logic [NB_MPERIPHS-1:0]                            s_mperiph_bus_gnt;
   logic [NB_MPERIPHS-1:0]                            s_mperiph_bus_r_opc;
   logic [NB_MPERIPHS-1:0][DATA_WIDTH-1:0]            s_mperiph_bus_r_rdata;
   logic [NB_MPERIPHS-1:0]                            s_mperiph_bus_r_valid;

   // DEMUX --> LOGARITHMIC INTERCONNECT BUS SIGNALS
   logic [NB_CORES+NB_HWACC_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_wdata;
   logic [NB_CORES+NB_HWACC_PORTS-1:0][ADDR_WIDTH-1:0] s_core_tcdm_bus_add;
   logic [NB_CORES+NB_HWACC_PORTS-1:0]                 s_core_tcdm_bus_req;
   logic [NB_CORES+NB_HWACC_PORTS-1:0]                 s_core_tcdm_bus_wen;
   logic [NB_CORES+NB_HWACC_PORTS-1:0][BE_WIDTH-1:0]   s_core_tcdm_bus_be;
   logic [NB_CORES+NB_HWACC_PORTS-1:0]                 s_core_tcdm_bus_gnt;
   logic [NB_CORES+NB_HWACC_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_r_rdata;
   logic [NB_CORES+NB_HWACC_PORTS-1:0]                 s_core_tcdm_bus_r_valid;

   // DEMUX -->  PERIPHERAL INTERCONNECT BUS SIGNALS
   logic [NB_CORES-1:0][ADDR_WIDTH-1:0]               s_core_periph_bus_add;
   logic [NB_CORES-1:0]                               s_core_periph_bus_req;
   logic [NB_CORES-1:0][DATA_WIDTH-1:0]               s_core_periph_bus_wdata;
   logic [NB_CORES-1:0]                               s_core_periph_bus_wen;
   logic [NB_CORES-1:0][BE_WIDTH-1:0]                 s_core_periph_bus_be;
   logic [NB_CORES-1:0]                               s_core_periph_bus_gnt;
   logic [NB_CORES-1:0]                               s_core_periph_bus_r_opc;
   logic [NB_CORES-1:0]                               s_core_periph_bus_r_valid;
   logic [NB_CORES-1:0][DATA_WIDTH-1:0]               s_core_periph_bus_r_rdata;

   // LOGARITHMIC INTERCONNECT --> SRAM TCDM BUS SIGNALS
   logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]          s_tcdm_bus_sram_wdata;
   logic [NB_TCDM_BANKS-1:0][ADDR_MEM_WIDTH-1:0]      s_tcdm_bus_sram_add;
   logic [NB_TCDM_BANKS-1:0]                          s_tcdm_bus_sram_req;
   logic [NB_TCDM_BANKS-1:0]                          s_tcdm_bus_sram_wen;
   logic [NB_TCDM_BANKS-1:0][BE_WIDTH-1:0]            s_tcdm_bus_sram_be;
   logic [NB_TCDM_BANKS-1:0][TCDM_ID_WIDTH-1:0]       s_tcdm_bus_sram_ID;
   logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]          s_tcdm_bus_sram_rdata;
   logic [NB_TCDM_BANKS-1:0]                          s_tcdm_bus_sram_rvalid;
   logic [NB_TCDM_BANKS-1:0][TCDM_ID_WIDTH-1:0]       s_tcdm_bus_sram_rID;
   logic [NB_TCDM_BANKS-1:0]                          s_data_ts_set_int;
   logic [NB_TCDM_BANKS-1:0]                          s_data_ts_set_q;
   
   // PERIPHERAL INTERCONNECT INTERCONNECT --> SLAVE PERIPHERALS BUS SIGNALS
   logic [NB_SPERIPHS-1:0][DATA_WIDTH-1:0]            s_speriph_bus_wdata;
   logic [NB_SPERIPHS-1:0][ADDR_WIDTH-1:0]            s_speriph_bus_add;
   logic [NB_SPERIPHS-1:0]                            s_speriph_bus_req;
   logic [NB_SPERIPHS-1:0]                            s_speriph_bus_wen;
   logic [NB_SPERIPHS-1:0][BE_WIDTH-1:0]              s_speriph_bus_be;
   logic [NB_SPERIPHS-1:0][NB_CORES+NB_MPERIPHS-1:0]  s_speriph_bus_id;
   logic [NB_SPERIPHS-1:0]                            s_speriph_bus_gnt;
   logic [NB_SPERIPHS-1:0]                            s_speriph_bus_r_opc;
   logic [NB_SPERIPHS-1:0][NB_CORES+NB_MPERIPHS-1:0]  s_speriph_bus_r_id;
   logic [NB_SPERIPHS-1:0][DATA_WIDTH-1:0]            s_speriph_bus_r_rdata;
   logic [NB_SPERIPHS-1:0]                            s_speriph_bus_r_valid;

   //********************************************************
   //****** BINDING INTERFACES TO INTERNAL BUS SINGALS ******
   //********************************************************
   genvar i;

   generate

      for (i=0; i<NB_CORES; i++)

      begin : CORE_PERIPH_BIND
         assign s_core_periph_bus_add[i]      =  core_periph_slave[i].add;
         assign s_core_periph_bus_req[i]      =  core_periph_slave[i].req;
         assign s_core_periph_bus_wdata[i]    =  core_periph_slave[i].wdata;
         assign s_core_periph_bus_wen[i]      =  core_periph_slave[i].wen;
         assign s_core_periph_bus_be[i]       =  core_periph_slave[i].be;

         assign core_periph_slave[i].gnt      =  s_core_periph_bus_gnt[i];
         assign core_periph_slave[i].r_opc    =  s_core_periph_bus_r_opc[i];
         assign core_periph_slave[i].r_valid  =  s_core_periph_bus_r_valid[i];
         assign core_periph_slave[i].r_rdata  =  s_core_periph_bus_r_rdata[i];
      end // block: CORE_PERIPH_BIND

   endgenerate

   generate

      for (i=0; i<NB_CORES+NB_HWACC_PORTS; i++)

      begin : CORE_TCDM_BIND
         assign s_core_tcdm_bus_add[i]      = core_tcdm_slave[i].add;
         assign s_core_tcdm_bus_req[i]      = core_tcdm_slave[i].req;
         assign s_core_tcdm_bus_wdata[i]    = core_tcdm_slave[i].wdata;
         assign s_core_tcdm_bus_wen[i]      = core_tcdm_slave[i].wen;
         assign s_core_tcdm_bus_be[i]       = core_tcdm_slave[i].be;

         assign core_tcdm_slave[i].gnt      = s_core_tcdm_bus_gnt[i];
         assign core_tcdm_slave[i].r_valid  = s_core_tcdm_bus_r_valid[i];
         assign core_tcdm_slave[i].r_rdata  = s_core_tcdm_bus_r_rdata[i];
      end // block: CORE_TCDM_BIND

   endgenerate

   generate

      for (i=0; i<NB_DMAS; i++)
      begin : AXI2MEM_BIND
         assign s_dma_bus_add[i]      = ext_slave[i].add;
         assign s_dma_bus_req[i]      = ext_slave[i].req;
         assign s_dma_bus_wdata[i]    = ext_slave[i].wdata;
         assign s_dma_bus_wen[i]      = ext_slave[i].wen;
         assign s_dma_bus_be[i]       = ext_slave[i].be;

         assign ext_slave[i].gnt      = s_dma_bus_gnt[i];
         assign ext_slave[i].r_valid  = s_dma_bus_r_valid[i];
         assign ext_slave[i].r_rdata  = s_dma_bus_r_rdata[i];
      end

   endgenerate

   generate

      for (i=0; i<NB_DMAS; i++)  //4 takes into account the 4 ports used in axi2mem
      begin : DMAS_BIND
         assign s_dma_bus_add[i+4]    = dma_slave[i].add;
         assign s_dma_bus_req[i+4]    = dma_slave[i].req;
         assign s_dma_bus_wdata[i+4]  = dma_slave[i].wdata;
         assign s_dma_bus_wen[i+4]    = dma_slave[i].wen;
         assign s_dma_bus_be[i+4]     = dma_slave[i].be;

         assign dma_slave[i].gnt      = s_dma_bus_gnt[i+NB_DMAS];
         assign dma_slave[i].r_valid  = s_dma_bus_r_valid[i+NB_DMAS];
         assign dma_slave[i].r_rdata  = s_dma_bus_r_rdata[i+NB_DMAS];
      end
   endgenerate

   generate

      for (i=0; i<NB_MPERIPHS; i++)

      begin : MPERIPHS_BIND
         assign s_mperiph_bus_add[i]      = mperiph_slave[i].add;
         assign s_mperiph_bus_req[i]      = mperiph_slave[i].req;
         assign s_mperiph_bus_wdata[i]    = mperiph_slave[i].wdata;
         assign s_mperiph_bus_wen[i]      = mperiph_slave[i].wen;
         assign s_mperiph_bus_be[i]       = mperiph_slave[i].be;

         assign mperiph_slave[i].gnt      = s_mperiph_bus_gnt[i];
         assign mperiph_slave[i].r_opc    = s_mperiph_bus_r_opc[i];
         assign mperiph_slave[i].r_valid  = s_mperiph_bus_r_valid[i];
         assign mperiph_slave[i].r_rdata  = s_mperiph_bus_r_rdata[i];
      end // block: MPERIPHS_BIND

   endgenerate

   generate
      for (i=0; i<NB_TCDM_BANKS; i++)
      begin : TCDM_BANKS_BIND
         assign tcdm_sram_master[i].req   = s_tcdm_bus_sram_req   [i];
         assign tcdm_sram_master[i].add   = s_tcdm_bus_sram_add   [i];
         assign tcdm_sram_master[i].wen   = s_tcdm_bus_sram_wen   [i];
         assign tcdm_sram_master[i].wdata = s_tcdm_bus_sram_wdata [i];
         assign tcdm_sram_master[i].be    = s_tcdm_bus_sram_be    [i];
         assign s_tcdm_bus_sram_rdata[i]  = tcdm_sram_master[i].rdata;


         always_ff @(posedge clk_i or negedge rst_ni) 
         begin : TCDM_BANKS_RESP
            if(~rst_ni)
            begin
               s_tcdm_bus_sram_rID[i]    <= '0;
               s_tcdm_bus_sram_rvalid[i] <= 1'b0;
               s_data_ts_set_q[i]         <= '0;
            end
            else 
            begin
               s_data_ts_set_q[i]        <= s_data_ts_set_int[i];
                                                  // NORMAL MODE//                                                                       // DURING SET
               s_tcdm_bus_sram_rvalid[i] <= ( s_tcdm_bus_sram_req[i] & ~s_data_ts_set_int[i]  & ~s_data_ts_set_q[i] ) | (s_tcdm_bus_sram_req[i] & ~s_data_ts_set_int[i]  & s_data_ts_set_q[i] );
               if(s_tcdm_bus_sram_req[i])
                  s_tcdm_bus_sram_rID[i] <= s_tcdm_bus_sram_ID[i];
            end
         end

      end // block: TCDM_BANKS_BIND
   endgenerate


   generate
      for (i=0; i<NB_SPERIPHS; i++)
      begin : SPERIPHS_BIND
         assign speriph_master[i].add       = s_speriph_bus_add[i];
         assign speriph_master[i].req       = s_speriph_bus_req[i];
         assign speriph_master[i].wdata     = s_speriph_bus_wdata[i];
         assign speriph_master[i].wen       = s_speriph_bus_wen[i];
         assign speriph_master[i].be        = s_speriph_bus_be[i];
         assign speriph_master[i].id        = s_speriph_bus_id[i];

         assign s_speriph_bus_gnt[i]        = speriph_master[i].gnt;
         assign s_speriph_bus_r_id[i]       = speriph_master[i].r_id;
         assign s_speriph_bus_r_opc[i]      = speriph_master[i].r_opc;
         assign s_speriph_bus_r_valid[i]    = speriph_master[i].r_valid;
         assign s_speriph_bus_r_rdata[i]    = speriph_master[i].r_rdata;
      end // block: SPERIPHS_BIND

   endgenerate



   //-********************************************************
   //-*********** LOGARITHMIC INTERCONNECT TO TCDM ***********
   //-********************************************************
    XBAR_TCDM
    #(
      .N_CH0           ( NB_CORES+NB_HWACC_PORTS            ),
      .N_CH1           ( NB_DMAS+4                          ),
      .N_SLAVE         ( NB_TCDM_BANKS                      ),
      .ID_WIDTH        ( TCDM_ID_WIDTH                      ),

      //FRONT END PARAMS
      .ADDR_WIDTH      ( ADDR_WIDTH                         ),
      .DATA_WIDTH      ( DATA_WIDTH                         ),
      .BE_WIDTH        ( BE_WIDTH                           ),
      .TEST_SET_BIT    ( TEST_SET_BIT                       ),

      .ADDR_MEM_WIDTH  ( ADDR_MEM_WIDTH                     )
    )
    i_XBAR_TCDM
    (
      // ---------------- MASTER CH0+CH1 SIDE  --------------------------
      .data_req_i          (  {s_dma_bus_req,     s_core_tcdm_bus_req}      ),
      .data_add_i          (  {s_dma_bus_add,     s_core_tcdm_bus_add}      ),
      .data_wen_i          (  {s_dma_bus_wen,     s_core_tcdm_bus_wen}      ),
      .data_wdata_i        (  {s_dma_bus_wdata,   s_core_tcdm_bus_wdata}    ),
      .data_be_i           (  {s_dma_bus_be,      s_core_tcdm_bus_be}       ),
      .data_gnt_o          (  {s_dma_bus_gnt,     s_core_tcdm_bus_gnt}      ),  
      .data_r_valid_o      (  {s_dma_bus_r_valid, s_core_tcdm_bus_r_valid}  ),
      .data_r_rdata_o      (  {s_dma_bus_r_rdata, s_core_tcdm_bus_r_rdata}  ), 

      // ---------------- MM_SIDE (Interleaved) --------------------------
      .data_req_o          (  s_tcdm_bus_sram_req    ),
      .data_ts_set_o       (  s_data_ts_set_int      ),
      .data_add_o          (  s_tcdm_bus_sram_add    ),
      .data_wen_o          (  s_tcdm_bus_sram_wen    ),
      .data_wdata_o        (  s_tcdm_bus_sram_wdata  ),
      .data_be_o           (  s_tcdm_bus_sram_be     ),
      .data_ID_o           (  s_tcdm_bus_sram_ID     ),
      .data_gnt_i          (  {NB_TCDM_BANKS{1'b1}}  ),
      
      .data_r_rdata_i      (  s_tcdm_bus_sram_rdata  ), 
      .data_r_valid_i      (  s_tcdm_bus_sram_rvalid ),
      .data_r_ID_i         (  s_tcdm_bus_sram_rID    ),

      .TCDM_arb_policy_i   (  TCDM_arb_policy_i      ),
      
      .clk                 (  clk_i                  ),
      .rst_n               (  rst_ni                 )
    );
   
   //********************************************************
   //******* LOGARITHMIC INTERCONNECT TO PERIPHERALS ********
   //********************************************************
    XBAR_PE
    #(
        .N_CH0              ( NB_CORES             ),
        .N_CH1              ( NB_MPERIPHS          ),
        .N_SLAVE            ( NB_SPERIPHS          ),
        .ID_WIDTH           ( NB_CORES+NB_MPERIPHS ),
        .PE_LSB             ( 0                    ),
        .PE_MSB             ( ADDR_WIDTH-1         ),
        
        .LOG_CLUSTER        ( LOG_CLUSTER          ),
        .ADDR_WIDTH         ( ADDR_WIDTH           ),
        .DATA_WIDTH         ( DATA_WIDTH           ),
        .BE_WIDTH           ( BE_WIDTH             ),
        .PE_ROUTING_LSB     ( PE_ROUTING_LSB       ),
        .PE_ROUTING_MSB     ( PE_ROUTING_MSB       ),
        .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE   )
    )
    xbar_pe_inst
    (
        .clk              ( clk_i),
        .rst_n            ( rst_ni),
        
        //.CLUSTER_ID(cluster_id),
        .CLUSTER_ID       ( 5'b00000),

        .data_req_i       ( {s_mperiph_bus_req,     s_core_periph_bus_req}     ),
        .data_add_i       ( {s_mperiph_bus_add,     s_core_periph_bus_add}     ),
        .data_wen_i       ( {s_mperiph_bus_wen,     s_core_periph_bus_wen}     ),
        .data_wdata_i     ( {s_mperiph_bus_wdata,   s_core_periph_bus_wdata}   ),
        .data_be_i        ( {s_mperiph_bus_be,      s_core_periph_bus_be}      ),
        .data_gnt_o       ( {s_mperiph_bus_gnt,     s_core_periph_bus_gnt}     ),
        .data_r_valid_o   ( {s_mperiph_bus_r_valid, s_core_periph_bus_r_valid} ),
        .data_r_rdata_o   ( {s_mperiph_bus_r_rdata, s_core_periph_bus_r_rdata} ),
        .data_r_opc_o     ( {s_mperiph_bus_r_opc,   s_core_periph_bus_r_opc}   ),
        
        .data_req_o       ( s_speriph_bus_req        ),
        .data_add_o       ( s_speriph_bus_add        ),
        .data_wen_o       ( s_speriph_bus_wen        ),
        .data_wdata_o     ( s_speriph_bus_wdata      ),
        .data_be_o        ( s_speriph_bus_be         ),
        .data_ID_o        ( s_speriph_bus_id         ),
        .data_gnt_i       ( s_speriph_bus_gnt        ),
        .data_r_rdata_i   ( s_speriph_bus_r_rdata    ),
        .data_r_valid_i   ( s_speriph_bus_r_valid    ),
        .data_r_ID_i      ( s_speriph_bus_r_id       ),
        .data_r_opc_i     ( s_speriph_bus_r_opc      )
    );

endmodule
