# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

ROOT_DIR      = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

GIT ?= git
BENDER ?= bender
VSIM ?= vsim
VLIB ?= vlib
VOPT ?= vopt
top_level ?= pulp_cluster_tb
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

CFLAGS ?= -I$(QUESTASIM_HOME)/include \
					-I$(RISCV)/include/ \
					-I/include -std=c++11 -I../tb/dpi -O3
ifeq ($(LEGACY_DMA), 1)
compile_flag = -gIDMA=0
endif

VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\" \"+incdir+$(shell pwd)/include\"
XVLOG_ARGS += -64bit -compile -vtimescale 1ns/1ns -quiet

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	bender script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= fbf47af28e7377f542fe7cfaab2ed2b1f21de10b

nonfree-init:
	git clone $(NONFREE_REMOTE) nonfree
	cd nonfree && git checkout $(NONFREE_COMMIT)

################
# Dependencies #
################

.PHONY: checkout
## Checkout/update dependencies using Bender
checkout:
	bender checkout
	touch Bender.lock
	make scripts/compile.tcl

Bender.lock:
	bender checkout
	touch Bender.lock

######
# SW #
######
RT_REV ?= 0aa2c89de337713e63cd41b60388cf16275f5e7c
TESTS_REV ?= 09b9a46175567f7dd1da63c127e99b4307376c81
## Clone pulp-runtime as SW stack
pulp-runtime:
	git clone https://github.com/pulp-platform/pulp-runtime.git $@
	cd $@; git checkout $(RT_REV); cd ..

## Clone regression tests for bare-metal verification
regression-tests:
	git clone https://github.com/pulp-platform/regression_tests.git $@
	cd $@; git checkout $(TESTS_REV); cd ..

########################
# Build and simulation #
########################

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, -t rtl -t test -t cluster_standalone,..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@

$(library):
	$(VLIB) $(library)

compile: $(library) scripts/compile.tcl
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'source scripts/compile.tcl; quit'

build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc=nprt -debug


run:
	$(VSIM) +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression-tests
	cd regression-tests && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o runtime-parallel.xml parallel-bare-tests.yaml


.PHONY: test-rt-mchan
## Run mchan tests on pulp-runtime
test-rt-mchan: pulp-runtime regression-tests
	cd regression-tests && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o runtime-mchan.xml pulp_cluster-mchan-tests.yaml
