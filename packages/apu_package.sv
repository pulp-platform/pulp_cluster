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
 * apu_package.sv
 * Michael Gautschi <gautschi@iis.ee.ethz.ch>
 */

package apu_package;

   parameter FPU                 = 1;
   
   parameter SHARED_FP           = 1;
   parameter SHARED_DSP_MULT     = SHARED_FP ? 1 : 0; // only available with shared FPU
   parameter SHARED_INT_DIV      = SHARED_FP ? 0 : 0; // only available with shared FPU

   // Shared div/sqrt implementation 0=none, 1=pipelined version, 2=iterative shared unit
   parameter SHARED_FP_DIVSQRT = 2;

   ////////////////////////////////////////////////////////////////////////////////////////
   //  IMPORTANT!!                                                                       //
   ////////////////////////////////////////////////////////////////////////////////////////
   // THESE PARAMETERS HAVE TO MATCH THE ones in ips/riscv/includes/apu_core_package.sv  //
   ////////////////////////////////////////////////////////////////////////////////////////
  
   // by default set to 0
   parameter SHARED_INT_MULT   = 0;

   // CPU side / general params
   parameter NARGS_CPU     = 3;
   parameter WOP_CPU       = 6;
   parameter NUSFLAGS_CPU  = 5;
   parameter NDSFLAGS_CPU  = 15;
   /////////////////////////////////////////////////////////////////////////////
   // until here                                                              //
   /////////////////////////////////////////////////////////////////////////////
   
   // FP-general
   parameter APUTYPE_FP   = (SHARED_FP) ? SHARED_DSP_MULT + SHARED_INT_MULT + SHARED_INT_DIV : 0;
   parameter APU_FLAGS_FP = 2;

   // generated values
   parameter C_APUTYPES   = (SHARED_FP) ? (SHARED_FP_DIVSQRT==1) ? APUTYPE_FP+6 : (SHARED_FP_DIVSQRT==2) ? APUTYPE_FP+5 : APUTYPE_FP+4 : SHARED_DSP_MULT + SHARED_INT_DIV + SHARED_INT_MULT;

   parameter WAPUTYPE     = $clog2(C_APUTYPES);

endpackage
