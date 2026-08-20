`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end

  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

  base_test                 base                      = new();
  reg_def_test              def_test                  = new();
  reg_wr_test               wr_test                   = new();
  reg_rs_test               rs_test                   = new();
  reg_reserved_test         reserved_test             = new();
  reg_tsr_test              tsr_test                  = new();

  cnt_up_div1_test          up_div1_test              = new();
  cnt_up_div2_test          up_div2_test              = new();
  cnt_up_div4_test          up_div4_test              = new();
  cnt_up_div8_test          up_div8_test              = new();
  cnt_up_rd_div1_test       up_rd_div1_test           = new();
  cnt_up_rd_div2_test       up_rd_div2_test           = new();
  cnt_up_rd_div4_test       up_rd_div4_test           = new();
  cnt_up_rd_div8_test       up_rd_div8_test           = new();
  cnt_up_change_test        up_change_test            = new();
  cnt_up_rd_change_div_test up_rd_change_div_test = new();

  cnt_down_div1_test          down_div1_test          = new();
  cnt_down_div2_test          down_div2_test          = new();
  cnt_down_div4_test          down_div4_test          = new();
  cnt_down_div8_test          down_div8_test          = new();
  cnt_down_rd_div1_test       down_rd_div1_test       = new();
  cnt_down_rd_div2_test       down_rd_div2_test       = new();
  cnt_down_rd_div4_test       down_rd_div4_test       = new();
  cnt_down_rd_div8_test       down_rd_div8_test       = new();
  cnt_down_change_test        down_change_test        = new();
  cnt_down_rd_change_div_test down_rd_change_div_test = new();

  underflow_en_test           under_en_test       = new();
  underflow_dis_test          under_dis_test      = new();
  overflow_en_test            over_en_test        = new();
  overflow_dis_test           over_dis_test       = new();
  initial begin
      if($test$plusargs("reg_def_test")) begin
          base = def_test;
          $display("%0t: [testbench] Run reg_def_test",$time);
      end else if($test$plusargs("reg_wr_test")) begin
          base = wr_test;
          $display("%0t: [testbench] Run reg_wr_test",$time);
      end else if($test$plusargs("reg_rs_test")) begin
          base = rs_test;
          $display("%0t: [testbench] Run reg_rs_test",$time);
      end else if($test$plusargs("reg_reserved_test")) begin
          base = reserved_test;
          $display("%0t: [testbench] Run reg_reserved_test",$time);
      end else if($test$plusargs("reg_tsr_test")) begin
          base = tsr_test;
          $display("%0t: [testbench] Run reg_tsr_test",$time);
      end else if($test$plusargs("cnt_up_div1_test")) begin
          base = up_div1_test;
          $display("%0t: [testbench] Run cnt_up_div1_test",$time);
      end else if($test$plusargs("cnt_up_div2_test")) begin
          base = up_div2_test;
          $display("%0t: [testbench] Run cnt_up_div2_test",$time);
      end else if($test$plusargs("cnt_up_div4_test")) begin
          base = up_div4_test;
          $display("%0t: [testbench] Run cnt_up_div4_test",$time);
      end else if($test$plusargs("cnt_up_div8_test")) begin
          base = up_div8_test;
          $display("%0t: [testbench] Run cnt_up_div8_test",$time);
      end else if($test$plusargs("cnt_up_rd_div1_test")) begin
          base = up_rd_div1_test;
          $display("%0t: [testbench] Run cnt_up_rd_div1_test",$time);
      end else if($test$plusargs("cnt_up_rd_div2_test")) begin
          base = up_rd_div2_test;
          $display("%0t: [testbench] Run cnt_up_rd_div2_test",$time);
      end else if($test$plusargs("cnt_up_rd_div4_test")) begin
          base = up_rd_div4_test;
          $display("%0t: [testbench] Run cnt_up_rd_div4_test",$time);
      end else if($test$plusargs("cnt_up_rd_div8_test")) begin
          base = up_rd_div8_test;
          $display("%0t: [testbench] Run cnt_up_rd_div8_test",$time);
      end else if($test$plusargs("cnt_down_div1_test")) begin
          base = down_div1_test;
          $display("%0t: [testbench] Run cnt_down_div1_test",$time);
      end else if($test$plusargs("cnt_down_div2_test")) begin
          base = down_div2_test;
          $display("%0t: [testbench] Run cnt_down_div2_test",$time);
      end else if($test$plusargs("cnt_down_div4_test")) begin
          base = down_div4_test;
          $display("%0t: [testbench] Run cnt_down_div4_test",$time);
      end else if($test$plusargs("cnt_down_div8_test")) begin
          base = down_div8_test;
          $display("%0t: [testbench] Run cnt_down_div8_test",$time);
      end else if($test$plusargs("cnt_down_rd_div1_test")) begin
          base = down_rd_div1_test;
          $display("%0t: [testbench] Run cnt_down_rd_div1_test",$time);
      end else if($test$plusargs("cnt_down_rd_div2_test")) begin
          base = down_rd_div2_test;
          $display("%0t: [testbench] Run cnt_down_rd_div2_test",$time);
      end else if($test$plusargs("cnt_down_rd_div4_test")) begin
          base = down_rd_div4_test;
          $display("%0t: [testbench] Run cnt_down_rd_div4_test",$time);
      end else if($test$plusargs("cnt_down_rd_div8_test")) begin
          base = down_rd_div8_test;
          $display("%0t: [testbench] Run cnt_down_rd_div8_test",$time);
      end else if($test$plusargs("cnt_up_change_test")) begin
          base = up_change_test;
          $display("%0t: [testbench] Run cnt_up_change_test",$time);
      end else if($test$plusargs("cnt_down_change_test")) begin
          base = down_change_test;
          $display("%0t: [testbench] Run cnt_down_change_test",$time);
      end else if($test$plusargs("cnt_up_rd_change_div_test")) begin
          base = up_rd_change_div_test;
          $display("%0t: [testbench] Run cnt_up_rd_change_div_test",$time);
      end else if($test$plusargs("cnt_down_rd_change_div_test")) begin
          base = down_rd_change_div_test;
          $display("%0t: [testbench] Run cnt_down_rd_change_div_test",$time);
      end else if($test$plusargs("underflow_en_test")) begin
          base = under_en_test;
          $display("%0t: [testbench] Run underflow_en_test",$time);
      end else if($test$plusargs("underflow_dis_test")) begin
          base = under_dis_test;
          $display("%0t: [testbench] Run underflow_dis_test",$time);
      end else if($test$plusargs("overflow_en_test")) begin
          base = over_en_test;
          $display("%0t: [testbench] Run overflow_en_test",$time);
      end else if($test$plusargs("overflow_dis_test")) begin
          base = over_dis_test;
          $display("%0t: [testbench] Run overflow_dis_test",$time);
      end
      base.dut_vif = d_if;
      base.run_test();
  end    

  sequence apb_write_sequence;
      d_if.penable ##1 !d_if.psel && !d_if.penable;
  endsequence

  property apb_write_check;
      @(posedge d_if.pclk) d_if.psel && d_if.pwrite && !d_if.penable |=> apb_write_sequence;
  endproperty

  assert property(apb_write_check) begin
      $display("%0t: [assert] apb_write_check PASSED assertion",$time);
  end else begin
      $error ("%0t: [assert] apb_write_check failure",$time);
  end
  
  property stable_check;
      @(posedge d_if.pclk) d_if.psel && d_if.penable |-> $stable(d_if.paddr) && $stable(d_if.pwdata);
  endproperty

  assert property(stable_check) begin
      $display("%0t: [assert] PADDR & PWDATA stable",$time);
  end else begin
      $display("%0t: [assert] PADDR & PWDATA NOT stable",$time);
  end

endmodule
