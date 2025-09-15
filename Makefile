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

VSIM ?= $(QUESTA) vsim
VOPT ?= $(QUESTA) vopt
VLIB ?= $(QUESTA) vlib

QSIM ?= $(QUESTA) qsim
QOPT ?= $(QUESTA) qopt

top_level ?= pulp_cluster
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

REGRESSIONS := $(ROOT_DIR)/regression_tests

VLOG_ARGS_LINT += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 \"+incdir+$(shell pwd)/include\"
VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1ns / 1ps\" \"+incdir+$(shell pwd)/include\"

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= beb98ce

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
	@rm -rf pulp-runtime fault_injection_sim regression_tests

## Clone pulp-runtime as SW stack
PULP_RUNTIME_REMOTE ?= git@github.com:RiccardoGandolfi/pulp-runtime.git
PULP_RUNTIME_COMMIT ?= 048502d346e13753e384d9777829db26468097d6 # branch: lg/upstream

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
REGRESSION_TESTS_REMOTE ?= git@github.com:RiccardoGandolfi/regression_tests.git
REGRESSION_TESTS_COMMIT ?= 6fac940e924c7de83b37d7be14bfd9febbf04678 # branch: lg/upstream

regression_tests:
	git clone $(REGRESSION_TESTS_REMOTE) $@
	cd $@ && git checkout $(REGRESSION_TESTS_COMMIT)
	cd $@ && git submodule update --init --recursive

########################
# Build and simulation #
########################

.PHONY: sim-clean compile build run

sim-clean:
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

scripts/compile_lint.tcl:
	echo 'set ROOT $(ROOT_DIR)' > $@
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS_LINT)" $(common_defs) $(common_targs) | grep -v "set ROOT" >> $@
	echo >> $@

$(library):
	$(QUESTA) vlib $(library)

compile: $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build_qone: compile
	$(QOPT) $(compile_flag) -debug +designfile -suppress 3053 -suppress 8885 -work $(library)  $(top_level)_tb -o $(top_level)_tb_optimized


build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level)_tb -o $(top_level)_tb_optimized +acc

compile_lint: $(library)
	qverify -od lint/comp_lint_results -c -do " \
	onerror {exit}; \
	do scripts/compile_lint.tcl; \
	exit"

lint: compile_lint
	qverify -od lint/lint_results -c -do " \
	lint methodology ip -goal release; \
	lint run -d $(top_level); \
	exit"

cdc: compile_lint
	qverify -od cdc_results -c -do " \
	cdc run -d $(top_level); \
	exit"

run:
	$(VSIM) +permissive -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_tb_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

####################
# Regression tests #
####################

include regression.mk
