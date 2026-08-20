class reg_reserved_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] rd_data;
        bit [7:0] addr;
        int error_cnt;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        for(int i = 0; i < 10; i++) begin
            addr = $urandom_range(8'h4,8'hFF);
            write(addr, 8'hFF);
            read(addr, rd_data);
            if(rd_data == 8'h00) begin
                $display("%0t: [TEST PASSED] Read addr = %0h, data = %0h", $time,addr,rd_data);
            end else begin
                $display("%0t: [TEST FAILED] Read addr = %0h, data = %0h", $time,addr,rd_data);
                error_cnt++;
            end
            addr++;
        end
    endtask
endclass
