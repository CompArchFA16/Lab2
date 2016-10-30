//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

`include "shiftregister.v"

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    reg             dutpassed;
    reg             endtest;

    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    always begin
    #1 clk = ~clk;
    //#6 peripheralClkEdge= ~peripheralClkEdge;
    end

    initial begin
    	// Your Test Code
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        // Initial test flags
        endtest = 0;
        dutpassed = 1;

        
        
        clk=1; 
        
        peripheralClkEdge=0;
        parallelLoad=0; parallelDataIn=8'b00010000; serialDataIn=1;#3
        // Verify expectations and report test result
          if((parallelDataOut != 8'bxxxxxxxx) || (serialDataOut != 1'bx)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 1 Failed(?): Out test assumes initial state of shift reg memory is full of x's");
          end
          else begin
            $display("Test Case 1 Passed: Initialization Successful");
          end

        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  xxxxxxxx   x",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        

        parallelLoad=0; parallelDataIn=8'b00010000; serialDataIn=1;#1
        peripheralClkEdge=1;#1
        // Verify expectations and report test result
          if((parallelDataOut != 8'bxxxxxxx1) || (serialDataOut != 1'bx)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 2 Failed(?): Loading 1 to lsb of shift register failed");
          end
          else begin
            $display("Test Case 2 Passed: loading 1 to lsb of shift register Successful");
          end

        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  xxxxxxx1   x",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        peripheralClkEdge = 0; #1

        parallelLoad=1;#2
        // Verify expectations and report test result
          if((parallelDataOut != 8'b00010000) || (serialDataOut != 1'b0)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 3 Failed: parallelLoad function may have problem");
          end
          else begin
            $display("Test Case 3 Passed: parallelLoad works!");
          end

        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  00010000   0",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

        parallelLoad = 0; #2
                // Verify expectations and report test result
          if((parallelDataOut != 8'b00010000) || (serialDataOut != 1'b0)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 4 Failed: parallelLoad is off, but should still have previous value");
          end
          else begin
            $display("Test Case 4 Passed: parallelLoad is off, and we are still holding previous value");
          end
        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  00010000   0",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); 

        parallelLoad=0; serialDataIn=1;#8
        peripheralClkEdge = 1; #1
                // Verify expectations and report test result
          if((parallelDataOut != 8'b00100001) || (serialDataOut != 1'b0)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 5 Failed: unsuccessfully shifted and inputted 1 to lsb");
          end
          else begin
            $display("Test Case 5 Passed: successfully shifted and inputted 1 to lsb");
          end
        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  00100001   0",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        peripheralClkEdge = 0; #1
        
        parallelLoad=0; parallelDataIn=8'b11110000; serialDataIn=0; #10 
        peripheralClkEdge = 1; #1
                        // Verify expectations and report test result
          if((parallelDataOut != 8'b01000010) || (serialDataOut != 1'b0)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 6 Failed: unsuccessfully shifted and inputted 0 to lsb");
          end
          else begin
            $display("Test Case 6 Passed: successfully shifted and inputted 0 to lsb");
          end
        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  01000010   0",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        peripheralClkEdge =0; #1
        
        parallelLoad=1; parallelDataIn=8'b11110000; serialDataIn=1; #10 
        peripheralClkEdge = 1; #1
    // Verify expectations and report test result
          if((parallelDataOut != 8'b11110000) || (serialDataOut != 1'b1)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 7 Failed: conflicts when shifting & ploading at same time. Ploading should have priority to shifting.");
          end
          else begin
            $display("Test Case 7 Passed: successfully ploaded despite shift being raised as well");
          end
        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  11110000   1",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        
        peripheralClkEdge = 0; #1
        parallelLoad=0; parallelDataIn=8'b11110000; serialDataIn=1; #2
        peripheralClkEdge = 1; #1
            // Verify expectations and report test result
          if((parallelDataOut != 8'b11100001) || (serialDataOut != 1'b1)) begin
            dutpassed = 0;  // Set to 'false' on failure
            $display("Test Case 8 Failed: Shifting with lsb input 1 did not work");
          end
          else begin
            $display("Test Case 8 Passed: Shifting with lsb input 1 worked");
          end
        $display("  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        $display("    %b   |   %b   |   %b   |   %b    |   %b    |  11100001   1",  parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        peripheralClkEdge = 0; #1

        $display("dutpassed: %b",  dutpassed);

        #5 endtest = 1;
        #10 $finish;
    end

endmodule
