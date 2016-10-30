//------------------------------------------------------------------------
// SPI memory test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

module spimemory_test();
    // SPI I/O pins
    reg clk;
    reg sclk_pin;
    reg cs_pin;
    wire miso_pin;
    reg mosi_pin;
    wire[3:0] leds;

    // Instantiate module
    spiMemory dut(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, leds);

    // SCLK triggers every N clock cycles
    reg sclk_counter = 0; parameter N = 10;
    always begin
        #1 clk <= ~clk;
    end

    always begin
        #10 sclk_pin <= ~sclk_pin;
    end

    initial begin
    	// Your Test Code
        $dumpfile("spimemory.vcd");
        $dumpvars();

        // Initial Conditions time = 0
        clk=1; sclk_pin=0;

        // Test 1: CS is high --> output is suppressed
        cs_pin = 1; #100
        if (miso_pin != 1'bz) begin
          $display("CS check failed");
        end

        // Test 2: Write 8'b11001010 to address 7'b1010101
        cs_pin = 0;   #5

        // Address
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20

        // Read? = nope
        mosi_pin = 0; #20

        // Value
        mosi_pin = 1; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20

        // Test 2: Read from address 7'b1010101
        cs_pin = 1; #105
        cs_pin = 0;

        // Address
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20
        mosi_pin = 0; #20
        mosi_pin = 1; #20

        // Read? = yes
        mosi_pin = 1; #20

        // Wait...
        #200

        #10 $finish;
    end

endmodule
