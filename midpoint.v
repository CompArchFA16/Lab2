`include "shiftregister.v"
`include "inputconditioner.v"

module midpoint
(
input 	    clk, 
input 		peripheralClk,           
input	    noisysignal,    
output reg  parallelOut,    
output reg  serialOut       
);

	wire positiveedge, negativeedge, conditioned;
	reg parallelIn;

	initial clk=0;
    always #10 clk=!clk;  

    inputconditioner conditioner1(conditioned, pe1, 
    	ne1, clk, noisysignal);

    inputconditioner conditioner2(c2, positiveedge, 
    	ne2, clk, noisysignal);

    inputconditioner conditioner3(c3, pe2, 
    	negativeedge, clk, noisysignal);
    

    shiftregister register(parallelOut, serialOut, clk, peripheralClk, 
    	negativeedge, parallelIn, conditioned);
endmodule
