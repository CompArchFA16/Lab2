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

    // Write something when writeEnable === 1.
    writeEnable = 1;
    addressLatchIn = 7'd25;
    #10;
    if (addressLatchOut !== 7'd25) begin
      dutPassed = 0;
      $display("Happy path writing failed.");
      $display("Actual addressLatchOut: %d", addressLatchOut);
    end

    // Try to write something when writeEnable === 0.
    writeEnable = 0;
    addressLatchIn = 7'd27;
    #10;
    if (addressLatchOut === 7'd27) begin
      dutPassed = 0;
      $display("Writing bypassed the writeEnable.");
      $display("Actual addressLatchOut: %d", addressLatchOut);
    end

    $display("Didi all tests pass? %b", dutPassed);
    $finish;
  end
endmodule
