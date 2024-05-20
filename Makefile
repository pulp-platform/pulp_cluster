# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

ROOT_DIR = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

ifneq (,$(wildcard /etc/iis.version))
	QUESTA ?= questa-2022.3
	BENDER ?= bender
else
	QUESTA ?=
	BENDER ?= ./bender
endif
GIT ?= git
VSIM ?= $(QUESTA) vsim
VOPT ?= $(QUESTA) vopt
top_level ?= pulp_cluster_tb
dpi-library ?= work-dpi
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

REGRESSIONS := $(ROOT_DIR)/regression-tests

CFLAGS ?= -I$(QUESTASIM_HOME)/include \
					-I$(RISCV)/include/ \
					-I/include -std=c++11 -I../tb/dpi -O3

dpi := $(patsubst tb/dpi/%.cc, ${dpi-library}/%.o, $(wildcard tb/dpi/*.cc))

VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\" \"+incdir+$(shell pwd)/include\"
XVLOG_ARGS += -64bit -compile -vtimescale 1ns/1ns -quiet

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= c8593493 # branch: yt/standalone-synth

nonfree-init:
	git clone $(NONFREE_REMOTE) nonfree
	cd nonfree && git checkout $(NONFREE_COMMIT)

################
# Dependencies #
################

.PHONY: init

init: checkout
	git submodule update --init --recursive

.PHONY: checkout scripts/compile.tcl
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

## Clone pulp-runtime as SW stack
pulp-runtime:
	git submodule update --init --recursive $@

## Clone fault injection scripts
fault_injection_sim:
	git submodule update --init --recursive $@

########################
# Build and simulation #
########################

$(BENDER): 
	curl --proto '=https'  \
	--tlsv1.2 https://pulp-platform.github.io/bender/init -sSf | sh -s -- 0.24.0
	mv bender $(BENDER)

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

include bender-common.mk
include bender-sim.mk
scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, $(common_defs) $(common_targs) $(sim_defs) $(sim_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@
	echo 'vopt +permissive -suppress 3053 -suppress 8885 +UVM_NO_RELNOTES $(top_level) -o $(top_level)_optimized' >> $@

include bender-synth.mk
scripts/synth-compile.tcl: | Bender.lock
	$(BENDER) script synopsys $(common_targs) $(common_defs) $(synth_targs) $(synth_defs)	> $@

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
