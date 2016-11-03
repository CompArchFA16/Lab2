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

    $dumpfile("inputconditioner.vcd");
    $dumpvars();

    $display("----------------------------------------");
    $display("Test 1: Invalid Regions at Start");
    $display("----------------------------------------");

    signal           <= 50'b00000000000000000000000000000000000000000000000000;
    expected_output  <= 50'bxxxxxxxx000000000000000000000000000000000000000000;
    expected_posedge <= 50'bxxxxxxxx000000000000000000000000000000000000000000;
    expected_negedge <= 50'bxxxxxxxxxx0000000000000000000000000000000000000000;

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
