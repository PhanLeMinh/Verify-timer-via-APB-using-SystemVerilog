class reg_wr_test extends base_test;
    function new();
        super.new();
    endfunction

    task run_scenario();
        bit [7:0] addr;
        bit [7:0] rd_data;
        int error_cnt;
        wait (dut_vif.presetn == 1'b1);
        @(posedge dut_vif.pclk);
        // TCR_ADDR
        write(TCR_ADDR,8'h55);
        read(TCR_ADDR,rd_data);
        check(rd_data,8'h15);
        write(TCR_ADDR,8'hAA);
        read(TCR_ADDR,rd_data);
        check(rd_data,8'h0A);
        write(TCR_ADDR,8'hFF);
        read(TCR_ADDR,rd_data);
        check(rd_data,8'h1F);
        // TDR_ADDR
        write(TDR_ADDR,8'h55);
        read(TDR_ADDR,rd_data);
        check(rd_data,8'h55);
        write(TDR_ADDR,8'hAA);
        read(TDR_ADDR,rd_data);
        check(rd_data,8'hAA);
        write(TDR_ADDR,8'hFF);
        read(TDR_ADDR,rd_data);
        check(rd_data,8'hFF);
        // TIE_ADDR
        write(TIE_ADDR,8'h55);
        read(TIE_ADDR,rd_data);
        check(rd_data,8'h01);
        write(TIE_ADDR,8'hAA);
        read(TIE_ADDR,rd_data);
        check(rd_data,8'h02);
        write(TIE_ADDR,8'hFF);
        read(TIE_ADDR,rd_data);
        check(rd_data,8'h03);
    endtask

    task check(bit[7:0] act, bit [7:0] exp);
        if(act === exp) begin
            $display("%0t: [TEST PASSED]. Data is matching!", $time);
        end else begin
            $display("%0t: [TEST FAILED]. Data is NOT matching!, act = %0h, exp = %0h", $time, act, exp);
            error_cnt++;
        end
    endtask
endclass
