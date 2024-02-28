set ROOT [file normalize [file dirname [info script]]/..]
# This script was generated automatically by bender.

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/clk_rst_gen.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_id_queue.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_stream_mst.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_synch_holdable_driver.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_verif_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/signal_highlighter.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/sim_timeout.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/stream_watchdog.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_synch_driver.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/src/rand_stream_slv.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/common_verification-cc1bf617dee837ac/test/tb_clk_rst_gen.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/rtl/tc_sram.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/rtl/tc_sram_impl.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/rtl/tc_clk.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/cluster_pwr_cells.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/generic_memory.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/generic_rom.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/pad_functional.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/pulp_buffer.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/pulp_pwr_cells.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/tc_pwr.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/test/tb_tc_sram.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/pulp_clock_gating_async.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/cluster_clk_cells.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-a2219ab85e824aa9/src/deprecated/pulp_clk_cells.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/binary_to_gray.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cb_filter_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cc_onehot.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_reset_ctrlr_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cf_math_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/clk_int_div.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/delta_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/ecc_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/edge_propagator_tx.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/exp_backoff.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/fifo_v3.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/gray_to_binary.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/isochronous_4phase_handshake.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/isochronous_spill_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/lfsr.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/lfsr_16bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/lfsr_8bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/lossy_valid_to_stream.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/mv_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/onehot_to_bin.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/plru_tree.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/popcount.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/rr_arb_tree.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/rstgen_bypass.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/serial_deglitch.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/shift_reg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/shift_reg_gated.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/spill_register_flushable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_demux.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_fork.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_intf.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_join_dynamic.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_mux.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_throttle.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/sub_per_hash.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/sync.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/sync_wedge.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/unread.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/read.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/addr_decode_dync.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_2phase.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_4phase.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/clk_int_div_static.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/addr_decode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/addr_decode_napot.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/multiaddr_decode.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cb_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_fifo_2phase.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/clk_mux_glitch_free.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/ecc_decode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/ecc_encode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/edge_detect.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/lzc.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/max_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/rstgen.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/spill_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_delay.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_fifo.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_fork_dynamic.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_join.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_reset_ctrlr.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_fifo_gray.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/fall_through_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/id_queue.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_arbiter_flushable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_fifo_optimal_wrap.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_xbar.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_fifo_gray_clearable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/cdc_2phase_clearable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/mem_to_banks_detailed.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/stream_omega_net.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/mem_to_banks.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/sram.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/addr_decode_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/cb_filter_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/cdc_2phase_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/cdc_2phase_clearable_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/cdc_fifo_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/cdc_fifo_clearable_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/fifo_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/graycode_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/id_queue_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/popcount_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/rr_arb_tree_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/stream_test.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/stream_register_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/stream_to_mem_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/sub_per_hash_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/isochronous_crossing_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/stream_omega_net_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/stream_xbar_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/clk_int_div_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/clk_int_div_static_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/clk_mux_glitch_free_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/test/lossy_valid_to_stream_tb.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/clock_divider_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/clk_div.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/find_first_one.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/generic_LFSR_8bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/generic_fifo.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/prioarbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/pulp_sync.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/pulp_sync_wedge.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/rrarbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/clock_divider.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/fifo_v2.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/deprecated/fifo_v1.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/edge_propagator_ack.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/edge_propagator.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/src/edge_propagator_rx.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/defs_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/iteration_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/control_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/norm_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/preprocess_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/nrbd_nrsc_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/div_sqrt_top_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-63417eb299582dbb/hdl/div_sqrt_mvp_wrapper.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_pkg.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_intf.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_err_slv.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_regs.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_cdc.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_demux.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/src/apb_test.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/test/tb_apb_regs.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/test/tb_apb_cdc.sv" \
    "$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/test/tb_apb_demux.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_intf.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_atop_filter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_burst_splitter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_bus_compare.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_cdc_dst.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_cdc_src.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_cut.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_delayer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_demux_simple.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_dw_downsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_dw_upsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_fifo.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_id_remap.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_id_prepend.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_isolate.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_join.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_demux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_dw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_from_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_join.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_lfsr.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_mailbox.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_mux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_regs.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_to_apb.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_to_axi.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_modify_address.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_mux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_rw_join.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_rw_split.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_serializer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_slave_compare.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_throttle.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_detailed_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_cdc.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_demux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_err_slv.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_dw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_from_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_id_serialize.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lfsr.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_multicut.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_axi_lite.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_iw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_lite_xbar.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_xbar.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_mem_banked.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_mem_interleaved.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_to_mem_split.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_xp.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_chan_compare.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_dumper.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_sim_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/src/axi_test.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_dw_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_xbar_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_addr_test.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_atop_filter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_bus_compare.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_cdc.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_delayer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_dw_downsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_dw_upsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_fifo.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_isolate.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_dw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_mailbox.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_regs.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_iw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_to_apb.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_to_axi.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_lite_xbar.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_modify_address.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_serializer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_sim_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_slave_compare.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_to_axi_lite.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_to_mem_banked.sv" \
    "$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/test/tb_axi_xbar.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/addr_dec_resp_mux.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/amo_shim.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/variable_latency_interconnect/addr_decoder.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/xbar.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/variable_latency_interconnect/simplex_xbar.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/clos_net.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/bfly_net.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/variable_latency_interconnect/full_duplex_xbar.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/tcdm_interconnect/tcdm_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/variable_latency_interconnect/variable_latency_bfly_net.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/variable_latency_interconnect/variable_latency_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/FanInPrimitive_Req.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/ArbitrationTree.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/MUX2_REQ.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/AddressDecoder_Resp.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/TestAndSet.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/RequestBlock2CH.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/RequestBlock1CH.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/FanInPrimitive_Resp.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/ResponseTree.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/ResponseBlock.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/AddressDecoder_Req.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/XBAR_TCDM.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/TCDM_PIPE_REQ.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/TCDM_PIPE_RESP.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/grant_mask.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco/priority_Flag_Req.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/AddressDecoder_PE_Req.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/ArbitrationTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/RR_Flag_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/MUX2_REQ_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/RequestBlock1CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/RequestBlock2CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/ResponseBlock_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/ResponseTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco/XBAR_PE.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_pkg.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_cast_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_classifier.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/clk/rtl/gated_clk_cell.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_ctrl.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_ff1.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_pack_single.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_prepare.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_round_single.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_special.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_srt_single.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_top.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_dp.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_frbus.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_src_type.v" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_divsqrt_th_32.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_divsqrt_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_fma.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_fma_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_sdotp_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_sdotp_multi_wrapper.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_noncomp.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_opgroup_block.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_opgroup_fmt_slice.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_opgroup_multifmt_slice.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_rounding.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/lfsr_sr.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-9db08a877f46b059/src/fpnew_top.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/hwpe_stream_interfaces.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/hwpe_stream_package.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_assign.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_buffer.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_demux_static.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_deserialize.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_fence.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_merge.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_mux_static.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_serialize.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/basic/hwpe_stream_split.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_scm.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_addressgen.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_addressgen_v2.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_addressgen_v3.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_sink_realign.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_source_realign.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_strbgen.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_streamer_queue.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_assign.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_mux.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_mux_static.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_reorder.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_reorder_static.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_earlystall.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_earlystall_sidech.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_scm_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_sidech.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_fifo_load_sidech.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/fifo/hwpe_stream_fifo_passthrough.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_source.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_fifo.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_fifo_load.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/tcdm/hwpe_stream_tcdm_fifo_store.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/streamer/hwpe_stream_sink.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/verif/hwpe_stream_traffic_gen.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/verif/hwpe_stream_traffic_recv.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-stream-bc1f2d87c271f75a/rtl/verif/tb_fifo.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/l2_tcdm_demux.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/lint_2_apb.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/lint_2_axi.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/axi_2_lint/axi64_2_lint32.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/axi_2_lint/axi_read_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/axi_2_lint/axi_write_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/axi_2_lint/lint64_to_32.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/AddressDecoder_Req_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/AddressDecoder_Resp_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/ArbitrationTree_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/FanInPrimitive_Req_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/FanInPrimitive_Resp_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/MUX2_REQ_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/RequestBlock_L2_1CH.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/RequestBlock_L2_2CH.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/ResponseBlock_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/ResponseTree_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/RR_Flag_Req_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_L2/XBAR_L2.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/AddressDecoder_Req_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/AddressDecoder_Resp_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/ArbitrationTree_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/FanInPrimitive_Req_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/FanInPrimitive_Resp_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/MUX2_REQ_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/RequestBlock1CH_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/RequestBlock2CH_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/ResponseBlock_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/ResponseTree_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/RR_Flag_Req_BRIDGE.sv" \
    "$ROOT/.bender/git/checkouts/l2_tcdm_hybrid_interco-1269e18c44c5aa21/RTL/XBAR_BRIDGE/XBAR_BRIDGE.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_single_slice.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_ar_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_aw_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_b_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_r_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_slice.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_w_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-097f179baf7559d9/src/axi_slice_wrap.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/bhv" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/include" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/include/cv32e40p_apu_core_pkg.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/include/cv32e40p_pkg.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_pulp_clock_gate.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_alu.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_alu_div.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_aligner.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_compressed_decoder.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_controller.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_shadow_controller.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_cs_registers.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_decoder.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_int_controller.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_ex_stage.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_fifo.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_hwloop_regs.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_id_stage.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_if_stage.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_load_store_unit.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_mult.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_prefetch_buffer.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_prefetch_controller.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_obi_interface.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_core.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_apu_disp.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_popcnt.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_ff_one.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_sleep_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/bhv" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/include" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/cv32e40p_register_file_ff.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+CV32E40P_TRACE_EXECUTION \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/bhv" \
    "+incdir+$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/rtl/include" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/bhv/include/cv32e40p_tracer_pkg.sv" \
    "$ROOT/.bender/git/checkouts/cv32e40p-35b87d405a0b7598/bhv/cv32e40p_wrapper.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/common/hci_package.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/common/hci_interfaces.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_assign.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_cmd_queue.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_fifo.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_memmap_demux_interl.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_memmap_filter.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_mux_dynamic.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_mux_static.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_mux_ooo.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_r_valid_filter.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_r_user_filter.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_source.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_split.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_log_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_log_interconnect_l2.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_new_log_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_shallow_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/mem/hci_mem_assign.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_hwpe_reorder.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/core/hci_core_sink.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/interco/hci_hwpe_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/hci-f956ddaaacdaf461/rtl/hci_interconnect.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_interfaces.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_package.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_regfile_ff.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_regfile_latch.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_seq_mult.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_uloop.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_regfile_latch_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_regfile.sv" \
    "$ROOT/.bender/git/checkouts/hwpe-ctrl-f0ffa31ac61ad2d6/rtl/hwpe_ctrl_slave.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/Req_Arb_Node_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/Resp_Arb_Node_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/lint_mux.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/DistributedArbitrationNetwork_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/DistributedArbitrationNetwork_Resp_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/RoutingBlock_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/RoutingBlock_2ch_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/RoutingBlock_Resp_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-02d7b8b93cfd008b/icache_intc.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_intf.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/vendor/lowrisc_opentitan/src/prim_subreg_arb.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/vendor/lowrisc_opentitan/src/prim_subreg_ext.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/apb_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/axi_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/periph_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_cdc.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_demux.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_err_slv.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_filter_empty_writes.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_mux.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_to_apb.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_uniform.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_to_tlul.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/vendor/lowrisc_opentitan/src/prim_subreg_shadow.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/vendor/lowrisc_opentitan/src/prim_subreg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/axi_lite_to_reg.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/apb-a9fe5d9ed5687f05/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/src/reg_test.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1r_1w_all.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1r_1w_be.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1r_1w.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1r_1w_1row.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1r_1w_raw.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1w_multi_port_read.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1w_64b_multi_port_read_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_1w_64b_1r_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_2r_1w_asymm.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_2r_1w_asymm_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_2r_2w.sv" \
    "$ROOT/.bender/git/checkouts/scm-b5c3b6e26a3cbb29/fpga_scm/register_file_3r_2w.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_busy_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_rd_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_tcdm_rd_if.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_tcdm_synch.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_tcdm_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_tcdm_wr_if.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_trans_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2mem-72695b5154370c02/axi2mem_wr_channel.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/axi2per-70eb6ef4b0b0efca/axi2per_req_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2per-70eb6ef4b0b0efca/axi2per_res_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2per-70eb6ef4b0b0efca/axi2per.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/cluster_control_unit/cluster_control_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/include" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/HW_barrier_logic.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/event_unit_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/event_unit_mux.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/event_unit_sm.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/interrupt_mask.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/HW_barrier.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/event_unit_input.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/event_unit/event_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/mp_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/mp_pf_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/new_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/pri_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/icache_ctrl_unit/sp_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/mmu_config_unit/mmu_config_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/perf_counters_unit/perf_counters_unit.sv" \
    "$ROOT/.bender/git/checkouts/cluster_peripherals-45e4f8f679514447/tcdm_pipe_unit/tcdm_pipe_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/event_unit_core.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/hw_barrier_unit.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/hw_dispatch.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/hw_mutex_unit.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/interc_sw_evt_trig.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/periph_FIFO_id.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/soc_periph_fifo.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/event_unit_interface_mux.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-915b40dfa1db7f9f/rtl/event_unit_top.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/CTRL_UNIT/hier_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/ram_ws_rs_data_scm.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/ram_ws_rs_tag_scm.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/RefillTracker_4.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/REP_buffer_4.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1_CACHE/pri_icache_controller.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1_CACHE/refill_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/CTRL_UNIT/hier_icache_ctrl_unit_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/AXI4_REFILL_Resp_Deserializer.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/share_icache_controller.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1_CACHE/register_file_1w_multi_port_read_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1.5_CACHE/share_icache.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/L1_CACHE/pri_icache.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-71ffd6f896cfd54b/RTL/TOP/icache_hier_top.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_register_file_latch.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_register_file_ff.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_register_file_fpga.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+RVFI=true \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl" \
    "+incdir+$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/vendor/lowrisc_ip/ip/prim/rtl" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_pkg.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_register_file_ff.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/vendor/lowrisc_ip/ip/prim/rtl/prim_assert.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_alu.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_compressed_decoder.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_controller.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_counter.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_csr.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_decoder.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_fetch_fifo.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_load_store_unit.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_multdiv_fast.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_multdiv_slow.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_pmp.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_tracer_pkg.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_wb_stage.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_cs_registers.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_ex_block.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_id_stage.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_prefetch_buffer.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_tracer.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_if_stage.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_core.sv" \
    "$ROOT/.bender/git/checkouts/ibex-ea88d7e2212bdc23/rtl/ibex_core_tracing.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/idma_transfer_id_gen.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_pkg.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_stream_fifo.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_buffer.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_error_handler.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_channel_coupler.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_axi_transport_layer.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_axi_lite_transport_layer.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_obi_transport_layer.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_legalizer.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/idma_backend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/legacy/axi_dma_backend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/legacy/midends/idma_2D_midend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/midends/idma_nd_midend.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_32bit_2d/idma_reg32_2d_frontend_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_32bit_2d/idma_reg32_2d_frontend_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_32bit_2d/idma_reg32_2d_frontend.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_64bit/idma_reg64_frontend_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_64bit/idma_reg64_frontend_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/register_64bit/idma_reg64_frontend.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/desc64/idma_desc64_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/desc64/idma_desc64_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/desc64/idma_desc64_shared_counter.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/desc64/idma_desc64_reg_wrapper.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/frontends/desc64/idma_desc64_top.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_SIMULATION \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/idma_intf.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/idma_tb_per2axi.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/idma_obi_asserter.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/idma_test.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/idma_obi2axi_bridge.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/tb_idma_backend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/tb_idma_lite_backend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/tb_idma_obi_backend.sv" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/tb_idma_nd_backend.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/test/frontends/tb_idma_desc64_top.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/include" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/misc/mchan_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/misc/mchan_arb_primitive.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/misc/mchan_rr_flag_req.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/ctrl_fsm.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/ctrl_if.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/synch_unit.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/trans_allocator.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/trans_queue.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/trans_arbiter_wrap.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/trans_unpack.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/twd_trans_queue.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ctrl_unit/twd_trans_splitter.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_ar_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_aw_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_b_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_opc_buf.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_r_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_rx_if.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_tid_gen.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_tx_if.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_unit.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/ext_unit/ext_w_buffer.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/tcdm_unit/tcdm_cmd_unpack.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/tcdm_unit/tcdm_rx_if.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/tcdm_unit/tcdm_synch.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/tcdm_unit/tcdm_tx_if.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/tcdm_unit/tcdm_unit.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/trans_unit/trans_aligner.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/trans_unit/trans_buffers.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/trans_unit/trans_unit.sv" \
    "$ROOT/.bender/git/checkouts/mchan-9c1d6ff87a51f443/rtl/top/mchan.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/per2axi-60b4d6ef3b53fc48/src/per2axi_busy_unit.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-60b4d6ef3b53fc48/src/per2axi_req_channel.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-60b4d6ef3b53fc48/src/per2axi_res_channel.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-60b4d6ef3b53fc48/src/per2axi.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_scheduler.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_castin.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_castout.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_streamer.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_x_buffer.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_w_buffer.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_z_buffer.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_fma.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_noncomp.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_ce.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_row.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_engine.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_top.sv" \
    "$ROOT/.bender/git/checkouts/redmule-8ba8e6c90026f85e/rtl/redmule_wrap.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ODRG_unit/odrg_manager_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_wrap/ecc_manager_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/pulpissimo_tcls/tcls_manager_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ODRG_unit/triple_core_barrier.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/hsiao_ecc/hsiao_ecc_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/hsiao_ecc/hsiao_ecc_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/hsiao_ecc/hsiao_ecc_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/hsiao_ecc/hsiao_ecc_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/TMR_voter.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/TMR_word_voter.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/resp_suppress.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ODRG_unit/odrg_manager_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_wrap/ecc_manager_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/pulpissimo_tcls/tcls_manager_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_wrap/ecc_scrubber.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_concat_32_64.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_13_8_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_22_16_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_39_32_enc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_cor.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_dec.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/lowrisc_ecc/prim_secded_72_64_enc.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/TMR_voter_detect.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/bitwise_TMR_voter.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_wrap/ecc_manager.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ecc_wrap/ecc_sram_wrap.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ODRG_unit" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/ODRG_unit/ODRG_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/pulpissimo_tcls" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/pulpissimo_tcls/TCLS_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_ecc_scrubber.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_ecc_secded.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_ecc_sram.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_tmr_voter.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_tmr_voter_detect.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_tmr_word_voter.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/test/tb_bitwise_tmr_voter.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/rapid_recovery_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/recovery_csr.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/recovery_pc.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/recovery_rf.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/rapid_recovery_unit.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/DMR_checker.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/DMR_CSR_checker.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/DMR_address_generator.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_rapid_recovery_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_registers_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_core_regs_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_dmr_regs_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_tmr_regs_reg_pkg.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_registers_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_core_regs_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_dmr_regs_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_dmr_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_tmr_regs_reg_top.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_tmr_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/HMR_wrap.sv" \
    "$ROOT/.bender/git/checkouts/redundancy_cells-5efefdcf7db23b80/rtl/HMR/hmr_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include/apu_core_package.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include/riscv_defines.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include/riscv_tracer_defines.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/macload_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/mixed_precision_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_alu.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_alu_basic.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_alu_div.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_compressed_decoder.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_cs_registers.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_decoder.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_int_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_ex_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_hwloop_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_hwloop_regs.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/register_file_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_id_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_if_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_load_store_unit.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_mult.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_prefetch_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_prefetch_L0_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_core.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_apu_disp.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_fetch_fifo.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_L0_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_pmp.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_register_file.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-fa10b6376f1fd1ee/rtl/riscv_tracer.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "$ROOT/.bender/git/checkouts/timer_unit-beb608985450c057/rtl/timer_unit_counter.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-beb608985450c057/rtl/timer_unit_counter_presc.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-beb608985450c057/rtl/apb_timer_unit.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-beb608985450c057/rtl/timer_unit.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "+incdir+$ROOT/include" \
    "$ROOT/packages/pulp_cluster_package.sv" \
    "$ROOT/rtl/axi2mem_wrap.sv" \
    "$ROOT/rtl/axi2per_wrap.sv" \
    "$ROOT/rtl/cluster_bus_wrap.sv" \
    "$ROOT/rtl/cluster_clock_gate.sv" \
    "$ROOT/rtl/cluster_event_map.sv" \
    "$ROOT/rtl/cluster_timer_wrap.sv" \
    "$ROOT/rtl/obi_pulp_adapter.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "+incdir+$ROOT/include" \
    "$ROOT/rtl/mchan_wrap.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "+incdir+$ROOT/include" \
    "$ROOT/rtl/hwpe_subsystem.sv" \
    "$ROOT/rtl/instr_width_converter.sv" \
    "$ROOT/rtl/per2axi_wrap.sv" \
    "$ROOT/rtl/periph_demux.sv" \
    "$ROOT/rtl/per_demux_wrap.sv" \
    "$ROOT/rtl/periph_FIFO.sv" \
    "$ROOT/rtl/tcdm_banks_wrap.sv" \
    "$ROOT/rtl/xbar_pe_wrap.sv" \
    "$ROOT/rtl/cluster_interconnect_wrap.sv" \
    "$ROOT/rtl/cluster_peripherals.sv" \
    "$ROOT/rtl/data_periph_demux.sv" \
    "$ROOT/rtl/core_demux_wrap.sv" \
    "$ROOT/rtl/core_region.sv" \
    "$ROOT/rtl/pulp_cluster.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "+incdir+$ROOT/include" \
    "$ROOT/tb/mock_uart.sv" \
    "$ROOT/tb/axi2apb_64_32.sv" \
    "$ROOT/tb/mock_uart_axi.sv" \
    "$ROOT/tb/pulp_cluster_tb.sv" \
}]} {return 1}

