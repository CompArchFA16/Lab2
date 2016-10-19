`timescale 1ns / 1ps

// JK flip-flop
module jkff1
(
    input trigger,
    input j,
    input k,
    output reg q
);
    always @(posedge trigger) begin
        if(j && ~k) begin
            q <= 1'b1;
        end
        else if(k && ~j) begin
            q <= 1'b0;
        end
        else if(k && j) begin
            q <= ~q;
        end
    end
endmodule

// 2 input mux
module mux2 #( parameter W = 1 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule

module lab2_wrapper
(
	input clk,
	input  [3:0] btn,
	input [2:0] sw,
	output [3:0] led
);

	wire[3:0] res0, res1; // Output display options
	wire [7:0] pOut;
	wire res_sel;
	wire btnNegEdge;
	wire sw0Conditioned;
	wire sw1PosEdge;
    // Capture button input to switch which MUX input to LEDs
    jkff1 src_sel(.trigger(clk), .j(btn[3]), .k(btn[2]), .q(res_sel));
	mux2 #(4) output_select(.in0(res0), .in1(res1), .sel(res_sel), .out(led));

	inputconditioner btnedge(.clk(clk), .noisysignal(btn),.negativeedge(btnNegEdge));
	inputconditioner sw0conditioned(.clk(clk), .noisysignal(sw[0]), .conditioned(sw0Conditioned));
	inputconditioner swEdge(.clk(clk), .noisysignal(sw[1]), .positiveedge(sw1PosEdge));

	shiftregister shiftregister(.clk(clk), .peripheralClkEdge(sw1PosEdge), 
		.parallelLoad(btnNegEdge), .parallelDataOut(pOut), .serialDataIn(sw0conditioned));

endmodule