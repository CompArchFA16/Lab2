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
    
    wire mosi_rising, mosi_falling, mosi_conditioned;
    wire sclk_rising, sclk_falling, sclk_conditioned;
    wire cs_rising, cs_falling, cs_conditioned;
    wire [7:0] parallelOut, parallelIn;
    wire serialOut, parallelLoad;
    wire [7:0] address;
    wire addre_we, dm_we, miso_bufe, sr_we;

	inputconditioner mosiIC(clk, mosi_pin, mosi_conditioned, mosi_rising, mosi_falling);
	inputconditioner sclkIC(clk, sclk_pin, sclk_conditioned, sclk_rising, sclk_falling);
	inputconditioner csIC(clk, cs_pin, cs_conditioned, cs_rising, cs_falling);

    shiftregister shifreg(clk, sclk_rising, sr_we, parallelIn, mosi_conditioned, parallelOut, serialOut);

    // DFF & MISO_BUFE
    wire miso_pin_pre_buffer;
    dff dff0(serialOut, sclk_falling, clk, miso_pin_pre_buffer);
    bufferSwitch buffswitch0(miso_pin_pre_buffer, miso_bufe, miso_pin);

    // Memory
    datamemory memory0(clk, parallelIn, address, dm_we, parallelOut);
    dff8bit dff1(parallelOut, addre_we, clk, address);

    // FSM
    fsm fsm0( miso_bufe, dm_we, addre_we, sr_we, sclk_rising, cs_conditioned, parallelOut[0]);

endmodule
   
