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
    integer i;
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=1;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin

    $dumpfile("inputconditioner.vcd");
    $dumpvars(0, dut);
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronize, Clean, Preprocess (edge finding)
    $display("Clock Pin | Conditioned Rising Falling");
    //check a noisy signal
    //1 clock cycle
    pin = 0;  #5; pin = 1; #5; pin = 0;  #5; pin = 1; #5;
    $display("%b   %b | %b   %b   %b", clk, pin, conditioned, rising, falling);
    $display($time);
    //off then on
    //4 clock cycles
    pin = 0;  #40; pin = 1; #40;
    $display("%b   %b | %b   %b   %b", clk, pin, conditioned, rising, falling);
    $display($time);
    //on then off
    //4 clock cycles
    pin = 1;  #4000; pin = 0; #400;
    $display("%b   %b | %b   %b   %b", clk, pin, conditioned, rising, falling);
    $display($time);
    #1000
    $finish;
end

endmodule
