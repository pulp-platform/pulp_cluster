# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# set up environment variables for rtl simulation, pulp-runtime and freertos
ROOTD=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)

# If at IIS, set up appropriate questa version.
if test -f /etc/iis.version; then
  export QUESTA=questa-2023.4-zr
  export QUESTASIM_HOME=/usr/pack/${QUESTA}/questasim
  export PULP_RUNTIME_GCC_TOOLCHAIN=/usr/pack/riscv-1.0-kgf/pulp-gcc-1.0.16
fi

source "$ROOTD/pulp-runtime/configs/astral-cluster.sh"
source "$ROOTD/scripts/vsim.sh"
