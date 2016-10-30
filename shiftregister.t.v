//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"
module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn;

    reg pin;
    wire conditioned;
    wire rising;
    wire falling;

    // Instantiate with parameter width = 8
    

    inputconditioner dut(.clk(clk),
             .noisysignal(pin),
             .conditioned(conditioned),
             .positiveedge(rising),
             .negativeedge(falling));

    shiftregister #(8) dut1(.clk(clk), 
           .peripheralClkEdge(peripheralClkEdge),
           .parallelLoad(parallelLoad), 
           .parallelDataIn(parallelDataIn), 
           .serialDataIn(serialDataIn), 
           .parallelDataOut(parallelDataOut), 
           .serialDataOut(serialDataOut));
    
    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    // For this test bench, we have hard-coded in values for 
    // the peripheral clock, for testing purposes.
    // We will eventually hook this up to the input conditioner correctly,
    // see midpoint.v for that setup.
    // We are just using this test bench to test the behavior of the shift register,
    // assuming the inputs from other modules are correct.

    initial begin

        $dumpfile("shiftregister.vcd");
        $dumpvars();

    	// Your Test Code

        $display("CLK PCLK ParallelLoad ParallelDataIn SerialDataIn | ParallelDataOut SerialDataOut");

        //pin =0; #1000 pin = 1; #1000
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 8'b1111000; serialDataIn=1; #110
        $display("Parallel In");
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        parallelDataIn = 8'b10101010; #110
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);


        $display("Serial In");
        peripheralClkEdge = 1; parallelLoad = 0; parallelDataIn = 8'b10101010; serialDataIn=1; #21
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        #20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        #20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        serialDataIn=0;#20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        serialDataIn=1;#20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        #20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        #20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        #20
        $display("%b   %b    %b            %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);


        #50 $finish;
    end


endmodule
