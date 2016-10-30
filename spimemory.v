//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

`include "inputconditioner.v"
`include "datamemory.v"
`include "fsm.v"
`include "flipFlopModules.v"
`include "shiftregister.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
);

///// WIRES /////

// Wires for IC1
wire conditioned;
wire positiveEdge;
wire negativeEdge;

// Wires for IC2
wire conditioned1;
wire positiveEdge1;
wire negativeEdge1;

// Wires for IC3
wire conditioned2;
wire positiveEdge2;
wire negativeEdge2;

// Wires for FSM
wire misoBufe;
wire dmWe;
wire addrWe;
wire srWe;

// Wires for Shift Register
wire [7:0] parallelOut;
wire serialOut;

// Wires for DFF
wire dffOutput;

// Wires for Address Latch
wire [6:0] addr;

// Wires for data memory
wire [7:0] dOut;



///// Create SPI Structure /////

// Define input conditioners
// 1) mosi input
inputconditioner mosiIC(clk, mosi_pin, conditioned, positiveEdge, negativeEdge);
// 2) sclk input
inputconditioner sclkIC(clk, sclk_pin, conditioned1, positiveEdge1, negativeEdge1);
// 3) cs input
inputconditioner csIC(clk, cs_pin, conditioned2, positiveEdge2, negativeEdge2);

// Define other modules
fsm finiteStateMachine(srWe, dmWe, addrWe, misoBufe, positiveEdge1, conditioned2, parallelOut[0]);
shiftregister sr(clk, positiveEdge1, srWe, dOut, conditioned, parallelOut, serialOut);
addressLatch al(clk, parallelOut [7:1], addrWe, addr);
datamemory dm(clk, dOut, addr, dmWe, parallelOut);
dFF dff(clk, serialOut, negativeEdge1, diffOutput);

// Final output
and andgate(miso_pin, misoBufe, dffOutput);

endmodule

