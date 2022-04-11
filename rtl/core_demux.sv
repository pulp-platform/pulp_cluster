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
//`define  PERF_CNT

module core_demux
#(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter BYTE_ENABLE_BIT = DATA_WIDTH/8,
    parameter CLUSTER_ALIAS_BASE = 12'h000
)
(
    input logic                          clk,
    input logic                          rst_ni,
    input logic                          test_en_i,
`ifdef REMAP_ADDRESS
    input logic [3:0]                    base_addr_i,
`endif

    // CORE SIDE
    input logic                          data_req_i,
    input logic [ADDR_WIDTH - 1:0]       data_add_i,
    input logic                          data_wen_i,
    input logic [5:0]                    data_atop_i,
    input logic [DATA_WIDTH - 1:0]       data_wdata_i,
    input logic [BYTE_ENABLE_BIT - 1:0]  data_be_i,
    output logic                         data_gnt_o,

    input logic                          data_r_gnt_i,    // Data Response Grant (For LOAD/STORE commands)
    output logic                         data_r_valid_o,  // Data Response Valid (For LOAD/STORE commands)
    output logic [DATA_WIDTH - 1:0]      data_r_rdata_o,  // Data Response DATA (For LOAD commands)
    output logic                         data_r_opc_o,    // Data Response Error

    // Low Latency log interconnect SIDE
    output logic                         data_req_o_SH,
    output logic [ADDR_WIDTH - 1:0]      data_add_o_SH,
    output logic                         data_wen_o_SH,
    output logic [5:0]                   data_atop_o_SH,
    output logic [DATA_WIDTH - 1:0]      data_wdata_o_SH,
    output logic [BYTE_ENABLE_BIT - 1:0] data_be_o_SH,
    input logic                          data_gnt_i_SH,
    input logic                          data_r_valid_i_SH,
    input logic [DATA_WIDTH - 1:0]       data_r_rdata_i_SH,

    // EXT_MEMORY_PAPPER PERIPHERALS (EG DMA)
    output logic                         data_req_o_EXT,
    output logic [ADDR_WIDTH - 1:0]      data_add_o_EXT,
    output logic                         data_wen_o_EXT,
    output logic [DATA_WIDTH - 1:0]      data_wdata_o_EXT,
    output logic [BYTE_ENABLE_BIT - 1:0] data_be_o_EXT,
    input logic                          data_gnt_i_EXT,
    input logic                          data_r_valid_i_EXT,
    input logic [DATA_WIDTH - 1:0]       data_r_rdata_i_EXT,
    input logic                          data_r_opc_i_EXT,
    
    // Peripheral interconnect SIDE
    output logic                         data_req_o_PE,
    output logic [ADDR_WIDTH - 1:0]      data_add_o_PE,
    output logic                         data_wen_o_PE,
    output logic [5:0]                   data_atop_o_PE,
    output logic [DATA_WIDTH - 1:0]      data_wdata_o_PE,
    output logic [BYTE_ENABLE_BIT - 1:0] data_be_o_PE,
    input logic                          data_gnt_i_PE,
    input logic                          data_r_valid_i_PE,
    input logic                          data_r_opc_i_PE,
    input logic [DATA_WIDTH - 1:0]       data_r_rdata_i_PE,
    
    // Performance Counters
    output logic                         perf_l2_ld_o, // nr of L2 loads
    output logic                         perf_l2_st_o, // nr of L2 stores
    output logic                         perf_l2_ld_cyc_o, // cycles used for L2 loads
    output logic                         perf_l2_st_cyc_o,  // cycles used for L2 stores
    
    input  logic [5:0]                   CLUSTER_ID
);
   
   logic [10:0] CLUSTER_ALIAS_BASE_11;
   logic [11:0] CLUSTER_ALIAS_BASE_12;
   
   logic                                  s_data_req_PE;
   logic                                  s_data_gnt_PE;  
   logic [DATA_WIDTH - 1:0]               s_data_r_data_PE;
   logic                                  s_data_r_valid_PE;
   logic                                  s_data_r_opc_PE;
   logic [DATA_WIDTH - 1:0]               s_data_r_data_PE_0;
   logic                                  s_data_r_valid_PE_0;
   logic                                  s_data_r_opc_PE_0;

   enum logic [1:0]                      { TRANS_IDLE, TRANS_PENDING, TRANS_GRANTED } CS, NS;

   // From L1 Arbiter
   logic                                  data_req_to_L2;
   logic [ADDR_WIDTH - 1:0]               data_add_to_L2;
   logic                                  data_wen_to_L2;
   logic [DATA_WIDTH - 1:0]               data_wdata_to_L2;
   logic [BYTE_ENABLE_BIT - 1:0]          data_be_to_L2;
   logic                                  data_gnt_from_L2;
   
   enum logic [1:0]                       {SH, PE, EXT } request_destination, destination;

   
  logic [ADDR_WIDTH - 1:0]                data_add_int;
   
  // Signal to PERIPH FIFO
  logic                                   data_busy_PE_fifo;
  logic                                   data_req_PE_fifo;
  logic [ADDR_WIDTH - 1:0]                data_add_PE_fifo;
  logic                                   data_wen_PE_fifo;
  logic [5:0]                             data_atop_PE_fifo;
  logic [DATA_WIDTH - 1:0]                data_wdata_PE_fifo;
  logic [BYTE_ENABLE_BIT - 1:0]           data_be_PE_fifo;
  logic                                   data_gnt_PE_fifo;
  
  logic                                   data_r_valid_PE_fifo;
  logic                                   data_r_opc_PE_fifo;
  logic [DATA_WIDTH - 1:0]                data_r_rdata_PE_fifo;


  logic [11:0]                            TCDM_RW;
  logic [11:0]                            TCDM_TS;
  logic [11:0]                            DEM_PER;

  assign CLUSTER_ALIAS_BASE_12 = CLUSTER_ALIAS_BASE;
  assign CLUSTER_ALIAS_BASE_11 = CLUSTER_ALIAS_BASE_12[11:1];



  always_comb
  begin
    TCDM_RW          = 12'h100 + (CLUSTER_ID << 2) + 0;
    TCDM_TS          = 12'h100 + (CLUSTER_ID << 2) + 1;
    DEM_PER          = 12'h100 + (CLUSTER_ID << 2) + 2;
  end
 
 
 
   // This section is used to swap the 4 most significant bits of the address 
   // with the ones that are provided by the base_addr_i
   // If data_add_i[31:28] == base_addr_i then data_add_i[31:28] are changed in 4'b0001
   // If data_add_i[31:28] == 4'b0001 --> then th data_add_i[31:28] is changed in base_addr_i
   // In the other cases, the address is unchanged

   assign data_add_int[27:0] = data_add_i[27:0];

