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

  initial begin

    $dumpfile("fsm.vcd");
    $dumpvars;

    dutPassed = 1;

    //Write test
    readWriteEnable = 0;
    chipSelectConditioned = ; //When it's high the clk shouldn't run?    
    

    
  end
endmodule
