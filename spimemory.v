//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------
`include "inputconditioner.v"
`include "shiftregister.v"
`include "datamemory.v"
`include "addresslatch.v"
`include "fsm.v"
`include "misoSoup.v"

module spiMemory (
  output       miso_pin, // SPI master in slave out
  output [3:0] leds,     // LEDs for debugging
  input        clk,      // FPGA clock
  input        sclk_pin, // SPI clock
  input        cs_pin,   // SPI chip select
  input        mosi_pin  // SPI master out slave in
);

  // INPUT =====================================================================

  // Conditioner outputs
	wire conditionedMosi;
	wire conditionedCS;
	wire sClkPosEdge;
	wire sClkNegEdge;

	inputconditioner mosiConditioner (
    .conditioned(conditionedMosi),
	  .clk(clk),
	  .noisysignal(mosi_pin)
	);

  inputconditioner sClkConditioner (
    .positiveedge(sClkPosEdge),
	  .negativeedge(sClkNegEdge),
	  .clk(clk),
	  .noisysignal(sclk_pin)
  );

  inputconditioner csConditioner (
    .conditioned(conditionedCS),
	  .clk(clk),
	  .noisysignal(cs_pin)
  );

  // REGISTER CONTENT ==========================================================

  // Shift register outputs
  wire [7:0] shiftRegParallelOut;
  wire       shiftRegSerialOut;

  // Address latch outputs
  wire [6:0] addressLatchOut;

  // Data memory outputs
  wire [7:0] dataMemDataOut;

  // FSM outputs
  wire misoBufferEnable;
  wire DMWriteEnable;
  wire addressWriteEnable;
  wire SRWriteEnable;

  shiftregister shiftRegister (
    .parallelDataOut(shiftRegParallelOut),
    .serialDataOut(shiftRegSerialOut),
    .serialDataIn(conditionedMosi),
    .peripheralClkEdge(sClkPosEdge),
    .parallelDataIn(dataMemDataOut),
    .clk(clk),
    .parallelLoad(SRWriteEnable)
  );

  datamemory dataMemory (
    .dataOut(dataMemDataOut),
	  .clk(clk),
	  .address(addressLatchOut),
    .writeEnable(DMWriteEnable),
    .dataIn(shiftRegParallelOut)
  );

  fsm FSM (
    .misoBufferEnable(misoBufferEnable),
  	.DMWriteEnable(DMWriteEnable),
    .addressWriteEnable(addressWriteEnable),
    .SRWriteEnable(SRWriteEnable),
    .clk(clk),
    .sClkPosEdge(sClkPosEdge),
    .readWriteEnable(shiftRegParallelOut[0]),
    .chipSelectConditioned(conditionedCS)
  );

  addressLatch addressLatch (
    .addressLatchOut(addressLatchOut),
    .clk(clk),
    .writeEnable(addressWriteEnable),
    .addressLatchIn(shiftRegParallelOut[7:1])
  );

  misoSoup misoOut (
    .q(miso_pin),
    .d(shiftRegSerialOut),
    .writeEnable(sClkNegEdge),
    .misoBufe(misoBufferEnable),
    .clk(clk)
  );
endmodule
