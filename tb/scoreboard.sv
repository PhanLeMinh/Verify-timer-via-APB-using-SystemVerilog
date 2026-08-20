class scoreboard;
    mailbox #(packet) m2s_mb;
    int error_cnt;
    bit en_fc=1;

    `include "coverage.sv"

    function new(mailbox #(packet) m2s_mb);
        this.m2s_mb = m2s_mb;
        pkt = new();
        APB_GROUP = new();
    endfunction

    task run();
        packet pkt;
        while (1) begin
            m2s_mb.get(pkt);
            $display("%0t: [scoreboard] Get packet from monitor: %s, addr = %b, data = %h", $time,pkt.transfer.name(),pkt.addr,pkt.data);
            if(en_fc) sample_apb_fc(pkt);
        end
    endtask

    function void sample_apb_fc(packet pkt);
        $cast(pkt,pkt);
        APB_GROUP.sample();
    endfunction

    function void report(int error_cnt);
        int total_error;
        total_error = this.error_cnt + error_cnt;
        if(total_error != 0) begin
            $display("%0t: [soreboard] TEST FAILED, number of error = %0d", $time, total_error);
        end else begin
            $display("%0t: [soreboard] TEST PASSED", $time);
        end
    endfunction

endclass
