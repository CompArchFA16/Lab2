`include "spimemory.v"

module test_spimemory
(

);

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

end

endmodule
