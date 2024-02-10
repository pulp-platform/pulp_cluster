# Copyright 2023 ETH Zurich and University of Bologna
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

ROOT_DIR = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

QUESTA ?= questa-2022.3
GIT ?= git
BENDER ?= bender
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

bender_defs += -D FEATURE_ICACHE_STAT
bender_defs += -D PRIVATE_ICACHE
bender_defs += -D HIERARCHY_ICACHE_32BIT
bender_defs += -D ICAHE_USE_FF
bender_defs += -D NO_FPU
bender_defs += -D TRACE_EXECUTION
bender_defs += -D CLUSTER_ALIAS
bender_defs += -D USE_PULP_PARAMETERS

bender_targs += -t rtl
bender_targs += -t test
bender_targs += -t mchan
bender_targs += -t cluster_standalone
bender_targs += -t scm_use_fpga_scm
bender_targs += -t cv32e40p_use_ff_regfile

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	bender script vsim --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= bb64efc82c3cff99a5de9585c8963025078c16c2

nonfree-init:
	git clone $(NONFREE_REMOTE) nonfree
	cd nonfree && git checkout $(NONFREE_COMMIT)

################
# Dependencies #
################

.PHONY: checkout scripts/compile.tcl
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

## Clone pulp-runtime as SW stack
pulp-runtime:
	git clone https://github.com/pulp-platform/pulp-runtime.git $@
	cd $@; git checkout 197d06b6ad1d8014cef73e0e87b59b5ebf66d019; cd $(ROOT_DIR)

## Clone regression tests for bare-metal verification
regression-tests:
	git clone https://github.com/pulp-platform/regression_tests.git $@
	cd $@; git checkout b85310fd9ed068a0b310b67ed7b3aa46ec30c9bb; cd $(ROOT_DIR)

########################
# Build and simulation #
########################

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, $(bender_defs) $(bender_targs),..)
	echo 'vlog "$(realpath $(ROOT_DIR))/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"' >> $@
	echo 'vopt +permissive -suppress 3053 -suppress 8885 +UVM_NO_RELNOTES $(top_level) -o $(top_level)_optimized'

$(library):
	$(QUESTA) vlib $(library)

compile: $(library)
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	$(VSIM) -c -do 'quit -code [source scripts/compile.tcl]'

build: compile
	$(VOPT) $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc -check_synthesis

run:
	$(VSIM) +permissive $(questa-flags) $(uvm-flags) $(QUESTASIM_FLAGS) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression-tests
	cd $(REGRESSIONS)/carfield && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/carfield/runtime-parallel.xml $(REGRESSIONS)/carfield/parallel-bare-tests.yaml

.PHONY: test-rt-mchan
## Run mchan tests on pulp-runtime
test-rt-mchan: pulp-runtime regression-tests
	cd regression-tests && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/carfield/runtime-mchan.xml $(REGRESSIONS)/carfield/pulp_cluster-mchan-tests.yaml
