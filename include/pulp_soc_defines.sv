// Copyright 2013-2023 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/*
 *  Activate this define to exclude the cluster and speed up the FPGA deployement
 */

// `define EXCLUDE_CLUSTER

/*
 * Collection of legacy pulp cluster defines.
 * 
 */

`ifndef PULP_SOC_DEFINES_SV
`define PULP_SOC_DEFINES_SV


`define CLUSTER_ALIAS
`define PRIVATE_ICACHE
`define HIERARCHY_ICACHE_32BIT
`define FEATURE_ICACHE_STAT

`define FC_FPU 1
`define FC_FP_DIVSQRT 1

// Remove the FPUs in the cluster for FPGA SYNTHESIS
`ifdef FPGA_TARGET_XILINX
  `define CLUST_FPU 0
  `define CLUST_FP_DIVSQRT 0
  `define CLUST_SHARED_FP 0
  `define CLUST_SHARED_FP_DIVSQRT 0
`elsif NO_FPU
  `define CLUST_FPU 0
  `define CLUST_FP_DIVSQRT 0
  `define CLUST_SHARED_FP 0
  `define CLUST_SHARED_FP_DIVSQRT 0
`else
  `define CLUST_FPU 1
  `define CLUST_FP_DIVSQRT 1
  `define CLUST_SHARED_FP 2
  `define CLUST_SHARED_FP_DIVSQRT 2
`endif 

//PARAMETRES
`define NB_CLUSTERS   1
`define NB_CORES      8
`define NB_DMAS       4
`define NB_MPERIPHS   1
`define NB_SPERIPHS   12

// Width of byte enable for a given data width
`define EVAL_BE_WIDTH(DATAWIDTH) (DATAWIDTH/8)

`define NB_L2_CHANNELS 4

// Default JTAG ID code type
typedef struct packed {
  bit [ 3:0]  version;
  bit [15:0]  part_num;
  bit [10:0]  manufacturer;
  bit         _one;
} jtag_idcode_t;

// PULP Platform manufacturer and default PulpOpen part number
localparam bit [10:0] JtagPulpManufacturer  = 11'h6d9;
localparam bit [15:0] JtagPulpOpenPartNum   = 16'hc5e5;
localparam bit [ 3:0] JtagPulpOpenVersion   = 4'h1;
localparam jtag_idcode_t PulpOpenIdCode = '{
  _one          : 1,
  manufacturer  : JtagPulpManufacturer,
  part_num      : JtagPulpOpenPartNum,
  version       : JtagPulpOpenVersion
};

// JTAG
`define DMI_JTAG_IDCODE PulpOpenIdCode
// `define DMI_JTAG_IDCODE 32'h249511C3

`endif
