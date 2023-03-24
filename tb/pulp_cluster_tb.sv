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
// Date: 15/04/2017
// Description: Top level testbench module. Instantiates the top level DUT, configures
//              the virtual interfaces and starts the test passed by +UVM_TEST+
//`define TEST_CLOCK_BYPASS

`timescale 1ps/1ps

`include "pulp_soc_defines.sv"
`include "uvm_macros.svh"
`include "axi/assign.svh"
`include "axi/typedef.svh"

import "DPI-C" function read_elf(input string filename);
import "DPI-C" function byte get_section(output longint address, output longint len);
import "DPI-C" context function byte read_section(input longint address, inout byte buffer[]);

module pulp_cluster_tb;
   
  import uvm_pkg::*;
  import axi_pkg::*;

  logic s_clk;
  logic s_rstn;
  logic s_rstn_cl;
  
  localparam time SYS_TCK  = 8ns;
  localparam time SYS_TA   = 2ns;
  localparam time SYS_TT   = SYS_TCK - 2ns;

  clk_rst_gen #(
    .ClkPeriod    ( SYS_TCK ),
    .RstClkCycles ( 5       )
  ) i_clk_rst_gen (
      .clk_o  ( s_clk  ),
      .rst_no ( s_rstn )
  );
   
  localparam AxiAw  = 32;
  localparam AxiDw  = 64;
  localparam AxiIw  = 6;
  localparam NMst   = 2;
  localparam NSlv   = 3;
  localparam AxiIwMst = AxiIw + $clog2(NMst);
  localparam AxiWideBeWidth = AxiDw/8;
  localparam AxiWideByteOffset = $clog2(AxiWideBeWidth);
  localparam AxiUw = 1;
   
  typedef logic [AxiAw-1:0]    axi_addr_t;
  typedef logic [AxiDw-1:0]    axi_data_t;
  typedef logic [AxiDw/8-1:0]  axi_strb_t;
  typedef logic [AxiUw-1:0]    axi_user_t;
  typedef logic [AxiIw-1:0]    axi_id_t;
  typedef logic [AxiIwMst-1:0] axi_m_id_t;

  `AXI_TYPEDEF_W_CHAN_T(w_chan_t, axi_data_t, axi_strb_t, axi_user_t)
  `AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, axi_addr_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_chan_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, axi_addr_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_chan_t, axi_data_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_REQ_T(axi_req_t, aw_chan_t, w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(axi_resp_t, b_chan_t, r_chan_t)

  `AXI_TYPEDEF_AW_CHAN_T(aw_m_chan_t, axi_addr_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_m_chan_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_m_chan_t, axi_addr_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_m_chan_t, axi_data_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_REQ_T(axi_m_req_t, aw_m_chan_t, w_chan_t, ar_m_chan_t)
  `AXI_TYPEDEF_RESP_T(axi_m_resp_t, b_m_chan_t, r_m_chan_t)   

  typedef logic [AxiAw-1:0] addr_t;
  typedef logic [AxiDw-1:0] data_t;   
  data_t memory [bit [31:0]];
  int sections  [bit [31:0]];
   
  string        binary ;
   
  logic s_cluster_en_sa_boot ;
  logic s_cluster_fetch_en   ;
  logic s_cluster_eoc        ;
  logic s_cluster_busy       ;
   
  AXI_BUS #(
      .AXI_ADDR_WIDTH( AxiAw    ),
      .AXI_DATA_WIDTH( AxiDw    ),
      .AXI_ID_WIDTH  ( AxiIwMst ),
      .AXI_USER_WIDTH( AxiUw    )
  ) axi_master[NSlv-1:0]();

  AXI_BUS #(
      .AXI_ADDR_WIDTH( AxiAw ),
      .AXI_DATA_WIDTH( AxiDw ),
      .AXI_ID_WIDTH  ( AxiIw ),
      .AXI_USER_WIDTH( AxiUw )
  ) axi_slave[NMst-1:0]();

  AXI_BUS #(
      .AXI_ADDR_WIDTH( AxiAw   ),
      .AXI_DATA_WIDTH( AxiDw   ),
      .AXI_ID_WIDTH  ( AxiIw-2 ),
      .AXI_USER_WIDTH( AxiUw   )
  ) soc_to_cluster_axi_bus();

  AXI_BUS_ASYNC_GRAY #(
     .AXI_ADDR_WIDTH ( AxiAw   ),
     .AXI_DATA_WIDTH ( AxiDw   ),
     .AXI_ID_WIDTH   ( AxiIw-2 ),
     .AXI_USER_WIDTH ( AxiUw   ),
     .LOG_DEPTH      ( 3       )
  ) async_soc_to_cluster_axi_bus();

  AXI_BUS_ASYNC_GRAY #(
     .AXI_ADDR_WIDTH ( AxiAw ),
     .AXI_DATA_WIDTH ( AxiDw ),
     .AXI_ID_WIDTH   ( AxiIw ),
     .AXI_USER_WIDTH ( AxiUw ),
     .LOG_DEPTH      ( 3     )
  ) async_cluster_to_soc_axi_bus();

   // Behavioural slaves
   axi_m_req_t  axi_memreq;
   axi_m_resp_t axi_memrsp;
   
  `AXI_ASSIGN_TO_REQ(axi_memreq, axi_master[1])
  `AXI_ASSIGN_FROM_RESP(axi_master[1], axi_memrsp)
   
  axi_sim_mem #(
    .AddrWidth ( AxiAw        ),
    .DataWidth ( AxiDw        ),
    .IdWidth   ( AxiIwMst     ),
    .UserWidth ( AxiUw        ),
    .req_t     ( axi_m_req_t  ),
    .rsp_t     ( axi_m_resp_t ),
    .ApplDelay ( SYS_TA       ),
    .AcqDelay  ( SYS_TT       )    
  ) sim_mem (
     .clk_i     ( s_clk      ),
     .rst_ni    ( s_rstn     ),
     .axi_req_i ( axi_memreq ),
     .axi_rsp_o ( axi_memrsp )
  );

  mock_uart_axi #(
   .AxiIw ( AxiIwMst ),
   .AxiAw ( AxiAw    ),
   .AxiDw ( AxiDw    ),
   .AxiUw ( AxiUw    )
  ) i_mock_uart (
     .clk_i  ( s_clk         ),
     .rst_ni ( s_rstn        ),
     .test_i ( '0            ),
     .uart   ( axi_master[0] )
  );
   
  // XBAR
  localparam int unsigned NumRules = NSlv+1;
  typedef axi_pkg::xbar_rule_32_t rule_t;
  rule_t [NumRules-1:0] addr_map;
  assign addr_map[0] = '{ // UART
    idx:        0,
    start_addr: 32'h4000_0000,
    end_addr:   32'h4000_ffff
  };
  assign addr_map[1] = '{ // 512KiB L2SPM
    idx:        1,
    start_addr: 32'h1C00_0000,
    end_addr:   32'h1C08_0000
  };
  assign addr_map[2] = '{ // Pulp Cluster
    idx:        2,
    start_addr: 32'h1000_0000,
    end_addr:   32'h1004_0000
  };
  assign addr_map[3] = '{ // Return address
    idx:        1, // Just put it in axi_sim_mem
    start_addr: 32'h1A10_4000,
    end_addr:   32'h1A10_40F0
  };
  // Crossbar Configuration and Instantiation
  localparam axi_pkg::xbar_cfg_t XbarCfg = '{
    NoSlvPorts:         NMst,
    NoMstPorts:         NSlv,
    MaxMstTrans:        8,
    MaxSlvTrans:        8,
    FallThrough:        1'b1,
    LatencyMode:        axi_pkg::NO_LATENCY,
    AxiIdWidthSlvPorts: AxiIw,
    AxiIdUsedSlvPorts:  AxiIw,
    UniqueIds:          1'b1,
    AxiAddrWidth:       AxiAw,
    AxiDataWidth:       AxiDw,
    NoAddrRules:        NumRules
  };
  axi_xbar_intf #(
    .AXI_USER_WIDTH ( AxiUw   ),
    .Cfg            ( XbarCfg ),
    .rule_t         ( rule_t  )
  ) i_xbar (
    .clk_i                  ( s_clk      ),
    .rst_ni                 ( s_rstn     ),
    .test_i                 ( 1'b0       ),
    .slv_ports              ( axi_slave  ),
    .mst_ports              ( axi_master ),
    .addr_map_i             ( addr_map   ),
    .en_default_mst_port_i  ( '1         ), // default all slave ports to master port 0
    .default_mst_port_i     ( '0         )
  );

  axi_serializer_intf #(
    .AXI_ID_WIDTH   ( AxiIwMst ),
    .AXI_ADDR_WIDTH ( AxiAw    ),
    .AXI_DATA_WIDTH ( AxiDw    ),
    .AXI_USER_WIDTH ( AxiUw    ),
    .MAX_READ_TXNS  ( 8        ),
    .MAX_WRITE_TXNS ( 8        )
    ) i_s2c_serializer (
      .clk_i  ( s_clk                  ),
      .rst_ni ( s_rstn                 ),
      .slv    ( axi_master[2]          ),
      .mst    ( soc_to_cluster_axi_bus )
    );
   
  axi_cdc_src_intf   #(
    .AXI_ADDR_WIDTH ( AxiAw   ),
    .AXI_DATA_WIDTH ( AxiDw   ),
    .AXI_ID_WIDTH   ( AxiIw-2 ),
    .AXI_USER_WIDTH ( AxiUw   ),
    .LOG_DEPTH      ( 3       )
  ) soc_to_cluster_src_cdc_fifo_i  (
      .src_clk_i  ( s_clk                        ),
      .src_rst_ni ( s_rstn                       ),
      .src        ( soc_to_cluster_axi_bus       ),
      .dst        ( async_soc_to_cluster_axi_bus )
      );
   
  axi_cdc_dst_intf   #(
    .AXI_ADDR_WIDTH ( AxiAw ),
    .AXI_DATA_WIDTH ( AxiDw ),
    .AXI_ID_WIDTH   ( AxiIw ),
    .AXI_USER_WIDTH ( AxiUw ),
    .LOG_DEPTH      ( 3     )
    ) cluster_to_soc_dst_cdc_fifo_i (
      .dst_clk_i  ( s_clk                        ),
      .dst_rst_ni ( s_rstn                       ),
      .src        ( async_cluster_to_soc_axi_bus ),
      .dst        ( axi_slave[1]                 )
      );

  pulp_cluster  #(
    .NB_CORES                     ( `NB_CORES                ),
    .NB_HWPE_PORTS                ( 4                        ),
    .NB_DMAS                      ( `NB_DMAS                 ),
    .HWPE_PRESENT                 ( 0                        ),
    .TCDM_SIZE                    ( 128*1024                 ),
    .NB_TCDM_BANKS                ( 16                       ),
    .SET_ASSOCIATIVE              ( 4                        ),
    .CACHE_LINE                   ( 1                        ),
    .CACHE_SIZE                   ( 4096                     ),
    .ICACHE_DATA_WIDTH            ( 128                      ),
    .L0_BUFFER_FEATURE            ( "DISABLED"               ),
    .MULTICAST_FEATURE            ( "DISABLED"               ),
    .SHARED_ICACHE                ( "ENABLED"                ),
    .DIRECT_MAPPED_FEATURE        ( "DISABLED"               ),
    .L2_SIZE                      ( 32'h10000                ),
    .ROM_BOOT_ADDR                ( 32'h1A000000             ),
    .BOOT_ADDR                    ( 32'h1c008080             ),
    .INSTR_RDATA_WIDTH            ( 32                       ),
    .CLUST_FPU                    ( `CLUST_FPU               ),
    .CLUST_FP_DIVSQRT             ( `CLUST_FP_DIVSQRT        ),
    .CLUST_SHARED_FP              ( `CLUST_SHARED_FP         ),
    .CLUST_SHARED_FP_DIVSQRT      ( `CLUST_SHARED_FP_DIVSQRT ),
    .AXI_ADDR_WIDTH               ( AxiAw                    ),
    .AXI_DATA_S2C_WIDTH           ( AxiDw                    ),
    .AXI_DATA_C2S_WIDTH           ( AxiDw                    ),
    .AXI_USER_WIDTH               ( AxiUw                    ),
    .AXI_ID_IN_WIDTH              ( AxiIw-2                  ),
    .AXI_ID_OUT_WIDTH             ( AxiIw                    ),
    .LOG_DEPTH                    ( 3                        ),
    .DATA_WIDTH                   ( 32                       ),
    .ADDR_WIDTH                   ( 32                       ),
    .LOG_CLUSTER                  ( 3                        ),
    .PE_ROUTING_LSB               ( 10                       ),
    .EVNT_WIDTH                   ( 8                        )
  ) cluster_i (
      .clk_i                       ( s_clk                                ),
      .rst_ni                      ( s_rstn                               ),
      .ref_clk_i                   ( s_clk                                ),
                                       
      .pmu_mem_pwdn_i              ( 1'b0                                 ),
                                       
      .base_addr_i                 ( '0                                   ),
                                       
      .dma_pe_evt_ack_i            ( '1                                   ),
      .dma_pe_evt_valid_o          (                                      ),
                                       
      .dma_pe_irq_ack_i            ( 1'b1                                 ),
      .dma_pe_irq_valid_o          (                                      ),
                                       
      .dbg_irq_valid_i             ( '0                                   ),
                                       
      .pf_evt_ack_i                ( 1'b1                                 ),
      .pf_evt_valid_o              (                                      ),
                                       
      .async_cluster_events_wptr_i ( '0                                   ),
      .async_cluster_events_rptr_o (                                      ),
      .async_cluster_events_data_i ( '0                                   ),
                                       
      .en_sa_boot_i                ( s_cluster_en_sa_boot                 ),
      .test_mode_i                 ( 1'b0                                 ),
      .fetch_en_i                  ( s_cluster_fetch_en                   ),
      .eoc_o                       ( s_cluster_eoc                        ),
      .busy_o                      ( s_cluster_busy                       ),
      .cluster_id_i                ( 6'b000000                            ),

      .async_data_master_aw_wptr_o ( async_cluster_to_soc_axi_bus.aw_wptr ),
      .async_data_master_aw_rptr_i ( async_cluster_to_soc_axi_bus.aw_rptr ),
      .async_data_master_aw_data_o ( async_cluster_to_soc_axi_bus.aw_data ),
      .async_data_master_ar_wptr_o ( async_cluster_to_soc_axi_bus.ar_wptr ),
      .async_data_master_ar_rptr_i ( async_cluster_to_soc_axi_bus.ar_rptr ),
      .async_data_master_ar_data_o ( async_cluster_to_soc_axi_bus.ar_data ),
      .async_data_master_w_data_o  ( async_cluster_to_soc_axi_bus.w_data  ),
      .async_data_master_w_wptr_o  ( async_cluster_to_soc_axi_bus.w_wptr  ),
      .async_data_master_w_rptr_i  ( async_cluster_to_soc_axi_bus.w_rptr  ),
      .async_data_master_r_wptr_i  ( async_cluster_to_soc_axi_bus.r_wptr  ),
      .async_data_master_r_rptr_o  ( async_cluster_to_soc_axi_bus.r_rptr  ),
      .async_data_master_r_data_i  ( async_cluster_to_soc_axi_bus.r_data  ),
      .async_data_master_b_wptr_i  ( async_cluster_to_soc_axi_bus.b_wptr  ),
      .async_data_master_b_rptr_o  ( async_cluster_to_soc_axi_bus.b_rptr  ),
      .async_data_master_b_data_i  ( async_cluster_to_soc_axi_bus.b_data  ),
     
      .async_data_slave_aw_wptr_i  ( async_soc_to_cluster_axi_bus.aw_wptr ),
      .async_data_slave_aw_rptr_o  ( async_soc_to_cluster_axi_bus.aw_rptr ),
      .async_data_slave_aw_data_i  ( async_soc_to_cluster_axi_bus.aw_data ),
      .async_data_slave_ar_wptr_i  ( async_soc_to_cluster_axi_bus.ar_wptr ),
      .async_data_slave_ar_rptr_o  ( async_soc_to_cluster_axi_bus.ar_rptr ),
      .async_data_slave_ar_data_i  ( async_soc_to_cluster_axi_bus.ar_data ),
      .async_data_slave_w_data_i   ( async_soc_to_cluster_axi_bus.w_data  ),
      .async_data_slave_w_wptr_i   ( async_soc_to_cluster_axi_bus.w_wptr  ),
      .async_data_slave_w_rptr_o   ( async_soc_to_cluster_axi_bus.w_rptr  ),
      .async_data_slave_r_wptr_o   ( async_soc_to_cluster_axi_bus.r_wptr  ),
      .async_data_slave_r_rptr_i   ( async_soc_to_cluster_axi_bus.r_rptr  ),
      .async_data_slave_r_data_o   ( async_soc_to_cluster_axi_bus.r_data  ),
      .async_data_slave_b_wptr_o   ( async_soc_to_cluster_axi_bus.b_wptr  ),
      .async_data_slave_b_rptr_i   ( async_soc_to_cluster_axi_bus.b_rptr  ),
      .async_data_slave_b_data_o   ( async_soc_to_cluster_axi_bus.b_data  )
   );

  // Load ELF binary file
  task load_binary;
    input string binary;                   // File name
    addr_t       section_addr, section_len;
    byte         buffer[];

    // Read ELF
    void'(read_elf(binary));
    $display("[TB] Reading %s", binary);
    while (get_section(section_addr, section_len)) begin
      // Read Sections
      automatic int num_words = (section_len + AxiWideBeWidth - 1)/AxiWideBeWidth;
      $display("[TB] Reading section %x with %0d words", section_addr, num_words);

      sections[section_addr >> AxiWideByteOffset] = num_words;
      buffer                                      = new[num_words * AxiWideBeWidth];
      void'(read_section(section_addr, buffer));
      for (int i = 0; i < num_words; i++) begin
        automatic logic [AxiWideBeWidth-1:0][7:0] word = '0;
        for (int j = 0; j < AxiWideBeWidth; j++) begin
          word[j] = buffer[i * AxiWideBeWidth + j];
        end
        memory[section_addr/AxiWideBeWidth + i] = word;
      end
    end

  endtask // load_binary

  AXI_BUS_DV #(
      .AXI_ADDR_WIDTH(AxiAw ),
      .AXI_DATA_WIDTH(AxiDw ),
      .AXI_ID_WIDTH  (AxiIw ),
      .AXI_USER_WIDTH(AxiUw )
  ) axi_dv(s_clk);

  axi_test::axi_ax_beat #(.AW(AxiAw ), .IW(AxiIw ), .UW(AxiUw)) ar_beat = new();
  axi_test::axi_r_beat  #(.DW(AxiDw ), .IW(AxiIw ), .UW(AxiUw)) r_beat  = new();
  axi_test::axi_ax_beat #(.AW(AxiAw ), .IW(AxiIw ), .UW(AxiUw)) aw_beat = new();
  axi_test::axi_w_beat  #(.DW(AxiDw ), .UW(AxiUw))              w_beat  = new();
  axi_test::axi_b_beat  #(.IW(AxiIw ), .UW(AxiUw))              b_beat  = new();

  `AXI_ASSIGN(axi_slave[0], axi_dv)

  typedef axi_test::axi_driver #(.AW(AxiAw ), .DW(AxiDw ), .IW(AxiIw ), .UW(AxiUw), .TA(SYS_TA), .TT(SYS_TT)) axi_drv_t;
  axi_drv_t axi_master_drv = new(axi_dv);

  // Start writing to SRAM
  logic [32:0] addr;
  logic [AxiDw-1:0] ret_val;

  initial begin

   assign s_cluster_en_sa_boot = 1'b0;
   assign s_cluster_fetch_en = 1'b0;  
   axi_master_drv.reset_master();
   axi_master_drv.reset_slave();
     
   @(posedge s_rstn);
   @(posedge s_clk);

   if ( $value$plusargs ("APP=%s", binary));
     $display("[TB] Testing %s", binary);

   load_binary(binary);
     
   foreach (sections[addr]) begin
      $display("[TB] Writing %h with %0d words", addr << 3, sections[addr]); // word = 8 bytes here
      for (int i = 0; i < sections[addr]; i++) begin
         
        aw_beat.ax_addr  = ( addr << 3 ) + ( i * 8 );
        aw_beat.ax_len   = '0;
        aw_beat.ax_burst = axi_pkg::BURST_INCR;
        aw_beat.ax_size  = 4'h3;
        
        w_beat.w_data = memory[addr + i][63:0];
        w_beat.w_strb = '1;
        w_beat.w_last = '1;
 
        axi_master_drv.send_aw(aw_beat);
        axi_master_drv.send_w(w_beat);
        @(posedge s_clk);
        axi_master_drv.recv_b(b_beat);

      end // for (int i = 0; i < sections[addr]; i++)
      $display("[TB] Completed\n");      
   end 

   $display("[TB] Initialize ret_val\n");
     
   aw_beat.ax_addr  = 32'h1A10_40A0;
   aw_beat.ax_len   = '0;
   aw_beat.ax_burst = axi_pkg::BURST_INCR;
   aw_beat.ax_size  = 4'h3;
   
   w_beat.w_data = '0;
   w_beat.w_strb = '1;
   w_beat.w_last = '1;
 
   axi_master_drv.send_aw(aw_beat);
   axi_master_drv.send_w(w_beat);
   @(posedge s_clk);
   axi_master_drv.recv_b(b_beat);

   $display("[TB] Launch cluster\n");
     
   @(negedge s_clk);
   assign s_cluster_en_sa_boot = 1'b1;
   @(negedge s_clk);
   assign s_cluster_fetch_en = 1'b1;  

   ret_val = '0;
   while(~ret_val[31]) begin
      
      ar_beat.ax_addr  = 32'h1A10_40A0;
      ar_beat.ax_len   = '0;
      ar_beat.ax_burst = axi_pkg::BURST_INCR;
      ar_beat.ax_size  = 4'h2;

      axi_master_drv.send_ar(ar_beat);
      @(posedge s_clk);
      axi_master_drv.recv_r(r_beat);
      ret_val = r_beat.r_data;      
      repeat(1000)
        @(posedge s_clk);
      
   end
     
   $display("[TB] Received ret_val: %d\n", ret_val[30:0]);
     
   if(ret_val[30:0]==0) begin
     $display("[TB] Test passed\n");
     $finish;
   end else begin
     $fatal(1,"[TB] Test not passed: ret_val!=0\n");
   end
  
  end // initial begin
   
   
endmodule // pulp_cluster_tb
