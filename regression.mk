## Clone regression tests for bare-metal verification
TARGET ?= astral

regression-tests:
	git submodule update --init --recursive $@

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/$(TARGET)/runtime-parallel.xml $(REGRESSIONS)/parallel-bare-tests.yaml

.PHONY: test-rt-mchan
## Run mchan tests on pulp-runtime
test-rt-mchan: pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 7200 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/$(TARGET)/runtime-mchan.xml $(REGRESSIONS)/pulp_cluster-mchan-tests.yaml

.PHONY: test-rt-$(TARGET)
## Run Carfield tests on pulp-runtime
test-rt-$(TARGET): pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/$(TARGET)/runtime-mchan.xml $(REGRESSIONS)/$(TARGET).yaml
