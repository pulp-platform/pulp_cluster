if {![info exists VSIM_PATH ]} {
    return -code error -errorinfo "[ERRORINFO] You must set the \"VSIM_PATH\" variable before sourcing the start script."
    set VSIM_PATH ""
}


vsim +permissive -suppress 3053 -suppress 8885 -suppress 12130 -lib $VSIM_PATH/work +APP=./build/test/test +notimingchecks +nospecify -voptargs="-debug" -t 1ps  pulp_cluster_tb_optimized +permissive-off ++./build/test/test

add log -r /*
run -all
