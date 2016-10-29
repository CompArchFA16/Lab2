`include "spimemory.v"

module testSpiMemory ();

  wire       miso_pin;
  wire [3:0] leds;
  reg        clk;
  reg        sclk_pin;
  reg        cs_pin;
  reg        mosi_pin;

  spiMemory dut (
    .miso_pin(miso_pin),
    .leds(leds),
    .clk(clk),
    .sclk_pin(sclk_pin),
    .cs_pin(cs_pin),
    .mosi_pin(mosi_pin)
  );

  // Start the clock.
  initial clk = 0;
  always #1 clk = !clk;

  // Start our peripheral clock.
  initial sclk_pin = 0;
  always #100 sclk_pin = !sclk_pin;

  task spiRead;
    input [6:0] address;
    integer i;
    begin
      cs_pin = 0;
      for (i = 6; i >= 0; i = i - 1) begin
        sclk_pin = 0;
        mosi_pin = address[i];
        #50;
        sclk_pin = 1;
        #50;
      end
      sclk_pin = 0;
      cs_pin = 1;
    end
  endtask

  reg dutPassed;

  initial begin
    $dumpfile("spimemory.vcd");
    $dumpvars;

    dutPassed = 1;

    // Does read work?

    // Does write work?

    // Does reset work?

    $display("Did all tests pass? %b", dutPassed);
    $finish;
  end
endmodule
