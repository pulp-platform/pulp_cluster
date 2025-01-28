# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# set up environment variables for rtl simulation, pulp-runtime and freertos
ROOTD=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)

export PULP_RUNTIME_GCC_TOOLCHAIN=/usr/pack/riscv-1.0-kgf/pulp-gcc-1.0.16

source "$ROOTD/pulp-runtime/configs/pulp_cluster.sh"
source "$ROOTD/scripts/vsim.sh"