`ifdef REMAP_ADDRESS
   always_comb
   begin
    if(data_add_i[31:28] == base_addr_i)
    begin
      data_add_int[31:28] = 4'b0001;
    end
    else if(data_add_int[31:28] == 4'b0001)
         begin
            data_add_int[31:28] = base_addr_i;
         end
         else
         begin
            data_add_int[31:28] = data_add_i[31:28];
         end
   end
`else
   assign data_add_int[31:28] = data_add_i[31:28]; 
`endif

   //********************************************************
   //************** LEVEL 1 REQUEST ARBITER *****************
   //********************************************************
   assign data_add_o_SH   = data_add_int;
   assign data_wen_o_SH   = data_wen_i;
   assign data_atop_o_SH  = data_atop_i;
   assign data_wdata_o_SH = data_wdata_i;
   assign data_be_o_SH    = data_be_i;

   assign data_add_to_L2   = data_add_int;
   assign data_wen_to_L2   = data_wen_i;
   assign data_wdata_to_L2 = data_wdata_i;
   assign data_be_to_L2    = data_be_i;   

   always_ff @(posedge clk, negedge rst_ni)
   begin : _UPDATE_RESPONSE_DESTINATION_
      if(rst_ni == 1'b0)
      begin
          request_destination <= SH;
      end
      else
      begin
          if(data_req_i)
          begin

            case(data_add_int[31:20])

          `ifdef DEM_PER_BEFORE_TCDM_TS

                TCDM_RW `ifdef CLUSTER_ALIAS , CLUSTER_ALIAS_BASE  `endif : 
                begin
                    if(data_add_int[19:14] == 6'b11_1111)
                        request_destination <= EXT;
                    else 
                        request_destination <= SH;
                end  // CLUSTER or DEM peripherals (mappping based on Germain suggestion)

                TCDM_TS `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+1) `endif: 
                begin
                        request_destination <= SH;
                end          
                
                DEM_PER `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+2) `endif: 
                begin
                        request_destination <= PE;
                end

          `else
            
                TCDM_RW, TCDM_TS  `ifdef CLUSTER_ALIAS , CLUSTER_ALIAS_BASE, (CLUSTER_ALIAS_BASE+1) `endif : 
                begin 
                    request_destination <= SH; 
                end  // CLUSTER

                DEM_PER `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+2) `endif: 
                begin
                     if(data_add_int[14]) // DEMUX PERIPHERALS
                        request_destination <= EXT; 
                     else
                        request_destination <= PE;
                end
          `endif
                default: 
                begin 
                    request_destination <= PE; 
                end  // CLUSTER PERIPHERAL and REst of the memory map

                endcase


          end
      end
   end

   
   // USED FOR THE PE FSM
   always_comb
   begin : _UPDATE_REQUEST_DESTINATION_

      `ifdef DEM_PER_BEFORE_TCDM_TS
            case(data_add_int[31:20])
                TCDM_RW   `ifdef CLUSTER_ALIAS , CLUSTER_ALIAS_BASE `endif : 
                begin
                    if(data_add_int[19:14] == 6'b11_1111)
                        destination = EXT;
                    else 
                        destination = SH;
                end  // CLUSTER or DEM peripherals (mappping based on Germain suggestion)

                TCDM_TS `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+1) `endif: 
                begin
                        destination = SH;
                end          
                
                DEM_PER `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+2) `endif: 
                begin
                        destination = PE;
                end
                default:          begin destination  = PE;  end  // CLUSTER PERIPHERAL and REst of the memory map
            endcase
      `else
            case(data_add_int[31:20])
                TCDM_RW, TCDM_TS  `ifdef CLUSTER_ALIAS , CLUSTER_ALIAS_BASE, (CLUSTER_ALIAS_BASE+1) `endif : 
                begin 
                    destination  = SH;  // CLUSTER
                end


                DEM_PER `ifdef CLUSTER_ALIAS  , (CLUSTER_ALIAS_BASE+2) `endif: 
                begin
                    if(data_add_int[14]) // DEMUX PERIPHERALS
                        destination  = EXT; 
                    else
                        destination  = PE; 
                end  // DEMUX PERIPHERALS
            default:          begin destination  = PE;  end  // CLUSTER PERIPHERAL and REst of the memory map
            endcase
        `endif
   end   
   
   
   always_comb
   begin : L1_REQUEST_ARBITER   

`ifdef DEM_PER_BEFORE_TCDM_TS

   `ifdef CLUSTER_ALIAS
        if( ( data_add_int[31:21] == TCDM_RW[11:1])  || ( data_add_int[31:21] == CLUSTER_ALIAS_BASE_11 ) )  //LOGARITHMIC INTERCONNECT --> 31:20 --> 0x100 or 0x101 or ALIAS (0x000 or 0x001) or DEM PERIPH
   `else 
        if(data_add_int[31:21] == TCDM_RW[11:1])  //LOGARITHMIC INTERCONNECT --> 31:20 --> 0x100 or 0x101 or DEM PERIPH
   `endif
        begin : _TO_DEM_PER_L2_
            if(data_add_int[19:14] == 6'b11_1111)
            begin
               data_req_o_SH  = 1'b0;
               data_req_to_L2 = data_req_i;
               data_gnt_o     = data_gnt_from_L2;
            end
            else
            begin : _TO_CLUSTER_L1_
               data_req_o_SH  = data_req_i;
               data_req_to_L2 = 1'b0;
               data_gnt_o     = data_gnt_i_SH;
            end
        end
        else 
        begin : _TO_L2_LEVEL_
           data_req_o_SH  = 1'b0;
           data_req_to_L2 = data_req_i;
           data_gnt_o     = data_gnt_from_L2;
        end

`else

   `ifdef CLUSTER_ALIAS
        if( ( data_add_int[31:21] == TCDM_RW[11:1])  || ( data_add_int[31:21] == CLUSTER_ALIAS_BASE_11) )  //LOGARITHMIC INTERCONNECT --> 31:20 --> 0x100 or 0x101 or ALIAS (0x000 or 0x001)
   `else 
        if(data_add_int[31:21] == TCDM_RW[11:1])  //LOGARITHMIC INTERCONNECT --> 31:20 --> 0x100 or 0x101
   `endif
        begin : _TO_CLUSTER_
           data_req_o_SH  = data_req_i;
           data_req_to_L2 = 1'b0;
           data_gnt_o     = data_gnt_i_SH;
        end
        else 
        begin : _TO_L2_LEVEL_
           data_req_o_SH  = 1'b0;
           data_req_to_L2 = data_req_i;
           data_gnt_o     = data_gnt_from_L2;
        end
`endif
   end
 
 
 
 
 
   //********************************************************
   //************** LEVEL 2 REQUEST ARBITER *****************
   //********************************************************
   assign data_add_PE_fifo   = data_add_int;
   assign data_wen_PE_fifo   = data_wen_i;
   assign data_atop_PE_fifo  = data_atop_i;
   assign data_wdata_PE_fifo = data_wdata_i;
   assign data_be_PE_fifo    = data_be_i;

   assign data_add_o_EXT   = data_add_int;
   assign data_wen_o_EXT   = data_wen_i;
   assign data_wdata_o_EXT = data_wdata_i;
   assign data_be_o_EXT    = data_be_i;

   always_comb
   begin : _L2_REQUEST_ARBITER_

  `ifdef DEM_PER_BEFORE_TCDM_TS

        `ifdef CLUSTER_ALIAS
            if ( ((data_add_int[31:20] == TCDM_RW )  || (data_add_int[31:20] == CLUSTER_ALIAS) )  && (data_add_int[19:14] == 6'b11_1111) ) 
        `else
            if ( (data_add_int[31:20] == DEM_PER ) && (data_add_int[19:14] == 6'b11_1111) ) 
        `endif
            begin : _TO_DEMUX_PERIPH_  //Peripheral --> add_i[31:0] --> 0x100F_FC00 to 0x100F_FFFF
               data_req_PE_fifo = 1'b0;
               data_req_o_EXT  = data_req_to_L2;
               data_gnt_from_L2 = data_gnt_i_EXT;
            end
            else 
            begin : _TO_PERIPHERAL_INTERCO_ 
               data_req_PE_fifo = s_data_req_PE;
               data_req_o_EXT   = 1'b0;
               data_gnt_from_L2 = s_data_gnt_PE;
            end

  `else

        `ifdef CLUSTER_ALIAS
            if ( ((data_add_int[31:20] == DEM_PER )  || (data_add_int[31:20] == (CLUSTER_ALIAS_BASE+2)) )  && (data_add_int[14] == 1'b1) ) 
        `else
            if ( (data_add_int[31:20] == DEM_PER ) && (data_add_int[14] == 1'b1) ) 
        `endif
            begin : _TO_DEMUX_PERIPH_  //Peripheral --> add_i[31:0] --> 0x1020_4000 to 0x1020_7FFF
               data_req_PE_fifo = 1'b0;
               data_req_o_EXT  = data_req_to_L2;
               data_gnt_from_L2 = data_gnt_i_EXT;
            end
            else 
            begin : _TO_PERIPHERAL_INTERCO_ 
               data_req_PE_fifo = s_data_req_PE;
               data_req_o_EXT   = 1'b0;
               data_gnt_from_L2 = s_data_gnt_PE;
            end
  `endif
   end



   //********************************************************
   //************** RESPONSE ARBITER ************************
   //********************************************************
   always_comb
   begin: _RESPONSE_ARBITER_
      case(request_destination)
        SH: 
        begin
          data_r_valid_o = data_r_valid_i_SH;
          data_r_rdata_o = data_r_rdata_i_SH;
          data_r_opc_o   = 1'b0;
        end

        PE:
        begin
          data_r_valid_o = s_data_r_valid_PE;
          data_r_rdata_o = s_data_r_data_PE;
          data_r_opc_o   = s_data_r_opc_PE;
        end

        EXT:
        begin
          data_r_valid_o = data_r_valid_i_EXT;
          data_r_rdata_o = data_r_rdata_i_EXT;
          data_r_opc_o   = data_r_opc_i_EXT;
        end

        default:
        begin
          data_r_valid_o = 1'b0;
          data_r_rdata_o = data_r_rdata_i_SH;
          data_r_opc_o   = 1'b0;
        end
      endcase
   end

   //********************************************************
   //************** PE INTERFACE ****************************
   //********************************************************
   // UPDATE THE STATE
   always_ff @(posedge clk, negedge rst_ni)
   begin
        if(rst_ni == 1'b0)
          begin
             CS <= TRANS_IDLE;
          end
        else
          begin
             CS <= NS;
          end
   end

   //COMPUTE NEXT STATE
   always_comb
     begin

        s_data_gnt_PE   = 1'b0;
        s_data_req_PE   = 1'b0;

        case(CS)

          TRANS_IDLE:
            begin

               if( ( data_req_i == 1'b1 )  &&  ( destination == PE ) )
               begin
                    s_data_req_PE = 1'b1;
                    if (data_gnt_PE_fifo == 1'b1)
                      begin
                         NS = TRANS_PENDING;
                      end
                    else
                      begin
                         NS = TRANS_IDLE;
                      end
               end
               else
               begin
                    NS = TRANS_IDLE;
               end
            end

          TRANS_PENDING:
            begin
               if (data_r_valid_PE_fifo == 1'b1)
                 begin
                    NS = TRANS_GRANTED;
                 end
               else
                 begin
                    NS = TRANS_PENDING;
                 end
            end

          TRANS_GRANTED:
            begin
               s_data_gnt_PE     = 1'b1;
               NS                = TRANS_IDLE;
            end

          default:
            begin
               NS                = TRANS_IDLE;
            end

        endcase
     end

   //**** GNT PE GEN ****//
   always_ff @(posedge clk, negedge  rst_ni)
     begin
        if(rst_ni == 1'b0)
          begin
             s_data_r_valid_PE_0 <= '0;
             s_data_r_data_PE_0  <= '0;
             s_data_r_opc_PE_0   <= '0;
          end
        else
          begin
            s_data_r_valid_PE_0 <= data_r_valid_PE_fifo;

            if(data_r_valid_PE_fifo)
            begin
               s_data_r_data_PE_0  <= data_r_rdata_PE_fifo;
               s_data_r_opc_PE_0   <= data_r_opc_PE_fifo;
            end
          end
     end

   always_ff @(posedge clk, negedge  rst_ni)
     begin
        if(rst_ni == 1'b0)
          begin
             s_data_r_valid_PE <= '0;
             s_data_r_data_PE  <= '0;
             s_data_r_opc_PE   <= '0;
          end
        else
          begin
             s_data_r_valid_PE <= s_data_r_valid_PE_0;
             if(s_data_r_valid_PE_0)
             begin
               s_data_r_data_PE  <= s_data_r_data_PE_0;
               s_data_r_opc_PE   <= s_data_r_opc_PE_0;
             end
          end
     end



periph_FIFO
#(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .BYTE_ENABLE_BIT(DATA_WIDTH/8)
)
periph_FIFO_i
(
    .clk_i          ( clk                     ),
    .rst_ni         ( rst_ni                  ),
    .test_en_i      ( test_en_i               ),

    //Input SIde REQ
    .data_req_i     ( data_req_PE_fifo        ),
    .data_add_i     ( data_add_PE_fifo        ),
    .data_wen_i     ( data_wen_PE_fifo        ),
    .data_atop_i    ( data_atop_PE_fifo       ),
    .data_wdata_i   ( data_wdata_PE_fifo      ),
    .data_be_i      ( data_be_PE_fifo         ),
    .data_gnt_o     ( data_gnt_PE_fifo        ),

    //Output side REQ
    .data_req_o     ( data_req_o_PE           ),
    .data_add_o     ( data_add_o_PE           ),
    .data_wen_o     ( data_wen_o_PE           ),
    .data_atop_o    ( data_atop_o_PE          ),
    .data_wdata_o   ( data_wdata_o_PE         ),
    .data_be_o      ( data_be_o_PE            ),
    .data_gnt_i     ( data_gnt_i_PE           ),

    //Input Side RESP
    .data_r_valid_i ( data_r_valid_i_PE       ),
    .data_r_opc_i   ( data_r_opc_i_PE         ),
    .data_r_rdata_i ( data_r_rdata_i_PE       ),

    //Output Side RESP
    .data_r_valid_o ( data_r_valid_PE_fifo    ),
    .data_r_opc_o   ( data_r_opc_PE_fifo      ),
    .data_r_rdata_o ( data_r_rdata_PE_fifo    )
);

  // Performance Counters
  assign perf_l2_ld_o     = data_req_to_L2 & data_gnt_from_L2 & data_wen_i;
  assign perf_l2_st_o     = data_req_to_L2 & data_gnt_from_L2 & (~data_wen_i);
  assign perf_l2_ld_cyc_o = data_req_to_L2 & data_wen_i;
  assign perf_l2_st_cyc_o = data_req_to_L2 & (~data_wen_i);



`ifdef PERF_CNT
logic [31:0] STALL_TCDM;
logic [31:0] STALL_L2;

logic clear_regs, enable_regs;

  always_ff @(posedge clk or negedge rst_ni) 
  begin
    if(~rst_ni) 
    begin
       STALL_TCDM <= '0;
       STALL_L2 <= '0;
    end 
    else
    begin
        if(clear_regs)
        begin 
          STALL_TCDM <= '0;
          STALL_L2 <= '0;
        end
        else 
             if( enable_regs )
             begin
                if( data_req_o_SH & ~data_gnt_i_SH )
                  STALL_TCDM <= STALL_TCDM + 1'b1;

                if( data_req_to_L2 & ~data_gnt_from_L2 )
                  STALL_L2 <= STALL_L2 + 1'b1;
             end
    end
  end
`endif

endmodule
