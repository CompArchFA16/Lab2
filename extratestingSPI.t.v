//EXTRAS of the test bench
/*This module does extra testing to ensure the SPI memory design is robust*/

`include "spimemory.v"
module spimodule();

    reg clk;
    reg sclk;
    reg cs_pin;
    wire miso_pin;
    reg mosi_pin;
    wire[7:0] leds; //4 LED's

    spiMemory dut(clk, sclk, cs_pin, miso_pin, mosi_pin, leds);

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin

        $dumpfile("extraspi.vcd");
        $dumpvars();

        // TEST CASE 1: Does it write if chip select is high?
        $display("Chip select high while writing");
        $display("CLK SCLK CS MOSI | MISO ");
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
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //////// write
        $display("write");
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //TEST CASE 2: DOES IT READ WHEN CHIP SELECT IS HIGH?
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
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //////// read
        $display("read");
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //TEST CASE 3: WRITE TO 1 ADDRESS, WRITE TO ANOTHER ADDRESS
        // READ FROM SECOND ADDRESS, READ FROM FIRST ADDRESS
        //AND BONUS: USE AN ADDRESS THAT HAS 1'S IN THE MSB&LSB.

        ///////// set first address

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
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //////// write to first address
        $display("write");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //intermediate
        #1000;
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000;
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000;

        ///////// set 2nd address
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
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
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //////// write
        $display("write");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //intermediate
        #1000;
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000;
        sclk = 0; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000
        sclk = 1; cs_pin = 1; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );
        #1000;

        //read from first address
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
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
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin );

        //////// read
        $display("read");
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 1;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 1; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);
        #1000
        sclk = 0; cs_pin = 0; mosi_pin = 0;
        $display("%b   %b   %b    %b    | %b ", clk, sclk, cs_pin, mosi_pin, miso_pin);

        #50 $finish;
    end


endmodule
