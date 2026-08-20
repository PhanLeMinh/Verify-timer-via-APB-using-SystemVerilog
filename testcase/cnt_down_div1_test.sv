class cnt_down_div1_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TDR_ADDR,8'hFF);
        write(TCR_ADDR,8'b000_00_100); // set load bit
        write(TIE_ADDR,8'h02); // allow interrupt trigger
        write(TCR_ADDR,8'h02); // set count down
        write(TCR_ADDR,8'h03);
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h02) begin
            $display("%0t: [TEST PASSED] Underflow is triggered",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow is NOT triggered",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h02);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h00) begin
            $display("%0t: [TEST PASSED] Clear underflow success",$time);
        end else begin
            $display("%0t: [TEST FAILED] NOT clear uderrflow success",$time);
            error_cnt++;
        end

    endtask
    
endclass
