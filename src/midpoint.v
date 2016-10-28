`timescale 1ns / 1ps

`include "shiftregister.v"
`include "inputconditioner.v"

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

module midpoint
(
    input        clk,
    input  [3:0] sw,
    input  [3:0] btn,
    output [3:0] led
);

    wire[7:0] leds;

    wire negativeedge;
    wire positiveedge;
    wire conditioned;

    wire res_sel;

    inputconditioner conditioner1(.negativeedge(negativeedge), .clk(clk), .noisysignal(btn[0]));
    inputconditioner conditioner2(.conditioned(conditioned), .clk(clk), .noisysignal(sw[0]));
    inputconditioner conditioner3(.positiveedge(positiveedge), .clk(clk), .noisysignal(sw[1]));
    
    shiftregister register(
        .parallelDataOut(leds), 
        .clk(clk), 
        .peripheralClkEdge(positiveedge), 
        .parallelDataIn(8'b10100101), 
        .parallelLoad(negativeedge), 
        .serialDataIn(conditioned)
    );

    // Capture button input to switch which MUX input to LEDs
    jkff1 src_sel(.trigger(clk), .j(btn[2]), .k(btn[1]), .q(res_sel));
    mux2 #(4) output_select(.in0(leds[3:0]), .in1(leds[7:4]), .sel(res_sel), .out(led));

endmodule
