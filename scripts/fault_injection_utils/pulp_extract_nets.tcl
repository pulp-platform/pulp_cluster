# Copyright 2023 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
#
# Author: Michael Rogenmoser (michaero@iis.ee.ethz.ch)
#         Riccardo Tedeschi  (riccardo.tedeschi6@unibo.it)

# Description: This file is used to extract specific groups of nets from the
#              PULP Cluster, so they can be used in the fault injection script

# Source generic netlist extraction procs
source [file join $script_base_path extract_nets.tcl]

# == Base Path of a Cluster Core ==
proc base_path {core} {return "pulp_cluster_tb/cluster_i/CORE\[$core\]/core_region_i"}

# nets that would crash the simulation if flipped
lappend core_netlist_ignore *clk_i
lappend core_netlist_ignore *Clk_CI
lappend core_netlist_ignore *clk
lappend core_netlist_ignore *clk_ungated_i
lappend core_netlist_ignore *rst_ni
lappend core_netlist_ignore *rst_i
lappend core_netlist_ignore *rst_n
lappend core_netlist_ignore *rst
lappend core_netlist_ignore *Rst_RBI
lappend core_netlist_ignore *scan_cg_en_i
lappend core_netlist_ignore *testmode_i
lappend core_netlist_ignore *i_fpnew_bulk*

# registers/memories:
# lappend core_netlist_ignore *_q
# lappend core_netlist_ignore *obi_pulp_adapter/ps TODOs

# debug
lappend core_netlist_ignore *tracer_i*

######################
#  Core Output Nets  #
######################

proc get_core_output_nets {core} {
  set core_output_netlist [get_output_netlist [base_path $core]]
  lappend core_output_netlist [base_path $core]/RI5CY_CORE/RI5CY_CORE/data_we_o
  lappend core_output_netlist [base_path $core]/RI5CY_CORE/RI5CY_CORE/data_be_o
  lappend core_output_netlist [base_path $core]/RI5CY_CORE/RI5CY_CORE/data_addr_o
  lappend core_output_netlist [base_path $core]/RI5CY_CORE/RI5CY_CORE/data_wdata_o
  return [concat $core_output_netlist]
}

####################
#  State Netlists  #
####################
proc get_core_state_nets {core} {
  set state_list {\
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/fifo_i/write_pointer_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/register_file_i/wdata_b_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/register_file_i/wdata_a_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/register_file_i/waddr_onehot_b_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/gen_apu/apu_disp_i/valid_waiting \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/gen_apu/apu_disp_i/valid_inflight \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/utvec_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/utvec_mode_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/uepc_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/ucause_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/trans_addr_q \
    [base_path $core]/RI5CY_CORE/riscv_tracer_i/trace_wb_is_null \
    [base_path $core]/RI5CY_CORE/riscv_tracer_i/trace_wb_delay_is_null \
    [base_path $core]/RI5CY_CORE/riscv_tracer_i/trace_ex_is_null \
    [base_path $core]/RI5CY_CORE/riscv_tracer_i/trace_ex_delay_is_null \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/gen_trigger_regs/tmatch_value_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/gen_trigger_regs/tmatch_control_exec_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/fifo_i/status_cnt_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/State_SP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/data_obi_i/state_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/state_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/state_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/state \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/ResReg_DP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/ResInv_SP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/RemSel_SP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/regfile_we_lsu \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/regfile_we_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/regfile_waddr_lsu \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/regfile_waddr_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/regfile_alu_we_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/regfile_alu_waddr_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/fifo_i/read_pointer_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/rdata_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/rdata_offset_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/r_instr_h \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/priv_lvl_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/prepost_useincr_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/pc_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/pc_id_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/pc_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/sleep_unit_i/p_elw_busy_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/gen_no_trans_stable/obi_we_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/gen_no_trans_stable/obi_wdata_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/gen_no_trans_stable/obi_be_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/gen_no_trans_stable/obi_atop_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/instruction_obi_i/gen_no_trans_stable/obi_addr_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_signed_mode_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_sel_subword_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_operator_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_operand_c_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_operand_b_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_operand_a_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_is_clpx_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_imm_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_en_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_dot_signed_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_dot_op_c_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_dot_op_b_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_dot_op_a_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_clpx_shift_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mult_clpx_img_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/mult_i/mulh_CS \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/mult_i/mulh_carry_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mtvec_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mtvec_mode_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mstatus_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mscratch_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mie_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_store_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_pipe_stall_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_minstret_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_load_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_ld_stall_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_jump_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_jr_stall_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_imiss_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_compressed_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_branch_taken_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/mhpmevent_branch_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mhpmcounter_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mepc_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/fifo_i/mem_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mcountinhibit_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mcounteren_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/mcause_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/jump_done_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/is_fetch_failed_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/is_compressed_id_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/int_controller_i/irq_sec_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/int_controller_i/irq_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/instr_valid_id_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/instr_rdata_id_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/imm_vec_ext_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/illegal_insn_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/illegal_c_insn_id_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/id_valid_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/hwlp_update_pc_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/gen_hwloop_regs/hwloop_regs_i/hwlp_start_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/hwlp_flush_cnt_delayed_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/hwlp_flush_after_resp \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/gen_hwloop_regs/hwloop_regs_i/hwlp_end_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/hwlp_end_4_id_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/gen_hwloop_regs/hwloop_regs_i/hwlp_counter_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/hwlp_addr_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/frm_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/flush_cnt_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/fflags_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/sleep_unit_i/fetch_enable_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/dscratch1_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/dscratch0_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/depc_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/debug_req_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/debug_req_entry_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/debug_mode_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/debug_fsm_cs \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/debug_force_wakeup_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/cs_registers_i/dcsr_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/data_we_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_we_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/data_type_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_type_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/data_sign_ext_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_sign_ext_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_req_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_reg_offset_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_misaligned_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/data_load_event_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/data_load_event_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/data_err_q \
    [base_path $core]/RI5CY_CORE/riscv_tracer_i/cycles \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/controller_i/ctrl_fsm_cs \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/csr_op_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/csr_access_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/sleep_unit_i/core_busy_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/CompInv_SP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/prefetch_buffer_i/prefetch_controller_i/cnt_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/load_store_unit_i/cnt_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/Cnt_DP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/BReg_DP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/branch_in_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/bmask_b_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/bmask_a_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/atop_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/alu_i/alu_div_i/AReg_DP \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_waddr_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_operands_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_op_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_lat_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_lat \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/gen_apu/apu_disp_i/apu_lat \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_flags_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/apu_en_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_vec_mode_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_operator_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_operand_c_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_operand_b_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_operand_a_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_is_subrot_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_is_clpx_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_en_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/id_stage_i/alu_clpx_shift_ex_o \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/if_stage_i/aligner_i/aligner_ready_q \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/gen_apu/apu_disp_i/addr_waiting \
    [base_path $core]/RI5CY_CORE/RI5CY_CORE/ex_stage_i/gen_apu/apu_disp_i/addr_inflight \
  }

  return [extract_netlists [subst $state_list] 1]
}

