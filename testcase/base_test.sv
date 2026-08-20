class base_test;

    int error_cnt;

    environment env;
    virtual dut_if dut_vif;

    function new();
    endfunction

    function void build();
        env = new(dut_vif);
        env.build();
    endfunction

    task write(bit [7:0] addr, bit [7:0] data);
        packet pkt = new();
        pkt.addr   = addr;
        pkt.data   = data;
        pkt.transfer = packet::WRITE;
        env.stim.send_pkt(pkt);
        @(env.drv.xfer_done);
    endtask

    task read(bit [7:0] addr, ref bit [7:0] data);
        packet pkt = new();
        pkt.addr   = addr;
        pkt.transfer = packet::READ;
        env.stim.send_pkt(pkt);
        @(env.drv.xfer_done);
        data = pkt.data;
        $display("%0t: [test] READ addr = %0h, data = %0h",$time,addr,data);
    endtask

    virtual task run_scenario(); // scenario test difinition
    endtask

    task run_test();
        build();
        fork
            env.run();
            run_scenario();
        join_any
        env.scb.report(error_cnt);
        #1us;
        $display("%0t: [base_test] End simulation", $time);
        $finish;
    endtask

endclass
