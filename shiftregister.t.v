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


	integer it;

   	always begin
		#10 clk=!clk;    // 50MHz Clock
	end 

	always begin
		#30 peripheralClkEdge = 1;
		#10 peripheralClkEdge = 0;
	end

    initial begin
    	$dumpfile("shiftregister.vcd");
		$dumpvars(0, testshiftregister);
		clk = 0;
		peripheralClkEdge = 0;

    	// Your Test Code
		
		// Test advancing
		for(it=0; it<100; it=it+1) begin
			parallelLoad = 0;
			serialDataIn = $urandom % 2; // get last bit only
			#25; // wait half of clock cycle ... i.e. this should only work half of the time
			$display("%b %b %b", serialDataIn, parallelDataOut, serialDataOut);
		end	
		// Test parallelLoad
		
		$finish();
    end

endmodule

