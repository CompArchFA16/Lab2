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
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    
    initial begin

        $display("-------------------------");
    	$display("SHIFT REGISTER TEST CASES");
        $display("-------------------------");

        // Test peripheralClkEdge case
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 0; parallelDataIn = 00000000; serialDataIn = 0;
        $display(" %b  %b  |  %b  %b  |  %b  %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        // Test parallelLoad case
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 00000000; serialDataIn = 0;
        $display(" %b  %b  |  %b  %b  |  %b  %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        // Test with both inputs high
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 00000000; serialDataIn = 0;
        $display(" %b  %b  |  %b  %b  |  %b  %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        



    end

endmodule

