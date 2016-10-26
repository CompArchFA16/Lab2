`include "spimemory.v"

module testSpimemory();
    
    reg clk, sclk_pin, cs, mosi_pin;
    wire miso_pin;
    wire [3:0] leds;

    spiMemory spi0(clk, sclk_pin, cs, miso_pin, mosi_pin, leds);

    initial clk=0;
    initial sclk_pin=0;
    always #50 clk=!clk;

    initial begin
        $dumpfile("spimemory.vcd");
        $dumpvars();

        cs=1;#100

        cs=0;

        // ADDR 6
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 5
        mosi_pin=0;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 4
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 3
        mosi_pin=0;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 2
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 1
        mosi_pin=0;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // ADDR 0
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // R/W? 
        mosi_pin=0;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 7
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 6
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 5
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 4
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 3
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 2
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 1
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        // Write 0
        mosi_pin=1;#100
        sclk_pin=1;#1000
        sclk_pin=0;#1000

        cs=1;

        $finish;
        $dumpflush;
    end

endmodule
