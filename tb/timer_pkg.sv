package timer_pkg;

    parameter TCR_ADDR=8'h00;
    parameter TSR_ADDR=8'h01;
    parameter TDR_ADDR=8'h02;
    parameter TIE_ADDR=8'h03;
  `include "packet.sv"
  `include "stimulus.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "scoreboard.sv"
  `include "environment.sv"

endpackage
