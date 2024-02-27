if {![info exists VSIM_PATH ]} {
    return -code error -errorinfo "[ERRORINFO] You must set the \"VSIM_PATH\" variable before sourcing the start script."
    set VSIM_PATH ""
}

if {![info exists VSIM]} {
    set VSIM vsim
}

$VSIM +permissive -suppress 3053 -suppress 8885 -suppress 12130 -lib $VSIM_PATH/work +APP=./build/test/test +notimingchecks +nospecify  -t 1ps  pulp_cluster_tb_optimized +permissive-off ++./build/test/test

if {[info exists ::env(FAULT_INJECTION)]} {
    source [file join $::env(VSIM_PATH) scripts fault_injection_config pulp_inject_fault.tcl]
}

add log -r /*
run -all
