`include "fsm.v"

module testFSM();

  // Wires.
  wire misoBufferEnable;
  wire DMWriteEnable;
  wire addressWriteEnable;
  wire SRWriteEnable;

  reg clk;
  reg sClkPosEdge;
  reg readWriteEnable;
  reg chipSelectConditioned;

  // DUT.
  fsm dut(
    .misoBufferEnable(misoBufferEnable),
    .DMWriteEnable(DMWriteEnable),
    .addressWriteEnable(addressWriteEnable),
    .SRWriteEnable(SRWriteEnable),
    .clk(clk),
    .sClkPosEdge(sClkPosEdge),
    .readWriteEnable(readWriteEnable),
    .chipSelectConditioned(chipSelectConditioned)
  );

  initial clk=0;
  always #1 clk=!clk;

  initial sClkPosEdge = 0;
  always begin
    #299;
    sClkPosEdge <= 1;
    #1;
    sClkPosEdge <= 0;
  end

  reg dutPassed;

  task resetTest;
  begin
    $display("RESET STARTED AT %d.", $time);
    #800;
    chipSelectConditioned = 1;
    #800;
    $display("RESET ENDED AT %d.", $time);
  end
  endtask

  task waitFor8SClkCycles;
  begin
    #6400;
  end
  endtask

  task displayFailedResults;
  begin
    $display("misoBufferEnable: %b", misoBufferEnable);
    $display("DMWriteEnable: %b", DMWriteEnable);
    $display("addressWriteEnable: %b", addressWriteEnable);
    $display("SRWriteEnable: %b", SRWriteEnable);
  end
  endtask

  initial begin

    $dumpfile("fsm.vcd");
    $dumpvars;

    dutPassed = 1;

    // Test if read request flags can be set properly.
    resetTest();
    chipSelectConditioned = 0;
    readWriteEnable = 1;

    waitFor8SClkCycles();
    if (misoBufferEnable !== 1
      || DMWriteEnable !== 0
      || addressWriteEnable !== 1
      || SRWriteEnable !== 1) begin
      dutPassed = 0;
      $display("Reading failed.");
      displayFailedResults();
    end

    // Test if write request flags can be set properly.
    resetTest();
    chipSelectConditioned = 0;
    readWriteEnable = 0;

    waitFor8SClkCycles();
    if (misoBufferEnable !== 0
      || DMWriteEnable !== 1
      || addressWriteEnable !== 1
      || SRWriteEnable !== 0) begin
      dutPassed = 0;
      $display("Writing failed at %d.", $time);
      displayFailedResults();
    end

    // Test if any resets in `chipSelectConditioned = 1` nulls the whole operation.
    resetTest();
    chipSelectConditioned = 0;
    readWriteEnable = 0;

    waitFor8SClkCycles();
    chipSelectConditioned = 1; #10;
    if (misoBufferEnable !== 0
      || DMWriteEnable !== 0
      || addressWriteEnable !== 0
      || SRWriteEnable !== 0) begin
      dutPassed = 0;
      $display("Resetting failed at %d.", $time);
      displayFailedResults();
    end

    $display("Have all tests passed? %b", dutPassed);
    $finish();
  end
endmodule
