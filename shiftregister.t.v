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
        clk = 0;
    end

    always begin
        #10 clk = ~clk;
    end

    initial begin
        peripheralClkEdge = 0;
        parallelLoad = 0;
        parallelDataIn = 8'd0;
        serialDataIn = 0;

        //Test Case 1: setting to 0
        parallelLoad = 1;
        #40

        if (parallelDataOut == 8'd0 && serialDataOut == 0) begin
            $display("Test Case 1 Passed: everything are set to 0");
        end
        else begin
            $display("Test Case 1 Failed");
        end


        //Testing parallel operation
        //Test Case 2: Parallel Operation On
        parallelLoad = 1; //parallel operation on
        parallelDataIn = 8'd10;
        #40;
        if (parallelDataOut == 8'd10) begin
            $display("Test Case 2 Passed: parallel operation is functioning");
        end
        else begin
            $display("Test Case 2 Failed");
        end

        //Test Case 3: Parallel Operation Off
        parallelLoad = 0;
        parallelDataIn = 8'd64; //01000000
        #40;
        if (parallelDataOut == 8'd10) begin
            $display("Test Case 3 Passed: parallel operation is functioning");
        end
        else begin
            $display("Test Case 3 Failed");
        end


        //Testing serial operation
        //Test Case 4: Series Operation On
        parallelLoad = 1;
        parallelDataIn = 8'd1; //00000001
        peripheralClkEdge = 0;
        #40
        parallelLoad = 0;
        peripheralClkEdge = 1; //Serial Operation on
        serialDataIn = 1;
        #20;
        serialDataIn = 0;
        #20
        if (serialDataOut == 0 && parallelDataOut == 8'd6) begin //00000110
            $display("Test Case 4 Passed: serial operation is functioning");
        end
        else begin
            $display("Test Case 4 Failed");
        end

        //Test Case 5: Series Operation Off
        peripheralClkEdge = 0; //Serial Operation off
        serialDataIn = 0;
        #20;
        if (serialDataOut == 0 && parallelDataOut == 8'd6) begin
            $display("Test Case 5 Passed: serial operation is functioning");
        end
        else begin
            $display("Test Case 5 Failed");
        end


        //Both operations are on
        parallelLoad = 1;
        peripheralClkEdge = 0;
        parallelDataIn = 8'd128; //10000000
        serialDataIn = 0;
        #40;
        //parallelLoad & peripheralClkEdge are on
        parallelLoad = 1;
        peripheralClkEdge = 1;
        parallelDataIn = 8'd0;
        serialDataIn = 1;
        #100

        if (parallelDataOut != 8'd128 || serialDataOut != 1) begin
            $display("Test Case 6 Failed");
        end
        else begin
            $display("Test Case 6 Passed: both operations are ignored");
        end

        $finish;
    end

endmodule

