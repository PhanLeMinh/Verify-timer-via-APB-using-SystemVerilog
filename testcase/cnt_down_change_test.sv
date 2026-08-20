class cnt_down_change_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit[7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TDR_ADDR,8'hff); 
        write(TCR_ADDR,8'b000_00_100);
        write(TIE_ADDR,8'h03); // allow over, under trigger
        write(TCR_ADDR,8'h02); // set count down
        write(TCR_ADDR,8'h03); // start counter
        repeat(200) @(posedge dut_vif.ker_clk);
        write(TCR_ADDR,8'h00); // set count up
        write(TCR_ADDR,8'h01); // start counter
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h01) begin
            $display("%0t: [TEST PASSED]",$time);
        end else begin
            $display("%0t: [TEST FAILED]",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h01);
    endtask
endclass
