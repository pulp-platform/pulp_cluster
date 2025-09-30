if {![info exists VSIM_PATH ]} {
    return -code error -errorinfo "[ERRORINFO] You must set the \"VSIM_PATH\" variable before sourcing the start script."
    set VSIM_PATH ""
}

if {![info exists APP]} {
    set APP "./build/test/test"
}

if {![info exists VSIM]} {
    set VSIM vsim
}

$VSIM +permissive -suppress 3053 -suppress 8885 -suppress 12130 -suppress 7077 -lib $VSIM_PATH/work +APP=./build/test/test +notimingchecks +nospecify -t 1ps pulp_cluster_tb_optimized +permissive-off ++./build/test/test

proc run_and_exit {} {
    run -all
    quit -code [examine -radix decimal sim:/pulp_cluster_tb/ret_val(30:0)]
}

if {[info exists ::env(FAULT_INJECTION)]} {
    if {![info exists ::env(FAULT_INJECTION_SCRIPT)]} {
        error "Error: Missing FAULT_INJECTION_SCRIPT to source!"
    }
    source $::env(FAULT_INJECTION_SCRIPT)
}

run_and_exit
