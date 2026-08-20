packet pkt;
covergroup APB_GROUP;
    cp_transfer: coverpoint pkt.transfer{
        bins apb_write = {packet::WRITE};
        bins apb_read  = {packet::READ};
    }

    cp_addr: coverpoint pkt.addr{
        bins TCR = {8'h00};
        bins TSR = {8'h01};
        bins TDR = {8'h02};
        bins TIE = {8'h03};
    }
    
    cp_data: coverpoint pkt.data{
        bins zero = {8'h00};
        bins max  = {8'hFF};
        bins others = default;
    }

    transaction_addr: cross cp_transfer, cp_addr{
        bins wr_TCR = binsof(cp_transfer.apb_write) && binsof(cp_addr.TCR);
        bins wr_TSR = binsof(cp_transfer.apb_write) && binsof(cp_addr.TSR);
        bins wr_TDR = binsof(cp_transfer.apb_write) && binsof(cp_addr.TDR);
        bins wr_TIE = binsof(cp_transfer.apb_write) && binsof(cp_addr.TIE);

        bins rd_TCR = binsof(cp_transfer.apb_read) && binsof(cp_addr.TCR);
        bins rd_TSR = binsof(cp_transfer.apb_read) && binsof(cp_addr.TSR);
        bins rd_TDR = binsof(cp_transfer.apb_read) && binsof(cp_addr.TDR);
        bins rd_TIE = binsof(cp_transfer.apb_read) && binsof(cp_addr.TIE);
    }
endgroup
