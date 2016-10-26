`include "fsm.v"

module testFSM();

  // Wires.
  wire misoBufferEnable;
  wire DMWriteEnable;
  wire addressWriteEnable;
  wire SRWriteEnable;

  reg sClkPosEdge;
  reg readWriteEnable;
  reg chipSelectConditioned;

  // DUT.
  fsm dut(
    .misoBufferEnable(misoBufferEnable),
    .DMWriteEnable(DMWriteEnable),
    .addressWriteEnable(addressWriteEnable),
    .SRWriteEnable(SRWriteEnable),
    .sClkPosEdge(sClkPosEdge),
    .readWriteEnable(readWriteEnable),
    .chipSelectConditioned(chipSelectConditioned)
  );

  initial sClkPosEdge=0;
  always #10 sClkPosEdge=!sClkPosEdge;

  reg dutPassed;

  task resetTest;
  begin
    #80;
    chipSelectConditioned = 1;
    #80;
  end
  endtask

  task waitFor8SClkCycles;
  begin
    #160;
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
      // $display("Reading failed.");
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
      $display("Writing failed.");
      displayFailedResults();
    end

    // Test if any resets in `chipSelectConditioned = 1` nulls the whole operation.

    $display("Have all tests passed? %b", dutPassed);

    $finish();
  end
endmodule
