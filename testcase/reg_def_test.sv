class reg_def_test extends base_test;
    
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] addr = 8'h00;
        bit [7:0] r_data;

        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        for(int i = 0; i < 4; i++)
        begin
            read(addr, r_data);
            if(r_data == 8'h00) begin
                $display("%0t: [TEST PASSED]. Read addr: %0h, data: %0h", $time , addr, r_data);
            end else begin
                $display("%0t: [TEST FAILED]. Read addr: %0h, data: %0h", $time,addr,r_data);
                error_cnt++;
            end
            addr++;
        end
    endtask

endclass
