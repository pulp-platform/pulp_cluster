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
NONFREE_BRANCH ?= dkeller/chimera-v2

nonfree-init:
	rm -rf nonfree;
	git clone --single-branch --branch $(NONFREE_BRANCH) $(NONFREE_REMOTE) nonfree
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

update:
	$(BENDER) update

######
# SW #
######

.PHONY: sw-init sw-clean

sw-init: pulp-runtime fault_injection_sim regression_tests
sw-clean:
	@rm -rf pulp-runtime fault_injection_sim regression_test

## Clone pulp-runtime as SW stack
PULP_RUNTIME_REMOTE ?= https://github.com/pulp-platform/pulp-runtime.git
PULP_RUNTIME_REF	?= dkeller/chimera-v2
PULP_RUNTIME_DIR	?= $(ROOT_DIR)/pulp-runtime
# Lock (optional)
PULP_RUNTIME_LOCK_FILE ?= pulp-runtime.lock
PULP_RUNTIME_COMMIT := $(shell test -f $(PULP_RUNTIME_LOCK_FILE) && cat $(PULP_RUNTIME_LOCK_FILE) || echo)

pulp-runtime:
	@if [ -d "$(PULP_RUNTIME_DIR)/.git" ]; then \
		echo "[pulp-runtime] Using existing repo at $(PULP_RUNTIME_DIR)"; \
		git -C $(PULP_RUNTIME_DIR) fetch --tags --all; \
	else \
		echo "[pulp-runtime] Cloning $(PULP_RUNTIME_REMOTE)"; \
		git clone $(PULP_RUNTIME_REMOTE) $(PULP_RUNTIME_DIR); \
	fi
	@if [ -n "$(PULP_RUNTIME_COMMIT)" ]; then \
		echo "[pulp-runtime] Checking out locked commit $(PULP_RUNTIME_COMMIT)"; \
		git -C $(PULP_RUNTIME_DIR) checkout --detach $(PULP_RUNTIME_COMMIT); \
	else \
		echo "[pulp-runtime] Checking out ref $(PULP_RUNTIME_REF)"; \
		git -C $(PULP_RUNTIME_DIR) checkout $(PULP_RUNTIME_REF) || true; \
		git -C $(PULP_RUNTIME_DIR) pull --ff-only || true; \
	fi

lock-runtime:
	@git -C $(PULP_RUNTIME_DIR) rev-parse HEAD > $(PULP_RUNTIME_LOCK_FILE) && \
	echo "Locked pulp-runtime to $$(cat $(PULP_RUNTIME_LOCK_FILE))"

unlock-runtime:
	@rm -f $(PULP_RUNTIME_LOCK_FILE) && echo "Unlocked pulp-runtime (will track $(PULP_RUNTIME_REF))"

## Clone fault injection scripts
FAULT_SIM_REMOTE ?= https://github.com/pulp-platform/InjectaFault.git
FAULT_SIM_BRANCH ?= rt/rename-var
FAULT_SIM_DIR	?= $(ROOT_DIR)/fault_injection_sim
# Lock (optional)
FAULT_SIM_LOCK_FILE ?= fault_injection_sim.lock
FAULT_SIM_COMMIT := $(shell test -f $(FAULT_SIM_LOCK_FILE) && cat $(FAULT_SIM_LOCK_FILE) || echo)

fault_injection_sim:
	@if [ -d "$(FAULT_SIM_DIR)/.git" ]; then \
		echo "[fault_injection_sim] Using existing repo at $(FAULT_SIM_DIR)"; \
		git -C $(FAULT_SIM_DIR) fetch --tags --all; \
	else \
		echo "[fault_injection_sim] Cloning $(FAULT_SIM_REMOTE)"; \
		git clone $(FAULT_SIM_REMOTE) $(FAULT_SIM_DIR); \
	fi
	@if [ -n "$(FAULT_SIM_COMMIT)" ]; then \
		echo "[fault_injection_sim] Checking out locked commit $(FAULT_SIM_COMMIT)"; \
		git -C $(FAULT_SIM_DIR) checkout --detach $(FAULT_SIM_COMMIT); \
	else \
		echo "[fault_injection_sim] Checking out ref $(FAULT_SIM_BRANCH)"; \
		git -C $(FAULT_SIM_DIR) checkout $(FAULT_SIM_BRANCH) || true; \
		git -C $(FAULT_SIM_DIR) pull --ff-only || true; \
	fi
	
lock-fault-sim:
	@git -C $(FAULT_SIM_DIR) rev-parse HEAD > $(FAULT_SIM_LOCK_FILE) && \
	echo "Locked fault_injection_sim to $$(cat $(FAULT_SIM_LOCK_FILE))"

unlock-fault-sim:
	@rm -f $(FAULT_SIM_LOCK_FILE) && echo "Unlocked fault_injection_sim (will track $(FAULT_SIM_BRANCH))"

## Clone regression tests
REGRESSION_TESTS_REMOTE ?= https://github.com/pulp-platform/regression_tests.git
REGRESSION_TESTS_BRANCH ?= dkeller/chimera-v2
REGRESSION_TESTS_DIR	?= $(ROOT_DIR)/regression_tests
# Lock (optional)
REGRESSION_TESTS_LOCK_FILE ?= regression_tests.lock
REGRESSION_TESTS_COMMIT := $(shell test -f $(REGRESSION_TESTS_LOCK_FILE) && cat $(REGRESSION_TESTS_LOCK_FILE) || echo)

regression_tests:
	@if [ -d "$(REGRESSION_TESTS_DIR)/.git" ]; then \
		echo "[regression_tests] Using existing repo at $(REGRESSION_TESTS_DIR)"; \
		git -C $(REGRESSION_TESTS_DIR) fetch --tags --all; \
	else \
		echo "[regression_tests] Cloning $(REGRESSION_TESTS_REMOTE)"; \
		git clone $(REGRESSION_TESTS_REMOTE) $(REGRESSION_TESTS_DIR); \
	fi
	@if [ -n "$(REGRESSION_TESTS_COMMIT)" ]; then \
		echo "[regression_tests] Checking out locked commit $(REGRESSION_TESTS_COMMIT)"; \
		git -C $(REGRESSION_TESTS_DIR) checkout --detach $(REGRESSION_TESTS_COMMIT); \
	else \
		echo "[regression_tests] Checking out ref $(REGRESSION_TESTS_BRANCH)"; \
		git -C $(REGRESSION_TESTS_DIR) checkout $(REGRESSION_TESTS_BRANCH) || true; \
		git -C $(REGRESSION_TESTS_DIR) pull --ff-only || true; \
	fi
	@echo "[regression_tests] Initializing submodules (e.g., pulp-nnx)"
	@git -C $(REGRESSION_TESTS_DIR) submodule update --init --recursive

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
	$(call generate_vsim, $@, $(common_defs) $(common_targs) $(sim_defs) $(sim_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@

include bender-synth.mk
scripts/synth-compile.tcl: | Bender.lock
	$(BENDER) script synopsys $(common_targs) $(common_defs) $(synth_targs) $(synth_defs)	> $@

$(library):
	$(QUESTA) vlib $(library)

compile: $(IDMA_ROOT)/.idma_generated $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc

run:
	$(VSIM) +permissive -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

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
