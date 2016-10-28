//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

`include "fsmachine.v"

module testshiftregister();

    reg             clk;
    reg             rising;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    
    fsmachine fsm(.clk(clk),
                  .sclk(rising),
                  .cs(conditioned_cs),
                  .rw(parallelDataOut[0]),
                  .misobuff(misoBufe),
                  .dm(dmWe),
                  .addr(addrWe),
                  .sr(srWe));
    initial begin
        clk = 0;
        rising = 0;
    end

    always begin
        #10 clk = ~clk;
        rising = ~rising;
    end

    initial begin
       

        $finish;
    end

endmodule

