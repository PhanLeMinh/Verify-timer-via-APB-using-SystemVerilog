class driver;
    mailbox #(packet) s2d_mb;
    virtual dut_if dut_vif;
    event xfer_done;

    function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
        this.dut_vif = dut_vif;
        this.s2d_mb  = s2d_mb;
    endfunction

    task run();
        packet pkt;
        while (1) begin
            s2d_mb.get(pkt);
            $display("%0t: [driver] Get packet from stimulus", $time);
            if(pkt.transfer == packet::WRITE) begin
                @(posedge dut_vif.pclk);
                dut_vif.paddr   = pkt.addr;
                dut_vif.pwdata  = pkt.data;
                dut_vif.pwrite  = 1'b1;
                dut_vif.psel    = 1'b1;
                dut_vif.penable = 1'b0;
                @(posedge dut_vif.pclk);
                dut_vif.penable = 1'b1;
                @(posedge dut_vif.pclk);
                // reset bus
                dut_vif.pwrite  = 1'b0;
                dut_vif.psel    = 1'b0;
                dut_vif.penable = 1'b0;
            end
            else if(pkt.transfer == packet::READ) begin
                @(posedge dut_vif.pclk);
                dut_vif.paddr   = pkt.addr;
                dut_vif.pwrite  = 0;
                dut_vif.psel    = 1'b1;
                dut_vif.penable = 1'b0;
                @(posedge dut_vif.pclk);
                dut_vif.penable = 1'b1;
                @(posedge dut_vif.pclk);
                pkt.data = dut_vif.prdata;
                //$display("%0t: [driver] READ addr = %0h, data = %0h", $time,pkt.addr,pkt.data);
                dut_vif.psel    = 1'b0;
                dut_vif.penable = 1'b0;
            end
            -> xfer_done;
        end
    endtask
endclass
