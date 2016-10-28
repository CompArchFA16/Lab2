//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps
`include "fsmachine.v"

module testfsm();

    reg read;
    reg con;
    reg rising;  
    reg clk;          
    wire misoBufe;       
    wire dmWe;        
    wire addrWe;            
    wire srWe;   
    
    fsmachine fsm(.clk(clk),
                  .sclk(rising),
                  .cs(con),
                  .rw(read),
                  .misobuff(misoBufe),
                  .dm(dmWe),
                  .addr(addrWe),
                  .sr(srWe));
    initial begin
        clk = 0;
        rising = 0;
    end

    always begin
        #5 clk = ~clk;
    end

    always begin
        #5
        rising = 1;
        #1
        rising = 0;
        #4;
    end


    initial begin 

    $dumpfile("fsm.vcd");
    $dumpvars();

      //writing
      read = 1; 
      con = 0; 
      #130

      //resetting
      con = 1;
      #10

      //reading
      con = 0;
      read = 0;  
      #150

      //resetting
      con = 1;
      #10
      
      con = 0;
      #10

      $finish;
    end

endmodule

