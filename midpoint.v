`include "shiftregister.v"
`include "inputconditioner.v"

`timescale 1ns / 1ps

module midpoint
(
    input        clk,
    input  [1:0] sw,
    input  [1:0] btn,
    output [3:0] led
);
	
	wire [7:0] parallelDataIn; //xA5
	assign parallelDataIn = 8'd3;
	wire [7:0] parallelDataOut; //LED
	wire SerialDataOut;

    wire conditioned;
    wire rising;
    wire falling;
    wire dummy0, dummy1, dummy2, dummy3, dummy4, dummy5;


    inputconditioner dut0(.clk(clk),
    			 		 .noisysignal(btn[0]),
						 .conditioned(dummy0),
						 .positiveedge(dummy1),
						 .negativeedge(falling));

    inputconditioner dut1(.clk(clk),
    			 		 .noisysignal(sw[0]),
						 .conditioned(conditioned),
						 .positiveedge(dummy2),
						 .negativeedge(dummy3));

	inputconditioner dut2(.clk(clk),
    			 		 .noisysignal(sw[1]), 
						 .conditioned(dummy4),
						 .positiveedge(rising),
						 .negativeedge(dummy5));

    
    // Instantiate with parameter width = 8
    shiftregister #(8) sr(.clk(clk), 
    		           .peripheralClkEdge(rising),
    		           .parallelLoad(falling), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(conditioned), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));


   	assign led = parallelDataOut[3:0];
endmodule