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
    always #10 clk=!clk;    // 50MHz Clock
      
    initial begin
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        parallelDataIn = 5'd5;
        parallelLoad = 1;
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        parallelDataIn = 5'd5;
        parallelLoad = 0;
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10


        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        serialDataIn = 1; #500
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        serialDataIn = 0; #500
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        serialDataIn = 1; #500
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        serialDataIn = 0; #500
        peripheralClkEdge=0;#500
        peripheralClkEdge=1;#10
        serialDataIn = 1; #500

        $dumpflush;
        $finish;
    end

endmodule

