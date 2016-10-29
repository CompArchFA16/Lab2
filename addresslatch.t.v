`include "addresslatch.v"

module testAddressLatch ();
  wire [6:0] addressLatchOut;
  reg        clk;
  reg        writeEnable;
  reg  [6:0] addressLatchIn;

  addressLatch dut (
    .addressLatchOut(addressLatchOut),
    .clk(clk),
    .writeEnable(writeEnable),
    .addressLatchIn(addressLatchIn)
  );

  // Start the clock.
  initial clk = 0;
  always #1 clk = !clk;

  reg dutPassed;

  initial begin
    $dumpfile("addresslatch.vcd");
    $dumpvars;

    dutPassed = 1;

    $display("Didi all tests pass? %b", dutPassed);
    $finish;
  end
endmodule
