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
     reg [3:0] i;

    initial begin

    $dumpfile("spi.vcd");
    $dumpvars(0, dut);
        mosi_h <= 8'b_0010_1000;
        clk <= 0;
        sclk_pin <= 0;
        cs_pin <= 0;
    end

    always begin
        #5   clk = ~clk;
    end
    always begin
        #50    sclk_pin = ~sclk_pin;
    end

    initial begin
        #10 cs_pin = 1;
        #30 cs_pin = 0;
    for (i = 7; i > 0; i = i - 1) // Turns mosi_h into serial signal
        begin
           mosi_pin <= mosi_h[i];
           #100;
        end
            mosi_pin = 1; //8th bit decides read or write, 1 = read, 0 = write

        //#100 cs_pin = 1;
        #100  mosi_pin = 0;

    for (i = 7; i > 0; i = i - 1) // Turns mosi_h into serial signal
        begin
          mosi_pin <= mosi_h[i];
          #300;
        end

        mosi_pin = 0;
        #10;

        $finish;
    end

endmodule
