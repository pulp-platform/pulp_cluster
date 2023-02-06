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

`include "pulp_soc_defines.sv"
`include "periph_bus_defines.sv"


// USER DEFINED MACROS to improve self-testing capabilities
`ifndef PULP_FPGA_SIM
  `define DEBUG_FETCH_INTERFACE
`endif
//`define DATA_MISS
//`define DUMP_INSTR_FETCH

module core_region
#(
  // CORE PARAMETERS
  parameter CORE_TYPE_CL        = 0,  // 0 for RISCY, 1 for IBEX RV32IMC (formerly ZERORISCY), 2 for IBEX RV32EC (formerly MICRORISCY)
  // parameter USE_FPU             = 1,
  // parameter USE_HWPE            = 1,
  parameter N_EXT_PERF_COUNTERS = 1,
  // parameter CORE_ID             = 0,
  parameter ADDR_WIDTH          = 32,
  parameter DATA_WIDTH          = 32,
  parameter INSTR_RDATA_WIDTH   = 32,
  parameter CLUSTER_ALIAS_BASE  = 12'h000,
  parameter REMAP_ADDRESS       = 0,

  parameter APU_NARGS_CPU       = 2,
  parameter APU_WOP_CPU         = 1,
  parameter WAPUTYPE            = 3,
  parameter APU_NDSFLAGS_CPU    = 3,
  parameter APU_NUSFLAGS_CPU    = 5,
  
  parameter FPU                 =  0,
  parameter FP_DIVSQRT          =  0,
  parameter SHARED_FP           =  0,
  parameter SHARED_FP_DIVSQRT   =  0,

  parameter DEBUG_START_ADDR    = `DEBUG_START_ADDR,

  parameter L2_SLM_FILE         = "./slm_files/l2_stim.slm",
  parameter ROM_SLM_FILE        = "../sw/apps/boot/slm_files/l2_stim.slm"
)
(
  input logic                            clk_i,
  input logic                            rst_ni,
  input logic                            setback_i,

  input logic [5:0]                      cluster_id_i,
  input logic [3:0]                      core_id_i,
  
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
  output logic                           debug_halted_o,
  input logic                            debug_resume_i,


  // Program Counter Backup
  output logic [31:0]                    backup_program_counter_o,
  output logic                           backup_branch_o,
  output logic [31:0]                    backup_branch_addr_o,
  // Program Counter Recovery
  input  logic                           pc_recover_i,
  input  logic [31:0]                    recovery_program_counter_i,
  input  logic                           recovery_branch_i,
  input  logic [31:0]                    recovery_branch_addr_i,


  // Recovery Ports for RF
  input logic                            recover_i        ,
  input logic                            instr_lock_i     ,
  // Write Port A
  input logic [5:0]                      regfile_waddr_a_i,
  input logic [31:0]                     regfile_wdata_a_i,
  input logic                            regfile_we_a_i   ,
  // Write Port B                        
  input logic [5:0]                      regfile_waddr_b_i,
  input logic [31:0]                     regfile_wdata_b_i,
  input logic                            regfile_we_b_i   ,
  // Outputs from RF
  // Port A
  output logic                           regfile_we_a_o   ,
  output logic [ 5:0]                    regfile_waddr_a_o,
  output logic [31:0]                    regfile_wdata_a_o,
  // Port B
  output logic                           regfile_we_b_o   ,
  output logic [ 5:0]                    regfile_waddr_b_o,
  output logic [31:0]                    regfile_wdata_b_o,
  // Backup ports to the RF
  input  logic                           regfile_backup_i  ,
  input  logic [ 5:0]                    regfile_raddr_ra_i,
  input  logic [ 5:0]                    regfile_raddr_rb_i,
  input  logic [ 5:0]                    regfile_raddr_rc_i, 
  output logic [31:0]                    regfile_rdata_ra_o,
  output logic [31:0]                    regfile_rdata_rb_o,
  output logic [31:0]                    regfile_rdata_rc_o,

  // CSRs Backup
  output logic [6:0]                    backup_mstatus_o ,
  output logic [DATA_WIDTH-1:0]         backup_mie_o     ,
  output logic [23:0]                   backup_mtvec_o   ,
  output logic [DATA_WIDTH-1:0]         backup_mscratch_o,
  output logic [DATA_WIDTH-1:0]         backup_mip_o     ,
  output logic [DATA_WIDTH-1:0]         backup_mepc_o    ,
  output logic [ 5:0]                   backup_mcause_o  ,
  // CSRs Recovery
  input  logic [6:0]                    recovery_mstatus_i ,
  input  logic [DATA_WIDTH-1:0]         recovery_mie_i     ,
  input  logic [23:0]                   recovery_mtvec_i   ,
  input  logic [DATA_WIDTH-1:0]         recovery_mscratch_i,
  input  logic [DATA_WIDTH-1:0]         recovery_mip_i     ,
  input  logic [DATA_WIDTH-1:0]         recovery_mepc_i    ,
  input  logic [ 5:0]                   recovery_mcause_i  ,
  //XBAR_TCDM_BUS.Slave     debug_bus,
  //output logic            debug_core_halted_o,
  //input logic             debug_core_halt_i,
  //input logic             debug_core_resume_i,
              
  // Interface for DEMUX to TCDM INTERCONNECT ,PERIPHERAL INTERCONNECT and DMA CONTROLLER
  // hci_core_intf.master tcdm_data_master,
  // hci_core_intf.master dma_ctrl_master,
  // XBAR_PERIPH_BUS.Master eu_ctrl_master,
  // XBAR_PERIPH_BUS.Master periph_data_master
  hci_core_intf.master core_data_bus,

  input logic [N_EXT_PERF_COUNTERS-1:0] perf_counters_i

 // new interface signals
 `ifdef SHARED_FPU_CLUSTER
 // TODO: Ensure disable if CORE_TYPE_CL != 0
  ,
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
`endif

`ifdef APU_CLUSTER
 // TODO: Ensure disable if CORE_TYPE_CL != 0
  ,
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
`endif
 

);

  // localparam N_EXT_PERF_COUNTERS_ACTUAL = 5;
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

  logic [31:0]     hart_id;
  logic            core_sleep;
  logic [31:0]     boot_addr;
  logic [31:0]     core_irq_x;

  logic            core_instr_req;
  logic            core_instr_gnt;
  logic [31:0]     core_instr_addr;
  logic [31:0]     core_instr_r_rdata;
  logic            core_instr_r_valid;

  logic            core_mem_req;


  assign hart_id = {21'b0, cluster_id_i[5:0], 1'b0, core_id_i[3:0]};

`ifndef APU_CLUSTER
 `ifndef SHARED_FPU_CLUSTER
  // TODO: Disable if CORE_TYPE_CL != 0
  logic                     apu_master_req_o;
  logic                     apu_master_gnt_i;
  // request channel
  logic [WAPUTYPE-1:0]             apu_master_type_o;
  logic [APU_NARGS_CPU-1:0][31:0]  apu_master_operands_o;
  logic [APU_WOP_CPU-1:0]          apu_master_op_o;
  logic [APU_NDSFLAGS_CPU-1:0]     apu_master_flags_o;
  // response channel
  logic                        apu_master_ready_o;
  logic                        apu_master_valid_i;
  logic [31:0]                 apu_master_result_i;
  logic [APU_NUSFLAGS_CPU-1:0] apu_master_flags_i;

  assign apu_master_gnt_i      = '1;
  assign apu_master_valid_i    = '0;
  assign apu_master_result_i   = '0;
  assign apu_master_flags_i    = '0;
 `endif
