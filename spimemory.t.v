`include "spimemory.v"

module test_spimemory
(

);

integer it; // iterator
reg [6:0] addr; // address 
reg [7:0] dummy; // 8-bit dummy register

reg clk, sclk_pin, cs_pin;
reg miso_pin, mosi_pin;
reg [3:0] leds;

spiMemory sm(clk,sclk_pin,cs_pin,miso_pin,mosi_pin,leds);

// global clock
always begin
	#10 clk = !clk;
end

// serial clock
always begin
	#15 sclk_pin = !sclk_pin;
end

initial begin
	$dumpfile("spimemory.vcd");
	$dumpvars(0, test_spimemory);

	cs_pin = 1; // cs_pin de-asserted, nothing should happen
	for(it = 0; it < 100; it = it+1) begin // check that the state of the fsm stays at GET for 100 clock cycles
		#30;
		$display("STATE : %b", sm.fsm.state);
	end


	cs_pin = 0; // now, start interacting with the SPI memory
	addr = $urandom % (1 << 7); // dummy is the address

	for(it = 0; it < 7; it = it+1) begin
		mosi_pin <= addr[it]; // feed in address
		$display("STATE : %b", sm.fsm.state);
		#30;
	end


	// WRITE OPERATION BEGIN ...
	dummy = $urandom % (1 << 8);

	$display("WRITE DATA : %b", dummy);
	mosi_pin <= 0; // "WRITE"
	#30;

	for(it = 0; it < 8; it = it+1) begin
		mosi_pin <= dummy[it]; // feed in data values
		$display("STATE : %b", sm.fsm.state);
		#30;
	end

	#30; // wait one clock cycle for write operation to complete for data memory

	cs_pin = 1; // go back to "get"
	#30;

	// READ OPERATION BEGIN ...
	cs_pin = 0;
	for(it = 0; it < 7; it = it + 1) begin
		mosi_pin <= addr[it];
		$display("STATE : %b", sm.fsm.state);
		#30;
	end

	mosi_pin <= 1; // "READ"
	#30; // wait one clock cycle to read from data memory

	#30; // wait one clock cycle to write to shift register

	for(it = 0; it < 8; it = it + 1) begin
		dummy[7 - it] <= miso_pin;
		#30;
	end

	#30;

	$display("READ DATA : %b", dummy);
end

endmodule
