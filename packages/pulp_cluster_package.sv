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

  parameter NB_SPERIPH_PLUGS_EU  = 2;

  // position of peripherals on slave port of periph interconnect
  parameter SPER_EOC_ID      = 0;
  parameter SPER_TIMER_ID    = 1;
  parameter SPER_EVENT_U_ID  = 2;
  // Event unit has two plugs
  parameter SPER_HWPE_ID     = 4;
  parameter SPER_ACCEL_ID    = 4;
  parameter SPER_ICACHE_CTRL = 5;
  parameter SPER_DMA_ID      = 6;
  parameter SPER_EXT_ID      = 7;

  // if set to 1, then instantiate APU in the cluster
  parameter APU_CLUSTER = 0;

  // // if set to 1, the 0x0000_0000 to 0x0040_0000 is the alias of the current cluster address space (eg cluster 0 is from  0x1000_0000 to 0x1040_0000)
  // parameter CLUSTER_ALIAS = 1;

  // // if set to 1, the DEMUX peripherals (EU, MCHAN) are placed right before the test and set region.
  // // This will steal 16KB from the 1MB TCDM reegion.
  // // EU is mapped           from 0x10100000 - 0x400
  // // MCHAN regs are mapped  from 0x10100000 - 0x800
  // // remember to change the defines in the pulp.h as well to be coherent with this approach
  // parameter DEM_PER_BEFORE_TCDM_TS = 0;

endpackage
