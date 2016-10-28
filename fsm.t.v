//------------------------------------------------------------------------
// Finite State Machine test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps
`include "fsmachine.v"

module fsm();

    reg r;  
    reg c;
    reg peripheralClkEdge;  
    reg clk;          
    wire MISO_BUFF;       
    wire DM_WE;        
    wire ADDR_WE;            
    wire SR_WE;             

    fsmachine dut(.clk(clk),
    		           .sclk(peripheralClkEdge),
    		           .rw(r),
    		           .cs(c),
    		           .misobuff(MISO_BUFF),
    		           .dm(DM_WE),
                       .addr(ADDR_WE),
    		           .sr(SR_WE));
    initial begin
    clk = 0;
    peripheralClkEdge = 1;
    end

    always begin
    #5 clk <= ~clk;
    end

//    always begin
//    peripheralClkEdge = 1; #3;
//    peripheralClkEdge = 0; #7;
//    end

    initial begin
    	// Your Test Code
        $dumpfile("fsm.vcd");
        $dumpvars();

        r = 1; 
        c = 0; 
        #150

        c = 0;
        r = 0;
        #150

        c = 0;
        r = 1;  
        #150  


        #10 $finish;
    end

endmodule