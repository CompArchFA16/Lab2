//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

`include "spimemory.v"

module testspi();

    reg             clk;
    reg             sclk_pin;
    reg             cs_pin;
    wire            miso_pin;
    reg             mosi_pin;
    wire[3:0]       leds;

    spiMemory #(8) dut(.clk(clk), 
    		           .sclk_pin(sclk_pin),
    		           .cs_pin(cs_pin), 
    		           .miso_pin(miso_pin), 
    		           .mosi_pin(mosi_pin), 
    		           .leds(leds));
    

    initial begin
        clk = 0;
        sclk_pin = 0;
    end

    always begin
        #10 clk = ~clk;
        #10 sclk_pin = ~sclk_pin;
    end

    initial begin


        $finish;
    end

endmodule

