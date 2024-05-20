# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

common_defs += -D FEATURE_ICACHE_STAT
common_defs += -D PRIVATE_ICACHE
common_defs += -D HIERARCHY_ICACHE_32BIT
common_defs += -D ICAHE_USE_FF
common_defs += -D NO_FPU
common_defs += -D CLUSTER_ALIAS
common_defs += -D USE_PULP_PARAMETERS

common_targs += -t rtl
common_targs += -t mchan
common_targs += -t cluster_standalone
common_targs += -t scm_use_fpga_scm
common_targs += -t cv32e40p_use_ff_regfile
