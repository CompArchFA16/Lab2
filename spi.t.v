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
     reg [7:0] addr1; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr2; //8 bit address (but only uses [6:0]) 
     reg [3:0] i;

    initial begin

        data <= 8'b_1100_1111;
        addr1 <= 8'b_0_011_0011;
        addr2 <= 8'b_0_011_1100;
        dataout <=0;
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
        #200

        //store data into address1
        cs_pin = 0;

        //address1
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr1[i]; 
               #100;
            end

        //write
        mosi_pin = 0; //8th bit decides read or write, 1 = read, 0 = write
        #20

        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
              mosi_pin <= data[i];
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
        cs_pin = 1;
        #20

        cs_pin = 0;

        //address1
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr1[i]; 
               #100;
            end

        //read
        mosi_pin = 1; //8th bit decides read or write, 1 = read, 0 = write
        #20;
        #20;


        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
                $display("%b", miso_pin);
                dataout[i] <= miso_pin;
                #100;
            end

        $finish;
    end

endmodule
