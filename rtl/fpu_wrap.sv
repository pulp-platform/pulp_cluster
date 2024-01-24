// Copyright 2023 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

module fpu_wrap
  import riscv_defines::*;
#(
  parameter int unsigned DataWidth        = 32,
  parameter int unsigned FpuNumOperands   = 3,
  parameter int unsigned FpuOpcodeWidth   = 6,
  parameter int unsigned FpuInFlagsWidth  = 15,
  parameter int unsigned FpuOutFlagsWidth = 5,
  parameter int unsigned FpuFmtBits       = fpnew_pkg::FP_FORMAT_BITS,
  parameter int unsigned FpuIntFmtBits    = fpnew_pkg::INT_FORMAT_BITS,
  parameter int unsigned FpuRoundBits     = 3,
  parameter int unsigned FpuOpBits        = fpnew_pkg::OP_BITS,
  parameter int unsigned FpuDivSqrt       = 0
)(
  // Clock and Reset
  input  logic clk_i,
  input  logic rst_ni,
  input  logic [31:0] hart_id_i,
  // APU Side: Master port
  input  logic fpu_req_i,
  output logic fpu_gnt_o,
  // request channel
  input  logic [FpuNumOperands-1:0][DataWidth-1:0] fpu_operands_i,
  input  logic [FpuOpcodeWidth-1:0] fpu_op_i,
  input  logic [FpuInFlagsWidth-1:0] fpu_flags_i,
  // response channel
  output logic fpu_valid_o,
  output logic [DataWidth-1:0] fpu_result_o,
  output logic [FpuOutFlagsWidth-1:0] fpu_flags_o
);

localparam fpnew_pkg::unit_type_t C_DIV = FpuDivSqrt ? fpnew_pkg::MERGED :
                                                       fpnew_pkg::DISABLED;

logic fpu_op_mod;
logic fpu_vec_op;
logic [FpuOpBits-1:0] fpu_op;

logic [FpuFmtBits-1:0] dst_fmt;
logic [FpuFmtBits-1:0] src_fmt;
logic [FpuIntFmtBits-1:0] int_fmt;
logic [FpuRoundBits-1:0] fp_rnd_mode;

assign {fpu_vec_op, fpu_op_mod, fpu_op} = fpu_op_i;
assign {int_fmt, src_fmt, dst_fmt, fp_rnd_mode} = fpu_flags_i;

// -----------
// FPU Config
// -----------
// Features (enabled formats, vectors etc.)
localparam fpnew_pkg::fpu_features_t FpuFeatures = '{
  Width:         C_FLEN,
  EnableVectors: C_XFVEC,
  EnableNanBox:  1'b0,
  FpFmtMask:     {C_RVF, C_RVD, C_XF16, C_XF8, C_XF16ALT, C_XF8ALT},
  IntFmtMask:    {C_XFVEC && (C_XF8 || C_XF8ALT),
                  C_XFVEC && (C_XF16 || C_XF16ALT), 1'b1, 1'b0}
};

// Implementation (number of registers etc)
localparam fpnew_pkg::fpu_implementation_t FpuImplementation = '{
  PipeRegs:  '{// FP32, FP64, FP16, FP8, FP16alt, FP8alt
               '{C_LAT_FP32, C_LAT_FP64,
                 C_LAT_FP16, C_LAT_FP8 ,
                 C_LAT_FP16ALT, C_LAT_FP8ALT},   // ADDMUL
               '{default: C_LAT_DIVSQRT},        // DIVSQRT
               '{default: C_LAT_NONCOMP},        // NONCOMP
               '{default: C_LAT_CONV   },        // CONV
               '{default: C_LAT_DOTP   }},       // SDOTP
  UnitTypes: '{'{default: fpnew_pkg::MERGED},    // ADDMUL
               '{default: C_DIV},                // DIVSQRT
               '{default: fpnew_pkg::PARALLEL},  // NONCOMP
               '{default: fpnew_pkg::MERGED},    // CONV
               '{default: fpnew_pkg::DISABLED}}, // SDOTP
  PipeConfig: fpnew_pkg::BEFORE
};

//---------------
// FPU instance
//---------------
fpnew_top #(
  .Features       ( FpuImplementation ),
  .Implementation ( FpuFeatures       ),
  .TagType        ( logic             )
) i_fpnew (
  .clk_i          ( clk_i                                ),
  .rst_ni         ( rst_ni                               ),
  .hart_id_i      ( hart_id_i                            ),
  .operands_i     ( fpu_operands_i                       ),
  .rnd_mode_i     ( fpnew_pkg::roundmode_e'(fp_rnd_mode) ),
  .op_i           ( fpnew_pkg::operation_e'(fpu_op)      ),
  .op_mod_i       ( fpu_op_mod                           ),
  .src_fmt_i      ( fpnew_pkg::fp_format_e'(src_fmt)     ),
  .dst_fmt_i      ( fpnew_pkg::fp_format_e'(dst_fmt)     ),
  .int_fmt_i      ( fpnew_pkg::int_format_e'(int_fmt)    ),
  .vectorial_op_i ( fpu_vec_op                           ),
  .tag_i          ( '0                                   ),
  .simd_mask_i    ( '1                                   ),
  .in_valid_i     ( fpu_req_i                            ),
  .in_ready_o     ( fpu_gnt_o                            ),
  .flush_i        ( '0                                   ),
  .result_o       ( fpu_result_o                         ),
  .status_o       ( fpu_flags_o                          ),
  .tag_o          (                                      ),
  .out_valid_o    ( fpu_valid_o                          ),
  .out_ready_i    ( 1'b1                                 ),
  .busy_o         (                                      )
);

endmodule: fpu_wrap