`endif

   //********************************************************
   //***************** PROCESSOR ****************************
   //********************************************************

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
      .clk_i       (clk_i                         ),
      .rst_ni      (rst_ni                        ),
      .setback_i   (setback_i                     ),
      .core_req_i  (core_instr_req & ~instr_lock_i),
      .mem_req_o   (instr_req_o                   ),
      .mem_gnt_i   (instr_gnt_i                   ),
      .mem_rvalid_i(instr_r_valid_i               )
    );
    assign core_instr_gnt     = instr_gnt_i;
    assign instr_addr_o       = core_instr_addr;
    assign core_instr_r_rdata = instr_r_rdata_i;
    assign core_instr_r_valid = instr_r_valid_i;
  end
  
  obi_pulp_adapter i_obi_pulp_adapter_mem (
    .clk_i       (clk_i             ),
    .rst_ni      (rst_ni            ),
    .setback_i   (setback_i         ),
    .core_req_i  (core_mem_req      ),
    .mem_req_o   (core_data_bus.req    ),
    .mem_gnt_i   (core_data_bus.gnt    ),
    .mem_rvalid_i(core_data_bus.r_valid)
  );

  logic core_data_bus_we;
  assign core_data_bus.wen = ~core_data_bus_we;

  // Cores only support 32 fast interrupts and reads the interrupt lines directly.
  // Convert ID back to interrupt lines
  always_comb begin : gen_core_irq_x
    core_irq_x = '0;
    if (irq_req_i) begin
        core_irq_x[irq_id_i] = 1'b1;
    end
  end
  assign core_busy_o = ~core_sleep;

  generate
    if ( CORE_TYPE_CL == 0 ) begin: CL_CORE
      assign boot_addr = boot_addr_i;
`ifdef PULP_FPGA_EMUL
      cv32e40p_core #(
