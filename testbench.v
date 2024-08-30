`default_nettype none
`timescale 1ns / 1ps

module testbench;

  reg [2:0] upt;
  reg ck, rs, en;
  wire pwmout;

  initial begin
    $display($time," rs en upt pwmout");
    $monitor($time," %b %b %h %b", rs, en, upt, pwmout);

    ck = 0; rs = 0; en = 0; upt = 0;
    #5 rs = 1'b1;
    #30 rs = 1'b0;
    #50 upt = 3'h1;
    #5 en = 1; #5 en = 0;
    #1000 upt = 3'h2;
    #5 en = 1; #15 en = 0;
    #1000 upt = 3'h3;
    #5 en = 1; #15 en = 0;
    #1000 $finish;
  end 

`ifdef DUMP_VCD
  initial begin
    $dumpfile("pwm.vcd");
    $dumpvars(0, testbench);
  end 
`endif

  always
    #10 ck = ~ck;

  pwm P0 (
    .clkin(ck),
    .reset(rs),
    .cs(en),
    .uptime(upt),
    .clkout(pwmout)
);
endmodule
