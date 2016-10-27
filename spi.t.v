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
     reg [7:0] mosi_h; //8 bit mosi signal that is human readable

    initial begin

        mosi_h <= 8'b_0010_1010;
        clk <= 0;
        sclk_pin <= 0;
        cs_pin <= 0;
    end

    always begin
        #10 clk = ~clk;
            sclk_pin = ~sclk_pin;
    end

    initial begin
        #30 cs_pin = 1;
        #10 mosi_pin = mosi_h[7];
        #10 mosi_pin = mosi_h[6];
        #10 mosi_pin = mosi_h[5];
        #10 mosi_pin = mosi_h[4];
        #10 mosi_pin = mosi_h[3];
        #10 mosi_pin = mosi_h[2];
        #10 mosi_pin = mosi_h[1];
        #10 mosi_pin = mosi_h[0];

        $finish;
    end

endmodule

