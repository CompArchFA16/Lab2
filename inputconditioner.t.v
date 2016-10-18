//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`include "inputconditioner.v"

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;

    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    $dumpfile("inputconditions.vcd");
    $dumpvars();

    $display("----------------------------------------------------------------------------------");
    $display("Pin  CLK   | Ris Fall  Condit  |  Expected outcome");
    $display("Testing Synchronization");
    pin =0; #1000 pin = 1; #1000
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1);
    pin =0; #2000
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0);

    $display("Testing Debouncing");
    pin =0; #600 pin = 1; #200
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1);
    pin =0; #1000 pin = 1; #700
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1);
    pin =1; #200 pin = 0; #300
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0);
    pin =1; #440 pin = 0; #1000
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0);
    pin =0; #90 pin = 1; #330
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1);

    $display("Testing Edge Detection");
    pin = 0; #100 pin = 1; #120
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 1,0,1);
    pin =0; #120
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,1,0);
    #50 $finish;
    end
endmodule
