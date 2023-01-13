/* Copyright 2023 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 * 
 * Core Region: contains the RISCV core and the interface towards the iCache
 * Authors:
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 * Yvan Tortorella <yvan.tortorella@unibo.it>
 */

`include "pulp_soc_defines.sv"
`include "periph_bus_defines.sv"

// USER DEFINED MACROS to improve self-testing capabilities
`ifndef PULP_FPGA_SIM
  `define DEBUG_FETCH_INTERFACE
`endif

module core_region #(
  // CORE PARAMETERS
  parameter CORE_TYPE_CL        = 0, // 0: RISCY
                                     // 1: IBEX RV32IMC
                                     // 2: IBEX RV32EC
  parameter NUM_EXT_PERF_CNTRS = 1,
  parameter ADDR_WIDTH         = 32,
  parameter DATA_WIDTH         = 32,
  parameter INSTR_RDATA_WIDTH  = 32,
  parameter APU_NARGS_CPU      = 2,
  parameter APU_WOP_CPU        = 1,
  parameter WAPUTYPE           = 3,
  parameter APU_NDSFLAGS_CPU   = 3,
  parameter APU_NUSFLAGS_CPU   = 5,  
  parameter FPU                = 0,
  parameter DEBUG_START_ADDR   = `DEBUG_START_ADDR,
  parameter L2_SLM_FILE        = "./slm_files/l2_stim.slm",
  parameter ROM_SLM_FILE       = "../sw/apps/boot/slm_files/l2_stim.slm"
)
(
  input  logic                          clk_i            ,
  input  logic                          rst_ni           ,
  input  logic                          init_ni          ,
  input  logic [3:0]                    core_id_i        ,
  input  logic                          clock_en_i       ,
  input  logic                          fetch_en_i       ,
  input  logic [3:0]                    base_addr_i      , // FOR CLUSTER VIRTUALIZATION
  input  logic [5:0]                    cluster_id_i     ,
  input  logic [ADDR_WIDTH-1:0]         boot_addr_i      ,
  input  logic                          test_mode_i      ,
  output logic                          core_busy_o      ,
  // IRQs
  input  logic                          irq_req_i        ,
  output logic                          irq_ack_o        ,
  input  logic [4:0]                    irq_id_i         ,
  output logic [4:0]                    irq_ack_id_o     ,
  // iCache BUS
  output logic                          instr_req_o      ,
  input  logic                          instr_gnt_i      ,
  output logic [ADDR_WIDTH-1:0]         instr_addr_o     ,
  input  logic [INSTR_RDATA_WIDTH-1:0]  instr_r_rdata_i  ,
  input  logic                          instr_r_valid_i  ,
  // Debug Unit
  input logic                           debug_req_i      ,
  // External Performance Counters
  input logic [NUM_EXT_PERF_CNTRS-1:0]  ext_perf_cntrs_i ,
  // Recovery Ports for RF
  input logic                           recover_i        ,
  // Write Port A
  input logic                           regfile_we_a_i   ,
  input logic [5:0]                     regfile_waddr_a_i,
  input logic [DATA_WIDTH-1:0]          regfile_wdata_a_i,
  // Write Port B
  input logic                           regfile_we_b_i   ,
  input logic [5:0]                     regfile_waddr_b_i,
  input logic [DATA_WIDTH-1:0]          regfile_wdata_b_i,
  // Backup ports to the RF
  input  logic                          regfile_backup_i  ,
  input  logic [ 5:0]                   regfile_raddr_ra_i,
  input  logic [ 5:0]                   regfile_raddr_rb_i,
  input  logic [ 5:0]                   regfile_raddr_rc_i, 
  output logic [DATA_WIDTH-1:0]         regfile_rdata_ra_o,
  output logic [DATA_WIDTH-1:0]         regfile_rdata_rb_o,
  output logic [DATA_WIDTH-1:0]         regfile_rdata_rc_o,
`ifdef SHARED_FPU_CLUSTER // Ensure disable if CORE_TYPE_CL != 0
  output logic                           apu_master_req_o     ,
  input  logic                           apu_master_gnt_i     ,
  // request channel
  output logic [WAPUTYPE-1:0]            apu_master_type_o    ,
  output logic [APU_NARGS_CPU-1:0][31:0] apu_master_operands_o,
  output logic [APU_WOP_CPU-1:0]         apu_master_op_o      ,
  output logic [APU_NDSFLAGS_CPU-1:0]    apu_master_flags_o   ,
  // response channel
  input  logic                           apu_master_valid_i   ,
  output logic                           apu_master_ready_o   ,
  input  logic [DATA_WIDTH-1:0]          apu_master_result_i  ,
  input  logic [APU_NUSFLAGS_CPU-1:0]    apu_master_flags_i   ,
`endif
  hci_core_intf.master                   core_bus_master // Slave BUS to Core Assist
);

