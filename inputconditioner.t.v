//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`define TEST_SEPARATION #100;
`define OUTPUT_DELAY #30;

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    wire dutpassed;

    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling))


    // Generate clock (50MHz)
    reg clk_offset;
    initial clk=0; initial clk_offset=0;
    always #10 clk=!clk;    // 50MHz Clock
    always #1 clk_offset=!clk_offset;

    initial begin
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    // -------------------------------------------------------------------------
    // TEST SYNCHRONIZATION
    // -------------------------------------------------------------------------

    // Pin rising before clock edge
    `TEST_SEPARATION; pin = 0; #9; pin = 1; `OUTPUT_DELAY;
    if(!conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 1: Rising edge immediately before clock edge");
    end

    `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 2: Falling edge immediately before clock edge");
    end

    `TEST_SEPARATION; #11; pin = 1; `OUTPUT_DELAY;
    if(!conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 3: Rising edge on clock edge");
    end

    `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 4: Falling edge on clock edge");
    end

    `TEST_SEPARATION; #11; pin = 1; `OUTPUT_DELAY;
    if(!conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 5: Rising edge immediately after clock edge");
    end

    `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 6: Falling edge immediately after clock edge");
    end

    `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Sync Test 6: Falling edge immediately after clock edge");
    end

    #9; // Resync with clock

    // -------------------------------------------------------------------------
    // TEST DEBOUNCING
    // -------------------------------------------------------------------------

    `TEST_SEPARATION; pin = 1; #20; pin = 0;
    // 10 units before blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #10 before");
    end
    #10; // moment at which blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #0 after");
    end
    #10; // 10 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #10 after");
    end
    #10; // 20 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #20 after");
    end
    #10; // 30 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #30 after");
    end
    #10; // 40 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 1: #20 unit blip @ #40 after");
    end

    `TEST_SEPARATION; pin = 1; #20;
    // 10 units before blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #10 before");
    end
    #10; pin = 0; // moment at which blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #0 after");
    end
    #10; // 10 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #10 after");
    end
    #10; // 20 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #20 after");
    end
    #10; // 30 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #30 after");
    end
    #10; // 40 units after the rising edge of the blip would appear in the output
    if(conditioned) begin
        dutpassed = 0;
        $display("Failed Debouncing Test 2: #30 unit blip @ #40 after");
    end

    $finish
    end

endmodule
