`include "midpoint.v"
`timescale 1ns / 1ps

module lab2_wrapper
(
    input        clk,
    input  [1:0] sw,
    input  [1:0] btn,
    output [3:0] led
);

	wire [7:0] ledOut;
	wire SerialOut;

	midpoint mid(.b0(btn[0]), .s0(sw[0]), .s1(sw[1]), .clk(clk), .parallelDataOut(ledOut), .SerialDataOut(SerialOut));

	assign led = ledOut;
	
    
endmodule