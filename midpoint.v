`include "shiftregister.v"
`include "inputconditioner.v"

module midpoint
	
	(
	input b0,
	input s0,
	input s1,
	input clk,

	//input [7:0] parallelDataIn,

	output [7:0] parallelDataOut, //LED
	output SerialDataOut
	);

    wire conditioned;
    wire rising;
    wire falling;
    wire dummy = 0;
    reg [7:0] parallelDataIn = 8'd3;
    
    //reg[7:0]        parallelDataIn; //xA5?

    inputconditioner dut0(.clk(clk),
    			 		 .noisysignal(b0),
						 .conditioned(dummy),
						 .positiveedge(dummy),
						 .negativeedge(falling));

    inputconditioner dut1(.clk(clk),
    			 		 .noisysignal(s0),
						 .conditioned(conditioned),
						 .positiveedge(dummy),
						 .negativeedge(dummy));

	inputconditioner dut2(.clk(clk),
    			 		 .noisysignal(s1),
						 .conditioned(dummy),
						 .positiveedge(rising),
						 .negativeedge(dummy));

    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(rising),
    		           .parallelLoad(falling), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(conditioned), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));

endmodule