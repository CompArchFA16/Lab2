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

module quicktest();
    //variables for testing address latch
    reg clk;
    reg[6:0] d;
    reg ce;
    wire[6:0] q;

    addressLatch addrTest (clk, d, ce, q);

    initial begin
        clk = 0; #10

        d = 7'd6;
        ce = 1;
        clk = 1; #10;

        $display("Output address latch: %d", q);
    end
endmodule

module quicktestDFF ();

//variables for testing d flip flop
reg clkd;
reg dd;
reg ced;
wire qd;

dFlipFlop dff(clkd, dd, ced, qd);

initial begin
    clkd = 0; #10

    dd = 1;
    ced = 1;
    clkd = 1; #10;

    $display("Output dff: %d", qd);
end

endmodule
