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

`include "pulp_soc_defines.sv"

package pulp_cluster_package;

  import rapid_recovery_pkg::*;

  typedef bit [ 7:0] byte_t;
  typedef bit [12:0] alias_t;
  typedef bit [31:0] word_t;
  typedef bit [63:0] doub_t;

  // Core type
  typedef enum logic[1:0] {
    CV32,
    RI5CY,
    IBEX
  } core_type_e;

  // HWPE type
  typedef enum byte_t {
    REDMULE,
    NEUREKA,
    SOFTEX
  } hwpe_type_e;

  localparam int unsigned MAX_NUM_HWPES = 8;

  typedef struct {
    hwpe_type_e [MAX_NUM_HWPES-1:0] HwpeList;
    byte_t NumHwpes;
  } hwpe_subsystem_cfg_t;

  // PULP cluster configuration
  typedef struct {
    // Type of core in the cluster
    core_type_e CoreType;
    // Number of cores in the cluster
    byte_t NumCores;
    // Number of DMA TCDM plugs
    byte_t DmaNumPlugs;
    // Number of DMA outstanding transactions
    byte_t DmaNumOutstandingBursts;
    // DMA burst length in bits
    word_t DmaBurstLength;
    // Number of masters in crossbar peripherals
    byte_t NumMstPeriphs;
    // Number of slaves in crossbar peripherals
    byte_t NumSlvPeriphs;
    // Enable cluster aliasing
    bit ClusterAlias;
    // Base of the cluster alias
    alias_t ClusterAliasBase;
    // Number of internal synchronization stages
    byte_t NumSyncStages;
    // Enable HCI
    bit UseHci;
    // Size of the TCDM in bytes (power of two)
    word_t TcdmSize;
    // Number of TCDM banks (power of two)
    byte_t TcdmNumBank;
    // Enable HWPEs
    bit HwpePresent;
    // HWPEs selection and ID map
    hwpe_subsystem_cfg_t HwpeCfg;
    // Number of memory ports available for HWPEs
    byte_t HwpeNumPorts;
    // Enable the HMR Unit
    bit HMRPresent;
    // Enable double modular redundancy
    bit HMRDmrEnabled;
    // Enable triple modular redundancy
    bit HMRTmrEnabled;
    // Lock HMR into permanent DMR mode
    bit HMRDmrFIxed;
    // Lock HMR into permanent TMR mode
    bit HMRTmrFIxed;
    // Interleave DMR/TMR cores
    bit HMRInterleaveGrps;
    // Enable rapid recovery
    bit HMREnableRapidRecovery;
    // Separates voters and checkers for data
    bit HMRSeparateDataVoters;
    // Separates voters and checkers for AXI buses
    bit HMRSeparateAxiBus;
    // Number of separate voters/checkers for individual buses
    bit HMRNumBusVoters;
    // Enable ECC
    bit EnableECC;
    // Enable ECC on the hci interconnect
    bit ECCInterco;
    // Number if I$ banks
    byte_t iCacheNumBanks;
    // Number of I$ lines
    byte_t iCacheNumLines;
    // Number of I$ ways
    byte_t iCacheNumWays; // default is 4
    // Shared I$ size in bytes
    word_t iCacheSharedSize; // default is 4096
    // Private I$ size in bytes
    word_t iCachePrivateSize; // default is 521
    // Private I$ data width
    byte_t iCachePrivateDataWidth;
    // Enable reduced tag
    bit EnableReducedTag;
    // L2 size
    word_t L2Size;
    // Debug module base address
    doub_t DmBaseAddr;
    // BootROM base address
    doub_t BootRomBaseAddr;
    // Cores boot address
    doub_t BootAddr;
    // Enable private FPU
    bit EnablePrivateFpu;
    // Enable private FP division/sqrt
    bit EnablePrivateFpDivSqrt;
    // Enable shared FPUs
    bit EnableSharedFpu;
    // Enable shared FP division/sqrt
    bit EnableSharedFpDivSqrt;
    // Number of shared FPUs
    byte_t NumSharedFpu;
    // Enable TNN extension
    bit EnableTnnExtension;
    // Enable TNN unsigned
    bit EnableTnnUnsigned;
    // Number of AXI crossbar subordinate ports
    byte_t NumAxiIn;
    // Number of AXI crossbar manager ports
    byte_t NumAxiOut;
    // AXI ID width of crossbar subordinate ports
    byte_t AxiIdInWidth;
    // AXI ID width of crossbar manager ports
    byte_t AxiIdOutWidth;
    // AXI address width
    byte_t AxiAddrWidth;
    // AXI data width from external to cluster
    byte_t AxiDataInWidth;
    // AXI data width from cluster to external
    byte_t AxiDataOutWidth;
    // AXI user width
    byte_t AxiUserWidth;
    // AXI maximum subordinate transaction per ID
    byte_t AxiMaxInTrans;
    // AXI maximum manager transaction per ID
    byte_t AxiMaxOutTrans;
    // Log depth of AXI CDC FIFOs
    byte_t AxiCdcLogDepth; // old LOG_DEPTH
    // Sinchronization stages of AXI CDC FIFOs
    byte_t AxiCdcSyncStages;
    // Input synchronization stages
    byte_t SyncStages;
    // Cluster base address
    doub_t ClusterBaseAddr;
    // Cluster peripherals offset
    doub_t ClusterPeriphOffs;
    // Cluster base external offset
    doub_t ClusterExternalOffs;
    // Address remap for virtualization
    bit EnableRemapAddress;
    // Enable Snitch ICache
    bit SnitchICache;
  } pulp_cluster_cfg_t;

  localparam int unsigned NB_SPERIPH_PLUGS_EU = 2;

  // number of master and slave cluster periphs
  parameter int unsigned NB_MPERIPHS = `NB_MPERIPHS;
  parameter int unsigned NB_SPERIPHS = `NB_SPERIPHS;

  // position of peripherals on slave port of periph interconnect
  localparam int unsigned SPER_EOC_ID           = 0;  // 0x0000 - 0x0400
  localparam int unsigned SPER_TIMER_ID         = 1;  // 0x0400 - 0x0800
  localparam int unsigned SPER_EVENT_U_ID       = 2;  // 0x0800 - 0x1000
                                                     // 3 also used for Event Unit
  localparam int unsigned SPER_HWPE_ID          = 4;  // 0x1000 - 0x1400
  localparam int unsigned SPER_ICACHE_CTRL      = 5;  // 0x1400 - 0x1800
  localparam int unsigned SPER_DMA_CL_ID        = 6;  // 0x1800 - 0x1C00
  localparam int unsigned SPER_DMA_FC_ID        = 7;  // 0x1C00 - 0x2000
  localparam int unsigned SPER_HMR_UNIT_ID      = 8;  // 0x2000 - 0x2400
  localparam int unsigned SPER_TCDM_SCRUBBER_ID = 9;  // 0x2400 - 0x2800
  localparam int unsigned SPER_HWPE_HCI_ECC_ID  = 10; // 0x2800 - 0x3200
  localparam int unsigned SPER_EXT_ID           = 11; // -> unmapped, directed to error
  localparam int unsigned SPER_ERROR_ID         = 12; // -> unmapped, directed to error

  // The following parameters refer to the cluster AXI crossbar
  localparam byte_t NumAxiSubordinatePorts = 4;
  localparam byte_t NumAxiManagerPorts = 3;
  localparam byte_t AxiSubordinateIdwidth = 4;
  localparam byte_t AxiManagerIdwidth = AxiSubordinateIdwidth + $clog2(NumAxiSubordinatePorts);
  localparam int unsigned NumCores = `NB_CORES;
  localparam int unsigned NumDmas = `NB_DMAS;

  localparam pulp_cluster_cfg_t PulpClusterDefaultCfg = '{
    CoreType: RI5CY,
    NumCores: NumCores,
    DmaNumPlugs: NumDmas,
    DmaNumOutstandingBursts: 8,
    DmaBurstLength: 256,
    NumMstPeriphs: NB_MPERIPHS,
    NumSlvPeriphs: NB_SPERIPHS,
    ClusterAlias: 1,
    ClusterAliasBase: 'h0,
    NumSyncStages: 3,
    UseHci: 1,
    TcdmSize: 128*1024,
    TcdmNumBank: 16,
    HwpePresent: 1,
    HwpeCfg: '{NumHwpes: 3, HwpeList: {SOFTEX, NEUREKA, REDMULE}},
    HwpeNumPorts: 9,
    HMRPresent: 1,
    HMRDmrEnabled: 1,
    HMRTmrEnabled: 1,
    HMRDmrFIxed: 0,
    HMRTmrFIxed: 0,
    HMRInterleaveGrps: 1,
    HMREnableRapidRecovery: 1,
    HMRSeparateDataVoters:1,
    HMRSeparateAxiBus:0,
    HMRNumBusVoters:1,
    EnableECC: 1,
    ECCInterco: 1,
    iCacheNumBanks: 2,
    iCacheNumLines: 1,
    iCacheNumWays: 4,
    iCacheSharedSize: 4*1024,
    iCachePrivateSize: 512,
    iCachePrivateDataWidth: 32,
    EnableReducedTag: 1,
    L2Size: 1000*1024,
    DmBaseAddr: 'h1A110000,
    BootRomBaseAddr: 'h1A000000,
    BootAddr: 'h1C000000,
    EnablePrivateFpu: 1,
    EnablePrivateFpDivSqrt: 0,
    EnableSharedFpu: 0,
    EnableSharedFpDivSqrt: 0,
    NumSharedFpu: 0,
    EnableTnnExtension: 1,
    EnableTnnUnsigned: 1,
    NumAxiIn: NumAxiSubordinatePorts,
    NumAxiOut: NumAxiManagerPorts,
    AxiIdInWidth: AxiSubordinateIdwidth,
    AxiIdOutWidth:AxiManagerIdwidth,
    AxiAddrWidth: 48,
    AxiDataInWidth: 64,
    AxiDataOutWidth: 64,
    AxiUserWidth: 10,
    AxiMaxInTrans: 64,
    AxiMaxOutTrans: 64,
    AxiCdcLogDepth: 3,
    AxiCdcSyncStages: 3,
    SyncStages: 3,
    ClusterBaseAddr: 'h10000000,
    ClusterPeriphOffs: 'h00200000,
    ClusterExternalOffs: 'h00400000,
    EnableRemapAddress: 0,
    SnitchICache: 0,
    default: '0
  };

  typedef struct packed {
    logic gnt;
    logic [31:0] r_data;
    logic r_valid;
  } core_data_rsp_t;

  typedef struct packed {
    logic req;
    logic [31:0] add;
    logic we;
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
    logic        debug_halted;
    logic        core_busy;
  } core_outputs_t;

  typedef struct packed {
    rapid_recovery_pkg::regfile_write_t regfile_backup;
    rapid_recovery_pkg::csrs_intf_t     csr_backup;
    rapid_recovery_pkg::pc_intf_t       pc_backup;
  } core_backup_t;

endpackage
