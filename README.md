# PULP Cluster

![pulp_cluster schematic](doc/PULP_CLUSTER.png)

The `pulp_cluster` repository contains the structure of the cluster subsystem
used in PULP chips. For more details on the internal architecture, see the
README.md in the [`pulp` repository](https://github.com/pulp-platform/pulp).

The [`doc`](doc/) folder contains the draw.io schematic shown above, as well as
the raw source to allow for updates, outlining the most important components in
pulp_cluster, as well as the communication interfaces connecting these. While
not a complete overview of all signals, this is meant as a slightly more
detailed overview that can assist in development. Please be aware that the
schematic may not be 100% accurate.

## Simulation

It is possible to run benchmarks on the cluster, either within
[PULP](https://github.com/pulp-platform/pulp) or as a separate IP. For
simulation within PULP, you can directly go to the PULP repo and follow the
README.

To simulate the cluster on its own, you can perform the following steps:

1. Make sure the PULP RV32 toolchain is in your `PATH`. Please refer to [PULP
   RISCV GCC toolchain](https://github.com/pulp-platform/pulp-riscv-gcc) to use
   a pre-built release.

2. We need RV64 toolchain to compile DPI libraries. Export it to a `RISCV` env
   variable. Please refer to [RISC-V GNU
   toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain/) to use a
   pre-built release.

3. Compile the hw:
   ```
   make checkout
   make scripts/compile.tcl
   make build
   ```

4. Source the environment:
   ```
   source env/env.sh
   ```

5. Download the sw stack and bare-metal tests:
	```
	make pulp-runtime
	make regression-tests
	```

6. Run the tests. Choose any test among the `parallel_bare_tests` and the
   `mchan_tests`, move into the related folder and do:

   ```
   make clean all run
   ```

   To use the GUI, add `gui=1` to the previous command.
