class reg_tsr_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        // check interrupt trigger - overflow
        @(posedge dut_vif.pclk);
        write(TIE_ADDR,8'h03); // set output interrupt
        write(TCR_ADDR,8'h01); // count up
        wait(dut_vif.interrupt == 1'b1);
        // xem overflow triger
        write(TSR_ADDR,8'h00);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h01) begin
            $display("%0t: [TEST PASSED] Overflow is triggered",$time);
        end else begin
            $display("%0t: [TEST FAILED] Overflow is NOT triggered", $time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h01);
        read(TSR_ADDR,rd_data);
        @(posedge dut_vif.pclk);
        // check interrupt - underflow trigger
        @(posedge dut_vif.pclk);
        write(TCR_ADDR,8'h02); // set count down
        write(TCR_ADDR,8'h03); // start counter
        wait(dut_vif.interrupt == 1'b1);
        // xem underflow triger
        write(TSR_ADDR,8'h00);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h02) begin
            $display("%0t: [TEST PASSED] Underflow is triggered",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow is NOT triggered", $time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h02);
        read(TSR_ADDR,rd_data);
    endtask
endclass
