//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

`include "shiftregister.v"
`include "inputconditioner.v"

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

    initial clk = 0;
    always #10 clk =! clk;
    initial begin

        $display("-------------------------");
    	$display("SHIFT REGISTER TEST CASES");
        $display("-------------------------");

        // Test peripheralClkEdge case
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 8'b10101010; serialDataIn = 1; #50
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        // Test parallelLoad case
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut"); #50
        peripheralClkEdge = 1; parallelLoad = 0; parallelDataIn = 8'b10101010; serialDataIn = 1;
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        // Test with both inputs high
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut"); #50
        peripheralClkEdge = 0; parallelLoad = 1; parallelDataIn = 8'b10101010; serialDataIn = 1;
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        $finish;

    end

endmodule

