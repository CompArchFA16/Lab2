`include "inputconditioner.v"
`include "shiftregister.v"
`include "fsm.v"
`include "datamemory.v"

//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module dff
(
    input d,
    input ce,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        if (ce == 1) begin
            q <= d;
        end
    end
endmodule

module dff8bit
(
    input [7:0] d,
    input ce,
    input clk,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (ce == 1) begin
            q <= d;
        end
    end
endmodule

module bufferSwitch
(
    input in,
    input enable,
    output out
);
    wire out;
    assign out = (enable) ? in : 1'bz;
   //out <= (enable) ? in : 1'bz;
   /*
   always @(enable) begin
       out <= 1'bz;
   end
   */

endmodule

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
);
    
    wire [2:0] rising, falling, conditioned;
    wire [7:0] parallelOut, parallelIn;
    wire serialOut, parallelLoad;
    wire [7:0] address;
    wire addre_we, dm_we, miso_bufe, sr_we;

	inputconditioner mosiIC(clk, mosi_pin, conditioned[0], rising[0], falling[0]);
	inputconditioner sclkIC(clk, sclk_pin, conditioned[1], rising[1], falling[1]);
	inputconditioner csIC(clk, cs_pin, conditioned[2], rising[2], falling[2]);

    shiftregister shifreg(clk, rising[1], parallelLoad, parallelIn, conditioned[0], parallelOut, serialOut);

    // DFF & MISO_BUFE
    wire miso_pin_pre_buffer;
    dff dff0(serialOut, falling[1], clk, miso_pin_pre_buffer);
    bufferSwitch buffswitch0(miso_pin_pre_buffer, miso_bufe, miso_pin);

    // Memory
    datamemory memory0(clk, parallelIn, address, dm_we, parallelOut);
    dff8bit dff1(parallelOut, addre_we, clk, address);

    // FSM
    fsm fsm0(rising[1], conditioned[2], parallelOut[0], miso_bufe, dm_we, addre_we, sr_we);

endmodule
   
