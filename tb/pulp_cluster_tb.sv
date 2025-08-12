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
`include "axi/assign.svh"
`include "axi/typedef.svh"

import "DPI-C" function read_elf(input string filename);
import "DPI-C" function get_entry(output longint entry_ret);
import "DPI-C" function byte get_section(output longint address, output longint len);
import "DPI-C" context function byte read_section(input longint address, inout byte buffer[], input longint len);

// PULP Cluster flavors
`ifndef TB_ENABLE_WIDE_PORT
  `define TB_ENABLE_WIDE_PORT 1
`endif

module pulp_cluster_tb;
  localparam bit EnableWidePort = `TB_ENABLE_WIDE_PORT;

  import pulp_cluster_package::*;
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
  localparam NMst   = 3;
  localparam NSlv   = 3;
  localparam AxiIwMst = AxiIw + $clog2(NMst);
  localparam AxiWideBeWidth = AxiDw/8;
  localparam AxiWideByteOffset = $clog2(AxiWideBeWidth);
  localparam AxiUw = 10;

  localparam DmaAxiDw = EnableWidePort ? 256 : 64;
  localparam DmaAxiIw = EnableWidePort ? 1   : AxiIw;

  localparam bit[AxiAw-1:0] ClustBase       = 'h10000000;
  localparam bit[AxiAw-1:0] ClustPeriphOffs = 'h00200000;
  localparam bit[AxiAw-1:0] ClustExtOffs    = 'h00400000;
  localparam bit[      5:0] ClustIdx        = 'h0;
  localparam bit[AxiAw-1:0] ClustBaseAddr   = ClustBase;
  localparam bit[AxiAw-1:0] L2BaseAddr      = 'h1C000000;
  localparam bit[AxiAw-1:0] L2Size          = 'h00100000;
  localparam bit[AxiAw-1:0] BootAddr        = L2BaseAddr + 'h8080;
  localparam bit[AxiAw-1:0] ClustReturnInt  = ClustBase + ClustPeriphOffs + 'h100;

  typedef logic [AxiAw-1:0]    axi_addr_t;
  typedef logic [AxiDw-1:0]    axi_data_t;
  typedef logic [AxiDw/8-1:0]  axi_strb_t;
  typedef logic [AxiUw-1:0]    axi_user_t;
  typedef logic [AxiIw-1:0]    axi_id_t;
  typedef logic [AxiIwMst-1:0] axi_m_id_t;

  typedef logic [DmaAxiDw-1:0]   dma_axi_data_t;
  typedef logic [DmaAxiDw/8-1:0] dma_axi_strb_t;
  typedef logic [DmaAxiIw-1:0]   dma_axi_id_t;

  // Narrow AXI port type
  `AXI_TYPEDEF_W_CHAN_T(w_chan_t, axi_data_t, axi_strb_t, axi_user_t)
  `AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, axi_addr_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_chan_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, axi_addr_t, axi_id_t, axi_user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_chan_t, axi_data_t, axi_id_t, axi_user_t)

  `AXI_TYPEDEF_REQ_T(axi_req_t, aw_chan_t, w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(axi_resp_t, b_chan_t, r_chan_t)

  // Wide AXI port type
  `AXI_TYPEDEF_W_CHAN_T(dma_w_chan_t, dma_axi_data_t, dma_axi_strb_t, axi_user_t)
  `AXI_TYPEDEF_AW_CHAN_T(dma_aw_chan_t, axi_addr_t, dma_axi_id_t, axi_user_t)
  `AXI_TYPEDEF_B_CHAN_T(dma_b_chan_t, dma_axi_id_t, axi_user_t)
  `AXI_TYPEDEF_AR_CHAN_T(dma_ar_chan_t, axi_addr_t, dma_axi_id_t, axi_user_t)
  `AXI_TYPEDEF_R_CHAN_T(dma_r_chan_t, dma_axi_data_t, dma_axi_id_t, axi_user_t)

  `AXI_TYPEDEF_REQ_T(dma_axi_req_t, aw_chan_t, dma_w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(dma_axi_resp_t, b_chan_t, dma_r_chan_t)

  // Memory-side AXI port type
  `AXI_TYPEDEF_AW_CHAN_T(aw_m_chan_t, axi_addr_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_m_chan_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_m_chan_t, axi_addr_t, axi_m_id_t, axi_user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_m_chan_t, axi_data_t, axi_m_id_t, axi_user_t)

  `AXI_TYPEDEF_REQ_T(axi_m_req_t, aw_m_chan_t, w_chan_t, ar_m_chan_t)
  `AXI_TYPEDEF_RESP_T(axi_m_resp_t, b_m_chan_t, r_m_chan_t)

  typedef logic [AxiAw-1:0] addr_t;
  typedef logic [AxiDw-1:0] data_t;
  typedef logic [DmaAxiDw-1:0] dma_data_t;
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

  localparam pulp_cluster_cfg_t PulpClusterCfg = '{
    CoreType: pulp_cluster_package::RI5CY,
    NumCores: `NB_CORES,
    DmaNumPlugs: `NB_DMAS,
    DmaNumOutstandingBursts: 8,
    DmaBurstLength: 256,
    DmaUseHwpePort: `DMA_USE_HWPE_PORT,
    NumMstPeriphs: `NB_MPERIPHS,
    NumSlvPeriphs: `NB_SPERIPHS,
    ClusterAlias: 1,
    ClusterAliasBase: 'h0,
    NumSyncStages: 3,
    UseHci: 1,
    TcdmSize: 128*1024,
    TcdmNumBank: 16,
    HwpePresent: 1,
    HwpeCfg: '{NumHwpes: 1, HwpeList: {NEUREKA}},
    HwpeNumPorts: 9,
    HMRPresent: 1,
    HMRDmrEnabled: 1,
    HMRTmrEnabled: 1,
    HMRDmrFIxed: 0,
    HMRTmrFIxed: 0,
    HMRInterleaveGrps: 1,
    HMREnableRapidRecovery: 1,
    HMRSeparateDataVoters: 1,
    HMRSeparateAxiBus: 0,
    HMRNumBusVoters: 1,
    EnableECC: 0,
    ECCInterco: 0,
    iCacheNumBanks: 2,
    iCacheNumLines: 1,
    iCacheNumWays: 4,
    iCacheSharedSize: 4*1024,
    iCachePrivateSize: 512,
    iCachePrivateDataWidth: 32,
    EnableReducedTag: 1,
    L2Size: 1000*1024,
    DmBaseAddr: 'h60203000,
    BootRomBaseAddr: BootAddr,
    BootAddr: BootAddr,
    EnablePrivateFpu: 1,
    EnablePrivateFpDivSqrt: 0,
    NumAxiIn: NumAxiSubordinatePorts,
    NumAxiOut: NumAxiManagerPorts,
    AxiIdInWidth: AxiIw-2,
    AxiIdOutWidth: AxiIw,
    AxiIdOutWideWidth: 1,
    AxiAddrWidth: AxiAw,
    AxiDataInWidth: AxiDw,
    AxiDataOutWidth: AxiDw,
    AxiDataOutWideWidth: DmaAxiDw,
    AxiUserWidth: AxiUw,
    AxiMaxInTrans: 64,
    AxiMaxOutTrans: 64,
    AxiCdcLogDepth: 3,
    AxiCdcSyncStages: 3,
    SyncStages: 3,
    ClusterBaseAddr: ClustBaseAddr,
    ClusterPeriphOffs: ClustPeriphOffs,
    ClusterExternalOffs: ClustExtOffs,
    EnableRemapAddress: 0,
    EnableWidePort: EnableWidePort,
    SnitchICache: 0,
    default: '0
  };

  // Questasim visible; keep true to avoid optimization
  (* keep = "true" *) pulp_cluster_package::pulp_cluster_cfg_t PulpClusterCfgVis = PulpClusterCfg;

  initial begin
    if (EnableWidePort) begin
      $display("[TB] Instantiating cluster with wide ports");
    end else begin
      $display("[TB] Instantiating cluster with narrow ports");
    end
  end

  generate
    if (EnableWidePort) begin : gen_dma_buses
      // $display("[TB] Instantiting cluster with wide ports\n");
      AXI_BUS #(
        .AXI_ADDR_WIDTH( AxiAw    ),
        .AXI_DATA_WIDTH( DmaAxiDw ),
        .AXI_ID_WIDTH  ( DmaAxiIw ),
        .AXI_USER_WIDTH( AxiUw )
      ) dma_slave();

      AXI_BUS #(
        .AXI_ADDR_WIDTH( AxiAw ),
        .AXI_DATA_WIDTH( DmaAxiDw ),
        .AXI_ID_WIDTH  ( AxiIw ),
        .AXI_USER_WIDTH( AxiUw )
      ) dma_slave_iw();

      AXI_BUS_ASYNC_GRAY #(
        .AXI_ADDR_WIDTH ( AxiAw    ),
        .AXI_DATA_WIDTH ( DmaAxiDw ),
        .AXI_ID_WIDTH   ( DmaAxiIw ),
        .AXI_USER_WIDTH ( AxiUw    ),
        .LOG_DEPTH      ( 3        )
      ) async_dma_axi_bus();

      axi_dw_converter_intf #(
        .AXI_ID_WIDTH            ( AxiIw    ),
        .AXI_ADDR_WIDTH          ( AxiAw    ),
        .AXI_SLV_PORT_DATA_WIDTH ( DmaAxiDw ),
        .AXI_MST_PORT_DATA_WIDTH ( AxiDw    ),
        .AXI_USER_WIDTH          ( AxiUw    ),
        .AXI_MAX_READS           ( 3        )
      ) i_dma_dw_conv (
        .clk_i  ( s_clk        ),
        .rst_ni ( s_rstn       ),
        .slv    ( dma_slave_iw ),
        .mst    ( axi_slave[2] )
      );

      axi_iw_converter_intf #(
        .AXI_SLV_PORT_ID_WIDTH        ( DmaAxiIw ),
        .AXI_MST_PORT_ID_WIDTH        ( AxiIw    ),
        .AXI_SLV_PORT_MAX_UNIQ_IDS    ( 5        ),
        .AXI_SLV_PORT_MAX_TXNS_PER_ID ( 5        ),
        .AXI_SLV_PORT_MAX_TXNS        ( 5        ),
        .AXI_MST_PORT_MAX_UNIQ_IDS    ( 5        ),
        .AXI_MST_PORT_MAX_TXNS_PER_ID ( 5        ),
        .AXI_ADDR_WIDTH               ( AxiAw    ),
        .AXI_DATA_WIDTH               ( DmaAxiDw ),
        .AXI_USER_WIDTH               ( AxiUw    )
      ) i_dma_iw_conv (
        .clk_i  ( s_clk        ),
        .rst_ni ( s_rstn       ),
        .slv    ( dma_slave    ),
        .mst    ( dma_slave_iw )
      );

      axi_cdc_dst_intf   #(
        .AXI_ADDR_WIDTH ( AxiAw    ),
        .AXI_DATA_WIDTH ( DmaAxiDw ),
        .AXI_ID_WIDTH   ( DmaAxiIw ),
        .AXI_USER_WIDTH ( AxiUw    ),
        .LOG_DEPTH      ( 3        )
      ) cluster_to_soc_dma_dst_cdc_fifo_i (
        .dst_clk_i  ( s_clk             ),
        .dst_rst_ni ( s_rstn            ),
        .src        ( async_dma_axi_bus ),
        .dst        ( dma_slave         )
      );

      pulp_cluster
      `ifdef USE_PULP_PARAMETERS
        #( .Cfg ( PulpClusterCfg ) )
      `endif
      cluster_i (
        .clk_i                       ( s_clk                                ),
        .rst_ni                      ( s_rstn                               ),
        .pwr_on_rst_ni               ( s_rstn                               ),
        .ref_clk_i                   ( s_clk                                ),
        .axi_isolate_i               ( '0                                   ),
        .axi_isolated_o              (                                      ),
        .axi_isolated_wide_o         (                                      ),

        .pmu_mem_pwdn_i              ( 1'b0                                 ),

        .base_addr_i                 ( ClustBase[31:28]                     ),

        .dma_pe_evt_ack_i            ( '1                                   ),
        .dma_pe_evt_valid_o          (                                      ),

        .dma_pe_irq_ack_i            ( 1'b1                                 ),
        .dma_pe_irq_valid_o          (                                      ),

        .dbg_irq_valid_i             ( '0                                   ),
        .mbox_irq_i                  ( '0                                   ),

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
        .cluster_id_i                ( ClustIdx                             ),

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

        .async_wide_master_aw_wptr_o ( async_dma_axi_bus.aw_wptr ),
        .async_wide_master_aw_rptr_i ( async_dma_axi_bus.aw_rptr ),
        .async_wide_master_aw_data_o ( async_dma_axi_bus.aw_data ),
        .async_wide_master_ar_wptr_o ( async_dma_axi_bus.ar_wptr ),
        .async_wide_master_ar_rptr_i ( async_dma_axi_bus.ar_rptr ),
        .async_wide_master_ar_data_o ( async_dma_axi_bus.ar_data ),
        .async_wide_master_w_data_o  ( async_dma_axi_bus.w_data  ),
        .async_wide_master_w_wptr_o  ( async_dma_axi_bus.w_wptr  ),
        .async_wide_master_w_rptr_i  ( async_dma_axi_bus.w_rptr  ),
        .async_wide_master_r_wptr_i  ( async_dma_axi_bus.r_wptr  ),
        .async_wide_master_r_rptr_o  ( async_dma_axi_bus.r_rptr  ),
        .async_wide_master_r_data_i  ( async_dma_axi_bus.r_data  ),
        .async_wide_master_b_wptr_i  ( async_dma_axi_bus.b_wptr  ),
        .async_wide_master_b_rptr_o  ( async_dma_axi_bus.b_rptr  ),
        .async_wide_master_b_data_i  ( async_dma_axi_bus.b_data  ),

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

    end else begin : gen_dma_stubs
      // Dummy wires with correct width for cluster port connections
      logic async_dma_axi_bus_aw_wptr;
      logic async_dma_axi_bus_aw_rptr;
      logic async_dma_axi_bus_aw_data;
      logic async_dma_axi_bus_ar_wptr;
      logic async_dma_axi_bus_ar_rptr;
      logic async_dma_axi_bus_ar_data;
      logic async_dma_axi_bus_w_wptr;
      logic async_dma_axi_bus_w_rptr;
      logic async_dma_axi_bus_w_data;
      logic async_dma_axi_bus_r_wptr;
      logic async_dma_axi_bus_r_rptr;
      logic async_dma_axi_bus_r_data;
      logic async_dma_axi_bus_b_wptr;
      logic async_dma_axi_bus_b_rptr;
      logic async_dma_axi_bus_b_data;

      // $display("[TB] Instantiting cluster with narrow ports\n");
      pulp_cluster
      `ifdef USE_PULP_PARAMETERS
        #( .Cfg ( PulpClusterCfg ) )
      `endif
      cluster_i (
        .clk_i                       ( s_clk                                ),
        .rst_ni                      ( s_rstn                               ),
        .pwr_on_rst_ni               ( s_rstn                               ),
        .ref_clk_i                   ( s_clk                                ),
        .axi_isolate_i               ( '0                                   ),
        .axi_isolated_o              (                                      ),
        .axi_isolated_wide_o         (                                      ),

        .pmu_mem_pwdn_i              ( 1'b0                                 ),

        .base_addr_i                 ( ClustBase[31:28]                     ),

        .dma_pe_evt_ack_i            ( '1                                   ),
        .dma_pe_evt_valid_o          (                                      ),

        .dma_pe_irq_ack_i            ( 1'b1                                 ),
        .dma_pe_irq_valid_o          (                                      ),

        .dbg_irq_valid_i             ( '0                                   ),
        .mbox_irq_i                  ( '0                                   ),

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
        .cluster_id_i                ( ClustIdx                             ),

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

        // Wide master ports tied off when wide port disabled
        .async_wide_master_aw_wptr_o (                                      ),
        .async_wide_master_aw_rptr_i ( '0                                   ),
        .async_wide_master_aw_data_o (                                      ),
        .async_wide_master_ar_wptr_o (                                      ),
        .async_wide_master_ar_rptr_i ( '0                                   ),
        .async_wide_master_ar_data_o (                                      ),
        .async_wide_master_w_data_o  (                                      ),
        .async_wide_master_w_wptr_o  (                                      ),
        .async_wide_master_w_rptr_i  ( '0                                   ),
        .async_wide_master_r_wptr_i  ( '0                                   ),
        .async_wide_master_r_rptr_o  (                                      ),
        .async_wide_master_r_data_i  ( 'x                                   ),
        .async_wide_master_b_wptr_i  ( '0                                   ),
        .async_wide_master_b_rptr_o  (                                      ),
        .async_wide_master_b_data_i  ( 'x                                   ),

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
    end
  endgenerate

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
    .axi_req_t ( axi_m_req_t  ),
    .axi_rsp_t ( axi_m_resp_t ),
    .UninitializedData ( "random" ),
    .ApplDelay ( SYS_TA       ),
    .AcqDelay  ( SYS_TT       )
  ) sim_mem (
     .clk_i     ( s_clk      ),
     .rst_ni    ( s_rstn     ),
     .axi_req_i ( axi_memreq ),
     .axi_rsp_o ( axi_memrsp ),
     .mon_w_valid_o     (),
     .mon_w_addr_o      (),
     .mon_w_data_o      (),
     .mon_w_id_o        (),
     .mon_w_user_o      (),
     .mon_w_beat_count_o(),
     .mon_w_last_o      (),
     .mon_r_valid_o     (),
     .mon_r_addr_o      (),
     .mon_r_data_o      (),
     .mon_r_id_o        (),
     .mon_r_user_o      (),
     .mon_r_beat_count_o(),
     .mon_r_last_o      ()
  );

  mock_uart_axi #(
   .AxiIw   ( AxiIwMst      ),
   .AxiAw   ( AxiAw         ),
   .AxiDw   ( AxiDw         ),
   .AxiUw   ( AxiUw         ),
   .N_CORES ( 8             ),
   .BaseAddr( 32'h4000_0000 )
  ) i_mock_uart (
     .clk_i  ( s_clk         ),
     .rst_ni ( s_rstn        ),
     .test_i ( '0            ),
     .uart   ( axi_master[0] )
  );

  // XBAR
  localparam int unsigned NumRules = NSlv;

  typedef struct packed {
    int unsigned idx;
    logic [AxiAw-1:0] start_addr;
    logic [AxiAw-1:0] end_addr;
  } rule_t;

  rule_t [NumRules-1:0] addr_map;
  assign addr_map[0] = '{ // UART
    idx:        0,
    start_addr: 'h03002000,
    end_addr:   'h03003000
  };
  assign addr_map[1] = '{ // 512KiB L2SPM
    idx:        1,
    start_addr: L2BaseAddr,
    end_addr:   L2BaseAddr + L2Size
  };
  assign addr_map[2] = '{ // Pulp Cluster
    idx:        2,
    start_addr: ClustBaseAddr,
    end_addr:   ClustBaseAddr + ClustExtOffs
  };

  // Crossbar Configuration and Instantiation
  localparam axi_pkg::xbar_cfg_t XbarCfg = '{
    NoSlvPorts:         NMst,
    NoMstPorts:         NSlv,
    MaxMstTrans:        8,
    MaxSlvTrans:        8,
    FallThrough:        1'b1,
    LatencyMode:        axi_pkg::NO_LATENCY,
    PipelineStages:     0,
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

  // Load ELF binary file
  task load_binary;
    input  string binary;                   // File name
    output addr_t entry_point;
    addr_t        section_addr, section_len;
    byte          buffer[];
    addr_t        section_addr_offset;

    // Read ELF
    void'(read_elf(binary));
    get_entry(entry_point);
    $display("[TB] Reading %s", binary);
    while (get_section(section_addr, section_len)) begin
      // Read Sections
      automatic int num_start_unaligned_bytes = section_addr%AxiWideBeWidth;
      automatic int num_wide_words = (num_start_unaligned_bytes + section_len + AxiWideBeWidth - 1)/AxiWideBeWidth;

      $display("[TB] Reading section %x with %0d words", section_addr, num_wide_words);

      sections[section_addr >> AxiWideByteOffset] = num_wide_words;
      buffer                                      = new[num_wide_words * AxiWideBeWidth];
      void'(read_section(section_addr, buffer, section_len));
      for (int i = 0; i < num_wide_words; i++) begin
        automatic logic [AxiWideBeWidth-1:0][7:0] word = '0;
        for (int j = 0; j < AxiWideBeWidth; j++) begin
          automatic int index = i * AxiWideBeWidth + j - num_start_unaligned_bytes; 
          if(index >= 0) begin 
            word[j] = buffer[index];
          end
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
  logic [31:0] boot_addr;

  initial begin

   assign s_cluster_en_sa_boot = 1'b0;
   assign s_cluster_fetch_en = 1'b0;
   axi_master_drv.reset_master();
   axi_master_drv.reset_slave();

   @(posedge s_rstn);
   @(posedge s_clk);

   if ( $value$plusargs ("APP=%s", binary));
     $display("[TB] Testing %s", binary);

   load_binary(binary, boot_addr);

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

   aw_beat.ax_addr  = ClustReturnInt;
   aw_beat.ax_len   = '0;
   aw_beat.ax_burst = axi_pkg::BURST_INCR;
   aw_beat.ax_size  = 4'h3;

   w_beat.w_data = '1;
   w_beat.w_strb = '1;
   w_beat.w_last = '1;

   axi_master_drv.send_aw(aw_beat);
   axi_master_drv.send_w(w_beat);
   @(posedge s_clk);
   axi_master_drv.recv_b(b_beat);

   $display("[TB] Launch cluster\n");

   for (int i = 0; i < `NB_CORES; i++) begin
     aw_beat.ax_addr  = ClustBase + ClustPeriphOffs + 'h40 + i*4;
     aw_beat.ax_len   = '0;
     aw_beat.ax_burst = axi_pkg::BURST_INCR;
     aw_beat.ax_size  = 4'h3;

     w_beat.w_data = boot_addr;
     w_beat.w_strb = 'h1;
     w_beat.w_last = 'h1;

     axi_master_drv.send_aw(aw_beat);
     axi_master_drv.send_w(w_beat);
     @(posedge s_clk);
     axi_master_drv.recv_b(b_beat);
   end

   @(negedge s_clk);
   assign s_cluster_en_sa_boot = 1'b1;
   @(negedge s_clk);
   assign s_cluster_fetch_en = 1'b1;

   ret_val = '0;
   while(~s_cluster_eoc) begin
     repeat(1)
       @(posedge s_clk);
   end

   ar_beat.ax_addr  = ClustReturnInt;
   ar_beat.ax_len   = '0;
   ar_beat.ax_burst = axi_pkg::BURST_INCR;
   ar_beat.ax_size  = 4'h2;

   axi_master_drv.send_ar(ar_beat);
   @(posedge s_clk);
   axi_master_drv.recv_r(r_beat);
   ret_val = r_beat.r_data;

   $display("[TB] Received ret_val: %d\n", ret_val[30:0]);

   if(ret_val[30:0]==0) begin
     $display("[TB] Test passed\n");
     $finish;
   end else begin
     $fatal(1,"[TB] Test not passed: ret_val!=0\n");
   end

  end


endmodule : pulp_cluster_tb
