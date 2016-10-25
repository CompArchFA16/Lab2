//------------------------------------------------------------------------
// Address Latch
//------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module addressLatch
(
    input           clk,  
    input [6:0]     d,   
    input           ce,     
    output reg [6:0]    q   
);

	always @(posedge clk) begin
        if(ce) begin
            q = d;
        end
    end

endmodule
   

module dFlipFlop
(
    input           clk,  
    input		    d,   
    input           ce,     
    output reg          q
);

	always @(posedge clk) begin
        if(ce) begin
            q <= d;
        end
    end

endmodule
   
