class cnt_down_rd_div8_test extends base_test;
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
        write(TIE_ADDR,8'h02); // enable underflow
        write(TCR_ADDR,8'b000_11_011); // Start count down with div 8
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
        if(rd_data == 8'h02) begin
            $display("%0t: [TEST PASSED] Underflow is triggered!",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow is NOT triggered!",$time);
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
