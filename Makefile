GIT ?= git
BENDER ?= bender
VSIM ?= vsim
top_level ?= pulp_cluster_tb
dpi-library ?= work-dpi
library ?= work
elf-bin ?= stimuli.riscv

ifndef QUESTASIM_HOME
$(error QUESTASIM_HOME not set - set the path to the QUESTASIM home folder)
endif

ifndef RISCV
$(error RISCV not set - please point RISC-V to your RISC-V installation, containing riscv-fesvr, needed by the testbench)
endif

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

sim_clean:
	rm -rf scripts/compile.tcl
	rm -rf work

scripts/compile.tcl: Bender.yml
	$(call generate_vsim, $@, -t rtl -t test -t cluster_standalone,..)

# compile the elfloader.cpp
$(dpi-library)/%.o: tb/dpi/%.cc $(dpi_hdr)
	mkdir -p $(dpi-library)
  #echo hello
	$(CXX) -shared -fPIC -std=c++0x -Bsymbolic $(CFLAGS) -c $< -o $@

$(dpi-library)/cl_dpi.so: $(dpi)
	$(CXX) -shared -m64 -o $(dpi-library)/cl_dpi.so $? -L$(RISCV)/lib -L$(SPIKE_ROOT)/lib -Wl,-rpath,$(RISCV)/lib -Wl,-rpath,$(SPIKE_ROOT)/lib -lfesvr

$(library):
	vlib${questa_version} $(library)

compile: $(library) $(dpi)
	vsim -c -do 'source scripts/compile.tcl; quit'

build: compile $(dpi)
	vopt $(compile_flag) -suppress 3053 -suppress 8885 -work $(library)  $(top_level) -o $(top_level)_optimized +acc -check_synthesis


run:
	vsim +permissive $(questa-flags) $(questa-cmd) -suppress 3053 -suppress 8885 -lib $(library)  +MAX_CYCLES=$(max_cycles) +UVM_TESTNAME=$(test_case) +APP=$(elf-bin) +notimingchecks +nospecify  -t 1ps \
	$(uvm-flags) $(QUESTASIM_FLAGS) -sv_lib $(dpi-library)/cl_dpi  \
	${top_level}_optimized +permissive-off ++$(elf-bin) ++$(target-options) ++$(cl-bin) | tee sim.log
