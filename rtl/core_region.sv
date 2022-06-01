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
  parameter CORE_ID             = 0,
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
  input logic                            init_ni,

  input logic [3:0]                      base_addr_i, // FOR CLUSTER VIRTUALIZATION

  input logic [5:0]                      cluster_id_i,
  
  input logic                            irq_req_i,
  output logic                           irq_ack_o,
  input logic [4:0]                      irq_id_i,
  output logic [4:0]                     irq_ack_id_o,
  
  input logic                            clock_en_i,
  input logic                            fetch_en_i,
  input logic                            fregfile_disable_i,

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
              
  //XBAR_TCDM_BUS.Slave     debug_bus,
  //output logic            debug_core_halted_o,
  //input logic             debug_core_halt_i,
  //input logic             debug_core_resume_i,
              
  // Interface for DEMUX to TCDM INTERCONNECT ,PERIPHERAL INTERCONNECT and DMA CONTROLLER
  hci_core_intf.master tcdm_data_master,
  XBAR_TCDM_BUS.Master dma_ctrl_master,
  XBAR_PERIPH_BUS.Master eu_ctrl_master,
  XBAR_PERIPH_BUS.Master periph_data_master

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

  XBAR_DEMUX_BUS    s_core_bus();         // Internal interface between CORE       <--> DEMUX
  XBAR_PERIPH_BUS   periph_demux_bus();   // Internal interface between CORE_DEMUX <--> PERIPHERAL DEMUX

  logic [N_EXT_PERF_COUNTERS_ACTUAL-1:0]      perf_counters;
  logic            clk_int;
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

  // clock gate of the core_region less the core itself
  cluster_clock_gating clock_gate_i (
    .clk_i     ( clk_i       ),
    .en_i      ( clock_en_i  ),
    .test_en_i ( test_mode_i ),
    .clk_o     ( clk_int     )
  );

  assign hart_id = {21'b0, cluster_id_i[5:0], 1'b0, CORE_ID[3:0]};

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

  generate
    if ( CORE_TYPE_CL == 0 ) begin: CL_CORE
      assign boot_addr = boot_addr_i;
      riscv_core #(
        .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH ),
        .N_EXT_PERF_COUNTERS ( N_EXT_PERF_COUNTERS_ACTUAL ),
        .PULP_SECURE         ( 0                 ),
        .FPU                 ( FPU               ),
        .FP_DIVSQRT          ( FP_DIVSQRT        ),
        .SHARED_FP           ( SHARED_FP         ),
        .SHARED_DSP_MULT     ( 0                 ),
        .SHARED_INT_DIV      ( 0                 ),
        .SHARED_FP_DIVSQRT   ( SHARED_FP_DIVSQRT ),
        .WAPUTYPE            ( WAPUTYPE          ),
        .DM_HaltAddress      ( DEBUG_START_ADDR + 16'h0800 )

      ) RISCV_CORE (
        .clk_i                 ( clk_i             ),
        .rst_ni                ( rst_ni            ),

        .clock_en_i            ( clock_en_i        ),
        .test_en_i             ( test_mode_i       ),

        .boot_addr_i           ( boot_addr         ),
        .core_id_i             ( CORE_ID[3:0]      ),
        .cluster_id_i          ( cluster_id_i      ),

        .instr_addr_o          ( instr_addr_o             ),
        .instr_req_o           ( instr_req_o              ),
        .instr_rdata_i         ( instr_r_rdata_i          ),
        .instr_gnt_i           ( instr_gnt_i              ),
        .instr_rvalid_i        ( instr_r_valid_i          ),

        .data_addr_o           ( s_core_bus.add           ),
        .data_wdata_o          ( s_core_bus.wdata         ),
        .data_we_o             ( s_core_bus.we            ),
        .data_req_o            ( s_core_bus.req           ),
        .data_be_o             ( s_core_bus.be            ),
        .data_rdata_i          ( s_core_bus.r_rdata       ),
        .data_gnt_i            ( s_core_bus.gnt           ),
        .data_rvalid_i         ( s_core_bus.r_valid       ),

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

        .ext_perf_counters_i   ( perf_counters         ),
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
        .mem_req_o   (s_core_bus.req    ),
        .mem_gnt_i   (s_core_bus.gnt    ),
        .mem_rvalid_i(s_core_bus.r_valid)
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
        .data_req_o            ( core_mem_req       ),
        .data_gnt_i            ( s_core_bus.gnt     ),
        .data_rvalid_i         ( s_core_bus.r_valid ),
        .data_we_o             ( s_core_bus.we      ),
        .data_be_o             ( s_core_bus.be      ),
        .data_addr_o           ( s_core_bus.add     ),
        .data_wdata_o          ( s_core_bus.wdata   ),
        .data_rdata_i          ( s_core_bus.r_rdata ),
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

  //assign debug_bus.r_opc = 1'b0;

  // Bind to 0 Unused Signals in CORE interface
  assign s_core_bus.r_gnt       = 1'b0;
  assign s_core_bus.barrier     = 1'b0;
  assign s_core_bus.exec_cancel = 1'b0;
  assign s_core_bus.exec_stall  = 1'b0;

  // Performance Counters
  assign perf_counters[4] = tcdm_data_master.req & (~tcdm_data_master.gnt);  // Cycles lost due to contention


  //********************************************************
  //****** DEMUX TO TCDM AND PERIPHERAL INTERCONNECT *******
  //********************************************************
   
  // demuxes to TCDM & memory hierarchy
  core_demux #(
    .ADDR_WIDTH         ( 32                 ),
    .DATA_WIDTH         ( 32                 ),
    .BYTE_ENABLE_BIT    ( DATA_WIDTH/8       ),
    .CLUSTER_ALIAS_BASE ( CLUSTER_ALIAS_BASE )
  ) core_demux_i (
    .clk                (  clk_int                    ),
    .rst_ni             (  rst_ni                     ),
    .test_en_i          (  test_mode_i                ),
  `ifdef REMAP_ADDRESS
    .base_addr_i        (  base_addr_i                ),
`endif
    .data_req_i         (  s_core_bus.req             ),
    .data_add_i         (  s_core_bus.add             ),
    .data_wen_i         ( ~s_core_bus.we              ), //inverted when using OR10N
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
    .data_wdata_o_SH    (  tcdm_data_master.data      ),
    .data_be_o_SH       (  tcdm_data_master.be        ),
    .data_gnt_i_SH      (  tcdm_data_master.gnt       ),
    .data_r_valid_i_SH  (  tcdm_data_master.r_valid   ),
    .data_r_rdata_i_SH  (  tcdm_data_master.r_data    ),

    .data_req_o_EXT     (  periph_demux_bus.req         ),
    .data_add_o_EXT     (  periph_demux_bus.add         ),
    .data_wen_o_EXT     (  periph_demux_bus.wen         ),
    .data_wdata_o_EXT   (  periph_demux_bus.wdata       ),
    .data_be_o_EXT      (  periph_demux_bus.be          ),
    .data_gnt_i_EXT     (  periph_demux_bus.gnt         ),
    .data_r_valid_i_EXT (  periph_demux_bus.r_valid     ),
    .data_r_rdata_i_EXT (  periph_demux_bus.r_rdata     ),
    .data_r_opc_i_EXT   (  periph_demux_bus.r_opc       ),

    .data_req_o_PE      (  periph_data_master.req     ),
    .data_add_o_PE      (  periph_data_master.add     ),
    .data_wen_o_PE      (  periph_data_master.wen     ),
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

  assign tcdm_data_master.boffs = '0;
  assign tcdm_data_master.lrdy  = '1;

  assign periph_demux_bus.id = '0;

   periph_demux periph_demux_i (
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
