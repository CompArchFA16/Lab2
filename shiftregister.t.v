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

        // Parallel in, serial out
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 0; parallelLoad = 1; parallelDataIn = 8'b10101010; serialDataIn = 1; #100
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
       
        // Serial in, parallel out
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 0; parallelDataIn = 8'b10101010; serialDataIn = 1; #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); #20
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        // Parallel in, serial out
        $display("peripheralClkEdge parallelLoad | parallelDataIn serialDataIn | parallelDataOut serialDataOut");
        peripheralClkEdge = 1; parallelLoad = 1; parallelDataIn = 8'b00000000; serialDataIn = 1; #100
        $display("        %b              %b       |    %b          %b      |    %b           %b ", peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        $finish;

    end

endmodule

