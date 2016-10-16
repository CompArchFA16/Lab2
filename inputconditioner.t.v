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
    
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    reg[0:69] noisy;
    reg[0:69] expected;
    reg synchFailed;

    integer i;
    initial begin

        $dumpfile("inputconditioner.vcd");
        $dumpvars;

        synchFailed = 0;        
        // noisy signal
        noisy = 70'b0000000000111111111111111111110000000000000000001011111111111111111111;

        // expected signal
        expected = 70'bxxxxxxxx00000111111111111111111110000000000000000000011111111111111111;

        for (i = 0; i < 70; i=i+1) begin
            pin <= noisy[i];
            if (conditioned !== expected[i]) begin 
                synchFailed = 1;
            end
            $display("Expected: %b", expected[i]);
            $display("Conditioned: %b", conditioned);
            #10;
        end

        $display("Synchronization Failed: %b", synchFailed);
        $finish;
    end  
    
endmodule