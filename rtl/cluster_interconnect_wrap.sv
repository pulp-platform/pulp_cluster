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

module cluster_interconnect_wrap import tcdm_interconnect_pkg::topo_e;
   
#(
  parameter NB_CORES        = 8,
  parameter NB_HWPE_PORTS   = 4,
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
  XBAR_TCDM_BUS.Slave                  core_tcdm_slave[NB_CORES+NB_HWPE_PORTS-1:0],
  XBAR_PERIPH_BUS.Slave                core_periph_slave[NB_CORES-1:0],
  XBAR_TCDM_BUS.Slave                  ext_slave[NB_DMAS-1:0],
  XBAR_TCDM_BUS.Slave                  dma_slave[NB_DMAS-1:0], //FIXME IGOR --> check NB_CORES depend ASK DAVIDE
  XBAR_TCDM_BUS.Slave                  mperiph_slave[NB_MPERIPHS-1:0],
  TCDM_BANK_MEM_BUS.Master             tcdm_sram_master[NB_TCDM_BANKS-1:0],
  XBAR_PERIPH_BUS.Master               speriph_master[NB_SPERIPHS-1:0],
  input logic [1:0]                    TCDM_arb_policy_i
);

  localparam TCDM_ID_WIDTH  = NB_CORES+NB_DMAS+4+NB_HWPE_PORTS;

  // DMA --> LOGARITHMIC INTERCONNECT BUS SIGNALS
  logic [4+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_wdata;
  logic [4+NB_DMAS-1:0][ADDR_WIDTH-1:0]              s_dma_bus_add;
  logic [4+NB_DMAS-1:0]                              s_dma_bus_req;
  logic [4+NB_DMAS-1:0]                              s_dma_bus_wen;
  logic [4+NB_DMAS-1:0][BE_WIDTH-1:0]                s_dma_bus_be;
  logic [4+NB_DMAS-1:0]                              s_dma_bus_gnt;
  logic [4+NB_DMAS-1:0][DATA_WIDTH-1:0]              s_dma_bus_r_rdata;
  logic [4+NB_DMAS-1:0]                              s_dma_bus_r_valid;


  // DEMUX --> LOGARITHMIC INTERCONNECT BUS SIGNALS
  logic [NB_CORES+NB_HWPE_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_wdata;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][ADDR_WIDTH-1:0] s_core_tcdm_bus_add;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_req;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_wen;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][BE_WIDTH-1:0]   s_core_tcdm_bus_be;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_gnt;
  logic [NB_CORES+NB_HWPE_PORTS-1:0][DATA_WIDTH-1:0] s_core_tcdm_bus_r_rdata;
  logic [NB_CORES+NB_HWPE_PORTS-1:0]                 s_core_tcdm_bus_r_valid;


  // TCDM BANK MEM SIGNAL
  logic [NB_TCDM_BANKS-1:0][ADDR_MEM_WIDTH-1:0]           s_tcdm_bus_sram_add;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_req;
  logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]               s_tcdm_bus_sram_wdata;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_wen;
  logic [NB_TCDM_BANKS-1:0][BE_WIDTH-1:0]                 s_tcdm_bus_sram_be;
  logic [NB_TCDM_BANKS-1:0][DATA_WIDTH-1:0]               s_tcdm_bus_sram_rdata;
  logic [NB_TCDM_BANKS-1:0]                               s_tcdm_bus_sram_gnt;
   

  //********************************************************
  //****** BINDING INTERFACES TO XBAR_TCDM BUS SIGNALS *****
  //********************************************************
  generate
    for (genvar i=0; i<NB_CORES+NB_HWPE_PORTS; i++)
    begin : CORE_TCDM_BIND
      assign s_core_tcdm_bus_add[i]      = core_tcdm_slave[i].add-32'h1000_0000;
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
    for (genvar i=0; i<NB_DMAS; i++)
    begin : AXI2MEM_BIND
      assign s_dma_bus_add[i]      = ext_slave[i].add-32'h1000_0000;
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
    for (genvar i=0; i<NB_DMAS; i++)  //4 takes into account the 4 ports used in axi2mem
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
    for (genvar i=0; i<NB_TCDM_BANKS; i++)
    begin : TCDM_BANKS_BIND

      assign tcdm_sram_master[i].req   = s_tcdm_bus_sram_req   [i];
      assign tcdm_sram_master[i].add   = s_tcdm_bus_sram_add[i]   ;
      assign tcdm_sram_master[i].wen   = s_tcdm_bus_sram_wen   [i];
      assign tcdm_sram_master[i].wdata = s_tcdm_bus_sram_wdata [i];
      assign tcdm_sram_master[i].be    = s_tcdm_bus_sram_be    [i];
      assign s_tcdm_bus_sram_rdata[i]  = tcdm_sram_master[i].rdata;
      assign s_tcdm_bus_sram_gnt[i]    = s_tcdm_bus_sram_req[i];
     
    end 
  endgenerate

  //-********************************************************
  //-*********** LOGARITHMIC INTERCONNECT TO TCDM ***********
  //-********************************************************
  localparam NUM_TCDM_IN  = NB_CORES + NB_HWPE_PORTS + NB_DMAS +4;
  localparam NUM_TCDM_OUT = NB_TCDM_BANKS ;

  tcdm_interconnect #(
    .NumIn        ( NUM_TCDM_IN                 ),
    .NumOut       ( NUM_TCDM_OUT                ),
    .AddrWidth    ( ADDR_WIDTH                  ),
    .DataWidth    ( DATA_WIDTH                  ),
    .ByteOffWidth ( $clog2(DATA_WIDTH-1)-3      ), // determine byte offset from real data width
    .AddrMemWidth ( ADDR_MEM_WIDTH              ),
    .WriteRespOn  ( 1                           ),
    .RespLat      ( 1                           ),
    .Topology     ( tcdm_interconnect_pkg::LIC  )
  ) i_tcdm_interconnect (
    .clk_i,
    .rst_ni,

    .req_i    ( { s_dma_bus_req,      s_core_tcdm_bus_req}      ),
    .add_i    ( { s_dma_bus_add,      s_core_tcdm_bus_add}      ),
    .wen_i    ( { s_dma_bus_wen,      s_core_tcdm_bus_wen}      ),
    .wdata_i  ( { s_dma_bus_wdata,    s_core_tcdm_bus_wdata}    ),
    .be_i     ( { s_dma_bus_be,       s_core_tcdm_bus_be}       ),
    .gnt_o    ( { s_dma_bus_gnt,      s_core_tcdm_bus_gnt}      ),
    .vld_o    ( { s_dma_bus_r_valid,  s_core_tcdm_bus_r_valid}  ),
    .rdata_o  ( { s_dma_bus_r_rdata,  s_core_tcdm_bus_r_rdata}  ),
                         
    .req_o    ( s_tcdm_bus_sram_req                             ),
    .gnt_i    ( s_tcdm_bus_sram_gnt                             ),
    .add_o    ( s_tcdm_bus_sram_add                             ),
    .wen_o    ( s_tcdm_bus_sram_wen                             ),
    .wdata_o  ( s_tcdm_bus_sram_wdata                           ),
    .be_o     ( s_tcdm_bus_sram_be                              ),
    .rdata_i  ( s_tcdm_bus_sram_rdata                           )
  );
   
  //********************************************************
  //******* LOGARITHMIC INTERCONNECT TO PERIPHERALS ********
  //********************************************************
  xbar_pe_wrap
  #(
    .NB_CORES           ( NB_CORES             ),
    .NB_MPERIPHS        ( NB_MPERIPHS          ),
    .NB_SPERIPHS        ( NB_SPERIPHS          ),
    
    .ADDR_WIDTH         ( ADDR_WIDTH           ),
    .DATA_WIDTH         ( DATA_WIDTH           ),
    .BE_WIDTH           ( BE_WIDTH             ),
    .PE_ROUTING_LSB     ( PE_ROUTING_LSB       ),
    .PE_ROUTING_MSB     ( PE_ROUTING_MSB       ),
    .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE   )
   ) 
   xbar_pe_inst
   (
    .clk_i            ( clk_i ),
    .rst_ni           ( rst_ni),
    .core_periph_slave( core_periph_slave),
    .speriph_master   ( speriph_master   ),
    .mperiph_slave    ( mperiph_slave    )
    );


endmodule
