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

// USER DEFINED MACROS to improve self-testing capabilities
`ifndef PULP_FPGA_SIM
  `define DEBUG_FETCH_INTERFACE
`endif
//`define DATA_MISS
//`define DUMP_INSTR_FETCH

module core_region
import rapid_recovery_pkg::*;
#(
  // CORE PARAMETERS
  parameter CORE_TYPE_CL            = 0,  // 0 for CV32, 1 RI5CY, 2 for IBEX RV32IMC
  parameter N_EXT_PERF_COUNTERS     = 1,
  parameter NUM_INTERRUPTS          = 32,
  parameter ADDR_WIDTH              = 32,
  parameter DATA_WIDTH              = 32,
  parameter INSTR_RDATA_WIDTH       = 32,
  parameter CLUSTER_ALIAS           = 1,
  parameter CLUSTER_ALIAS_BASE      = 12'h000,
  parameter REMAP_ADDRESS           = 0,

  parameter APU_NARGS_CPU           = 2,
  parameter APU_WOP_CPU             = 1,
  parameter WAPUTYPE                = 3,
  parameter APU_NDSFLAGS_CPU        = 3,
  parameter APU_NUSFLAGS_CPU        = 5,

  parameter FPU                     =  0,
  parameter FP_DIVSQRT              =  0,
  parameter SHARED_FP               =  0,
  parameter SHARED_FP_DIVSQRT       =  0,

  parameter DEBUG_START_ADDR        = 32'h1A110000,

  parameter type core_data_req_t    = logic,
  parameter type core_data_rsp_t    = logic,

  parameter L2_SLM_FILE             = "./slm_files/l2_stim.slm",
  parameter ROM_SLM_FILE            = "../sw/apps/boot/slm_files/l2_stim.slm"
)
(
  input logic                            clk_i,
  input logic                            rst_ni,
  input logic                            setback_i,

  input logic [3:0]                      core_id_i,
  input logic [5:0]                      cluster_id_i,
  
  input logic                            irq_req_i,
  output logic                           irq_ack_o,
  input logic [4:0]                      irq_id_i,
  output logic [4:0]                     irq_ack_id_o,
  
  input logic                            clock_en_i,
  input logic                            fetch_en_i,

  input logic [31:0]                     boot_addr_i,

  input logic                            test_mode_i,

  output logic                           core_busy_o,

  // Interface to Instruction Logarithmic interconnect (Req->grant handshake)
  output logic                           instr_req_o,
  input logic                            instr_gnt_i,
  output logic [31:0]                    instr_addr_o,
  input logic [INSTR_RDATA_WIDTH-1:0]    instr_r_rdata_i,
  input logic                            instr_r_valid_i,

  input logic                            debug_req_i,
  output logic                           debug_havereset_o,
  output logic                           debug_running_o,
  output logic                           debug_halted_o,
  // Recovery bus
  input  rapid_recovery_pkg::rapid_recovery_t recovery_bus_i,
  // Backup bus
  output rapid_recovery_pkg::regfile_write_t  regfile_backup_o,
  output rapid_recovery_pkg::pc_intf_t        pc_backup_o,
  output rapid_recovery_pkg::csrs_intf_t      csr_backup_o,

  input logic [N_EXT_PERF_COUNTERS-1:0]  ext_perf_i,

  output core_data_req_t                 core_data_req_o,
  input  core_data_rsp_t                 core_data_rsp_i,
  output logic                           apu_master_req_o,
  input logic                            apu_master_gnt_i,
  // request channel
  output logic [WAPUTYPE-1:0]            apu_master_type_o,
  output logic [APU_NARGS_CPU-1:0][31:0] apu_master_operands_o,
  output logic [APU_WOP_CPU-1:0]         apu_master_op_o,
  output logic [APU_NDSFLAGS_CPU-1:0]    apu_master_flags_o,
  // response channel
  output logic                           apu_master_ready_o,
  input logic                            apu_master_valid_i,
  input logic [31:0]                     apu_master_result_i,
  input logic [APU_NUSFLAGS_CPU-1:0]     apu_master_flags_i
);

  localparam N_EXT_PERF_COUNTERS_ACTUAL = 5;
  localparam USE_IBEX   = CORE_TYPE_CL == 1 || CORE_TYPE_CL == 2;
  localparam IBEX_RV32M = CORE_TYPE_CL == 1 ? ibex_pkg::RV32MSingleCycle : ibex_pkg::RV32MNone;
  localparam IBEX_RV32E = CORE_TYPE_CL == 2;