if {[catch { vlog -incr -sv \
    -suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale "1 ns / 1 ps" "+incdir+/scratch2/rtedeschi/astral/scrubber/include" \
    +define+TARGET_CLUSTER_STANDALONE \
    +define+TARGET_CV32E40P_USE_FF_REGFILE \
    +define+TARGET_MCHAN \
    +define+TARGET_RTL \
    +define+TARGET_SCM_USE_FPGA_SCM \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VSIM \
    +define+FEATURE_ICACHE_STAT \
    +define+PRIVATE_ICACHE \
    +define+HIERARCHY_ICACHE_32BIT \
    +define+ICAHE_USE_FF \
    +define+NO_FPU \
    +define+TRACE_EXECUTION \
    +define+CLUSTER_ALIAS \
    +define+USE_PULP_PARAMETERS \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f34f593106290a7f/include" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/cluster_interconnect-9a146c2c6998a1b5/rtl/peripheral_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-5a98055a67ec8079/include" \
    "+incdir+$ROOT/.bender/git/checkouts/idma-56b9ad1d44bf0812/src/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-96e1aa763449594f/include" \
    "+incdir+$ROOT/include" \
    "$ROOT/include/pulp_interfaces.sv" \
}]} {return 1}


vlog "/scratch2/rtedeschi/astral/scrubber/tb/dpi/elfloader.cpp" -ccflags "-std=c++11"
