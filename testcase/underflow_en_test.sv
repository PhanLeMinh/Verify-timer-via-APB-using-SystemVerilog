class underflow_en_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit[7:0] rd_data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        write(TIE_ADDR,8'h02); 
        write(TDR_ADDR,8'hFF);
        write(TCR_ADDR,8'b000_00_100); // set load bit
        write(TCR_ADDR,8'h02);
        write(TCR_ADDR,8'h03);
        wait(dut_vif.interrupt == 1'b1);
        read(TSR_ADDR,rd_data);
         if(rd_data == 8'h02) begin
            $display("%0t: [TEST PASSED] Underflow triggered!",$time);
        end else begin
            $display("%0t: [TEST FAILED] Underflow NOT triggered",$time);
            error_cnt++;
        end
        write(TSR_ADDR,8'h02); // clear underflow
    endtask
endclass
