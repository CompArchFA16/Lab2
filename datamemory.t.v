`include "datamemory.v"

module testDataMemory ();
	
	wire[7:0] dataOut;
	reg clk;
	reg [6:0] address;
	reg writeEnable;
	reg [7:0] dataIn;

	datamemory dut (.clk(clk), 
					.dataOut(dataOut), 
					.address(address),
					.writeEnable(writeEnable),
					.dataIn(dataIn));

	initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    reg dutPassed;

	initial begin
		$dumpfile("datamemory.vcd");
        $dumpvars;
		
        dutPassed = 1;

        writeEnable = 1'b1;
        address = 7'b0000011;
        dataIn = 8'b00000001;
        #50;

        if (dataIn !== dataOut) begin
        	dutPassed = 0;
        	$display("dataOut: %d", dataOut);
        	$display("dataIn: %d", dataOut);
        end

        $display("Did all tests pass? %b", dutPassed);
        $finish;
	end
endmodule