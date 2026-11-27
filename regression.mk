## Clone regression tests for bare-metal verification
TARGET ?= pulp_cluster

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression_tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/$(TARGET)/runtime-parallel.xml $(REGRESSIONS)/parallel-bare-tests.yaml
