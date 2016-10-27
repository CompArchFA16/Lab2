`include "inputconditioner.v"
//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

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
        $dumpfile("inputconditioner.vcd");
        $dumpvars();

        pin=0; #1000
        pin=1; #50
        pin=0; #50
        pin=1; #50
        pin=0; #50
        pin=0; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=0; #50
        pin=0; #50
        pin=0; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=0; #50
        pin=1; #50
        pin=0; #50
        pin=1; #50
        pin=0; #50
        pin=0; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=0; #50
        pin=0; #50
        pin=0; #50
        pin=1; #50
        pin=1; #50
        pin=1; #50
        pin=0; #1000
        $display("%b");
        $display("%b");

        $dumpflush;
        $finish;
    end 
    
endmodule
