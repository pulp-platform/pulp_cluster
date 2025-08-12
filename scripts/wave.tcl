# Copyright 2025 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
#
# Andrea Belano <andrea.belano2@unibo.it>

onerror {resume}
quietly WaveActivateNextPane {} 0

set CORE_TYPE    [examine -radix symbolic sim:/pulp_cluster_tb/PulpClusterCfgVis.CoreType]
set NUM_CORES    [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfgVis.NumCores]
set HMR_PRESENT  [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfgVis.HMRPresent]
set HWPE_PRESENT [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfgVis.HwpePresent]
set HWPE_LIST    [examine sim:/pulp_cluster_tb/PulpClusterCfgVis.HwpeCfg.HwpeList]
set NUM_HWPE     [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfgVis.HwpeCfg.NumHwpes]

set ENABLE_WIDE  [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfgVis.EnableWidePort]
if { $ENABLE_WIDE == 1 } {
  set CLUSTER_PATH /pulp_cluster_tb/gen_dma_buses/cluster_i
} else {
  set CLUSTER_PATH /pulp_cluster_tb/gen_dma_stubs/cluster_i
}

# Cluster
add wave -noupdate -group cluster $CLUSTER_PATH/*

# HMR (if present)
if { $HMR_PRESENT != 0 } {
  set hmr_path "$CLUSTER_PATH/gen_hmr_unit/i_hmr_unit/*"
  set hmr_matches [find signals $hmr_path]
  if { [llength $hmr_matches] > 0 } {
    add wave -noupdate -group hmr $hmr_path
  }
}

# Peripherals
add wave -noupdate -group cluster_peripherals $CLUSTER_PATH/cluster_peripherals_i/*
# Control Unit
add wave -noupdate -group cluster_control_unit $CLUSTER_PATH/cluster_peripherals_i/cluster_control_unit_i/*
# HWPE Subsystem (if present)
if { $HWPE_PRESENT != 0 } {
  add wave -noupdate -group hwpe_subsystem $CLUSTER_PATH/hwpe_gen/hwpe_subsystem_i/*
}
for {set i 0} {$i < $NUM_HWPE} {incr i} {
  if { $HWPE_PRESENT != 0 } {
    # Try for different HWPEs
    foreach hwpe_kind {redmule neureka softex} {
      set inst_path "$CLUSTER_PATH/hwpe_gen/hwpe_subsystem_i/gen_hwpe[$i]/gen_${hwpe_kind}/i_${hwpe_kind}/*"
      set matches [find signals $inst_path]
      if { [llength $matches] > 0 } {
        add wave -noupdate -group hwpe_subsystem -group $hwpe_kind $inst_path
      }
    }
  }
}
# Cores
for {set i 0} {$i < $NUM_CORES} {incr i} {
  add wave -noupdate -group Core[$i] -group core_region $CLUSTER_PATH/CORE[$i]/core_region_i/*
  add wave -noupdate -group Core[$i] -group core_region -group core $CLUSTER_PATH/CORE[$i]/core_region_i/${CORE_TYPE}_CORE/${CORE_TYPE}_CORE/*
}

configure wave -timelineunits ns

# Remove the hierarchial strip from signals
config wave -signalnamewidth 1