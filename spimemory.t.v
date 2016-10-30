`include "spimemory.v"

module testSpiMemory (
  output [7:0] readValue,
  output [7:0] writeValue
);

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
      mosi_pin = 1; // Read mode.
      #50;
      sclk_pin = 1;
      #50;

      for (j = 7; j >= 0; j = j - 1) begin
        sclk_pin = 0;
        #50;
        readValue[j] = miso_pin;
        sclk_pin = 1;
        #50;
      end

      sclk_pin = 0;
      cs_pin = 1;
    end
  endtask

  task spiWrite;
    input [6:0] address;
    input [7:0] writeValue;
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
      mosi_pin = 0; // Write mode.
      #50;
      sclk_pin = 1;
      #50;

      for (j = 7; j >= 0; j = j - 1) begin
        sclk_pin = 0;
        mosi_pin = writeValue[j];
        #50;
        sclk_pin = 1;
        #50;
      end

      sclk_pin = 0;
      cs_pin = 1;
    end
  endtask

  reg       dutPassed;
  reg [6:0] address;
  reg [7:0] writeValue;
  reg [7:0] readValue;

  initial begin
    $dumpfile("spimemory.vcd");
    $dumpvars;

    dutPassed = 1;
    readValue = 0;
    writeValue = 0;

    // Does write and read work?
    address = 7'd3;
    writeValue = 8'd10;
    spiWrite (address, writeValue);
    #100;
    spiRead  (address, readValue);

    if (readValue !== 8'd10) begin
      dutPassed = 0;
      $display("Writing and reading failed.");
      $display("readValue: %d", readValue);
      $display("writeValue: %d", writeValue);
    end

    // Does reset work?

    $display("Did all tests pass? %b", dutPassed);
    $finish;
  end
endmodule
