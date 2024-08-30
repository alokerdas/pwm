module pwm (
  input clkin,
  input reset,
  input cs,
  input [2:0] uptime,
  output clkout
);

  reg [2:0] uptimelat;
  reg [2:0] uptimereg;
  reg [2:0] countreg;

  always_latch begin
    if (cs || reset) begin
      uptimelat = uptime;
    end
  end

  always @(posedge clkin or posedge reset) begin
    if (reset) begin
      uptimereg  <= 3'h0;
    end else if (!count1) begin
      uptimereg <= uptimelat;
    end else if (uptime1) begin
      uptimereg <= uptimereg - 1;
    end
  end

  always @(posedge clkin or posedge reset) begin
    if (reset) begin
      countreg  <= 3'h0;
    end else begin
      countreg <= countreg + 1;
    end
  end

  assign uptime1 = |uptimereg;
  assign count1 = |countreg;
  assign clkout = uptime1;

endmodule
