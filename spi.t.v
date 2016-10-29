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

     reg [7:0] data1; //8 bit mosi signal that is human readable
     reg [7:0] data2; //8 bit mosi signal that is human readable
     reg [7:0] dataout; //retrieved data
     reg [7:0] addr1r; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr1w; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr2r; //8 bit address (but only uses [6:0]) 
     reg [7:0] addr2w; //8 bit address (but only uses [6:0]) 
     reg [3:0] i;

    initial begin

        data1 <= 8'b_0101_0101; //data written in address
        data2 <= 8'b_1100_1100; //data written in address
        addr1r <= 8'b_1_111_1100; //read address
        addr1w <= 8'b_0_111_1100; //write address
        addr2r <= 8'b_1_100_1111; //read address
        addr2w <= 8'b_0_100_1111; //write address
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

        //Test Case 1: Testing Writing and Reading

        //Write data1 into address1
        cs_pin = 1;
        #1000

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
              mosi_pin <= data1[7-i];
              #100;
            end



        //Write data2 to address2
        mosi_pin = 0;
        cs_pin = 1;
        #1000

        //store data into address2
        cs_pin = 0;

        //address1
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr2w[7-i]; 
               #100;
            end

        //write data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
              mosi_pin <= data2[7-i];
              #100;
            end




        //get data1 from address 1
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


        if (dataout == data1) begin
            $display("Test Case 1 part 1 Passed: Got data1 from address1");
        end 
        else begin
            $display("Test Case 1 part 1 Failed:  Write and reading not working");
        end



        //get data2 from address 2
        mosi_pin = 0;
        cs_pin = 1;
        #20

        cs_pin = 0;

        //address2
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr2r[7-i]; 
               #100;
            end


        //read data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
                $display("%b", miso_pin);
                dataout[i] <= miso_pin;
                #100;
            end


        if (dataout == data2) begin
            $display("Test Case 1 part 2 Passed: Got data2 from address2");
        end 
        else begin
            $display("Test Case 1 part 2 Failed:  Write and reading not working");
        end




        //Test Case 2: Overwriting data to address

        //Overwrite data2 to address1
        mosi_pin = 0;
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
              mosi_pin <= data2[7-i];
              #100;
            end



        //get data2 from address 1
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


        if (dataout == data2) begin
            $display("Test Case 2 Passed: Successfully verwrote data in address1");
        end 
        else begin
            $display("Test Case 2 Failed: Overwriting failed");
        end


        //Test Case 3: Reading repeatedly from 1 address

        //get data2 from address 2
        mosi_pin = 0;
        cs_pin = 1;
        #20

        cs_pin = 0;

        //address2
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr2r[7-i]; 
               #100;
            end


        //read data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
                $display("%b", miso_pin);
                dataout[i] <= miso_pin;
                #100;
            end


        if (dataout == data2) begin
            $display("Test Case 3 Passed: Read data2 from address2 once");
        end 
        else begin
            $display("Test Case 3 Failed");
        end

        //get data2 from address 2 again
        mosi_pin = 0;
        cs_pin = 1;
        #20

        cs_pin = 0;

        //address2
        for (i = 0; i < 8; i = i + 1)
            begin
               mosi_pin <= addr2r[7-i]; 
               #100;
            end


        //read data
        for (i = 0; i < 8; i = i + 1) // Turns data into serial signal
            begin
                $display("%b", miso_pin);
                dataout[i] <= miso_pin;
                #100;
            end


        if (dataout == data2) begin
            $display("Test Case 3 Passed: Read data2 from address2 twice");
        end 
        else begin
            $display("Test Case 3 Failed");
        end

        $finish;
    end

endmodule
