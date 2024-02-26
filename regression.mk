## Clone regression tests for bare-metal verification
regression-tests:
	git submodule update --init --recursive $@

.PHONY: test-rt-par-bare
## Run only parallel tests on pulp-runtime
test-rt-par-bare: pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/carfield/runtime-parallel.xml $(REGRESSIONS)/parallel-bare-tests.yaml

.PHONY: test-rt-mchan
## Run mchan tests on pulp-runtime
test-rt-mchan: pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 7200 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/carfield/runtime-mchan.xml $(REGRESSIONS)/pulp_cluster-mchan-tests.yaml

.PHONY: test-rt-carfield
## Run Carfield tests on pulp-runtime
test-rt-carfield: pulp-runtime regression-tests
	cd $(REGRESSIONS) && $(bwruntest) --proc-verbose -v \
		-t 3600 --yaml --max-procs 2 \
		-o $(REGRESSIONS)/carfield/runtime-mchan.xml $(REGRESSIONS)/carfield.yaml
