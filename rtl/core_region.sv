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
 * core_region.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

import apu_package::*;

// USER DEFINED MACROS to improve self-testing capabilities
`ifndef PULP_FPGA_SIM
  `define DEBUG_FETCH_INTERFACE
`endif
//`define DATA_MISS
//`define DUMP_INSTR_FETCH

module core_region
#(
  // CORE PARAMETERS
  parameter int     CORE_ID                 = 0,
  parameter int     ADDR_WIDTH              = 32,
  parameter int     DATA_WIDTH              = 32,
  parameter int     INSTR_RDATA_WIDTH       = 32,
  parameter bit     CLUSTER_ALIAS           = 1'b1,
  parameter int     CLUSTER_ALIAS_BASE      = 12'h000,
  parameter int     REMAP_ADDRESS           = 0,
  parameter bit     DEM_PER_BEFORE_TCDM_TS  = 1'b0
`ifndef SYNTHESIS
  ,
  parameter string  L2_SLM_FILE   = "./slm_files/l2_stim.slm",
  parameter string  ROM_SLM_FILE  = "../sw/apps/boot/slm_files/l2_stim.slm"
`endif
)
(
  input logic 			      clk_i,
  input logic 			      rst_ni,
  input logic 			      init_ni,

  input logic [3:0] 		      base_addr_i, // FOR CLUSTER VIRTUALIZATION

  input logic [5:0] 		      cluster_id_i,
  
  input logic 			      irq_req_i,
  output logic 			      irq_ack_o,
  input logic [4:0] 		      irq_id_i,
  output logic [4:0] 		      irq_ack_id_o,
  
  input logic 			      clock_en_i,
  input logic 			      fetch_en_i,
  input logic 			      fregfile_disable_i,

  input logic [31:0] 		      boot_addr_i,

  input logic 			      test_mode_i,

  output logic 			      core_busy_o,

  // Interface to Instruction Logarithmic interconnect (Req->grant handshake)
  output logic 			      instr_req_o,
  input logic 			      instr_gnt_i,
  output logic [31:0] 		      instr_addr_o,
  input logic [INSTR_RDATA_WIDTH-1:0] instr_r_rdata_i,
  input logic 			      instr_r_valid_i,
				      
				      XBAR_TCDM_BUS.Slave debug_bus,
  output logic 			      debug_core_halted_o,
  input logic 			      debug_core_halt_i,
  input logic 			      debug_core_resume_i,
				      
				      // Interface for DEMUX to TCDM INTERCONNECT ,PERIPHERAL INTERCONNECT and DMA CONTROLLER
				      XBAR_TCDM_BUS.Master tcdm_data_master,
				      XBAR_TCDM_BUS.Master dma_ctrl_master,
				      XBAR_PERIPH_BUS.Master eu_ctrl_master,
				      XBAR_PERIPH_BUS.Master periph_data_master,
				      output logic [5:0]     periph_data_master_atop,
				      
				      // APU interconnect interface
				      cpu_marx_if.cpu apu_master
);

  XBAR_DEMUX_BUS    s_core_bus();         // Internal interface between CORE       <--> DEMUX
  XBAR_PERIPH_BUS   periph_demux_bus();   // Internal interface between CORE_DEMUX <--> PERIPHERAL DEMUX

  logic [4:0]      perf_counters;
  logic            clk_int;

  // clock gate of the core_region less the core itself
  cluster_clock_gating clock_gate_i (
    .clk_i     ( clk_i       ),
    .en_i      ( clock_en_i  ),
    .test_en_i ( test_mode_i ),
    .clk_o     ( clk_int     )
  );

  riscv_core #(
    .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH ),
    .N_EXT_PERF_COUNTERS ( 5                 ),
    .FPU                 ( FPU               ),
    .SHARED_FP           ( SHARED_FP         ),
    .SHARED_DSP_MULT     ( SHARED_DSP_MULT   ),
    .SHARED_INT_DIV      ( SHARED_INT_DIV    ),
    .SHARED_FP_DIVSQRT   ( SHARED_FP_DIVSQRT ),
    .WAPUTYPE            ( WAPUTYPE          )
  ) RISCV_CORE (
    .clk_i                 ( clk_i                    ),
    .rst_ni                ( rst_ni                   ),

    .clock_en_i            ( clock_en_i               ),
    .test_en_i             ( test_mode_i              ),

    .boot_addr_i           ( boot_addr_i              ),
    .core_id_i             ( CORE_ID[3:0]             ),
    .cluster_id_i          ( cluster_id_i             ),

    .instr_addr_o          ( instr_addr_o             ),
    .instr_req_o           ( instr_req_o              ),
    .instr_rdata_i         ( instr_r_rdata_i          ),
    .instr_gnt_i           ( instr_gnt_i              ),
    .instr_rvalid_i        ( instr_r_valid_i          ),

    .data_addr_o           ( s_core_bus.add           ),
    .data_wdata_o          ( s_core_bus.wdata         ),
    .data_we_o             ( s_core_bus.we            ),
    .data_atop_o           ( s_core_bus.atop          ),
    .data_req_o            ( s_core_bus.req           ),
    .data_be_o             ( s_core_bus.be            ),
    .data_rdata_i          ( s_core_bus.r_rdata       ),
    .data_gnt_i            ( s_core_bus.gnt           ),
    .data_rvalid_i         ( s_core_bus.r_valid       ),
    .data_err_i            ( 1'b0                     ),

    .irq_i                 ( irq_req_i                ),
    .irq_id_i              ( irq_id_i                 ),
    .irq_id_o              ( irq_ack_id_o             ),
    .irq_ack_o             ( irq_ack_o                ),

    .sec_lvl_o             (                          ),
    .irq_sec_i             (                          ),

    .debug_req_i           ( debug_bus.req            ),
    .debug_gnt_o           ( debug_bus.gnt            ),
    .debug_rvalid_o        ( debug_bus.r_valid        ),
    .debug_addr_i          ( debug_bus.add[14:0]      ),
    .debug_we_i            ( ~debug_bus.wen           ),
    .debug_wdata_i         ( debug_bus.wdata          ),
    .debug_rdata_o         ( debug_bus.r_rdata        ),
    .debug_halted_o        ( debug_core_halted_o      ),
    .debug_halt_i          ( debug_core_halt_i        ),
    .debug_resume_i        ( debug_core_resume_i      ),

    .fetch_enable_i        ( fetch_en_i               ),
    .core_busy_o           ( core_busy_o              ),
    // apu-interconnect
    // handshake signals
    .apu_master_req_o      ( apu_master.req_ds_s      ),
    .apu_master_ready_o    ( apu_master.ready_us_s    ),
    .apu_master_gnt_i      ( apu_master.ack_ds_s      ),
     // request channel
    .apu_master_operands_o ( apu_master.operands_ds_d ),
    .apu_master_op_o       ( apu_master.op_ds_d       ),
    .apu_master_type_o     ( apu_master.type_ds_d     ),
    .apu_master_flags_o    ( apu_master.flags_ds_d    ),
    // response channel
    .apu_master_valid_i    ( apu_master.valid_us_s    ),
    .apu_master_result_i   ( apu_master.result_us_d   ),
    .apu_master_flags_i    ( apu_master.flags_us_d    ),

    .ext_perf_counters_i   ( perf_counters            ),
    .fregfile_disable_i    ( fregfile_disable_i       )
  );

  assign debug_bus.r_opc = 1'b0;

  // Bind to 0 Unused Signals in CORE interface
  assign s_core_bus.r_gnt       = 1'b0;
  assign s_core_bus.barrier     = 1'b0;
  assign s_core_bus.exec_cancel = 1'b0;
  assign s_core_bus.exec_stall  = 1'b0;

  // Performance Counters
  assign perf_counters[4] = tcdm_data_master.req & (~tcdm_data_master.gnt);  // Cycles lost due to contention

  // demuxes to TCDM & memory hierarchy
  core_demux #(
    .ADDR_WIDTH             ( 32                      ),
    .DATA_WIDTH             ( 32                      ),
    .BYTE_ENABLE_BIT        ( DATA_WIDTH/8            ),
    .CLUSTER_ALIAS          ( CLUSTER_ALIAS           ),
    .CLUSTER_ALIAS_BASE     ( CLUSTER_ALIAS_BASE      ),
    .DEM_PER_BEFORE_TCDM_TS ( DEM_PER_BEFORE_TCDM_TS  ),
    .REMAP_ADDRESS          ( REMAP_ADDRESS           )
  ) core_demux_i (
    .clk                (  clk_int                    ),
    .rst_ni             (  rst_ni                     ),
    .test_en_i          (  test_mode_i                ),
    .base_addr_i        (  base_addr_i                ),

    .data_req_i         (  s_core_bus.req             ),
    .data_add_i         (  s_core_bus.add             ),
    .data_wen_i         ( ~s_core_bus.we              ), //inverted when using OR10N
    .data_atop_i        (  s_core_bus.atop            ),
    .data_wdata_i       (  s_core_bus.wdata           ),
    .data_be_i          (  s_core_bus.be              ),
    .data_gnt_o         (  s_core_bus.gnt             ),
    .data_r_gnt_i       (  s_core_bus.r_gnt           ),
    .data_r_valid_o     (  s_core_bus.r_valid         ),
    .data_r_opc_o       (                             ),
    .data_r_rdata_o     (  s_core_bus.r_rdata         ),

    .data_req_o_SH      (  tcdm_data_master.req       ),
    .data_add_o_SH      (  tcdm_data_master.add       ),
    .data_wen_o_SH      (  tcdm_data_master.wen       ),
    .data_wdata_o_SH    (  tcdm_data_master.wdata     ),
    .data_be_o_SH       (  tcdm_data_master.be        ),
    .data_gnt_i_SH      (  tcdm_data_master.gnt       ),
    .data_r_valid_i_SH  (  tcdm_data_master.r_valid   ),
    .data_r_rdata_i_SH  (  tcdm_data_master.r_rdata   ),

    .data_req_o_EXT     (  periph_demux_bus.req       ),
    .data_add_o_EXT     (  periph_demux_bus.add       ),
    .data_wen_o_EXT     (  periph_demux_bus.wen       ),
    .data_wdata_o_EXT   (  periph_demux_bus.wdata     ),
    .data_be_o_EXT      (  periph_demux_bus.be        ),
    .data_gnt_i_EXT     (  periph_demux_bus.gnt       ),
    .data_r_valid_i_EXT (  periph_demux_bus.r_valid   ),
    .data_r_rdata_i_EXT (  periph_demux_bus.r_rdata   ),
    .data_r_opc_i_EXT   (  periph_demux_bus.r_opc     ),

    .data_req_o_PE      (  periph_data_master.req     ),
    .data_add_o_PE      (  periph_data_master.add     ),
    .data_wen_o_PE      (  periph_data_master.wen     ),
    .data_atop_o_PE     (  periph_data_master_atop    ),
    .data_wdata_o_PE    (  periph_data_master.wdata   ),
    .data_be_o_PE       (  periph_data_master.be      ),
    .data_gnt_i_PE      (  periph_data_master.gnt     ),
    .data_r_valid_i_PE  (  periph_data_master.r_valid ),
    .data_r_rdata_i_PE  (  periph_data_master.r_rdata ),
    .data_r_opc_i_PE    (  periph_data_master.r_opc   ),

    .perf_l2_ld_o       (  perf_counters[0]           ),
    .perf_l2_st_o       (  perf_counters[1]           ),
    .perf_l2_ld_cyc_o   (  perf_counters[2]           ),
    .perf_l2_st_cyc_o   (  perf_counters[3]           ),
    .CLUSTER_ID         (  cluster_id_i               )
  );

  periph_demux #(
    .DEM_PER_BEFORE_TCDM_TS (DEM_PER_BEFORE_TCDM_TS)
  ) periph_demux_i (
    .clk               ( clk_int                  ),
    .rst_ni            ( rst_ni                   ),

    .data_req_i        ( periph_demux_bus.req     ),
    .data_add_i        ( periph_demux_bus.add     ),
    .data_wen_i        ( periph_demux_bus.wen     ),
    .data_wdata_i      ( periph_demux_bus.wdata   ),
    .data_be_i         ( periph_demux_bus.be      ),
    .data_gnt_o        ( periph_demux_bus.gnt     ),

    .data_r_valid_o    ( periph_demux_bus.r_valid ),
    .data_r_opc_o      ( periph_demux_bus.r_opc   ),
    .data_r_rdata_o    ( periph_demux_bus.r_rdata ),

    .data_req_o_MH     ( dma_ctrl_master.req      ),
    .data_add_o_MH     ( dma_ctrl_master.add      ),
    .data_wen_o_MH     ( dma_ctrl_master.wen      ),
    .data_wdata_o_MH   ( dma_ctrl_master.wdata    ),
    .data_be_o_MH      ( dma_ctrl_master.be       ),
    .data_gnt_i_MH     ( dma_ctrl_master.gnt      ),

    .data_r_valid_i_MH ( dma_ctrl_master.r_valid  ),
    .data_r_rdata_i_MH ( dma_ctrl_master.r_rdata  ),
    .data_r_opc_i_MH   ( dma_ctrl_master.r_opc    ),

    .data_req_o_EU     ( eu_ctrl_master.req       ),
    .data_add_o_EU     ( eu_ctrl_master.add       ),
    .data_wen_o_EU     ( eu_ctrl_master.wen       ),
    .data_wdata_o_EU   ( eu_ctrl_master.wdata     ),
    .data_be_o_EU      ( eu_ctrl_master.be        ),
    .data_gnt_i_EU     ( eu_ctrl_master.gnt       ),

    .data_r_valid_i_EU ( eu_ctrl_master.r_valid   ),
    .data_r_rdata_i_EU ( eu_ctrl_master.r_rdata   ),
    .data_r_opc_i_EU   ( eu_ctrl_master.r_opc     )
  );

  /* debug stuff */
  //synopsys translate_off

  // COMPARE THE output of the instruction CACHE with the slm files generated by the compiler