`ifdef TARGET_SYNTHESIS
  localparam IBEX_RegFile = ibex_pkg::RegFileLatch;
`elsif TARGET_FPGA
  localparam IBEX_RegFile = ibex_pkg::RegFileFPGA;
`else
  localparam IBEX_RegFile = ibex_pkg::RegFileFF;
`endif

  //********************************************************
  //***************** SIGNALS DECLARATION ******************
  //********************************************************
  logic [31:0]               hart_id;
  logic                      core_sleep;
  logic [31:0]               boot_addr;
  logic [NUM_INTERRUPTS-1:0] core_irq_x;

  logic            core_instr_req;
  logic            core_instr_gnt;
  logic [31:0]     core_instr_addr;
  logic [31:0]     core_instr_r_rdata;
  logic            core_instr_r_valid;

  logic            core_mem_req;

  logic        core_data_req_we ;

  assign core_data_req_o.wen  = ~core_data_req_we;
  assign hart_id = {21'b0, cluster_id_i[5:0], 1'b0, core_id_i};

   //********************************************************
   //***************** PROCESSOR ****************************
   //********************************************************

  generate
    if ( CORE_TYPE_CL == 0 ) begin: CV32_CORE
      assign boot_addr = boot_addr_i;
      cv32e40p_wrapper #(
        .PULP_XPULP          ( 1                           ), // For now this is a no
        .PULP_CLUSTER        ( 1                           ),
        .FPU                 ( FPU                         ),
        .NUM_EXTERNAL_PERF   ( N_EXT_PERF_COUNTERS         ),
        .NUM_INTERRUPTS      ( NUM_INTERRUPTS              ),
        .PULP_ZFINX          ( 0                           )
      ) CV32_CORE (
        .clk_i                 ( clk_i                       ),
        .rst_ni                ( rst_ni                      ),
        .setback_i             ( '0                          ),
        // Control Interface
        .pulp_clock_en_i       ( clock_en_i                  ),
        .scan_cg_en_i          ( test_mode_i                 ),
        .boot_addr_i           ( boot_addr                   ),
        .mtvec_addr_i          ( '0                          ),
        .mtvt_addr_i           ( '0                          ),
        .dm_halt_addr_i        ( DEBUG_START_ADDR + 16'h0800 ),
        .hart_id_i             ( hart_id                     ),
        .dm_exception_addr_i   ( DEBUG_START_ADDR + 16'h080C ), // From Control PULP, to be checked
        // Instruction Interface
        .instr_req_o           ( instr_req_o                 ),
        .instr_gnt_i           ( instr_gnt_i                 ),
        .instr_rvalid_i        ( instr_r_valid_i             ),
        .instr_addr_o          ( instr_addr_o                ),
        .instr_rdata_i         ( instr_r_rdata_i             ),
        // Data Interface
        .data_req_o            ( core_data_req_o.req         ),
        .data_gnt_i            ( core_data_rsp_i.gnt         ),
        .data_rvalid_i         ( core_data_rsp_i.r_valid     ),
        .data_we_o             ( core_data_req_we            ),
        .data_be_o             ( core_data_req_o.be          ),
        .data_addr_o           ( core_data_req_o.add         ),
        .data_wdata_o          ( core_data_req_o.data        ),
        .data_rdata_i          ( core_data_rsp_i.r_data      ),
        // Shadow Memory Interface
        .shadow_req_o          ( /* Unconnected */           ),
        .shadow_gnt_i          ( '0                          ),
        .shadow_rvalid_i       ( '0                          ),
        .shadow_we_o           ( /* Unconnected */           ),
        .shadow_be_o           ( /* Unconnected */           ),
        .shadow_addr_o         ( /* Unconnected */           ),
        .shadow_wdata_o        ( /* Unconnected */           ),
        .shadow_rdata_i        ( '0                          ),
        // Atomic operation
        .data_atop_o           ( /* Unconnected */           ),
        // apu-interconnect
        // Handshake
        .apu_req_o             ( apu_master_req_o            ),
        .apu_gnt_i             ( apu_master_gnt_i            ),
        // Request Bus
        .apu_operands_o        ( apu_master_operands_o       ),
        .apu_op_o              ( apu_master_op_o             ),
        .apu_type_o            ( apu_master_type_o           ),
        .apu_flags_o           ( apu_master_flags_o          ),
        // Response Bus
        .apu_rvalid_i          ( apu_master_valid_i          ),
        .apu_result_i          ( apu_master_result_i         ),
        .apu_flags_i           ( apu_master_flags_i          ),
        // IRQ Interface
        .irq_i                 ( core_irq_x                  ),
        .irq_level_i           ( '0                          ), // CLIC interrupt level
        .irq_shv_i             ( '0                          ), // CLIC selective hardware vectoring
        .irq_ack_o             ( irq_ack_o                   ),
        .irq_id_o              ( irq_ack_id_o                ),
        // Debug Interface
        .debug_req_i           ( debug_req_i                 ),
        .debug_havereset_o     ( debug_havereset_o           ),
        .debug_running_o       ( debug_running_o             ),
        .debug_halted_o        ( debug_halted_o              ),
        // Yet other control signals
        .fetch_enable_i        ( fetch_en_i                  ),
        .core_sleep_o          ( core_sleep                  ),
        // External performance monitoring signals
        .external_perf_i       ( ext_perf_i                  )
      );
      assign core_busy_o = ~core_sleep;
    end else if ( CORE_TYPE_CL == 1 ) begin: RI5CY_CORE
      assign boot_addr = boot_addr_i;
      riscv_core #(
        .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH           ),
        .PULP_CLUSTER        ( 1                           ),
        .FPU                 ( FPU                         ),
        .N_EXT_PERF_COUNTERS ( N_EXT_PERF_COUNTERS_ACTUAL  ),
        .Zfinx               ( 0                           ),
        .WAPUTYPE            ( WAPUTYPE                    ),
        .DM_HaltAddress      ( DEBUG_START_ADDR + 16'h0800 )
      ) RI5CY_CORE             (
        .clk_i                 ( clk_i                       ),
        .rst_ni                ( rst_ni                      ),
        .setback_i             ( setback_i                   ),
        .clock_en_i            ( clock_en_i                  ),
        .test_en_i             ( test_mode_i                 ),
        // Control Interface
        .fregfile_disable_i    ( '1                          ),
        .boot_addr_i           ( boot_addr                   ),
        .core_id_i             ( hart_id                     ),
        .cluster_id_i          ( cluster_id_i                ),
        // Instruction Interface
        .instr_req_o           ( instr_req_o                 ),
        .instr_gnt_i           ( instr_gnt_i                 ),
        .instr_rvalid_i        ( instr_r_valid_i             ),
        .instr_addr_o          ( instr_addr_o                ),
        .instr_rdata_i         ( instr_r_rdata_i             ),
        // Data Interface
        .data_req_o            ( core_data_req_o.req         ),
        .data_gnt_i            ( core_data_rsp_i.gnt         ),
        .data_rvalid_i         ( core_data_rsp_i.r_valid     ),
        .data_we_o             ( core_data_req_we            ),
        .data_be_o             ( core_data_req_o.be          ),
        .data_addr_o           ( core_data_req_o.add         ),
        .data_wdata_o          ( core_data_req_o.data        ),
        .data_rdata_i          ( core_data_rsp_i.r_data      ),
        .data_unaligned_o      (         /* Unused */        ),
        // apu-interconnect
        // Handshake
        .apu_master_req_o      ( apu_master_req_o            ),
        .apu_master_ready_o    ( apu_master_ready_o          ),
        .apu_master_gnt_i      ( apu_master_gnt_i            ),
        // Request Bus
        .apu_master_operands_o ( apu_master_operands_o       ),
        .apu_master_op_o       ( apu_master_op_o             ),
        .apu_master_type_o     ( apu_master_type_o           ),
        .apu_master_flags_o    ( apu_master_flags_o          ),
        // Response Bus
        .apu_master_valid_i    ( apu_master_valid_i          ),
        .apu_master_result_i   ( apu_master_result_i         ),
        .apu_master_flags_i    ( apu_master_flags_i          ),
        // IRQ Interface
        .irq_i                 ( irq_req_i                   ),
        .irq_id_i              ( irq_id_i                    ),
        .irq_ack_o             ( irq_ack_o                   ),
        .irq_id_o              ( irq_ack_id_o                ),
        .irq_sec_i             ( '0                          ),
        .sec_lvl_o             (                             ),
        // Debug Interface
        .debug_req_i           ( debug_req_i                 ),
        .debug_mode_o          ( debug_halted_o              ),
        // Yet other control signals
        .fetch_enable_i        ( fetch_en_i                  ),
        .core_busy_o           ( core_busy_o                 ),
        // External performance monitoring signals
        .ext_perf_counters_i   ( ext_perf_i                  ),
        // RF recovery ports
        .recover_i         ( recovery_bus_i.rf_recovery_en            ),
        // Write port A
        .regfile_waddr_a_i ( recovery_bus_i.rf_recovery_wdata.waddr_a ),
        .regfile_wdata_a_i ( recovery_bus_i.rf_recovery_wdata.wdata_a ),
        .regfile_we_a_i    ( recovery_bus_i.rf_recovery_wdata.we_a    ),
        // Write port B
        .regfile_waddr_b_i ( recovery_bus_i.rf_recovery_wdata.waddr_b ),
        .regfile_wdata_b_i ( recovery_bus_i.rf_recovery_wdata.wdata_b ),
        .regfile_we_b_i    ( recovery_bus_i.rf_recovery_wdata.we_b    ),
        // Outputs from RF
        // Port A
        .regfile_we_a_o    ( regfile_backup_o.we_a    ),
        .regfile_waddr_a_o ( regfile_backup_o.waddr_a ),
        .regfile_wdata_a_o ( regfile_backup_o.wdata_a ),
        // Port B
        .regfile_we_b_o    ( regfile_backup_o.we_b    ),
        .regfile_waddr_b_o ( regfile_backup_o.waddr_b ),
        .regfile_wdata_b_o ( regfile_backup_o.wdata_b ),
        // Program Counter Backup
        .backup_program_counter_o   ( pc_backup_o.program_counter ),
        .backup_branch_o            ( pc_backup_o.is_branch       ),
        .backup_branch_addr_o       ( pc_backup_o.branch_addr     ),
        // Program Counter Recovery
        .pc_recover_i               ( recovery_bus_i.pc_recovery_en              ),
        .recovery_program_counter_i ( recovery_bus_i.pc_recovery.program_counter ),
        .recovery_branch_i          ( recovery_bus_i.pc_recovery.is_branch       ),
        .recovery_branch_addr_i     ( recovery_bus_i.pc_recovery.branch_addr     ),
        // CSRs Backup
        .backup_mstatus_o  ( csr_backup_o.csr_mstatus  ),
        .backup_mtvec_o    ( csr_backup_o.csr_mtvec    ),
        .backup_mscratch_o ( csr_backup_o.csr_mscratch ),
        .backup_mepc_o     ( csr_backup_o.csr_mepc     ),
        .backup_mcause_o   ( csr_backup_o.csr_mcause   ),
        // CSRs Recovery
        .recovery_mstatus_i  ( recovery_bus_i.csr_recovery.csr_mstatus  ),
        .recovery_mtvec_i    ( recovery_bus_i.csr_recovery.csr_mtvec    ),
        .recovery_mscratch_i ( recovery_bus_i.csr_recovery.csr_mscratch ),
        .recovery_mepc_i     ( recovery_bus_i.csr_recovery.csr_mepc     ),
        .recovery_mcause_i   ( recovery_bus_i.csr_recovery.csr_mcause   )
      );
      assign debug_havereset_o = '0;
      assign debug_running_o   = '0;
      assign csr_backup_o.csr_mie = '0;
      assign csr_backup_o.csr_mip = '0;
    end else begin: IBEX_CORE
      assign boot_addr = boot_addr_i & 32'hFFFFFF00; // RI5CY expects 0x80 offset, Ibex expects 0x00 offset (adds reset offset 0x80 internally)
      // Core busy
      assign core_busy_o = ~core_sleep;
      
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
        obi_pulp_adapter i_obi_pulp_adapter_instr (
          .clk_i       (clk_i          ),
          .rst_ni      (rst_ni         ),
          .core_req_i  (core_instr_req ),
          .mem_req_o   (instr_req_o    ),
          .mem_gnt_i   (instr_gnt_i    ),
          .mem_rvalid_i(instr_r_valid_i)
        );
        assign core_instr_gnt     = instr_gnt_i;
        assign instr_addr_o       = core_instr_addr;
        assign core_instr_r_rdata = instr_r_rdata_i;
        assign core_instr_r_valid = instr_r_valid_i;
      end
      
      obi_pulp_adapter i_obi_pulp_adapter_mem (
        .clk_i       (clk_i             ),
        .rst_ni      (rst_ni            ),
        .core_req_i  (core_mem_req      ),
        .mem_req_o   (core_data_req_o.req    ),
        .mem_gnt_i   (core_data_rsp_i.gnt    ),
        .mem_rvalid_i(core_data_rsp_i.r_valid)
      );

`ifdef VERILATOR
      ibex_core #(
`elsif TRACE_EXECUTION
      ibex_core_tracing #(
`else
      ibex_core #(
`endif
        .PMPEnable        ( 1'b0                ),
        .PMPGranularity   ( 0                   ),
        .PMPNumRegions    ( 4                   ),
        .MHPMCounterNum   ( 29                  ),
        .MHPMCounterWidth ( 40                  ),
        .RV32E            ( IBEX_RV32E          ),
        .RV32M            ( IBEX_RV32M          ),
        .RV32B            ( ibex_pkg::RV32BNone ),
        .RegFile          ( IBEX_RegFile        ),
        .BranchTargetALU  ( 1'b1                ),
        .WritebackStage   ( 1'b1                ),
        .ICache           ( 1'b0                ),
        .ICacheECC        ( 1'b0                ),
        .BranchPredictor  ( 1'b0                ),
        .DbgTriggerEn     ( 1'b1                ),
        .DbgHwBreakNum    ( 1                   ),
        .SecureIbex       ( 1'b0                ),
        .DmHaltAddr       ( 32'h1A110800        ),
        .DmExceptionAddr  ( 32'h1A110808        )
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
        .data_req_o            ( core_mem_req            ),
        .data_gnt_i            ( core_data_rsp_i.gnt     ),
        .data_rvalid_i         ( core_data_rsp_i.r_valid ),
        .data_we_o             ( core_data_req_we        ),
        .data_be_o             ( core_data_req_o.be      ),
        .data_addr_o           ( core_data_req_o.add     ),
        .data_wdata_o          ( core_data_req_o.wdata   ),
        .data_rdata_i          ( core_data_rsp_i.r_rdata ),
        .data_err_i            ( 1'b0               ),

        .irq_software_i        ( 1'b0               ),
        .irq_timer_i           ( 1'b0               ),
        .irq_external_i        ( 1'b0               ),
        .irq_fast_i            ( 15'b0              ),
        .irq_nm_i              ( 1'b0               ),

        .irq_x_i               ( core_irq_x         ),
        .irq_x_ack_o           ( irq_ack_o          ),
        .irq_x_ack_id_o        ( irq_ack_id_o       ),

        .external_perf_i       ( {{{16- N_EXT_PERF_COUNTERS_ACTUAL}{'0}}, perf_counters} ),

        .debug_req_i           ( debug_req_i        ),

        .fetch_enable_i        ( fetch_en_i         ),
        .alert_minor_o         (),
        .alert_major_o         (),
        .core_sleep_o          ( core_sleep         )
      );

    end
  endgenerate

  always_comb begin : gen_core_irq_x
    core_irq_x = '0;
    if (irq_req_i) begin
        core_irq_x[irq_id_i] = 1'b1;
    end
  end

  /* debug stuff */
  //synopsys translate_off

  // CHECK IF THE CORE --> LS port is makin accesses in unmapped regions
  always @(posedge clk_i)
  begin : CHECK_ASSERTIONS
`ifndef CLUSTER_ALIAS
    if ((core_data_req_o.req == 1'b1) && (core_data_req_o.add < 32'h1000_0000)) begin
      $error("ERROR_1 (0x00000000 -> 0x10000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,core_data_req_o.add, $time()/1000 );
      $finish();
    end
    if ((core_data_req_o.req == 1'b1) && (core_data_req_o.add >= 32'h1040_0000) && ((core_data_req_o.add < 32'h1A00_0000))) begin
      $error("ERROR_2 (0x10400000 -> 0x1A000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,core_data_req_o.add, $time()/1000 );
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
    FILE_ID.itoa(core_id_i);
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
