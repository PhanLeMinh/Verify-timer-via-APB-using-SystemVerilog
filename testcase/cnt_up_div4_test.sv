class cnt_up_div4_test extends base_test;
    function new();
        super.new();
    endfunction
    
    task run_scenario();
        bit[7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TIE_ADDR,8'h01);
        write(TCR_ADDR,8'b000_10_001); // set count up and division 4
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h01) begin
            $display("%0t: [TEST PASSED] Overflow is triggered",$time);
        end else begin
            $display("%0t: [TEST FAILED]",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h01);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h00) begin
            $display("%0t: [TEST PASSED] Clear overflow success",$time);
        end else begin
            $display("%0t: [TEST FAILED] NOT clear overflow success",$time);
            error_cnt++;
        end
    endtask
endclass
