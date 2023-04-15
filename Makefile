ROOT_DIR      = $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

GIT ?= git
BENDER ?= bender
VSIM ?= vsim
top_level ?= pulp_cluster_tb
dpi-library ?= work-dpi
library ?= work
elf-bin ?= stimuli.riscv
bwruntest = $(ROOT_DIR)/pulp-runtime/scripts/bwruntests.py

CFLAGS ?= -I$(QUESTASIM_HOME)/include \
					-I$(RISCV)/include/ \
					-I/include -std=c++11 -I../tb/dpi -O3

dpi := $(patsubst tb/dpi/%.cc, ${dpi-library}/%.o, $(wildcard tb/dpi/*.cc))

VLOG_ARGS += -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\" \"+incdir+$(shell pwd)/include\"
XVLOG_ARGS += -64bit -compile -vtimescale 1ns/1ns -quiet

define generate_vsim
	echo 'set ROOT [file normalize [file dirname [info script]]/$3]' > $1
	bender script $(VSIM) --vlog-arg="$(VLOG_ARGS)" $2 | grep -v "set ROOT" >> $1
	echo >> $1
endef

######################
# Nonfree components #
######################

NONFREE_REMOTE ?= git@iis-git.ee.ethz.ch:pulp-restricted/pulp-cluster-nonfree.git
NONFREE_COMMIT ?= e327fb9f8cb4a583d219862e81245405f22283bb

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

## Clone pulp-runtime as SW stack
pulp-runtime:
	git clone https://github.com/pulp-platform/pulp-runtime.git -b lv/pulp_cluster $@

## Clone regression tests for bare-metal verification
regression-tests:
	git clone https://github.com/pulp-platform/regression_tests $@

########################
# Build and simulation #
########################

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

scripts/compile.tcl: | Bender.lock
	$(call generate_vsim, $@, -t rtl -t test -t cluster_standalone,..)

# compile the elfloader.cpp
$(dpi-library)/%.o: tb/dpi/%.cc $(dpi_hdr)
	mkdir -p $(dpi-library)
	$(CXX) -shared -fPIC -std=c++0x -Bsymbolic $(CFLAGS) -c $< -o $@

$(dpi-library)/cl_dpi.so: $(dpi)
	$(CXX) -shared -m64 -o $(dpi-library)/cl_dpi.so $? -L$(RISCV)/lib -L$(SPIKE_ROOT)/lib -Wl,-rpath,$(RISCV)/lib -Wl,-rpath,$(SPIKE_ROOT)/lib -lfesvr

$(library):
	vlib${questa_version} $(library)

compile: $(library) $(dpi) $(dpi-library)/cl_dpi.so
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f scripts/compile.tcl || { echo "ERROR: scripts/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	vsim -c -do 'source scripts/compile.tcl; quit'

build: compile $(dpi)
	vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc -check_synthesis


run:
	vsim +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/cl_dpi  \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression-tests
	source env/env.sh; \
	cd regression-tests && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o runtime-parallel.xml parallel-bare-tests.yaml


.PHONY: test-rt-mchan
## Run mchan tests on pulp-runtime
test-rt-mchan: pulp-runtime regression-tests
	source env/env.sh; \
	cd regression-tests && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o runtime-mchan.xml mchan-tests.yaml
