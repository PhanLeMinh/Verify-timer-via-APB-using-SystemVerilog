class cnt_up_rd_div1_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] rd_data;
        bit [7:0] data = $random;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TDR_ADDR,data);
        write(TCR_ADDR,8'b000_00_100); // load initial data to counter
        write(TIE_ADDR,8'h01); // enable overflow
        write(TCR_ADDR,8'h01); // Start count up
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h01) begin
            $display("%0t: [TEST PASSED] Overflow is triggered!",$time);
        end else begin
            $display("%0t: [TEST FAILED] Overflow is NOT triggered!",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h01);
        read(TSR_ADDR,rd_data);
    endtask
endclass
