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

BENDER_SUPPRESS_WARNINGS ?= E24
export BENDER_SUPPRESS_WARNINGS

VSIM ?= $(QUESTA) vsim
VOPT ?= $(QUESTA) vopt
VLIB ?= $(QUESTA) vlib

QSIM ?= $(QUESTA) qsim
QOPT ?= $(QUESTA) qopt
Q1VE ?= q1ve --qverify

VENV  := venv

top_level ?= pulp_cluster
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

REGRESSIONS := $(ROOT_DIR)/regression_tests

VLOG_ARGS_LINT += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 \"+incdir+$(shell pwd)/include\"
VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1ns / 1ps\" \"+incdir+$(shell pwd)/include\"

# TB's wide DMA port toggle override
export TB_ENABLE_WIDE_PORT
ifneq ($(strip $(TB_ENABLE_WIDE_PORT)),)
VLOG_ARGS += +define+TB_ENABLE_WIDE_PORT=$(TB_ENABLE_WIDE_PORT)
endif

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= aad59d36bfef6b74f03ffed28903a44cb86b9497

nonfree-init:
	rm -rf nonfree;
	git clone $(NONFREE_REMOTE) nonfree
	cd nonfree && git checkout $(NONFREE_COMMIT)

################
# Dependencies #
################

.PHONY: init

init: checkout generate_idma_rtl scripts/compile.tcl

.PHONY: checkout
## Checkout/update dependencies using Bender
checkout:
	$(BENDER) checkout
	touch Bender.lock

Bender.lock:
	$(BENDER) checkout
	touch Bender.lock

update:
	$(BENDER) update

######
# SW #
######

.PHONY: sw-init sw-clean

sw-init: pulp-runtime fault_injection_sim regression_tests
sw-clean:
	@rm -rf pulp-runtime fault_injection_sim regression_tests

## Clone pulp-runtime as SW stack
PULP_RUNTIME_REMOTE ?= https://github.com/pulp-platform/pulp-runtime.git
PULP_RUNTIME_COMMIT ?= 3b48b0c6872cc01ba169a2c9c886ebb815d22cdc

pulp-runtime:
	rm -rf $@
	git clone $(PULP_RUNTIME_REMOTE) $@
	cd $@ && git checkout $(PULP_RUNTIME_COMMIT)

lock-runtime:
	@git -C $(PULP_RUNTIME_DIR) rev-parse HEAD > $(PULP_RUNTIME_LOCK_FILE) && \
	echo "Locked pulp-runtime to $$(cat $(PULP_RUNTIME_LOCK_FILE))"

unlock-runtime:
	@rm -f $(PULP_RUNTIME_LOCK_FILE) && echo "Unlocked pulp-runtime (will track $(PULP_RUNTIME_REF))"

## Clone fault injection scripts
FAULT_SIM_REMOTE ?= https://github.com/pulp-platform/InjectaFault.git
FAULT_SIM_COMMIT ?= 84ddcff # branch: rt/rename-var

fault_injection_sim:
	rm -rf $@
	git clone $(FAULT_SIM_REMOTE) $@
	cd $@ && git checkout $(FAULT_SIM_COMMIT)

lock-fault-sim:
	@git -C $(FAULT_SIM_DIR) rev-parse HEAD > $(FAULT_SIM_LOCK_FILE) && \
	echo "Locked fault_injection_sim to $$(cat $(FAULT_SIM_LOCK_FILE))"

unlock-fault-sim:
	@rm -f $(FAULT_SIM_LOCK_FILE) && echo "Unlocked fault_injection_sim (will track $(FAULT_SIM_BRANCH))"

## Clone regression tests
REGRESSION_TESTS_REMOTE ?= https://github.com/pulp-platform/regression_tests.git
REGRESSION_TESTS_COMMIT ?= f173611e3e8f15e7f526d40712135e7ff976f805 # branch: lg/upstream

regression_tests:
	rm -rf $@
	git clone $(REGRESSION_TESTS_REMOTE) $@
	cd $@ && git checkout $(REGRESSION_TESTS_COMMIT)
	cd $@ && git submodule update --init --recursive

lock-regression-tests:
	@git -C $(REGRESSION_TESTS_DIR) rev-parse HEAD > $(REGRESSION_TESTS_LOCK_FILE) && \
	echo "Locked regression_tests to $$(cat $(REGRESSION_TESTS_LOCK_FILE))"

unlock-regression-tests:
	@rm -f $(REGRESSION_TESTS_LOCK_FILE) && echo "Unlocked regression_tests (will track $(REGRESSION_TESTS_BRANCH))"

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
gen_idma_hw: $(IDMA_ROOT)/.idma_generated
$(IDMA_ROOT)/.idma_generated:
	@$(PYTHON) --version >/dev/null 2>&1 || { echo "ERROR: Python not found. Python 3.8 or higher is required."; exit 1; } && \
	$(PYTHON) -c "import sys; assert sys.version_info >= (3, 8)" || { echo "ERROR: Python version must be 3.8 or higher"; exit 1; } && \
	rm -rf venv && $(PYTHON) -m venv venv && \
	. venv/bin/activate && \
	pip install --upgrade pip && \
	pip install -r $(IDMA_ROOT)/requirements.txt && \
	make -C $(IDMA_ROOT) idma_hw_all && \
	touch $@

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
	$(call generate_vsim, $@, $(common_defs) $(common_targs) -t idma $(sim_defs) $(sim_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@

scripts/compile.tcl-mchan: | Bender.lock
	$(call generate_vsim, scripts/compile.tcl, $(common_defs) $(common_targs) -t mchan $(sim_defs) $(sim_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> scripts/compile.tcl

include bender-synth.mk
scripts/synth-compile.tcl: | Bender.lock
	$(BENDER) script synopsys $(common_targs) $(common_defs) $(synth_targs) $(synth_defs)	> $@

scripts/compile_lint.tcl:
	echo 'set ROOT $(ROOT_DIR)' > $@
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS_LINT)" $(common_defs) $(common_targs) | grep -v "set ROOT" >> $@
	echo >> $@

$(library):
	$(QUESTA) vlib $(library)


uv:
	cd $(shell bender path idma) && \
	curl -LsSf https://astral.sh/uv/install.sh | sh && \
	uv sync --locked

generate_idma_rtl: uv
	. "$(shell bender path idma)/.venv/bin/activate" && $(MAKE) -C $(shell bender path idma) idma_hw_all

compile: $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build_qone: compile
	$(QOPT) $(compile_flag) -debug +designfile -suppress 3053 -suppress 8885 -work $(library)  $(top_level)_tb -o $(top_level)_tb_optimized


build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level)_tb -o $(top_level)_tb_optimized +acc

compile_lint: $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile_lint.tcl || { echo "ERROR: scripts/compile_lint.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(Q1VE) -od lint/comp_lint_results -c -do " \
	onerror {exit}; \
	do scripts/compile_lint.tcl; \
	exit"

lint: compile_lint
	$(Q1VE) -od lint/lint_results -c -do " \
	lint methodology ip -goal release; \
	lint run -d $(top_level); \
	exit"

cdc: compile_lint
	$(Q1VE) -od cdc_results -c -do " \
	cdc run -d $(top_level); \
	exit"

run:
	$(VSIM) +permissive -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_tb_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

.PHONY: clean

clean:
	rm -rf scripts/synth-compile.tcl
	rm -rf scripts/compile.tcl
	rm -rf transcript
	rm -rf *.log
####################
# Regression tests #
####################

include regression.mk
