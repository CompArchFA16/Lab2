//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------
`include "inputconditioner.v"
`include "shiftregister.v"
`include "datamemory.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
)	
	// input conditioner wires
	wire conditionedMosi;
	wire conditionedCS;
	wire positiveedge;
	wire negativeedge;

	// shift register wires
	wire parallelOut;
	wire serialOut;

	// data memory wires
	wire[7:0] DMDataOut;
	wire[7:0] DMDataIn;
	wire DMWriteEnable;
	wire[6:0] DMAddress;

	inputconditioner conditioner1(.conditioned(conditioned), .clk(clk), .noisysignal(mosi_pin));
    inputconditioner conditioner2(.positiveedge(positiveedge), .negativeedge(negativeedge), .clk(clk), .noisysignal(sclk_pin));
    inputconditioner conditioner3(.conditioned(conditionedCS), .clk(clk), .noisysignal(cs_pin));
    
    datamemory mem(.dataOut(DMDataOut), .clk(clk), .address(DMAddress), .writeEnable(DMWriteEnable), .dataIn(DMDataIn));

    shiftregister register(.parallelDataOut(parallelOut), .serialDataOut(serialOut), 
    	.serialDataIn(conditionedMosi), .peripheralClkEdge(positiveedge), 
    	.parallelDataIn(DMDataOut), .clk(clk));

endmodule
   