##############################
#  Get all nets from a core  #
##############################

proc get_all_core_nets {core} {
  set core_path [base_path $core]
  # set core_netlist_ignore_full [concat $::core_netlist_ignore [get_core_state_nets $core]]
  set all_signals [extract_all_nets_recursive_filtered $core_path $::core_netlist_ignore]
  # set state_signals [get_core_state_nets $core]
  # set netlist_filtered {}
  # foreach signal $all_signals {
  #   set sig_unpacked [lindex $signal 0]
  #   # echo $sig_unpacked
  #   foreach state_sig $state_signals {
  #     if {[string first $state_sig $sig_unpacked] == -1} {
  #       lappend netlist_filtered $sig_unpacked
  #     }
  #   }
  # }
  return $all_signals
}

##########################
#  Get all icache state  #
##########################

proc get_all_icache_state {} {
  set icache_base /pulp_cluster_tb/cluster_i/icache_top_i/i_snitch_icache

  set l1_data_base $icache_base/gen_serial_lookup/i_lookup/i_data/i_tc_sram
  set l1_tag_base $icache_base/gen_serial_lookup/i_lookup/gen_scm

  set l1_data [list]
  for {set i 0} {$i < [examine -radix dec $l1_data_base/NumWords]} {incr i} {
    lappend l1_data $l1_data_base/sram\[$i\]
  }
  set l1_tag [list]
  for {set i 0} {$i < [examine -radix dec $icache_base/SET_COUNT]} {incr i} {
    for {set j 0} {$j < [examine -radix dec $l1_tag_base/g_sets\[$i\]/i_tag/N_SCM_REGISTERS]} {incr j} {
      lappend l1_tag $l1_tag_base/g_sets\[$i\]/i_tag/block_ram_gen/MemContent_int\[$j\]
    }
  }

  set l0_data [list]
  set l0_tag  [list]
  for {set i 0} {$i < [examine -radix dec $icache_base/NR_FETCH_PORTS]} {incr i} {
    for {set j 0} {$j < [examine -radix dec $icache_base/L0_LINE_COUNT]} {incr j} {
      lappend l0_data $icache_base/gen_prefetcher\[$i\]/i_snitch_icache_l0/data\[$j\]
    }
    # Questa force does not work properly on arrays of structs, always forcing the first element instead of the one specified.
    # Therefore, we limit our injections as well.
    lappend l0_tag  $icache_base/gen_prefetcher\[$i\]/i_snitch_icache_l0/tag\[0\].tag
    lappend l0_tag  $icache_base/gen_prefetcher\[$i\]/i_snitch_icache_l0/tag\[0\].vld
  }

  return [concat $l1_data $l1_tag $l0_data $l0_tag]
}

##################
# Memory signals #
##################

# <------ banks ------>
#   b1   b2   b3   b4
# +----+----+----+----+   ^
# |    |    |    |    | 3 |
# +----+----+----+----+   |
# |    |    |    |    | 2 |
# +----+----+----+----+   | words
# |    |    |    |    | 1 |
# +----+----+----+----+   |
# |    |    |    |    | 0 |
# +----+----+----+----+   v

# == Path to a word in sram signal in tc_sram ==
proc get_memory_word {bank word} {return "/pulp_cluster_tb/cluster_i/tcdm_banks_i/banks_gen\[$bank\]/gen_ecc_banks/gen_ecc_banks_and_connection/i_ecc_bank/i_bank/sram($word)"}

proc get_memory_slice {bank_range word_range} {
  set mem_slice [list]
  for {set i [lindex $bank_range 0]} {$i < [lindex $bank_range end]} {incr i} {
    for {set j [lindex $word_range 0]} {$j < [lindex $word_range end]} {incr j} {
    lappend mem_slice [get_memory_word $i $j]}
  }
  return $mem_slice
}
