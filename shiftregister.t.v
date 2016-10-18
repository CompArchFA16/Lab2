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
    

    inputconditioner dut(.clk(clk),
             .noisysignal(pin),
             .conditioned(conditioned),
             .positiveedge(rising),
             .negativeedge(falling));

    shiftregister #(8) dut1(.clk(clk), 
           .peripheralClkEdge(rising),
           .parallelLoad(parallelLoad), 
           .parallelDataIn(parallelDataIn), 
           .serialDataIn(serialDataIn), 
           .parallelDataOut(parallelDataOut), 
           .serialDataOut(serialDataOut));
    
    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
    	// Your Test Code

        $display("CLK PCLK ParallelLoad ParalleDataIn SerialDataIn | ParallelDataOut SerialDataOut");

        //pin =0; #1000 pin = 1; #1000
        //$display("Pin  CLK   | Ris Fall  Condit  |  Expected outcome");
        //$display("%b  %b  | %b  %b  %b  | %b  %b  %b ", pin, clk,  rising, falling, conditioned, 0,0,0);


        #50 $finish;
    end


endmodule
