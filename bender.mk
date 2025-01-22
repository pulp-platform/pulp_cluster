# Copyright 2025 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

bender_defs += -D FEATURE_ICACHE_STAT
bender_defs += -D PRIVATE_ICACHE
bender_defs += -D HIERARCHY_ICACHE_32BIT
bender_defs += -D ICAHE_USE_FF
bender_defs += -D TRACE_EXECUTION
bender_defs += -D CLUSTER_ALIAS
bender_defs += -D USE_PULP_PARAMETERS
bender_defs += -D SNITCH_ICACHE

bender_targs += -t rtl
bender_targs += -t test
bender_targs += -t mchan
bender_targs += -t cluster_standalone
bender_targs += -t scm_use_fpga_scm
bender_targs += -t cv32e40p_use_ff_regfile