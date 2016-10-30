`include "spimemory.v"

module testSpiMemory();
   
   reg clk;
   reg sclk_pin;
   reg cs_pin;
   reg mosi_pin;
   wire miso_pin;
   wire [3:0] leds;

   spiMemory spiMem(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, leds);

   initial clk=0;
   always #10 clk=!clk; // 50MHz Clock

   initial begin
      
      $dumpfile("spimemory.vcd");
      $dumpvars();

      cs_pin=1; #1000
      cs_pin=0;

      // Write to address 0101010

      // A6      
      sclk_pin = 0; #1000 
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000
      
      // A5
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A4
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // A3
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A2
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // A1
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A0
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // R/W
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // Write 00000111

      // W7
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // W6
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // W5
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // W4
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // W3
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // W2
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // W1
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // W0
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      cs_pin=1; #10000

      // Read from address 0101010

      cs_pin=1; #1000
      cs_pin=0;

      // A6      
      sclk_pin = 0; #1000 
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000
      
      // A5
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A4
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // A3
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A2
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // A1
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // A0
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000

      // R/W
      sclk_pin = 0; #1000
      mosi_pin = 1; #1000
      sclk_pin = 1; #1000

      // D7
      sclk_pin = 0; #1000
      mosi_pin = 0; #1000
      sclk_pin = 1; #1000      

      // D6
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D5
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D4
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D3
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D2
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D1
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      // D0
      sclk_pin = 0; #1000
      sclk_pin = 1; #1000

      cs_pin=1; #10000

   $finish;
   end // initial begin

endmodule
