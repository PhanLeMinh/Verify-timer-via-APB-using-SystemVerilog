package test_pkg;

  import timer_pkg::*;

  `include "base_test.sv"
  `include "reg_def_test.sv"
  `include "reg_wr_test.sv"
  `include "reg_rs_test.sv"
  `include "reg_reserved_test.sv"
  `include "reg_tsr_test.sv"

  `include "cnt_up_div1_test.sv"
  `include "cnt_up_div2_test.sv"
  `include "cnt_up_div4_test.sv"
  `include "cnt_up_div8_test.sv"
  `include "cnt_up_rd_div1_test.sv"
  `include "cnt_up_rd_div2_test.sv"
  `include "cnt_up_rd_div4_test.sv"
  `include "cnt_up_rd_div8_test.sv"
  `include "cnt_up_change_test.sv"
  `include "cnt_up_rd_change_div_test.sv"

  `include "cnt_down_div1_test.sv"
  `include "cnt_down_div2_test.sv"
  `include "cnt_down_div4_test.sv"
  `include "cnt_down_div8_test.sv"
  `include "cnt_down_rd_div1_test.sv"
  `include "cnt_down_rd_div2_test.sv"
  `include "cnt_down_rd_div4_test.sv"
  `include "cnt_down_rd_div8_test.sv"
  `include "cnt_down_change_test.sv"
  `include "cnt_down_rd_change_div_test.sv"

  `include "underflow_en_test.sv"
  `include "underflow_dis_test.sv"
  `include "overflow_en_test.sv"
  `include "overflow_dis_test.sv"
endpackage
