//------------------------------------------------------------------------
// Midpoint test bench
//------------------------------------------------------------------------
`include "midpoint.v"
module testshiftregister();

    reg clk;
    reg button0;
    reg switch0;
    reg switch1;
    wire serialOut;
    wire[7:0] leds; //4 LED's

    reg [7:0] parallelDataIn;

    // Instantiate with parameter width = 8
    
    // Make the input conditioner module
    midpoint dut(.button0(button0),
             .switch0(switch0),
             .switch1(switch1),
             .clk(clk),
             .parallelDataIn(parallelDataIn),
             .serialOut(serialOut),
             .leds(leds));

    
    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock


    initial begin

        $dumpfile("midpoint.vcd");
        $dumpvars();

    	// Your Test Code

        $display("CLK BT0 SW0 SW1 Parallel | SerialOut LEDs");
        #10
        button0 = 1; switch0 = 1; switch1 = 0; parallelDataIn = 8'b10101010;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
         #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
         #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        button0 = 1; switch0 = 1; switch1 = 0;
        #100
        button0 = 1; switch0 = 1; switch1 = 1;
        #100
        $display("%b   %b   %b    %b  %h       | %b         %h  ", clk, button0, switch0, switch1, parallelDataIn, serialOut, leds);


        button0 = 1; switch0 = 1; switch1 = 0; parallelDataIn = 8'b10101010; #110
        $display("%b   %b   %b    %b  %h       | %b         %h  ", clk, button0, switch0, switch1, parallelDataIn, serialOut, leds);



        #50 $finish;
    end


endmodule
