class reg_rs_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] rd_data;
        bit [7:0] addr;
        bit [7:0] data;
        wait(dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        for(int i; i < 4; i++) begin
            data = $random;
            write(addr,data);
            read(addr,rd_data);
            @(posedge dut_vif.pclk);
            dut_vif.presetn = 1'b0;
            @(posedge dut_vif.pclk);
            read(addr, rd_data);
            if(rd_data == 8'h00) begin
                $display("%0t: [TEST PASSED] Reset initial value",$time);
            end else begin
                $display("%0t: [TEST FAILED] NOT reset initial value",$time);
            end
            @(posedge dut_vif.pclk);
            dut_vif.presetn = 1'b1;
            addr++;
        end
    endtask
endclass
