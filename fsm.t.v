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

  initial begin

  end
endmodule
