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
   
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    integer i;
    reg dutPassed;
    reg[7:0] data;
    initial begin
        $dumpfile("testshiftregister.vcd");
        $dumpvars;

        dutPassed = 1; 

        //First Test Case
        data = 8'b10101010; //arbitrary 
        parallelLoad = 0; //false

        for (i=0; i < 8; i=i+1) begin
            serialDataIn <= data[i];
        end 

        if (parallelDataOut !== data) begin
            dutPassed = 0;
            $display("Serial in, parellel out test pass? %b", dutPassed);
        end
       
        $display("Did all tests pass? %b", dutPassed);
        $finish;
    end

endmodule

