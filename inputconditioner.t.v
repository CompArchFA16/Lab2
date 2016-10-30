//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

module testConditioner ();

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

    // Initial pin
    initial pin = 0;

    // Test pattern stimulus
    initial begin
        $dumpfile("inputconditioner.vcd");
        $dumpvars;
        #100

        // Test Case 1:
        //   Synchronization tester
        //   Applys an input at a slight phase offset
        #7 pin = 1; #20 pin = 0;
        #20 pin = 1; #20 pin = 0;
        #105

        // Test Case 2:
        //   Debouncing tester
        //   Inputs oscillations at a faster frequency than the clock
        #2 pin = 1; #2 pin = 0; #2 pin = 1; #2 pin = 0;
        #2 pin = 1; #2 pin = 0; #2 pin = 1; #2 pin = 0;
        #100

        // Test Case 3:
        //   Edge detection tester
        //   Inputs more normal signals to check that outputs are correct
        #50 pin = 1; #100 pin = 0;
        #150 pin = 1; #200 pin = 0;
        #100

        $finish;
    end
endmodule
