`include "finitestatemachine.v"
`include "addresslatch.v"
`include "shiftregister.v"
`include "dflipflop.v"
`include "inputconditioner.v"
`include "datamemory.v"
`include "misobuffer.v"

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
);

  wire miso_buff, dm_we, addr_we, sr_we;
  wire mosi_conditioned, sclk_conditioned, cs_conditioned;
  wire mosi_posedge, sclk_posedge, cs_posedge;
  wire mosi_negedge, sclk_negedge, cs_negedge;
  wire [7:0] parallelDataIn, parallelDataOut;
  wire serialDataOut, dffOut;

  reg [6:0] addr;
  wire [6:0] addrOut;

  // mosi inputconditioner
  inputconditioner mosi(clk, mosi_pin, mosi_conditioned, mosi_posedge, mosi_negedge);

  // sclk inputconditioner
  inputconditioner sclk(clk, sclk_pin, sclk_conditioned, sclk_posedge, sclk_negedge);

  // cs inputconditioner
  inputconditioner cs(clk, cs_pin, cs_conditioned, cs_posedge, cs_negedge);

  // Finite State Machine
  finitestatemachine fsm(clk, sclk_posedge, cs_conditioned, parallelDataOut[0], miso_buff, dm_we, addr_we, sr_we);

  // Shift Register
  shiftregister #(8) sr(clk, sclk_posedge, sr_we, parallelDataIn, mosi_conditioned, parallelDataOut, serialDataOut);

  // Address Latch
  addresslatch al(clk, addr_we, parallelDataOut[7:1], addrOut);

  // Data memory
  datamemory dm(clk, parallelDataIn, addrOut[6:0], dm_we, parallelDataOut); //may be wrong declaration

  // D Flip Flop
  dff dff(clk, sclk_negedge, serialDataOut, dffOut);

  // miso buffer
  misobuffer mb(dffOut, miso_buff, miso_pin);
  //assign miso_pin = 1'b1;
endmodule
