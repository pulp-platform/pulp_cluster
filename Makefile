# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

ROOT_DIR = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

QUESTA ?=
BENDER ?= bender

VSIM ?= $(QUESTA) vsim
VOPT ?= $(QUESTA) vopt
VLIB ?= $(QUESTA) vlib
top_level ?= pulp_cluster_tb
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

REGRESSIONS := $(ROOT_DIR)/regression_tests

VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\" \"+incdir+$(shell pwd)/include\"

bender_defs += -D FEATURE_ICACHE_STAT
bender_defs += -D PRIVATE_ICACHE
bender_defs += -D HIERARCHY_ICACHE_32BIT
bender_defs += -D ICAHE_USE_FF
bender_defs += -D NO_FPU
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

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= 9fc1aee

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
PULP_RUNTIME_COMMIT ?= a5bc02e # branch: upstream-features

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
REGRESSION_TESTS_COMMIT ?= b1c3f82 # branch: astral

regression_tests:
	git clone $(REGRESSION_TESTS_REMOTE) $@
	cd $@ && git checkout $(REGRESSION_TESTS_COMMIT)
	cd $@ && git submodule update --init --recursive

########################
# Build and simulation #
########################

.PHONY: sim_clean compile build run

$(BENDER): 
	curl --proto '=https'  \
	--tlsv1.2 https://pulp-platform.github.io/bender/init -sSf | sh -s -- 0.24.0
	mv bender $(BENDER)

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, $(bender_defs) $(bender_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@
	echo 'vopt +permissive -suppress 3053 -suppress 8885 +UVM_NO_RELNOTES $(top_level) -o $(top_level)_optimized' >> $@

$(library):
	$(QUESTA) vlib $(library)

compile: $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc

run:
	$(VSIM) +permissive $(questa-flags) $(uvm-flags) $(QUESTASIM_FLAGS) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

####################
# Regression tests #
####################

include regression.mk
