`include "spimemory.v"

module test_spimemory
(

);

integer it; // iterator
reg [6:0] addr; // address 
reg [7:0] dummy; // 8-bit dummy register

reg clk = 0;
reg sclk_pin = 0;
reg cs_pin;

reg mosi_pin;
wire miso_pin;
wire [3:0] leds;

spiMemory sm(clk,sclk_pin,cs_pin,miso_pin,mosi_pin,leds);

// fast interal clock
always begin
	#5 clk = !clk;
end

// slow serial clock
always begin
	#150 sclk_pin = !sclk_pin;
	// posedge at 150, 450, ...
	// negedge at 0, 300, ...
end

initial begin
	$dumpfile("spimemory.vcd");
	$dumpvars(0, test_spimemory);

	//cs_pin = 1; // cs_pin de-asserted, nothing should happen
	//for(it = 0; it < 100; it = it+1) begin // check that the state of the fsm stays at GET for 100 clock cycles
	//	#300;
	//	$display("STATE : %b", sm.fsm.state);
	//end

	// WRITE OPERATION BEGIN ...
	
	$display("STATE : %b", sm.fsm.state);

	cs_pin = 1; // waiting arbitrary amount of time
	#750;

	cs_pin = 0; // now, start interacting with the SPI memory
	addr = $urandom % (1 << 7); // dummy is the address

	for(it = 0; it < 7; it = it+1) begin
		mosi_pin <= addr[6-it]; // feed in address in reverse order
		$display("STATE : %b", sm.fsm.state);
		#300;
	end
	
	cs_pin = 0;
	dummy = $urandom % (1 << 8);

	$display("WRITE DATA : %b", dummy);
	mosi_pin <= 0; // "WRITE"
	#300;

	for(it = 0; it < 8; it = it+1) begin
		mosi_pin <= dummy[it]; // feed in data values
		$display("STATE : %b", sm.fsm.state);
		#300;
	end

	#300; // wait one clock cycle for write operation to complete for data memory

	cs_pin = 1; // go back to "get"
	#300;

	// READ OPERATION BEGIN ...
	cs_pin = 0;
	for(it = 0; it < 7; it = it + 1) begin
		mosi_pin <= addr[6-it];
		$display("STATE : %b", sm.fsm.state);
		#300;
	end

	mosi_pin <= 1; // "READ"
	#300; // trigger GOT
	mosi_pin <= 0;
	dummy <= 8'b11111111;
	#150; // rd1
	#300; // 150 delay + read at posedge

	for(it = 0; it < 8; it = it + 1) begin
		$display ("%d", $time);
		$display("-> %b", miso_pin);
		dummy[7 - it] <= miso_pin;
		#300;
	end

	#300;
	$display("READ DATA : %b", dummy);
	$finish();
end

endmodule