`ifdef DEBUG_FETCH_INTERFACE
  integer FILE;
  string  FILENAME;
  string  FILE_ID;

  logic                         instr_gnt_L2;
  logic                         instr_gnt_ROM;
  logic [INSTR_RDATA_WIDTH-1:0] instr_r_rdata_ROM;
  logic                         instr_r_valid_ROM;
  logic [INSTR_RDATA_WIDTH-1:0] instr_r_rdata_L2;
  logic                         instr_r_valid_L2;
  logic                         destination; //--> 0 fetch from BOOT_ROM, 1--> fetch from L2_MEMORY

  initial
  begin
    FILE_ID.itoa(CORE_ID);
    FILENAME = {"FETCH_CORE_", FILE_ID, ".log" };
    FILE=$fopen(FILENAME,"w");
  end

  // BOOT code is loaded in this dummy ROM_MEMORY
/* -----\/----- EXCLUDED -----\/-----
  generate
    case(INSTR_RDATA_WIDTH)
      128: begin
        ibus_lint_memory_128 #(
          .addr_width    ( 16           ),
          .INIT_MEM_FILE ( ROM_SLM_FILE )
        ) ROM_MEMORY (
          .clk            ( clk_i              ),
          .rst_n          ( rst_ni             ),
          .lint_req_i     ( instr_req_o        ),
          .lint_grant_o   ( instr_gnt_ROM      ),
          .lint_addr_i    ( instr_addr_o[19:4] ), //instr_addr_o[17:2]   --> 2^17 bytes max program
          .lint_r_rdata_o ( instr_r_rdata_ROM  ),
          .lint_r_valid_o ( instr_r_valid_ROM  )
        );

        // application code is loaded in this dummy L2_MEMORY
        ibus_lint_memory_128 #(
          .addr_width    ( 16          ),
          .INIT_MEM_FILE ( L2_SLM_FILE )
        ) L2_MEMORY (
          .clk            ( clk_i              ),
          .rst_n          ( rst_ni             ),
          .lint_req_i     ( instr_req_o        ),
          .lint_grant_o   ( instr_gnt_L2       ),
          .lint_addr_i    ( instr_addr_o[19:4] ), //instr_addr_o[17:2]    --> 2^17 bytes max program
          .lint_r_rdata_o ( instr_r_rdata_L2   ),
          .lint_r_valid_o ( instr_r_valid_L2   )
        );
      end
      32: begin
        ibus_lint_memory #(
          .addr_width      ( 16              ),
          .INIT_MEM_FILE   ( ROM_SLM_FILE    )
        ) ROM_MEMORY (
          .clk             ( clk_i              ),
          .rst_n           ( rst_ni             ),
          .lint_req_i      ( instr_req_o        ),
          .lint_grant_o    ( instr_gnt_ROM      ),
          .lint_addr_i     ( instr_addr_o[17:2] ), //instr_addr_o[17:2]   --> 2^17 bytes max program
          .lint_r_rdata_o  ( instr_r_rdata_ROM  ),
          .lint_r_valid_o  ( instr_r_valid_ROM  )
        );

        // application code is loaded in this dummy L2_MEMORY
        ibus_lint_memory #(
          .addr_width      ( 16                 ),
          .INIT_MEM_FILE   ( L2_SLM_FILE        )
        ) L2_MEMORY (
          .clk             ( clk_i              ),
          .rst_n           ( rst_ni             ),
          .lint_req_i      ( instr_req_o        ),
          .lint_grant_o    ( instr_gnt_L2       ),
          .lint_addr_i     ( instr_addr_o[17:2] ), //instr_addr_o[17:2]    --> 2^17 bytes max program
          .lint_r_rdata_o  ( instr_r_rdata_L2   ),
          .lint_r_valid_o  ( instr_r_valid_L2   )
        );
      end
    endcase // INSTR_RDATA_WIDTH
  endgenerate
 -----/\----- EXCLUDED -----/\----- */

  // SELF CHECK ROUTINES TO compare isntruction fetches with slm files
  always_ff @(posedge clk_i)
  begin
    if(instr_r_valid_i) begin
      $fwrite( FILE , "\t --> %8h\n",instr_r_rdata_i);
      case(destination)
        1'b1: begin
          // Not active by default as it is wrong once the code is dynamically modified
          //if(instr_r_rdata_i !== instr_r_rdata_L2)
          //begin
          //  $warning("Error DURING L2 fetch: %x != %x", instr_r_rdata_i, instr_r_rdata_L2);
          //  $stop();
          //end
        end
        1'b0: begin
          if(instr_r_rdata_i !== instr_r_rdata_ROM) begin
            $warning("Error DURING ROM Fetch: %x != %x", instr_r_rdata_i, instr_r_rdata_ROM);
            $stop();
          end
        end
      endcase
    end
    //DUMP TO FILE every transaction to instruction cache
    if(instr_req_o & instr_gnt_i) begin
      if(instr_addr_o[31:24] == 8'h1A)
        destination <= 1'b0;
      else
        destination <= 1'b1;
`ifdef DUMP_INSTR_FETCH
      $fwrite( FILE , "%t [ns]: FETCH at address %8h",$time/1000, instr_addr_o);
`endif
    end
  end
`endif

`ifdef DATA_MISS
  logic data_hit;
  logic req;
`endif
  logic reg_cache_refill;

  always_ff @(posedge clk_i , negedge rst_ni)
  begin
    if ( rst_ni == 1'b0 ) begin
      reg_cache_refill <= 1'b0;
    end
    else begin
      if (instr_req_o)
        reg_cache_refill <= 1'b1;
      else if(instr_r_valid_i && !instr_req_o)
        reg_cache_refill <= 1'b0;
    end
  end
//synopsys translate_on

endmodule
