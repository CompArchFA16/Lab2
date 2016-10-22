//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`define TEST_SEPARATION #100;
`define OUTPUT_DELAY #30;

`include "inputconditioner.v"

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
			 .negativeedge(falling));

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    reg [49:0] signal;
    reg [49:0] conditioned_output;
    reg [49:0] conditioned_posedge;
    reg [49:0] conditioned_negedge;
    reg [49:0] expected_output;
    reg [49:0] expected_posedge;
    reg [49:0] expected_negedge;
    integer i;

    initial begin
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    // // -------------------------------------------------------------------------
    // // TEST SYNCHRONIZATION
    // // -------------------------------------------------------------------------

    // // Pin rising before clock edge
    // `TEST_SEPARATION; pin = 0; #9; pin = 1; `OUTPUT_DELAY;
    // if(!conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 1: Rising edge immediately before clock edge");
    // end

    // `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 2: Falling edge immediately before clock edge");
    // end

    // `TEST_SEPARATION; #11; pin = 1; `OUTPUT_DELAY;
    // if(!conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 3: Rising edge on clock edge");
    // end

    // `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 4: Falling edge on clock edge");
    // end

    // `TEST_SEPARATION; #11; pin = 1; `OUTPUT_DELAY;
    // if(!conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 5: Rising edge immediately after clock edge");
    // end

    // `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 6: Falling edge immediately after clock edge");
    // end

    // `TEST_SEPARATION; #10; pin = 0; `OUTPUT_DELAY;
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Sync Test 6: Falling edge immediately after clock edge");
    // end

    // #9; // Resync with clock

    // // -------------------------------------------------------------------------
    // // TEST DEBOUNCING
    // // -------------------------------------------------------------------------

    // `TEST_SEPARATION; pin = 1; #20; pin = 0;
    // // 10 units before blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #10 before");
    // end
    // #10; // moment at which blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #0 after");
    // end
    // #10; // 10 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #10 after");
    // end
    // #10; // 20 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #20 after");
    // end
    // #10; // 30 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #30 after");
    // end
    // #10; // 40 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 1: #20 unit blip @ #40 after");
    // end

    // `TEST_SEPARATION; pin = 1; #20;
    // // 10 units before blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #10 before");
    // end
    // #10; pin = 0; // moment at which blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #0 after");
    // end
    // #10; // 10 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #10 after");
    // end
    // #10; // 20 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #20 after");
    // end
    // #10; // 30 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #30 after");
    // end
    // #10; // 40 units after the rising edge of the blip would appear in the output
    // if(conditioned) begin
    //     dutpassed = 0;
    //     $display("Failed Debouncing Test 2: #30 unit blip @ #40 after");
    // end

    // $finish
    // end

    $dumpfile("inputconditioner.vcd");
    $dumpvars();

    $display("----------------------------------------");
    $display("Test 1: Invalid Regions at Start");
    $display("----------------------------------------");

    signal           <= 50'b00000000000000000000000000000000000000000000000000;
    expected_output  <= 50'bxxxxxxxx000000000000000000000000000000000000000000;
    expected_posedge <= 50'bxxxxxxxx000000000000000000000000000000000000000000;
    expected_negedge <= 50'bxxxxxxxxxx0000000000000000000000000000000000000000;
    integer noise = `{
         9, 12, 11,  9, 10, 10, 12, 10, 10, 11,
         8, 11, 12,  8, 13, 11, 10, 10, 10, 11,
         8, 12, 13, 12,  7, 10,  9, 11, 10,  9,
        10,  8, 13,  9,  9,  9,  8, 10,  7, 10,
         9, 10,  8, 10, 10,  9, 11,  8, 11, 12
    };

    for (i = 0; i < 50; i = i + 1) begin
        pin <= signal[49-i];
        conditioned_output[49-i] <= conditioned;
        conditioned_posedge[49-i] <= rising;
        conditioned_negedge[49-i] <= falling;
        #(noise[i]);
    end

    $display("Original Signal:     %b", signal);
    $display("Conditioned Output:  %b", conditioned_output);
    $display("Expected Output:     %b", expected_output);
    $display("Conditioned Posedge: %b", conditioned_posedge);
    $display("Expected Posedge:    %b", expected_posedge);
    $display("Conditioned Negedge: %b", conditioned_negedge);
    $display("Expected Negedge:    %b", expected_negedge);

    $display("----------------------------------------");
    $display("Test 2: Synchronization and Edge Detection");
    $display("----------------------------------------");

    signal           <= 50'b00111111111100000000001111111111000000000000000000;
    expected_output  <= 50'b00000000000000111111111100000000001111111111000000;
    expected_posedge <= 50'b00000000000000110000000000000000001100000000000000;
    expected_negedge <= 50'b00000000000000000000000011000000000000000000110000;
    for (i = 0; i < 50; i = i + 1) begin
        pin <= signal[49-i];
        conditioned_output[49-i] <= conditioned;
        conditioned_posedge[49-i] <= rising;
        conditioned_negedge[49-i] <= falling;
        #10;
    end

    $display("Original Signal:     %b", signal);
    $display("Conditioned Output:  %b", conditioned_output);
    $display("Expected Output:     %b", expected_output);
    $display("Conditioned Posedge: %b", conditioned_posedge);
    $display("Expected Posedge:    %b", expected_posedge);
    $display("Conditioned Negedge: %b", conditioned_negedge);
    $display("Expected Negedge:    %b", expected_negedge);

    $display("----------------------------------------");
    $display("Test: Debouncing");
    $display("----------------------------------------");

    signal           <= 50'b01000110000001111000000011111111110000000000000000;
    expected_output  <= 50'b00000000000000000000000000000000000011111111110000;
    expected_posedge <= 50'b00000000000000000000000000000000000000000000001100;
    expected_negedge <= 50'b00000000000000000000000000000000000011000000000000;

    for (i = 0; i < 50; i = i + 1) begin
        pin <= signal[49-i];
        conditioned_output[49-i] <= conditioned;
        conditioned_posedge[49-i] <= rising;
        conditioned_negedge[49-i] <= falling;
        #10;
    end

    $display("Original Signal:     %b", signal);
    $display("Conditioned Output:  %b", conditioned_output);
    $display("Expected Output:     %b", expected_output);
    $display("Conditioned Posedge: %b", conditioned_posedge);
    $display("Expected Posedge:    %b", expected_posedge);
    $display("Conditioned Negedge: %b", conditioned_negedge);
    $display("Expected Negedge:    %b", expected_negedge);

    $finish;
    end // initial begin
endmodule
