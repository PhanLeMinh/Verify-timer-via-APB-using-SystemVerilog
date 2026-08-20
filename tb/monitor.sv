class monitor;
    mailbox #(packet) m2s_mb;
    virtual dut_if dut_vif;

    function new(virtual dut_if dut_vif, mailbox #(packet) m2s_mb);
        this.dut_vif = dut_vif;
        this.m2s_mb  = m2s_mb;
    endfunction

    task run();
        packet pkt;
        while (1) begin
            @(posedge dut_vif.pclk);
            if(dut_vif.psel & dut_vif.penable) begin // psel=1,penable=1 is transaction happen
                pkt = new();
                pkt.addr = dut_vif.paddr;
                pkt.transfer = dut_vif.pwrite ? packet::WRITE : packet::READ;

                if(dut_vif.pwrite) begin
                    pkt.data = dut_vif.pwdata; // Capture write data
                end else begin
                    pkt.data = dut_vif.prdata; // Capture read data from DUT
                end
                $display("%0t: [monitor] Capture APB transaction", $time);
                m2s_mb.put(pkt);
            end
        end
    endtask

endclass
