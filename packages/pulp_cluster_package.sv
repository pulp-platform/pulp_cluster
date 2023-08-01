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
 * pulp_cluster_package.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Michael Gautschi <gautschi@iis.ee.ethz.ch>
 */

package pulp_cluster_package;

  import rapid_recovery_pkg::*;
  parameter NB_SPERIPH_PLUGS_EU  =  2;

  // number of master and slave cluster periphs
  parameter NB_MPERIPHS          =  1;
  parameter NB_SPERIPHS          = 10;

  // position of peripherals on slave port of periph interconnect
  parameter SPER_EOC_ID      = 0;  // 0x0000 - 0x0400
  parameter SPER_TIMER_ID    = 1;  // 0x0400 - 0x0800
  parameter SPER_EVENT_U_ID  = 2;  // 0x0800 - 0x1000
                            // 3 also used for Event Unit
  parameter SPER_HWPE_ID     = 4;  // 0x1000 - 0x1400
  parameter SPER_ICACHE_CTRL = 5;  // 0x1400 - 0x1800
  parameter SPER_DMA_CL_ID   = 6;  // 0x1800 - 0x1C00
  parameter SPER_DMA_FC_ID   = 7;  // 0x1C00 - 0x2000
  parameter SPER_HMR_UNIT_ID = 8;  // 0x2000 - 0x2400
  parameter SPER_EXT_ID      = 9;  // 0x2400 - 0x2800
  parameter SPER_ERROR_ID    = 10; // 0x2800 - 0x2C00
   
  // if set to 1, then instantiate APU in the cluster
 // parameter APU_CLUSTER = 0;

  // // if set to 1, the 0x0000_0000 to 0x0040_0000 is the alias of the current cluster address space (eg cluster 0 is from  0x1000_0000 to 0x1040_0000)
  // parameter CLUSTER_ALIAS = 1;

  // // if set to 1, the DEMUX peripherals (EU, MCHAN) are placed right before the test and set region.
  // // This will steal 16KB from the 1MB TCDM reegion.
  // // EU is mapped           from 0x10100000 - 0x400
  // // MCHAN regs are mapped  from 0x10100000 - 0x800
  // // remember to change the defines in the pulp.h as well to be coherent with this approach
  // parameter DEM_PER_BEFORE_TCDM_TS = 0;

  typedef struct packed {
    logic gnt;
    logic [31:0] r_data;
    logic r_valid;
  } core_data_rsp_t;

  typedef struct packed {
    logic req;
    logic [31:0] add;
    logic wen;
    logic [31:0] data;
    logic [3:0] be;
  } core_data_req_t;

  typedef struct packed {
    logic        clock_en;
    logic [31:0] boot_addr;
    logic [3:0]  core_id;
    logic [5:0]  cluster_id;
    logic        instr_gnt;
    logic        instr_rvalid;
    logic [31:0] instr_rdata;
    logic        data_gnt;
    logic        data_rvalid;
    logic [31:0] data_rdata;
    logic        irq_req;
    logic [4:0]  irq_id;
  } core_inputs_t;

  typedef struct packed {
    logic        instr_req;
    logic [31:0] instr_addr;
    logic        data_req;
    logic        data_we;
    logic  [3:0] data_be;
    logic [31:0] data_add;
    logic [31:0] data_wdata;
    logic        irq_ack;
    logic [4:0]  irq_ack_id;
    // logic        debug_havereset;
    // logic        debug_running;
    logic        debug_halted;
    logic        core_busy;
    rapid_recovery_pkg::regfile_write_t regfile_backup;
    rapid_recovery_pkg::csrs_intf_t     csr_backup;
    rapid_recovery_pkg::pc_intf_t       pc_backup;
  } core_outputs_t;

endpackage
