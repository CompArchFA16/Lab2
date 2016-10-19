`include "shiftregister.v"
`include "inputconditioner.v"

`timescale 1ns / 1ps

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux_p #(parameter W = 4)
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule


module midpoint
(
    input        clk,
    input  [3:0] sw,
    input  [3:0] btn,
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

    mux_p #(4) ledout(.in0(parallelDataOut[3:0]), .in1(rparallelDataOut[7:4]), .sel(sw[3]), .out(led));
endmodule