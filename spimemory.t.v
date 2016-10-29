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
  always #10 clk = !clk;

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
