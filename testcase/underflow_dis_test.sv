class underflow_dis_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit[7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TDR_ADDR,8'hFF);
        write(TCR_ADDR,8'h02);
        write(TCR_ADDR,8'h03);
        repeat(225) @(posedge dut_vif.ker_clk);
        read(TSR_ADDR,rd_data);
         if(!dut_vif.interrupt) begin
            $display("%0t: [TEST PASSED] Underflow NOT triggered!",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow triggered",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h02);
    endtask
endclass
