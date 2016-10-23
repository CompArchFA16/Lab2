`include "finitestatemachine.v"
`include "addresslatch.v"
`include "shiftregister.v"

//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
)

wire miso_buff, dm_we, addr_we, sr_we;

reg [7:0] addr;

finitestatemachine fsm(peripheralClkEdge, conditioned, miso_buff, dm_we, addr_we, sr_we);

shiftregister #(8) sr(clk, peripheralClkEdge, sr_we, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
// fsm ...
addresslatch al(clk, addr_we, parallelDataOut, addr);

datamemory #(7) dm(clk, parallelDataIn, addr, dm_we, parallelDataOut); //may be wrong declaration

endmodule
