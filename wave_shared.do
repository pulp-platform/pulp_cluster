onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/clk_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/rst_ni
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/ref_clk_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/pwr_on_rst_ni
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/pmu_mem_pwdn_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/base_addr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/test_mode_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/en_sa_boot_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/cluster_id_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/fetch_en_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/eoc_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/busy_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/axi_isolate_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/axi_isolated_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dma_pe_evt_ack_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dma_pe_evt_valid_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dma_pe_irq_ack_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dma_pe_irq_valid_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/pf_evt_ack_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/pf_evt_valid_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_irq_valid_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/mbox_irq_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_cluster_events_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_cluster_events_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_cluster_events_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_aw_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_aw_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_aw_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_ar_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_ar_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_ar_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_w_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_w_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_w_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_r_wptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_r_data_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_r_rptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_b_wptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_b_data_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_slave_b_rptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_aw_wptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_aw_data_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_aw_rptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_ar_wptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_ar_data_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_ar_rptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_w_wptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_w_data_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_w_rptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_r_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_r_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_r_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_b_wptr_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_b_data_i
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/async_data_master_b_rptr_o
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/fetch_enable_reg_int
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/fetch_en_int
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/boot_addr
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_core_halt
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_core_resume
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_core_halted
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_core_havereset
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dbg_core_running
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dbg_irq
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hwpe_en
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hwpe_sel
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/fetch_en_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/en_sa_boot_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/axi_isolate_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/eoc_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_cluster_periphs_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_axi2mem_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_per2axi_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_axi2per_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dmac_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_cluster_cg_en
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_event
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_irq
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hwpe_remap_evt
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hwpe_evt
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hwpe_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_hci_ctrl
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/clk_core_en
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_cluster_int_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_fregfile_disable
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/core_busy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_incoming_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_isolate_cluster
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_events_async
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_events_valid
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_events_ready
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_events_data
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/instr_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/instr_addr
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/instr_gnt
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/instr_r_valid
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/instr_r_rdata
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_TCDM_arb_policy
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/tcdm_sleep
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/irq_id
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/irq_ack_id
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/irq_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/irq_ack
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_core_dbg_irq
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_rw_margin_L1
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_cl_event
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_cl_irq
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_fc_event
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_fc_irq
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_barrier_matched
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_dmr_sw_resynch_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_tmr_sw_resynch_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_dmr_sw_synch_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_tmr_sw_synch_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_gnt
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_operands
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_op
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_type
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_flags
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_rready
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_rvalid
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_rdata
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu_master_rflags
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_enable_l1_l15_prefetch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_icache_flush_valid
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_icache_flush_ready
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_icache_l0_events
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_icache_l1_events
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_slave_64_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_slave_64_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_slave_32_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_slave_32_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_master_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_data_master_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_core_instr_bus_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_core_instr_bus_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_core_ext_bus_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_core_ext_bus_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_ext_bus_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_dma_ext_bus_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_ext_tcdm_bus_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_ext_tcdm_bus_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_ext_mperiph_bus_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_ext_mperiph_bus_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_rst_n
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_init_n
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/mbox_irq_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_reg_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_reg_rsp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/core_data_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/demux_data_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/core_data_rsp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/demux_data_rsp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/sys2hmr
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr2core
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr2sys
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/core2hmr
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/backup_bus
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/recovery_bus
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/clk_core
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/setback
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/ext_perf
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_tmr_synch
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_tmr_sw_resynch_req_short
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/hmr_dmr_sw_resynch_req_short
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu__operands
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu__op
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu__type
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu__flags
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/s_apu__rflags
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/tcdm_scrubber_reg_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/tcdm_scrubber_reg_rsp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/bank_faults
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/ecc_single_error
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/ecc_multiple_error
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/scrubber_fix
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/scrubber_uncorrectable
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/scrubber_trigger
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/src_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/isolate_src_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/src_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/isolate_src_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/src_remap_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/src_remap_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dst_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dst_resp
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dst_remap_req
add wave -noupdate -group cluster /pulp_cluster_tb/cluster_i/dst_remap_resp
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/clk_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rst_ni
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/reg_request_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/reg_response_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_failure_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_error_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_resynch_req_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_sw_synch_req_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_cores_synch_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_error_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_resynch_req_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_sw_synch_req_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_cores_synch_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/redundancy_enable_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_backup_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_bootaddress_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_inputs_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_nominal_outputs_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_bus_outputs_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_axi_outputs_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sys_fetch_en_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/enable_bus_vote_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_bootaddress_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_setback_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_inputs_o
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_nominal_outputs_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_bus_outputs_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_axi_outputs_i
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_nominal_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_bus_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_nominal_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_bus_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_axi_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_backup_outputs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_failure
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_failure_main
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_failure_data
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_error
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_error_main
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_error_data
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_single_mismatch
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure_main
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure_axi
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure_backup
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_failure_data
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/checkpoint_reg_q
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_recovery_start
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_recovery_finished
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_recovery_start
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_recovery_finished
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_start
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_finished
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_backup_en_inp
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_backup_en_oup
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_setback
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_bus
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_backup_bus
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_backup_q
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/rapid_recovery_nominal
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_en_as_master
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_in_independent
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_in_dmr
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_in_tmr
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_core_rapid_recovery_en
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_core_rapid_recovery_en
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_setback_q
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_grp_in_independent
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_rapid_recovery_en
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_setback_q
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_grp_in_independent
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_rapid_recovery_en
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sp_store_is_zero
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/sp_store_will_be_zero
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/top_register_reqs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/top_register_resps
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/hmr_hw2reg
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/hmr_reg2hw
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_register_reqs
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_register_resps
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_config_reg2hw
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/core_config_hw2reg
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/tmr_incr_mismatches
add wave -noupdate -group hmr /pulp_cluster_tb/cluster_i/gen_hmr_unit/i_hmr_unit/dmr_incr_mismatches
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/clk_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/rst_ni
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/ref_clk_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/test_mode_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/en_sa_boot_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/fetch_en_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/core_busy_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/core_clk_en_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/fregfile_disable_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/boot_addr_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_cg_en_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/busy_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_event_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_irq_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/mbox_irq_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_cl_event_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_cl_irq_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_fc_event_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dma_fc_irq_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_ready_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_valid_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_data_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dbg_core_halted_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dbg_core_halt_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dbg_core_resume_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eoc_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/fetch_enable_reg_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/irq_id_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/irq_ack_id_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/irq_req_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/irq_ack_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dbg_req_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/dbg_req_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/barrier_matched_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hmr_sw_resynch_req_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hmr_sw_synch_req_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/TCDM_arb_policy_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hwpe_events_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hwpe_en_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hwpe_sel_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/hci_ctrl_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/enable_l1_l15_prefetch_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/flush_valid_o
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/flush_ready_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/l1_events_i
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_timer_out_lo_event
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_timer_out_hi_event
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_timer_in_lo_event
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_timer_in_hi_event
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_cluster_events
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_acc_events
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_timer_events
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_dma_events
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/s_fetch_en_cc
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_req
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_add
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_wen
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_wdata
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_be
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/eu_speriph_plug_id
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_valid
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_ready
add wave -noupdate -group cluster_peripherals /pulp_cluster_tb/cluster_i/cluster_peripherals_i/soc_periph_evt_data
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/clk_i
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/rst_ni
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/en_sa_boot_i
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fetch_en_i
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/event_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/eoc_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/cluster_cg_en_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hwpe_en_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hwpe_sel_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hci_ctrl_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fregfile_disable_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_halted_i
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_halt_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_resume_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fetch_enable_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/boot_addr_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/TCDM_arb_policy_o
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/rvalid_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/rvalid_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/id_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/id_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/rdata_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/rdata_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/ret_val_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/ret_val_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fetch_en_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fetch_en_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/dbg_halt_mask_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/dbg_halt_mask_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_halted_any_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_halted_any_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/eoc_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/event_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hwpe_en_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hwpe_sel_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hci_ctrl_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/hci_ctrl_q
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fregfile_disable_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/boot_addr_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/fetch_en_sync
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/start_fetch
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/start_boot
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/cluster_cg_en_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/TCDM_arb_policy_n
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/core_halt_rising_edge
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/boot_cs
add wave -noupdate -group cluster_control_unit /pulp_cluster_tb/cluster_i/cluster_peripherals_i/cluster_control_unit_i/boot_ns
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/clk
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/rst_n
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/test_mode
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/hwpe_en_i
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/hwpe_sel_i
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/evt_o
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/busy_o
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/busy
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/evt
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/hwpe_clk
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/hwpe_en_int
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/hwpe_sel_int
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/periph_gnt
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/periph_r_rdata
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/periph_r_valid
add wave -noupdate -group hwpe_subsystem /pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/periph_r_id
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/clk_i}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/rst_ni}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/test_mode_i}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/busy_o}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/evt_o}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/fsm_z_clk_en}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/ctrl_z_clk_en}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/enable}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/clear}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/soft_clear}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/y_buffer_depth_count}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/y_buffer_load}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/z_buffer_fill}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/z_buffer_store}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_shift}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_load}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/reg_enable}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/gate_en}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_cols_lftovr}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/y_cols_lftovr}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_rows_lftovr}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/y_rows_lftovr}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/cntrl_streamer}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/flgs_streamer}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/ecc_errors_streamer}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/cntrl_engine}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/x_buffer_ctrl}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/x_buffer_flgs}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_buffer_ctrl}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_buffer_flgs}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/z_buffer_ctrl}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/z_buffer_flgs}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/cntrl_scheduler}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/flgs_scheduler}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/reg_file}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_fifo_flgs}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/x_buffer_clk_en}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/x_buffer_clock}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/x_buffer_q}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/w_buffer_q}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/z_buffer_d}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/y_bias_q}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/ctrl_engine}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/flgs_engine}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/accumulate}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/engine_flush}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/fma_is_boxed}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/noncomp_is_boxed}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/stage1_rnd}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/stage2_rnd}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/op1}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/op2}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/op_mod}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/in_tag}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/in_aux}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/in_valid}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/in_ready}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/flush}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/status}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/extension_bit}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/class_mask}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/is_class}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/out_tag}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/out_aux}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/out_valid}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/out_ready}
add wave -noupdate -group hwpe_subsystem -group redmule {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[0]/gen_redmule/i_redmule/busy}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/clk_i}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/rst_ni}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/test_mode_i}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/evt_o}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/busy_o}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/enable}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/clear}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/streamer_ctrl}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/streamer_flags}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/streamer_ecc_errs}
add wave -noupdate -group hwpe_subsystem -group neureka {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[1]/gen_neureka/i_neureka/engine_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/clk_i}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/rst_ni}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/busy_o}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/evt_o}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/stream_in_flgs}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/stream_out_flgs}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/slot_in_flgs}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/slot_out_flgs}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/stream_in_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/stream_out_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/slot_in_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/slot_out_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/in_cast_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/out_cast_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/datapath_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/datapath_flgs}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/slot_regfile_ctrl}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/state_slot}
add wave -noupdate -group hwpe_subsystem -group softex {/pulp_cluster_tb/cluster_i/hwpe_gen/hwpe_subsystem_i/gen_hwpe[2]/gen_softex/i_softex/clear}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/clk_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/rst_ni}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/setback_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_id_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/hart_id}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_sleep}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/boot_addr}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/FILE}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/destination}
add wave -noupdate -group {Core[0]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[0]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[0]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/clk_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/rst_ni}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/setback_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_id_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/hart_id}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_sleep}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/boot_addr}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/FILE}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/destination}
add wave -noupdate -group {Core[1]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[1]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[1]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/clk_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/rst_ni}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/setback_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_id_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/hart_id}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_sleep}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/boot_addr}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/FILE}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/destination}
add wave -noupdate -group {Core[2]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[2]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[2]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/clk_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/rst_ni}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/setback_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_id_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/hart_id}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_sleep}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/boot_addr}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/FILE}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/destination}
add wave -noupdate -group {Core[3]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[3]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[3]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/clk_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/rst_ni}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/setback_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_id_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/hart_id}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_sleep}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/boot_addr}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/FILE}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/destination}
add wave -noupdate -group {Core[4]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[4]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[4]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/clk_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/rst_ni}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/setback_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_id_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/hart_id}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_sleep}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/boot_addr}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/FILE}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/destination}
add wave -noupdate -group {Core[5]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[5]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[5]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/clk_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/rst_ni}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/setback_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_id_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/hart_id}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_sleep}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/boot_addr}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/FILE}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/destination}
add wave -noupdate -group {Core[6]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[6]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[6]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/clk_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/rst_ni}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/setback_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_id_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/cluster_id_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/irq_req_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/irq_ack_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/irq_id_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/irq_ack_id_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/clock_en_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/fetch_en_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/boot_addr_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/test_mode_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_busy_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_req_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_gnt_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_addr_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_rdata_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_valid_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/debug_req_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/debug_havereset_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/debug_running_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/debug_halted_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/recovery_bus_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/regfile_backup_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/pc_backup_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/csr_backup_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/ext_perf_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_data_req_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_data_rsp_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_req_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_gnt_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_type_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_operands_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_op_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_flags_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_ready_o}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_valid_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_result_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/apu_master_flags_i}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/hart_id}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_sleep}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/boot_addr}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_irq_x}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_instr_req}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_instr_gnt}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_instr_addr}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_instr_r_rdata}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_instr_r_valid}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_mem_req}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/core_data_req_we}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/FILE}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_gnt_L2}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_gnt_ROM}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_rdata_ROM}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_valid_ROM}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_rdata_L2}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/instr_r_valid_L2}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/destination}
add wave -noupdate -group {Core[7]} -group core_region {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/reg_cache_refill}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/rst_ni}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/setback_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/test_en_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fregfile_disable_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/boot_addr_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_id_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/cluster_id_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rvalid_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_be_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_wdata_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rdata_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_unaligned_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_req_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_ready_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_gnt_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_operands_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_op_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_type_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_valid_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_result_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_master_flags_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_ack_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_id_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/irq_sec_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/sec_lvl_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_req_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_resume_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fetch_enable_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ext_perf_counters_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recover_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_program_counter_if_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_branch_addr_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_recover_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_program_counter_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_branch_addr_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mstatus_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mtvec_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mscratch_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mepc_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/backup_mcause_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mstatus_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mtvec_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mscratch_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mepc_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/recovery_mcause_i}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_hwlp_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_dec_cnt_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_valid_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_rdata_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_compressed_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_fetch_failed_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/illegal_c_insn_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_if}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/clear_instr_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_set}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_mux_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_pc_mux_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/exc_cause}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/trap_addr_mux}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_load_err}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_store_err}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tosprw_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_tospra_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/dot_spr_operand_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_w_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/update_a_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_decoding}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/useincr_addr_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_multicycle}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/jump_target_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_in_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/branch_decision}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ctrl_busy}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/if_busy}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_busy}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_busy}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pc_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_en_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operator_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_operand_c_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/bmask_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/imm_vec_ext_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_vec_mode_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_op_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_clpx_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_is_subrot_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/alu_clpx_shift_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operator_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_operand_c_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_en_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_sel_subword_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_signed_mode_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_imm_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_h_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_b_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_n_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_a_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_b_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_op_c_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_dot_signed_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex_o}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_shift_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_clpx_img_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fprec_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/frm_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/fflags_we}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_en_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_type_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_flags_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_op_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_lat_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_operands_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_waddr_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_regs_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_read_dep}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_regs_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_write_dep}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_type}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_cont}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_dep}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_apu_wb}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_fw_wb}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_wb}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr2_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_waddr_fw}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_we_fw}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_alu_wdata_fw}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ivec_fmt_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_cycle_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/skip_size_csr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/sb_legacy_mode}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mtvec}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/utvec}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_access}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_op}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_addr_int}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_rdata}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_wdata}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/current_priv_lvl}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_op}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_addr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_macl_wdata}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_address}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_address}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_stride}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_stride}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_rollback}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_rollback}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/a_skip}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/w_skip}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_a_rstn}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/macl_w_rstn}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/curr_cyc_sel}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_type_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_sign_ext_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_reg_offset_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_load_event_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_misaligned_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_rdata}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_rvalid_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/loadComputeVLIW_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/halt_if}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_ready}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_ready}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/id_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/ex_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/wb_valid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/lsu_ready_wb}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/apu_ready_wb}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_int}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/m_irq_enable}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/u_irq_enable}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_irq_sec}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mepc}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/uepc}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/depc}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_cause}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_if}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_save_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_cause}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_mret_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_uret_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_restore_dret_id}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_mode}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_cause}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_csr_save}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_single_step}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreakm}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/debug_ebreaku}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_start}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_end}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/hwlp_cnt}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_regid}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_we}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/csr_hwlp_data}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_imiss}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jump}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_jr_stall}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_ld_stall}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/perf_pipeline_stall}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_ctrl_firstfetch}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_int}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/core_busy_q}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_addr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/pmp_cfg}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_req_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_addr_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_we_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_gnt_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/data_err_ack}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_req_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_gnt_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_addr_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/instr_err_pmp}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mpc_next_cycle}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mux_sel_wcsr}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/is_interrupt}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/clk}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/clock_en}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/sleeping}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_a}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_waddr_b}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_a}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_wdata_b}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_a}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/regfile_we_b}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/mult_is_clpx_ex}
add wave -noupdate -group {Core[7]} -group core_region -group core {/pulp_cluster_tb/cluster_i/CORE[7]/core_region_i/RI5CY_CORE/RI5CY_CORE/tracer_clk}
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/clk
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/rst_n
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/test_mode_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_req_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_gnt_o
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_type_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_operands_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_op_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_flags_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_rready_i
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_rvalid_o
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_rdata_o
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/core_slave_rflags_o
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_req
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_gnt
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_operands
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_op
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_flags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_rready
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_rvalid
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_rdata
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_master_rflags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_req
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_gnt
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_ID
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_operands
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_op
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_flags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_rready
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_rvalid
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_rdata
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_rflags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_apu_slave_rID
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_req
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_gnt
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_operands
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_op
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_flags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_rready
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_rvalid
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_rdata
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_master_rflags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_req
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_gnt
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_ID
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_operands
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_op
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_flags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_rready
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_rvalid
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_rdata
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_rflags
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_slave_rID
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpu_clock_gate_enable
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/s_fpnew_clock_gate_enable
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/clk_fpu
add wave -noupdate -group shared_fpu_cluster /pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/clk_fpnew
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/clk}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/rst_n}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_req_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_gnt_o}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_ID_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_operands_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_op_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_flags_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_rready_i}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_rvalid_o}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_rdata_o}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_rflags_o}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/apu_rID_o}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/fpu_op}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/fpu_op_mod}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/fpu_vec_op}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/dst_fmt}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/src_fmt}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/int_fmt}
add wave -noupdate -group fpnew_wrapper0 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_UNIT[0]/i_fpnew_wrapper/fp_rnd_mode}
add wave -noupdate -expand -group fpnew_clk_gatting {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[0]/fpnew_clock_gating/clk_i}
add wave -noupdate -expand -group fpnew_clk_gatting {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[0]/fpnew_clock_gating/en_i}
add wave -noupdate -expand -group fpnew_clk_gatting {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[0]/fpnew_clock_gating/test_en_i}
add wave -noupdate -expand -group fpnew_clk_gatting {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[0]/fpnew_clock_gating/clk_o}
add wave -noupdate -expand -group fpnew_clk_gatting7 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[7]/fpnew_clock_gating/clk_i}
add wave -noupdate -expand -group fpnew_clk_gatting7 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[7]/fpnew_clock_gating/en_i}
add wave -noupdate -expand -group fpnew_clk_gatting7 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[7]/fpnew_clock_gating/test_en_i}
add wave -noupdate -expand -group fpnew_clk_gatting7 {/pulp_cluster_tb/cluster_i/genblk7/i_shared_fpu_cluster/FPNEW_CG[7]/fpnew_clock_gating/clk_o}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {147616245717 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {636493200 ns}
