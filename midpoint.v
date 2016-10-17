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

	wire [7:0] parallelDataOut; //LED
	wire SerialDataOut;

    wire conditioned;
    wire rising;
    wire falling;
    wire dummy = 0;


    inputconditioner dut0(.clk(clk),
    			 		 .noisysignal(btn[0]),
						 .conditioned(dummy),
						 .positiveedge(dummy),
						 .negativeedge(falling));

    inputconditioner dut1(.clk(clk),
    			 		 .noisysignal(sw[0]),
						 .conditioned(conditioned),
						 .positiveedge(dummy),
						 .negativeedge(dummy));

	inputconditioner dut2(.clk(clk),
    			 		 .noisysignal(sw[1]),
						 .conditioned(dummy),
						 .positiveedge(rising),
						 .negativeedge(dummy));

    
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