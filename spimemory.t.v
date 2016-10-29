`include "spimemory.v"

module testSpiMemory ();

  wire       miso_pin;
  wire [3:0] leds;
  reg        clk;
  reg        sclk_pin;
  reg        cs_pin;
  reg        mosi_pin;

  reg [7:0] miso_pin_stored;

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
    input  [6:0] address;
    output [7:0] readValue;
    integer i;
    integer j;
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
      mosi_pin = 1;
      #50;
      sclk_pin = 1;
      #50;

      for (j = 7; j >= 0; j = j - 1) begin
        sclk_pin = 0;
        miso_pin_stored[j] = miso_pin;
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
