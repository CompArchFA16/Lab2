
//-------------------
// D Flip Flops
//-------------------

// D Flip Flop
module dFF
(
input       clk,
input       d,
input       wrenable,
output reg  q

);
    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end
endmodule

// The address latch is a D Flip Flop with a 7 bit input
module addressLatch
(
input       		clk,
input [6:0] 		d,
input       		wrenable,
output reg [6:0] 	q

);
    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end
endmodule