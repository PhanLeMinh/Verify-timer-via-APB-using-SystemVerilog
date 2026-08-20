class overflow_dis_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit[7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        // write(TIE_ADDR,8'h01); 
        write(TCR_ADDR,8'h01);
        repeat(255) @(posedge dut_vif.ker_clk);
        read(TSR_ADDR,rd_data);
         if(!dut_vif.interrupt) begin
            $display("%0t: [TEST PASSED] Overflow NOT triggered!",$time);
        end else begin
            $display("%0t: [TEST FAILED] Overflow triggered",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h01);
    endtask
endclass
