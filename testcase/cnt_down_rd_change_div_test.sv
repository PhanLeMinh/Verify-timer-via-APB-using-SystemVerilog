class cnt_down_rd_change_div_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit[7:0] rd_data;
        bit[1:0] rand_div;
        bit[7:0] tcr_val;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TDR_ADDR,8'hFF);
        write(TCR_ADDR,8'b000_00_100); // set load = 1
        write(TCR_ADDR,8'h00); // clear load bit
        write(TIE_ADDR,8'h02); // allow  under trigger
        write(TCR_ADDR,8'b000_00_011); // count down with div 1
        repeat(50) @(posedge dut_vif.ker_clk);
        rand_div = $urandom_range(1,3);
        $display("%0t: [test] Changing div to %0d",$time,rand_div);
        write(TCR_ADDR,8'h00); // stop timer
        write(TCR_ADDR,8'h02);
        tcr_val = (rand_div << 3) | 8'h03; // set timer, count down
        write(TCR_ADDR,tcr_val);
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h02) begin
            $display("%0t: [TEST PASSED] Underflow triggered after div change",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow NOT triggered",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h02); // clear underflow
    endtask
endclass
