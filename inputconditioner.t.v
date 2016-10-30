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
    // pin =0; #1000 pin = 1; #1013
    // $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1);
    // pin =0; #2000
    // $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0);
    pin = 0; #33 pin = 1; #50
    $display("Noisy signal changed in the middle of a clock");
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0, "delay total = 50, 2.5 clock cycles");
    pin = 1; #40
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0,"delay total = 90, 4.5 clock cycles");
    pin = 1; #33
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1, "delay total= 120, 6 clock cycles");
    //end at 120
    pin = 0; #500;
    $display("----------------------------------------------------------------------------------");
    $display("Testing Debouncing");
    pin =0; #13 pin = 1; #50
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1, "delay total = 50");
    pin =0; #20 pin = 1; #10
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,1, "delay total = 80");
    pin =1; #10 pin = 0; #10
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0, "delay total = 100");
    pin =1; #30
    $display("Check after final signal");
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,0,0, "delay total = 130");
    $display("----------------------------------------------------------------------------------");
    $display("Testing Edge Detection");
    pin = 0; #100 pin = 1; #120
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 1,0,1);
    pin =0; #120
    $display("%b     %b    |  %b      %b     %b   |   %b     %b      %b   ", pin, clk,  rising, falling, conditioned, 0,1,0);
    #50 $finish;
    end
endmodule
