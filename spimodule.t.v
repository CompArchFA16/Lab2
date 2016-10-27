//------------------------------------------------------------------------
// SPI test bench
//------------------------------------------------------------------------
`include "spimemory.v"
module spimodule();

    reg clk;
    reg sclk;
    reg cs_pin;
    wire miso_pin;
    reg mosi_pin;
    wire[7:0] leds; //4 LED's


    // Instantiate with parameter width = 8
    
    // Make the input conditioner module

    spiMemory dut(clk, sclk, cs_pin, miso_pin, mosi_pin, leds);

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin

        $dumpfile("spi.vcd");
        $dumpvars();

    	// Your Test Code

        $display("CLK SCLK CS MOSI | MISO LEDs");
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        ///////// set address
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        //#1000
        //sclk = 0; cs_pin = 0; mosi_pin = 0;

        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);

        //////// write
        $display("write");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        //#1000
        //sclk = 0; cs_pin = 0; mosi_pin = 0;
        //$display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);

        ///////// set address
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;

        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("address");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        //#1000
        //sclk = 0; cs_pin = 0; mosi_pin = 1;

        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);


        //////// read
        $display("read");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b %b", clk, sclk, cs_pin, mosi_pin, miso_pin, leds);


        #50 $finish;
    end


endmodule
