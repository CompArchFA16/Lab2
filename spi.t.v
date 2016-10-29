//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

`timescale 1ns / 1ps
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

     reg [7:0] data; //8 bit mosi signal that is human readable
     reg [7:0] dataout; //retrieved data
     reg [7:0] addr1r; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr1w; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr2; //8 bit address (but only uses [6:0]) 
     reg [3:0] i;

    initial begin

        data <= 8'b_0_111_1111q1101110; //data written in address
        addr1r <= 8'b_1_111_1111; //read address
        addr1w <= 8'b_0_111_1111; //write address
        addr2 <= 8'b_0_011_1100;
        dataout <=0; //data attained from address
        clk <= 0;
        sclk_pin <= 0;
        cs_pin <= 0;
        mosi_pin <=0;
    end

    always begin
        #1   clk = ~clk;
    end

    always begin
        #50    sclk_pin = ~sclk_pin;
    end

    initial begin

        $dumpfile("spi.vcd");
        $dumpvars();

        cs_pin = 1;
        #1000

        //store data into address1
        cs_pin = 0;

        //address1
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr1w[7-i]; 
               #100;
            end

        //write data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
              mosi_pin <= data[7-i];
              #100;
            end



//        //store data into address2
//        cs_pin = 1;
//        #200
//
//        cs_pin = 0;
//
//        //address2
//        for (i = 0; i < 8; i = i + 1)
//            begin
//               mosi_pin <= addr2[i]; 
//               #100;
//            end
//
//        //write
//        mosi_pin = 0; //8th bit decides read or write, 1 = read, 0 = write
//        #200
//
//        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
//            begin
//              mosi_pin <= data[i];
//              #100;
//            end


        //get data from address 1
        mosi_pin = 0;
        cs_pin = 1;
        #20

        cs_pin = 0;

        //address1
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr1r[7-i]; 
               #100;
            end


        //read data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
                $display("%b", miso_pin);
                dataout[i] <= miso_pin;
                #100;
            end
        $finish;
    end

endmodule
