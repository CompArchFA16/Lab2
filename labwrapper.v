//--------------------------------------------------------------------------------
// 
//  Rationale: 
//     The ZYBO board has 4 buttons, 4 switches, and 4 LEDs. 
//
//  Usage:
//     btn0 - button0 input
//     sw2 - switch which bits are displayed on the LEDs
//     sw0 - noisy signal --> conditioned --> serial in
//     sw1 - noisy signal --> pos edge --> peripheral clk
//
//     Note: Buttons, switches, and LEDs have the least-significant (0) position
//     on the right.      
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps
`include "midpoint.v"

//--------------------------------------------------------------------------------
// Basic building block modules
//--------------------------------------------------------------------------------

// D flip-flop with parameterized bit width (default: 1-bit)
// Parameters in Verilog: http://www.asic-world.com/verilog/para_modules1.html
module dff #( parameter W = 1 )
(
    input trigger,
    input enable,
    input      [W-1:0] d,
    output reg [W-1:0] q
);
    always @(posedge trigger) begin
        if(enable) begin
            q <= d;
        end 
    end
endmodule

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

// Two-input MUX with parameterized bit width (default: 1-bit)
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


//--------------------------------------------------------------------------------
// Main Lab 0 wrapper module
//   Interfaces with switches, buttons, and LEDs on ZYBO board. Allows for two
//   4-bit operands to be stored, and two results to be alternately displayed
//   to the LEDs.
//
//   You must write the FullAdder4bit (in your adder.v) to complete this module.
//   Challenge: write your own interface module instead of using this one.
//--------------------------------------------------------------------------------

module lab0_wrapper
(
    input        clk,
    input  [3:0] sw,
    input  [3:0] btn,
    output [3:0] led
);

    wire[3:0] opA, opB;       // Stored inputs to adder
    wire[3:0] res0, res1;     // Output display options
    wire res_sel;             // Select between display options
    wire cout;                // Carry out from adder
    wire ovf;                 // Overflow from adder

    wire [7:0] parallelDataIn;
    assign parallelDataIn = 8'b10101010;
    wire serialOut;
    wire[7:0] res;
    
    // Memory for stored operands (parametric width set to 4 bits)
    dff #(4) opA_mem(.trigger(clk), .enable(btn[0]), .d(sw), .q(opA));
    dff #(4) opB_mem(.trigger(clk), .enable(btn[1]), .d(sw), .q(opB));
    
    // Capture button input to switch which MUX input to LEDs
    jkff1 src_sel(.trigger(clk), .j(btn[3]), .k(btn[2]), .q(res_sel));
    mux2 #(4) output_select(.in0(res0), .in1(res1), .sel(sw[2]), .out(led));
    
    // TODO: You write this in your adder.v
    //FullAdder4bit adder(.sum(res0), .carryout(cout), .overflow(ovf), .a(opA), .b(opB));
    midpoint midpt(btn[0], sw[0], sw[1], clk, parallelDataIn, serialOut, res);

    assign res0 = res[3:0];
    assign res1 = res[7:4];

    // Assign bits of second display output to show carry out and overflow
    assign res1[0] = cout;
    assign res1[1] = ovf;
    assign res1[2] = 1'b0;
    assign res1[3] = 1'b0;
    
endmodule