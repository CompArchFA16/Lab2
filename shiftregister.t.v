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

        //First Test Case - Serial Data In, Parallel Data Out
        data = 8'b10101010; //arbitrary 
        parallelLoad = 0; //false

        peripheralClkEdge = 0;

        for (i=0; i < 8; i=i+1) begin
            serialDataIn <= data[7-i];

            #60;
            peripheralClkEdge <= !peripheralClkEdge;
            #20;
            peripheralClkEdge <= !peripheralClkEdge;
            #20;
            // $display("serial data: %b", serialDataIn);
        end 

        if (parallelDataOut !== data) begin
            dutPassed = 0;
            $display("Serial in, parallel out test failed.");
            $display("Parallel data out: %b", parallelDataOut);
            $display("paralleldataout %b", parallelDataOut);
            $display("data %b", data);
        end



        //Second Test Case - Parallel Data In, Serial Data Out
        data = 8'b11111111;
        parallelLoad = 1;
        parallelDataIn <= data;

        #50;
        $display("parallelDataIn: %b", parallelDataIn);
        $display("parallelDataOut: %b", parallelDataOut);


        for (i=0; i < 8; i=i+1) begin

            if (serialDataOut !== data[i]) begin
                dutPassed = 0;
                $display("Parallel in, serial out failed.");
                $display("serial data out: %b", serialDataOut);
            end
            
            $display("serial data out: %b", serialDataOut);
            #60;
            peripheralClkEdge <= !peripheralClkEdge;
            #20;
            peripheralClkEdge <= !peripheralClkEdge;
            #20;
        end 
    
        // Test Case 3: Parallel In, Parallel Out
        
        parallelDataIn = 8'b10100101;
        parallelLoad = 1;

        #50;

        $display("parallelDataIn: %b", parallelDataIn);
        $display("parallelDataOut: %b", parallelDataOut);

        if (parallelDataOut !== parallelDataIn) begin
            dutPassed = 0;
            $display("Parallel in, parallel out test failed.");
        end

        $display("Did all tests pass? %b", dutPassed);
        $finish;
    end


endmodule

