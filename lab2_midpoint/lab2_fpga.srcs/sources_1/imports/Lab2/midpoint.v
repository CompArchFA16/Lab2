//--------------------------------------------------------------------------------
//  Wrapper for Lab 2
//
//  Usage:
//     btn0 - load operand A from the current switch configuration
//     btn1 - load operand B from the current switch configuration
//     btn2 - show SUM on LEDs
//     btn3 - show carryout on led0, overflow on led1
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps


//--------------------------------------------------------------------------------
// Midpoint check-in module
//--------------------------------------------------------------------------------

module half_SPI
#(parameter width = 8)
(
    input clk,
    input noisysignal0, // Button 0
    input noisysignal1, // Switch 0
    input noisysignal2, // Switch 1
    output[width-1:0] parallelout
);

    // 3 input conditioners
    wire conditioned0, conditioned1, conditioned2;
    wire posedge0, posedge1, posedge2;
    wire negedge0, negedge1, negedge2;
    inputconditioner conditioner0(clk, noisysignal0, conditioned0, posedge0, negedge0);
    inputconditioner conditioner1(clk, noisysignal1, conditioned1, posedge1, negedge1);
    inputconditioner conditioner2(clk, noisysignal2, conditioned2, posedge2, negedge2);

    // Shift register
    reg[(width-1):0] parallelin = 8'hA5;
    wire serialout;
    shiftregister #(width) register(clk, posedge2, negedge0, parallelin, conditioned1, parallelout, serialout);
endmodule

//--------------------------------------------------------------------------------
// Intermediate modules
//--------------------------------------------------------------------------------

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
// Lab 2 Midpoint wrapper module
//   Interfaces with switches, buttons, and LEDs on ZYBO board. Allows for two
//   4-bit operands to be stored, and two results to be alternately displayed
//   to the LEDs.
//--------------------------------------------------------------------------------

module midpoint
(
    input        clk,
    input  [3:0] sw,
    input  [3:0] btn,
    output [3:0] led
);

    wire[2:0] inputs;       // Stored inputs to adder
    wire[7:0] res;

    // Instantiates the midpoint module (parametric width set to 8 bits)
    half_SPI #(8) midpoint(.clk(clk), .noisysignal0(btn[0]), .noisysignal1(sw[0]), .noisysignal2(sw[1]), .parallelout(res));

    // Capture button input to switch which MUX input to LEDs
    mux2 #(4) output_select(.in0(res[3:0]), .in1(res[7:4]), .sel(sw[2]), .out(led));
endmodule
