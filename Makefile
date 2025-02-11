# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

ROOT_DIR = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

HOSTNAME := $(shell hostname)
ETH_HOST = $(shell echo $(HOSTNAME) | grep -q "\.ee\.ethz\.ch$$" && echo 1 || echo 0)
ifeq ($(ETH_HOST),1)
QUESTA ?= questa-2023.4-zr
else
QUESTA ?=
endif

BENDER ?= bender
PYTHON ?= python3

VSIM ?= $(QUESTA) vsim
VOPT ?= $(QUESTA) vopt
VLIB ?= $(QUESTA) vlib
top_level ?= pulp_cluster_tb
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

REGRESSIONS := $(ROOT_DIR)/regression_tests

VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\" \"+incdir+$(shell pwd)/include\"

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= 4267271dca54a6c6592336919034ee6e5573974a # branch: smazzola/chimera

nonfree-init:
	git clone $(NONFREE_REMOTE) nonfree
	cd nonfree && git checkout $(NONFREE_COMMIT)

################
# Dependencies #
################

.PHONY: init

init: checkout

.PHONY: checkout
## Checkout/update dependencies using Bender
checkout:
	$(BENDER) checkout
	touch Bender.lock
	make scripts/compile.tcl

Bender.lock:
	$(BENDER) checkout
	touch Bender.lock


######
# SW #
######

.PHONY: sw-init sw-clean

sw-init: pulp-runtime fault_injection_sim regression_tests
sw-clean:
	@rm -rf pulp-runtime fault_injection_sim regression_test

## Clone pulp-runtime as SW stack
PULP_RUNTIME_REMOTE ?= https://github.com/pulp-platform/pulp-runtime.git
PULP_RUNTIME_COMMIT ?= 749c08e2036ddcb7baaa956c09a556f8b386b66f # branch: smazzola/chimera

pulp-runtime:
	git clone $(PULP_RUNTIME_REMOTE) $@
	cd $@ && git checkout $(PULP_RUNTIME_COMMIT)

## Clone fault injection scripts
FAULT_SIM_REMOTE ?= https://github.com/pulp-platform/InjectaFault.git
FAULT_SIM_COMMIT ?= 84ddcff # branch: rt/rename-var

fault_injection_sim:
	git clone $(FAULT_SIM_REMOTE) $@
	cd $@ && git checkout $(FAULT_SIM_COMMIT)

## Clone regression tests
REGRESSION_TESTS_REMOTE ?= https://github.com/pulp-platform/regression_tests.git
REGRESSION_TESTS_COMMIT ?= 53e038baec991aa94e113ecefc03ca6377e56f85 # branch: smazzola/chimera

regression_tests:
	git clone $(REGRESSION_TESTS_REMOTE) $@
	cd $@ && git checkout $(REGRESSION_TESTS_COMMIT)
	cd $@ && git submodule update --init --recursive

#########################
# Hardware dependencies #
#########################

# Set dependency paths only if dependencies have already been cloned
# This avoids running `bender checkout` at every make command
ifeq ($(shell test -d $(ROOT_DIR)/.bender || echo 1),)
IDMA_ROOT := $(shell $(BENDER) path idma)
endif

# Fall back to safe defaults if dependencies are not cloned yet
IDMA_ROOT ?= .

# Python requirements (version and packages) coming from iDMA repository
gen_idma_hw:
	@$(PYTHON) --version >/dev/null 2>&1 || { echo "ERROR: Python not found. Python 3.8 or higher is required."; exit 1; } && \
	$(PYTHON) -c "import sys; assert sys.version_info >= (3, 8)" || { echo "ERROR: Python version must be 3.8 or higher"; exit 1; } && \
	$(PYTHON) -m venv venv && \
	. venv/bin/activate && \
	pip install --upgrade pip && \
	pip install -r $(IDMA_ROOT)/requirements.txt && \
	make -C $(IDMA_ROOT) idma_hw_all

clean_idma_hw:
	make -C $(IDMA_ROOT) idma_clean_all

########################
# Build and simulation #
########################

.PHONY: sim-clean compile build run

sim-clean: clean_idma_hw
	rm -rf scripts/compile.tcl
	rm -rf work

include bender-common.mk
include bender-sim.mk
scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, $(common_defs) $(common_targs) $(sim_defs) $(sim_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@

include bender-synth.mk
scripts/synth-compile.tcl: | Bender.lock
	$(BENDER) script synopsys $(common_targs) $(common_defs) $(synth_targs) $(synth_defs)	> $@

$(library):
	$(QUESTA) vlib $(library)

compile: gen_idma_hw $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc

run:
	$(VSIM) +permissive -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

####################
# Regression tests #
####################

include regression.mk
