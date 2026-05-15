if {![info exists VSIM_PATH ]} {
    return -code error -errorinfo "[ERRORINFO] You must set the \"VSIM_PATH\" variable before sourcing the start script."
    set VSIM_PATH ""
}

if {![info exists APP]} {
    set APP "./build/test/test"
}

if {[info exists USE_QONE] && $USE_QONE == 1} {
    qsim -qwavedb=+signal+memory +permissive -suppress 3053 -suppress 8885 -suppress 12130 -lib $VSIM_PATH/work +APP=./build/test/test +notimingchecks +nospecify  -t 1ps  pulp_cluster_tb_optimized +permissive-off ++./build/test/test
} else {
    vsim +permissive -suppress 3053 -suppress 8885 -suppress 12130 -suppress 7077 -lib $VSIM_PATH/work +APP=./build/test/test +notimingchecks +nospecify -t 1ps pulp_cluster_tb_optimized +permissive-off ++./build/test/test
}

if {[info exists ::env(FAULT_INJECTION)]} {
    if {![info exists ::env(FAULT_INJECTION_SCRIPT)]} {
        error "Error: Missing FAULT_INJECTION_SCRIPT to source!"
    }
    source $::env(FAULT_INJECTION_SCRIPT)
}

proc run_and_exit {} {
    global RUN_SAIF

    if {[info exists RUN_SAIF] && $RUN_SAIF == 1} {
        when -label {cluster_start} {pulp_cluster_tb.cluster_i.fetch_en_i == 1'b1} {
        set scope {pulp_cluster_tb.cluster_i}
        power reset -all
        power add -r $scope/*
        echo "\[POWER\] POWER ON: $now"
        power on
        }

        when -label {cluster_stop} {pulp_cluster_tb.cluster_i.eoc_o == 1'b1} {
            echo "\[POWER\] POWER OFF: $now"
            power off
            power report -all -bsaif cluster_i.saif
        }
    }

    run -all

    quit -code [examine -radix decimal sim:/pulp_cluster_tb/ret_val(30:0)]
}

run_and_exit
