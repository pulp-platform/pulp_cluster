// Copyright 2021 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
// 
// Module to instantiate RISC-V core (ibex or RI5CY)

`include "pulp_soc_defines.sv"
`include "periph_bus_defines.sv"

module cluster_core_wrap #(
  // CORE PARAMETERS
  parameter CORE_TYPE_CL        = 0,            // 0 for RI5CY, 1 for IBEX RV32IMC (formerly ZERORISCY), 2 for IBEX RV32EC (formerly MICRORISCY)
  parameter N_EXT_PERF_COUNTERS = 0,
  parameter FPU                 = 0,
  parameter FP_DIVSQRT          = 0,
  parameter SHARED_FP           = 0,
  parameter SHARED_FP_DIVSQRT   = 0,
  parameter DEBUG_START_ADDR    = 32'h1A110000,
  parameter INSTR_RDATA_WIDTH   = 128,
  // SHARED_FPU_CLUSTER params
  parameter WAPUTYPE            = 3,
  parameter APU_NARGS_CPU       = 2,
  parameter APU_WOP_CPU         = 1,
  parameter APU_NDSFLAGS_CPU    = 3,
  parameter APU_NUSFLAGS_CPU    = 5
) (
  input  logic                                 clk_i,                 // Clock
  input  logic                                 rst_ni,                // Asynchronous reset active low

  input  logic [                    3:0]       core_id_i,
  input  logic [                    5:0]       cluster_id_i,

  input  logic                                 irq_req_i,
  output logic                                 irq_ack_o,
  input  logic [                    4:0]       irq_id_i,
  output logic [                    4:0]       irq_ack_id_o,

  input  logic                                 clock_en_i,
  input  logic                                 fetch_en_i,
  input  logic                                 fregfile_disable_i,
  input  logic [                   31:0]       boot_addr_i,
  input  logic                                 test_mode_i,
  output logic                                 core_busy_o,

  // Interface to instruction cache (Req->gnt handshake)
  output logic                                 instr_req_o,
  input  logic                                 instr_gnt_i,
  output logic [                   31:0]       instr_addr_o,
  input  logic [  INSTR_RDATA_WIDTH-1:0]       instr_r_rdata_i,
  input  logic                                 instr_r_valid_i,

  input  logic                                 debug_req_i,

  hci_core_intf.master                         core_bus_master,


  output logic                                 apu_master_req_o,
  input  logic                                 apu_master_gnt_i,
  // request channel
  output logic [           WAPUTYPE-1:0]       apu_master_type_o,
  output logic [      APU_NARGS_CPU-1:0][31:0] apu_master_operands_o,
  output logic [        APU_WOP_CPU-1:0]       apu_master_op_o,
  output logic [   APU_NDSFLAGS_CPU-1:0]       apu_master_flags_o,
  // response channel
  output logic                                 apu_master_ready_o,
  input  logic                                 apu_master_valid_i,
  input  logic [                   31:0]       apu_master_result_i,
  input  logic [   APU_NUSFLAGS_CPU-1:0]       apu_master_flags_i,

  input  logic [N_EXT_PERF_COUNTERS-1:0]       perf_counters_i
);

  logic [31:0] boot_addr;
  logic        core_bus_master_we;
  assign core_bus_master.wen = ~core_bus_master_we;

  // For ibex
  logic [31:0] hart_id;
  logic        core_sleep;
  logic [31:0] core_irq_x;
  logic        core_instr_req;
  logic        core_instr_gnt;
  logic [31:0] core_instr_addr;
  logic [31:0] core_instr_r_rdata;
  logic        core_instr_r_valid;

  assign core_bus_master.boffs = '0;
  assign core_bus_master.lrdy  = '0;

  assign hart_id = {21'b0, cluster_id_i[5:0], 1'b0, core_id_i[3:0]};

  generate
    if ( CORE_TYPE_CL == 0 ) begin: CL_CORE
      assign boot_addr = boot_addr_i;
      riscv_core #(
        .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH   ),
        .N_EXT_PERF_COUNTERS ( N_EXT_PERF_COUNTERS ),
        .PULP_SECURE         ( 0                   ),
        .FPU                 ( FPU                 ),
        .FP_DIVSQRT          ( FP_DIVSQRT          ),
        .SHARED_FP           ( SHARED_FP           ),
        .SHARED_DSP_MULT     ( 0                   ),
        .SHARED_INT_DIV      ( 0                   ),
        .SHARED_FP_DIVSQRT   ( SHARED_FP_DIVSQRT   ),
        .WAPUTYPE            ( WAPUTYPE            ),
        .DM_HaltAddress      ( DEBUG_START_ADDR + 16'h0800 )

      ) RISCV_CORE (
        .clk_i                 ( clk_i             ),
        .rst_ni                ( rst_ni            ),

        .clock_en_i            ( clock_en_i        ),
        .test_en_i             ( test_mode_i       ),

        .boot_addr_i           ( boot_addr         ),
        .core_id_i             ( core_id_i         ),
        .cluster_id_i          ( cluster_id_i      ),

        .instr_addr_o          ( instr_addr_o             ),
        .instr_req_o           ( instr_req_o              ),
        .instr_rdata_i         ( instr_r_rdata_i          ),
        .instr_gnt_i           ( instr_gnt_i              ),
        .instr_rvalid_i        ( instr_r_valid_i          ),

        .data_addr_o           ( core_bus_master.add           ),
        .data_wdata_o          ( core_bus_master.data          ),
        .data_we_o             ( core_bus_master_we            ),
        .data_req_o            ( core_bus_master.req           ),
        .data_be_o             ( core_bus_master.be            ),
        .data_rdata_i          ( core_bus_master.r_data        ),
        .data_gnt_i            ( core_bus_master.gnt           ),
        .data_rvalid_i         ( core_bus_master.r_valid       ),

        .irq_i                 ( irq_req_i                ),
        .irq_id_i              ( irq_id_i                 ),
        .irq_id_o              ( irq_ack_id_o             ),
        .irq_ack_o             ( irq_ack_o                ),

        .sec_lvl_o             (                          ),
        .irq_sec_i             (      1'b0                ),

        .debug_req_i           ( debug_req_i              ),

        .fetch_enable_i        ( fetch_en_i               ),
        .core_busy_o           ( core_busy_o              ),


         // apu-interconnect
        .apu_master_req_o      ( apu_master_req_o      ),
        .apu_master_gnt_i      ( apu_master_gnt_i      ),
        .apu_master_type_o     ( apu_master_type_o     ),
        .apu_master_operands_o ( apu_master_operands_o ),
        .apu_master_op_o       ( apu_master_op_o       ),
        .apu_master_flags_o    ( apu_master_flags_o    ),

        .apu_master_valid_i    ( apu_master_valid_i    ),
        .apu_master_ready_o    ( apu_master_ready_o    ),
        .apu_master_result_i   ( apu_master_result_i   ),
        .apu_master_flags_i    ( apu_master_flags_i    ),

        .ext_perf_counters_i   ( perf_counters_i       ),
        .fregfile_disable_i    ( 1'b1                  )   //disable FP regfile
      ); 
    end else begin: CL_CORE
      assign boot_addr = boot_addr_i & 32'hFFFFFF00; // RI5CY expects 0x80 offset, Ibex expects 0x00 offset (adds reset offset 0x80 internally)
      
      if (INSTR_RDATA_WIDTH == 128) begin
        instr_width_converter ibex_width_converter (
          .clk_i            ( clk_i              ),
          .rst_ni           ( rst_ni             ),

          .cache_req_o      ( instr_req_o        ),
          .cache_gnt_i      ( instr_gnt_i        ),
          .cache_addr_o     ( instr_addr_o       ),
          .cache_r_rdata_i  ( instr_r_rdata_i    ),
          .cache_r_valid_i  ( instr_r_valid_i    ),

          .core_req_i       ( core_instr_req     ),
          .core_gnt_o       ( core_instr_gnt     ),
          .core_addr_i      ( core_instr_addr    ),
          .core_r_rdata_o   ( core_instr_r_rdata ),
          .core_r_valid_o   ( core_instr_r_valid )
        );
      end else begin
        assign instr_req_o        = core_instr_req;
        assign core_instr_gnt     = instr_gnt_i;
        assign instr_addr_o       = core_instr_addr;
        assign core_instr_r_rdata = instr_r_rdata_i;
        assign core_instr_r_valid = instr_r_valid_i;
      end
      
  `ifdef VERILATOR
      ibex_core #(
  `elsif TRACE_EXECUTION
      ibex_core_tracing #(
  `else
      ibex_core #(
  `endif
        .PMPEnable        ( 1'b0                        ),
        .PMPGranularity   ( 0                           ),
        .PMPNumRegions    ( 4                           ),
        .MHPMCounterNum   ( 29                          ),
        .MHPMCounterWidth ( 40                          ),
        .RV32E            ( CORE_TYPE_CL == 2           ),
        .RV32M            ( CORE_TYPE_CL == 1 ? ibex_pkg::RV32MSingleCycle : ibex_pkg::RV32MNone         ),
        .RV32B            ( ibex_pkg::RV32BNone         ),
  `ifdef TARGET_SYNTHESIS
        .RegFile          ( ibex_pkg::RegFileLatch      ),
  `elsif TARGET_FPGA
        .RegFile          ( ibex_pkg::RegFileFPGA       ),
  `else
        .RegFile          ( ibex_pkg::RegFileFF         ),
  `endif
        .BranchTargetALU  ( 1'b1                        ),
        .WritebackStage   ( 1'b1                        ),
        .ICache           ( 1'b0                        ),
        .ICacheECC        ( 1'b0                        ),
        .BranchPredictor  ( 1'b0                        ),
        .DbgTriggerEn     ( 1'b1                        ),
        .DbgHwBreakNum    ( 1                           ),
        .SecureIbex       ( 1'b0                        ),
        .DmHaltAddr       ( 32'h1A110800 ),
        .DmExceptionAddr  ( 32'h1A110808 )
      ) IBEX_CORE (
        .clk_i                 ( clk_i              ),
        .rst_ni                ( rst_ni             ),

        .test_en_i             ( test_mode_i        ),

        .hart_id_i             ( hart_id            ),
        .boot_addr_i           ( boot_addr          ),

        // Instruction Memory Interface:  Interface to Instruction Logaritmic interconnect: Req->grant handshake
        .instr_req_o           ( core_instr_req     ),
        .instr_gnt_i           ( core_instr_gnt     ),
        .instr_rvalid_i        ( core_instr_r_valid ),
        .instr_addr_o          ( core_instr_addr    ),
        .instr_rdata_i         ( core_instr_r_rdata ),
        .instr_err_i           ( 1'b0               ),

        // Data memory interface:
        .data_req_o            ( core_bus_master.req     ),
        .data_gnt_i            ( core_bus_master.gnt     ),
        .data_rvalid_i         ( core_bus_master.r_valid ),
        .data_we_o             ( core_bus_master_we      ),
        .data_be_o             ( core_bus_master.be      ),
        .data_addr_o           ( core_bus_master.add     ),
        .data_wdata_o          ( core_bus_master.data    ),
        .data_rdata_i          ( core_bus_master.r_data  ),
        .data_err_i            ( core_bus_master.r_opc   ),

        .irq_software_i        ( 1'b0               ),
        .irq_timer_i           ( 1'b0               ),
        .irq_external_i        ( 1'b0               ),
        .irq_fast_i            ( 15'b0              ),
        .irq_nm_i              ( 1'b0               ),

        .irq_x_i               ( core_irq_x         ),
        .irq_x_ack_o           ( irq_ack_o          ),
        .irq_x_ack_id_o        ( irq_ack_id_o       ),

        .external_perf_i       ( {{{16- N_EXT_PERF_COUNTERS}{'0}}, perf_counters_i} ),

        .debug_req_i           ( debug_req_i        ),

        .fetch_enable_i        ( fetch_en_i         ),
        .alert_minor_o         (),
        .alert_major_o         (),
        .core_sleep_o          ( core_sleep         )
      );
      assign core_busy_o = ~core_sleep;

      // Ibex supports 32 additional fast interrupts and reads the interrupt lines directly.
      // Convert ID back to interrupt lines
      always_comb begin : gen_core_irq_x
        core_irq_x = '0;
        if (irq_req_i) begin
            core_irq_x[irq_id_i] = 1'b1;
        end
      end
    end
  endgenerate

  /* debug stuff */
//synopsys translate_off

  // CHECK IF THE CORE --> LS port is makin accesses in unmapped regions
  always @(posedge clk_i) begin : CHECK_ASSERTIONS
`ifndef CLUSTER_ALIAS
    if ((core_bus_master.req == 1'b1) && (core_bus_master.add < 32'h1000_0000)) begin
      $error("ERROR_1 (0x00000000 -> 0x10000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,core_bus_master.add, $time()/1000 );
      $finish();
    end
    if ((core_bus_master.req == 1'b1) && (core_bus_master.add >= 32'h1040_0000) && ((core_bus_master.add < 32'h1A00_0000))) begin
      $error("ERROR_2 (0x10400000 -> 0x1A000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,core_bus_master.add, $time()/1000 );
      $finish();
    end
`endif
  end

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

  // SELF CHECK ROUTINES TO compare instruction fetches with slm files
  always_ff @(posedge clk_i) begin
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
      if(instr_addr_o[31:24] == 8'h1A) begin
        destination <= 1'b0;
      end else begin
        destination <= 1'b1;
      end
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

  always_ff @(posedge clk_i , negedge rst_ni) begin
    if ( rst_ni == 1'b0 ) begin
      reg_cache_refill <= 1'b0;
    end else begin
      if (instr_req_o) begin
        reg_cache_refill <= 1'b1;
      end else if(instr_r_valid_i && !instr_req_o) begin
        reg_cache_refill <= 1'b0;
      end
    end
  end
//synopsys translate_on

endmodule
