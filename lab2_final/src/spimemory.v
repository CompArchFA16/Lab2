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

    wire mosi_conditioned, sclk_posedge, sclk_negedge, cs_conditioned;
    wire mosi_posedge, mosi_negedge, sclk_conditioned, cs_posedge, cs_negedge; // Unused registers
    inputconditioner conditioner0(clk, mosi_pin, mosi_conditioned, mosi_posedge, mosi_negedge);
    inputconditioner conditioner1(clk, sclk_pin, sclk_conditioned, sclk_posedge, sclk_negedge);
    inputconditioner conditioner2(clk, cs_pin, cs_conditioned, cs_posedge, cs_negedge);

    wire miso_buff, dm_we, addr_we, sr_we;
    wire[7:0] shiftRegOutP;
    fsm fsm0(clk, shiftRegOutP[0], cs_conditioned, sclk_posedge, miso_buff, dm_we, addr_we, sr_we);

    wire[7:0] dataMemOut;
    reg[6:0] address;
    wire shiftRegOutS;
    reg shiftRegOutS_DFF;
    datamemory datamemory0(clk, dataMemOut, address, dm_we, shiftRegOutP);
    shiftregister #(8) shiftregister0(clk, sclk_posedge, sr_we, dataMemOut, mosi_conditioned, shiftRegOutP, shiftRegOutS);

    always @(posedge clk) begin
        // Reset address if CS is high
        if (cs_pin) begin
            address <= 0;
        end
        else begin
            // Address latch
            if (addr_we) begin
                address <= shiftRegOutP[7:1];
            end
        end

        shiftRegOutS_DFF <= shiftRegOutS;
    end

    tri_state_buffer tribuf(shiftRegOutS_DFF, miso_buff, miso_pin);

endmodule


module tri_state_buffer
(
    input a,
    input enable,
    output b
);

    assign b = (enable) ? a : 1'bz;
endmodule
