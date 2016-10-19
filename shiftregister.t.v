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

    initial begin
    	// Your Test Code

        $display("CLK PCLK ParallelLoad ParallelDataIn SerialDataIn | ParallelDataOut SerialDataOut");

        //pin =0; #1000 pin = 1; #1000
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 8'b10101010; serialDataIn=1; #1000
        $display("%b   %b    %b             %b      %b            | %b        %b  ", clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);


        #50 $finish;
    end


endmodule