localparam USE_IBEX   = (CORE_TYPE_CL == 1) || (CORE_TYPE_CL == 2);
localparam IBEX_RV32M = (CORE_TYPE_CL == 1) ? ibex_pkg::RV32MSingleCycle : ibex_pkg::RV32MNone;
localparam IBEX_RV32E = CORE_TYPE_CL == 2;

`ifdef TARGET_SYNTHESIS
  localparam IBEX_RegFile = ibex_pkg::RegFileLatch;
`elsif TARGET_FPGA
  localparam IBEX_RegFile = ibex_pkg::RegFileFPGA;
`else
  localparam IBEX_RegFile = ibex_pkg::RegFileFF;
`endif

//********************************************************
//****************** Signals and BUSEs *******************
//********************************************************

logic        clk_int;
logic [31:0] hart_id;
logic        core_sleep;
logic [31:0] core_irq_x;
logic        core_instr_req,
             core_instr_gnt;
logic [ADDR_WIDTH-1:0] boot_addr;
logic [ADDR_WIDTH-1:0] core_instr_addr;
logic [DATA_WIDTH-1:0] core_instr_r_rdata;
logic                  core_mem_req,
                       core_instr_r_valid,
                       core_bus_master_we;

assign hart_id = {21'b0, cluster_id_i[5:0], 1'b0, core_id_i[3:0]};

`ifndef APU_CLUSTER
  `ifndef SHARED_FPU_CLUSTER // Disable if CORE_TYPE_CL != 0
    logic                            apu_master_req_o;
    logic                            apu_master_gnt_i;
    // REQ Chan
    logic [WAPUTYPE-1:0]             apu_master_type_o;
    logic [APU_NARGS_CPU-1:0][31:0]  apu_master_operands_o;
    logic [APU_WOP_CPU-1:0]          apu_master_op_o;
    logic [APU_NDSFLAGS_CPU-1:0]     apu_master_flags_o;
    // RSP Chan
    logic                            apu_master_ready_o;
    logic                            apu_master_valid_i;
    logic [DATA_WIDTH-1:0]             apu_master_result_i;
    logic [APU_NUSFLAGS_CPU-1:0]     apu_master_flags_i;
    
    assign apu_master_gnt_i    = '1;
    assign apu_master_valid_i  = '0;
    assign apu_master_result_i = '0;
    assign apu_master_flags_i  = '0;
  `endif
`endif

//********************************************************
//***************** iCache Converter *********************
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
  .clk_i       (clk_i                  ),
  .rst_ni      (rst_ni                 ),
  .core_req_i  (core_mem_req           ),
  .mem_req_o   (core_bus_master.req    ),
  .mem_gnt_i   (core_bus_master.gnt    ),
  .mem_rvalid_i(core_bus_master.r_valid)
);

// Cores only support 32 fast interrupts and reads the interrupt lines directly.
// Convert ID back to interrupt lines
always_comb begin : gen_core_irq_x
  core_irq_x = '0;
  if (irq_req_i) begin
    core_irq_x [irq_id_i] = 1'b1;
  end
end
assign core_busy_o = ~core_sleep;

assign core_bus_master.wen = ~core_bus_master_we;

