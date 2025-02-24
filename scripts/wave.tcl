# Copyright 2025 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
#
# Andrea Belano <andrea.belano2@unibo.it>

onerror {resume}
quietly WaveActivateNextPane {} 0

set CORE_TYPE    [examine sim:/pulp_cluster_tb/PulpClusterCfg.CoreType]
set NUM_CORES    [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfg.NumCores]
set HMR_PRESENT  [examine sim:/pulp_cluster_tb/PulpClusterCfg.HMRPresent]
set HWPE_PRESENT [examine sim:/pulp_cluster_tb/PulpClusterCfg.HwpePresent]
set HWPE_LIST    [examine sim:/pulp_cluster_tb/PulpClusterCfg.HwpeCfg.HwpeList]
set NUM_HWPE     [examine -radix dec sim:/pulp_cluster_tb/PulpClusterCfg.HwpeCfg.NumHwpes]

# Cluster
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/*
# HMR
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/*
# Peripherals
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/*
# Control Unit
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/*
# HWPE Subsystem
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/*
for {set i 0} {$i < $NUM_HWPE} {incr i} {
  #set HWPE_NAME [tolower $HWPE_LIST($i)]
  set HWPE_NAME [string tolower [examine sim:/pulp_cluster_tb/PulpClusterCfg.HwpeCfg.HwpeList[$i]]]
  add wave -noupdate -group hwpe_subsystem -group $HWPE_NAME /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[$i]/gen_$HWPE_NAME/i_$HWPE_NAME/*
}
# Cores
for {set i 0} {$i < $NUM_CORES} {incr i} {
  add wave -noupdate -group Core[$i] -group core_region /pulp_cluster_tb/cluster_i/CORE[$i]/core_region_i/*
  add wave -noupdate -group Core[$i] -group core_region -group core /pulp_cluster_tb/cluster_i/CORE[$i]/core_region_i/${CORE_TYPE}_CORE/${CORE_TYPE}_CORE/*
}

configure wave -timelineunits ns

# Remove the hierarchial strip from signals
config wave -signalnamewidth 1