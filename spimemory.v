//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

`include "datamemory.v"
`include "shiftregister.v"
`include "fsm.v"
`include "addressLatch.v"
//`include "inputconditioner.v"

`timescale 1 ns / 1 ps

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
);
	// drop the least sig bit of parallel out from shiftregister
    //
	// instantiate wires and reg's
    wire conditioned1, positiveedge1, negativeedge1;
    wire conditioned2, positiveedge2, negativeedge2;
    wire conditioned3, positiveedge3, negativeedge3;
    wire parallelLoad;
    wire [7:0] parallelOut;
    wire [7:0] parallelDataIn;
    wire serialOut;
    wire [6:0] addr;
    wire dffout;

    wire miso_buff;
    wire dm_we;
    wire addr_we;
    wire sr_we;

	//three input conditioners
    inputconditioner inputC1(clk, mosi_pin, conditioned1, positiveedge1, negativeedge1 );
    inputconditioner inputC2(clk, sclk_pin, conditioned2, positiveedge2, negativeedge2 );
    inputconditioner inputC3(clk, cs_pin, conditioned3, positiveedge3, negativeedge3 );

    // Finite state machine
    finiteStateMachine fsm(positiveedge2, conditioned3, parallelOut[0], miso_buff, dm_we, addr_we, sr_we);

    //shiftregister
    shiftregister shiftie(clk, positiveedge2, sr_we ,parallelDataIn, conditioned1, parallelOut, serialOut);

    // Address latch
    addressLatch addresslatch(clk, parallelOut[7:1], addr_we, addr); // cutting off the read/write flag, which is LSB

    // Data Memory
    datamemory datamem(clk, parallelDataIn, addr, dm_we, parallelOut);

    // DFF
    dFlipFlop dff(clk, serialOut, negativeedge2, dffout);

    // miso buffer
    bufif1 misobuff(miso_pin, dffout, miso_buff);


endmodule
