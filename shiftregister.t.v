`include "shiftregister.v"
//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

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
    
    // Generate clock (50MHz)
    initial clk=0;
    initial peripheralClkEdge=0;
    initial parallelDataIn=8'b10110010;
    //always #10 clk=!clk;    // 50MHz Clock
      
    initial begin
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        $display("parOut   | serOut || Expected");
        clk=1;#10 clk=0;#10 // Have to set the clock

        // Testing parallelLoad
        parallelLoad=1; peripheralClkEdge=1; #10
        clk=1;#10 clk=0;#10
        clk=1;#10 clk=0;#10
        parallelLoad=0;
        $display("%b | %b      || 10110010 | 1", parallelDataOut, serialDataOut);

        // Testing shift register
        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 01100101 | 0", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 11001011 | 1", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=0;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 10010110 | 1", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 00101101 | 0", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=0;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 01011010 | 0", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 10110101 | 1", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 01101011 | 0", parallelDataOut, serialDataOut);

        peripheralClkEdge=1;
        serialDataIn=1;
        clk=1;#10 clk=0;#10
        peripheralClkEdge=0;
        clk=1;#10 clk=0;#10
        $display("%b | %b      || 11010111 | 1", parallelDataOut, serialDataOut);


        // Testing parallel Load again
        parallelLoad=1; peripheralClkEdge=1; #10
        parallelDataIn=8'b11110011;
        clk=1;#10 clk=0;#10
        clk=1;#10 clk=0;#10
        parallelLoad=0;
        $display("%b | %b      || 11110011 | 1", parallelDataOut, serialDataOut);

        $dumpflush;
        $finish;
    end

endmodule

