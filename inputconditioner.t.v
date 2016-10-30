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
    reg[0:69] expected_positiveedge;
    reg[0:69] expected_negativeedge;
    reg expectedWire;
    reg dutPassed;

    integer i;
    initial begin

        $dumpfile("inputconditioner.vcd");
        $dumpvars;

        dutPassed = 1;
        // clock = 70'b0101010101010101010101010101010101010101010101010101010101010101010101;
        noisy    = 70'b0000000000111111111111111111110000000000000000001011111111111111111111;
        expected = 70'bxxxxxxx000000000000001111111111111111111100000000000000000011111111111;
        expected_positiveedge = 70'bxxxxxxx000000000000001100000000000000000000000000000000000011000000000;
        expected_negativeedge = 70'bxxxxxxxxx0000000000000000000000000000000011000000000000000000000000000;

        for (i = 0; i < 70; i=i+1) begin
          pin <= noisy[i];
          expectedWire <= expected[i];
          #10;

          if (conditioned !== expected[i]) begin
            dutPassed = 0;
            $display("Expected debounce broken here: %d", i);
            $display("Expected debounce:    %d", expected[i]);
            $display("Conditioned debounce: %d", conditioned);
          end

          if (rising !== expected_positiveedge[i]) begin
            dutPassed = 0;
            $display("Expected positiveedge broken here: %d", i);
            $display("Expected positiveedge:    %d", expected_positiveedge[i]);
            $display("Conditioned positiveedge: %d", rising);
          end

          if (falling !== expected_negativeedge[i]) begin
            dutPassed = 0;
            $display("Expected negativeedge broken here: %d", i);
            $display("Expected negativeedge:    %d", expected_negativeedge[i]);
            $display("Conditioned negativeedge: %d", falling);
          end
        end

        $display("Did all tests pass? %b", dutPassed);
        $finish;
    end

endmodule