`elsif SYNTHESIS
      cv32e40p_core #(
`elsif VERILATOR
      cv32e40p_core #(
`else
      cv32e40p_wrapper #(
`endif
        .PULP_XPULP       (1),
        .PULP_CLUSTER     (1),
        .FPU              (FPU),
        .PULP_ZFINX       (1),
        .NUM_EXTERNAL_PERF(N_EXT_PERF_COUNTERS),
        .NUM_MHPMCOUNTERS (1)
      ) RISCV_CORE (
        .clk_i                 ( clk_i             ),
        .rst_ni                ( rst_ni            ),
        .setback_i             ( setback_i         ),

        .pulp_clock_en_i       ( clock_en_i        ),
        .scan_cg_en_i          ( test_mode_i       ),
        .boot_addr_i           ( boot_addr         ),
        .mtvec_addr_i          ( boot_addr & 32'hFFFFFF00 ),
        .dm_halt_addr_i        ( DEBUG_START_ADDR + dm::HaltAddress[31:0] ),
        .hart_id_i             ( hart_id           ),
        .dm_exception_addr_i   ( DEBUG_START_ADDR + dm::ExceptionAddress[31:0] ),

        .instr_req_o           ( core_instr_req     ),
        .instr_gnt_i           ( core_instr_gnt     ),
        .instr_rvalid_i        ( core_instr_r_valid ),
        .instr_addr_o          ( core_instr_addr    ),
        .instr_rdata_i         ( core_instr_r_rdata ),

        .data_req_o            ( core_mem_req       ),
        .data_gnt_i            ( core_data_bus.gnt     ),
        .data_rvalid_i         ( core_data_bus.r_valid ),
        .data_we_o             ( core_data_bus_we      ),
        .data_be_o             ( core_data_bus.be      ),
        .data_addr_o           ( core_data_bus.add     ),
        .data_wdata_o          ( core_data_bus.data   ),
        .data_rdata_i          ( core_data_bus.r_data ),

        .irq_i                 ( core_irq_x         ),
        // .irq_id_i              ( irq_id_i           ),
        .irq_id_o              ( irq_ack_id_o       ),
        .irq_ack_o             ( irq_ack_o          ),

        // .sec_lvl_o             (                    ),
        // .irq_sec_i             (      1'b0          ),

        .debug_req_i           ( debug_req_i        ),
        .debug_resume_i        ( debug_resume_i     ),
        .debug_havereset_o     (),
        .debug_running_o       (),
        .debug_halted_o        ( debug_halted_o     ),

        .fetch_enable_i        ( fetch_en_i         ),
        .core_sleep_o          ( core_sleep         ),


         // apu-interconnect
        .apu_req_o             ( apu_master_req_o      ),
        .apu_gnt_i             ( apu_master_gnt_i      ),
        .apu_operands_o        ( apu_master_operands_o ),
        .apu_op_o              ( apu_master_op_o       ),
        .apu_flags_o           ( apu_master_flags_o    ),
        // .apu_type_o            ( apu_master_type_o     ),

        .apu_rvalid_i          ( apu_master_valid_i    ),
        // .apu_ready_o           ( apu_master_ready_o    ),
        .apu_result_i          ( apu_master_result_i   ),
        .apu_flags_i           ( apu_master_flags_i    ),

        .external_perf_i       ( perf_counters_i       ),

        // Program Counter Backup
        .backup_program_counter_o   ( backup_program_counter_o),
        .backup_branch_o            ( backup_branch_o),
        .backup_branch_addr_o       ( backup_branch_addr_o),
        // Program Counter Recovery
        .pc_recover_i               ( pc_recover_i),
        .recovery_program_counter_i ( recovery_program_counter_i),
        .recovery_branch_i          ( recovery_branch_i),
        .recovery_branch_addr_i     ( recovery_branch_addr_i),

        // Recovery Ports for RF
        .recover_i         ( recover_i         ),
        // Write Port A
        .regfile_waddr_a_i ( regfile_waddr_a_i ),
        .regfile_wdata_a_i ( regfile_wdata_a_i ),
        .regfile_we_a_i    ( regfile_we_a_i    ),
     
        // Write Port B
        .regfile_waddr_b_i ( regfile_waddr_b_i ),
        .regfile_wdata_b_i ( regfile_wdata_b_i ),
        .regfile_we_b_i    ( regfile_we_b_i    ),
        // Outputs from RF
        // Port A
        .regfile_we_a_o    ( regfile_we_a_o    ),
        .regfile_waddr_a_o ( regfile_waddr_a_o ),
        .regfile_wdata_a_o ( regfile_wdata_a_o ),
        // Port B
        .regfile_we_b_o    ( regfile_we_b_o    ),
        .regfile_waddr_b_o ( regfile_waddr_b_o ),
        .regfile_wdata_b_o ( regfile_wdata_b_o ),
        // Backup ports to the RF
        .regfile_backup_i   ( regfile_backup_i   ),
        .regfile_raddr_ra_i ( regfile_raddr_ra_i ),
        .regfile_raddr_rb_i ( regfile_raddr_rb_i ),
        .regfile_raddr_rc_i ( regfile_raddr_rc_i ), 
        .regfile_rdata_ra_o ( regfile_rdata_ra_o ),
        .regfile_rdata_rb_o ( regfile_rdata_rb_o ),
        .regfile_rdata_rc_o ( regfile_rdata_rc_o ),
        // CSRs Backup
        .backup_mstatus_o  ( backup_mstatus_o  ),
        .backup_mie_o      ( backup_mie_o      ),
        .backup_mtvec_o    ( backup_mtvec_o    ),
        .backup_mscratch_o ( backup_mscratch_o ),
        .backup_mip_o      ( backup_mip_o      ),
        .backup_mepc_o     ( backup_mepc_o     ),
        .backup_mcause_o   ( backup_mcause_o   ),
        // CSRs Recovery
        .recovery_mstatus_i  ( recovery_mstatus_i  ),
        .recovery_mie_i      ( recovery_mie_i      ),
        .recovery_mtvec_i    ( recovery_mtvec_i    ),
        .recovery_mscratch_i ( recovery_mscratch_i ),
        .recovery_mip_i      ( recovery_mip_i      ),
        .recovery_mepc_i     ( recovery_mepc_i     ),
        .recovery_mcause_i   ( recovery_mcause_i   )

        // .ext_perf_counters_i   ( perf_counters         ),
        // .fregfile_disable_i    ( 1'b1                  )   //disable FP regfile
      ); 
    end else begin: CL_CORE
      assign boot_addr = boot_addr_i & 32'hFFFFFF00; // RI5CY expects 0x80 offset, Ibex expects 0x00 offset (adds reset offset 0x80 internally)

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
        .data_req_o            ( core_mem_req       ),
        .data_gnt_i            ( core_data_bus.gnt     ),
        .data_rvalid_i         ( core_data_bus.r_valid ),
        .data_we_o             ( core_data_bus_we      ),
        .data_be_o             ( core_data_bus.be      ),
        .data_addr_o           ( core_data_bus.add     ),
        .data_wdata_o          ( core_data_bus.data   ),
        .data_rdata_i          ( core_data_bus.r_data ),
        .data_err_i            ( 1'b0               ),

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
    end
  endgenerate

  /* debug stuff */
  //synopsys translate_off

  // CHECK IF THE CORE --> LS port is makin accesses in unmapped regions
  always @(posedge clk_i)
  begin : CHECK_ASSERTIONS
`ifndef CLUSTER_ALIAS
    if ((s_core_bus.req == 1'b1) && (s_core_bus.add < 32'h1000_0000)) begin
      $error("ERROR_1 (0x00000000 -> 0x10000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,s_core_bus.add, $time()/1000 );
      $finish();
    end
    if ((s_core_bus.req == 1'b1) && (s_core_bus.add >= 32'h1040_0000) && ((s_core_bus.add < 32'h1A00_0000))) begin
      $error("ERROR_2 (0x10400000 -> 0x1A000000) : Data interface is making a request on unmapped region --> %8x\t at time %t [ns]" ,s_core_bus.add, $time()/1000 );
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
          if((instr_r_rdata_i !== instr_r_rdata_ROM) && instr_lock_i) begin
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