generate
  if ( CORE_TYPE_CL == 0 ) begin: CL_CV32E40P_CORE
    // As a boot address, CV32E40P expects 0x80 offset
    assign boot_addr = boot_addr_i;

    `ifdef PULP_FPGA_EMUL || SYNTHESYS || VERILATOR // Only core for implementation/emulation
      cv32e40p_core #(
    `else // Core + tracer for simulations
      cv32e40p_wrapper #(
    `endif
        .PULP_XPULP          ( 1                   ),
        .PULP_CLUSTER        ( 1                   ),
        .FPU                 ( FPU                 ),
        .PULP_ZFINX          ( 1                   ),
        .NUM_MHPMCOUNTERS    ( 1                   ),
        .NUM_EXT_PERF_CNTRS  ( NUM_EXT_PERF_CNTRS  )
      ) cv32e40p_core     (
        .clk_i               ( clk_i                    ),
        .rst_ni              ( rst_ni                   ),
        .pulp_clock_en_i     ( clock_en_i               ),
        .fetch_enable_i      ( fetch_en_i               ),
        .boot_addr_i         ( boot_addr                ),
        .scan_cg_en_i        ( test_mode_i              ),
        .mtvec_addr_i        ( boot_addr & 32'hFFFFFF00 ),
        .hart_id_i           ( hart_id                  ),
        .core_sleep_o        ( core_sleep               ),
        // IRQs
        .irq_i               ( core_irq_x         ),
        .irq_id_o            ( irq_ack_id_o       ),
        .irq_ack_o           ( irq_ack_o          ),
        // iCache BUS
        .instr_req_o         ( core_instr_req     ),
        .instr_gnt_i         ( core_instr_gnt     ),
        .instr_addr_o        ( core_instr_addr    ),
        .instr_rdata_i       ( core_instr_r_rdata ),
        .instr_rvalid_i      ( core_instr_r_valid ),
        // Debug Unit
        .debug_req_i         ( debug_req_i        ),
        .debug_havereset_o   (                    ),
        .debug_running_o     (                    ),
        .debug_halted_o      (                    ),
        .dm_halt_addr_i      ( DEBUG_START_ADDR + dm::HaltAddress[31:0]      ),
        .dm_exception_addr_i ( DEBUG_START_ADDR + dm::ExceptionAddress[31:0] ),
        // External Performece Counters
        .ext_perf_cntrs_i    ( ext_perf_cntrs_i   ),
        // Recovery Ports for RF
        .recover_i           ( recover_i          ),
        // Write Port A
        .regfile_we_a_i      ( regfile_we_a_i     ),
        .regfile_waddr_a_i   ( regfile_waddr_a_i  ),
        .regfile_wdata_a_i   ( regfile_wdata_a_i  ),
        // Write Port B
        .regfile_we_b_i      ( regfile_we_b_i     ),
        .regfile_waddr_b_i   ( regfile_waddr_b_i  ),
        .regfile_wdata_b_i   ( regfile_wdata_b_i  ),
        // Backup ports to the RF
        .regfile_backup_i    ( regfile_backup_i   ),
        .regfile_raddr_ra_i  ( regfile_raddr_ra_i ),
        .regfile_raddr_rb_i  ( regfile_raddr_rb_i ),
        .regfile_raddr_rc_i  ( regfile_raddr_rc_i ),
        .regfile_rdata_ra_o  ( regfile_rdata_ra_o ),
        .regfile_rdata_rb_o  ( regfile_rdata_rb_o ),
        .regfile_rdata_rc_o  ( regfile_rdata_rc_o ),
         // FPU
        .apu_req_o           ( apu_master_req_o      ),
        .apu_gnt_i           ( apu_master_gnt_i      ),
        .apu_operands_o      ( apu_master_operands_o ),
        .apu_op_o            ( apu_master_op_o       ),
        .apu_flags_o         ( apu_master_flags_o    ),
        .apu_rvalid_i        ( apu_master_valid_i    ),
        .apu_result_i        ( apu_master_result_i   ),
        .apu_flags_i         ( apu_master_flags_i    ),
        // Master Bus to Core Demux
        .data_req_o          ( core_mem_req            ),
        .data_gnt_i          ( core_bus_master.gnt     ),
        .data_we_o           ( core_bus_master_we      ),
        .data_be_o           ( core_bus_master.be      ),
        .data_addr_o         ( core_bus_master.add     ),
        .data_wdata_o        ( core_bus_master.data    ),
        .data_rdata_i        ( core_bus_master.r_data  ),
        .data_rvalid_i       ( core_bus_master.r_valid )
      ); 
  end else /* Ibex */ begin: CL_IBEX_CORE
    // As a boot address, Ibex expects 0x00 offset (adds reset offset 0x80 internally)
    assign boot_addr = boot_addr_i & 32'hFFFFFF00;

    `ifdef TRACE_EXECUTION
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
      ) IBEX_CORE         (
        .clk_i            ( clk_i              ),
        .rst_ni           ( rst_ni             ),
        .test_en_i        ( test_mode_i        ),
        .hart_id_i        ( hart_id            ),
        .boot_addr_i      ( boot_addr          ),
        // Instruction Memory Interface:  Interface to Instruction Logaritmic interconnect: Req->grant handshake
        .instr_req_o      ( core_instr_req     ),
        .instr_gnt_i      ( core_instr_gnt     ),
        .instr_rvalid_i   ( core_instr_r_valid ),
        .instr_addr_o     ( core_instr_addr    ),
        .instr_rdata_i    ( core_instr_r_rdata ),
        .instr_err_i      ( 1'b0               ),
        // Data memory interface:
        .data_req_o       ( core_mem_req            ),
        .data_gnt_i       ( core_bus_master.gnt     ),
        .data_we_o        ( core_bus_master_we      ),
        .data_be_o        ( core_bus_master.be      ),
        .data_addr_o      ( core_bus_master.add     ),
        .data_wdata_o     ( core_bus_master.data    ),
        .data_rdata_i     ( core_bus_master.r_data  ),
        .data_rvalid_i    ( core_bus_master.r_valid ),
        .data_err_i       ( 1'b0                    ),
        .irq_software_i   ( 1'b0                    ),
        .irq_timer_i      ( 1'b0                    ),
        .irq_external_i   ( 1'b0                    ),
        .irq_fast_i       ( 15'b0                   ),
        .irq_nm_i         ( 1'b0                    ),
        .irq_x_i          ( core_irq_x              ),
        .irq_x_ack_o      ( irq_ack_o               ),
        .irq_x_ack_id_o   ( irq_ack_id_o            ),
        .external_perf_i  ( {{{16 - NUM_EXT_PERF_CNTRS}{'0}}, ext_perf_cntrs_i} ),
        .debug_req_i      ( debug_req_i             ),
        .fetch_enable_i   ( fetch_en_i              ),
        .alert_minor_o    (                         ),
        .alert_major_o    (                         ),
        .core_sleep_o     ( core_sleep              )
      );
  end
endgenerate

/* debug stuff */
//synopsys translate_off

// CHECK IF THE CORE --> LS port is makin accesses in unmapped regions
always @(posedge clk_i) begin : CHECK_ASSERTIONS
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

  logic instr_gnt_L2;
  logic instr_gnt_ROM;
  logic instr_r_valid_ROM;
  logic instr_r_valid_L2;
  logic destination; //--> 0 fetch from BOOT_ROM, 1--> fetch from L2_MEMORY
  logic [INSTR_RDATA_WIDTH-1:0] instr_r_rdata_ROM;
  logic [INSTR_RDATA_WIDTH-1:0] instr_r_rdata_L2;

  initial
  begin
    FILE_ID.itoa(core_id_i);
    FILENAME = {"FETCH_CORE_", FILE_ID, ".log" };
    FILE=$fopen(FILENAME,"w");
  end

  // SELF CHECK ROUTINES TO compare instruction fetches with slm files
  always_ff @(posedge clk_i) begin
    if(instr_r_valid_i) begin
      $fwrite( FILE , "\t --> %8h\n",instr_r_rdata_i);
      case(destination)
        1'b1: begin
          /* ... */
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
      `endif // DUMP_INSTR_FETCH
    end
  end
`endif // DEBUG_FETCH_INTERFACE

`ifdef DATA_MISS
  logic data_hit;
  logic req;
`endif
  logic reg_cache_refill;

always_ff @(posedge clk_i , negedge rst_ni) begin
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

endmodule: core_region
