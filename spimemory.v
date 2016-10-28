//------------------------------------------------------------------------
// SPI Memory
// still needs address latch, DFF, buffer
//------------------------------------------------------------------------

`include "shiftregister.v"
`include "inputconditioner.v"
`include "fsmachine.v"
`include "datamemory.v"

// D flip-flop with parameterized bit width (default: 1-bit)
// Parameters in Verilog: http://www.asic-world.com/verilog/para_modules1.html
module dff_p #(parameter W=1)
(
    input trigger,
    input enable,
    input      [W-1:0] d,
    output reg [W-1:0] q
);
    always @(posedge trigger) begin
        if(enable) begin
            q <= d;
        end
    end
endmodule

module dff
(
    input trigger,
    input enable,
    input d,
    output reg q
);
    always @(posedge trigger) begin
        if(enable) begin
            q <= d;
        end
    end
endmodule

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux_p #(parameter W = 4)
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule

//fullchipdesign.com/tristate.htm
module tristate_buffer(in, enable, out);
  input in;
  input enable;
  output out;

  assign out = (enable)? in : 1'bz;
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

	wire [7:0] parallelDataIn; //xA5
	wire [7:0] parallelDataOut;
	wire SerialDataOut;
    wire [7:0] dataOut;
    wire conditioned_mosi, conditioned_cs, rising, falling;
    wire dummy0, dummy1, dummy2, dummy3, dummy4, dummy5;

    wire misoBufe, dmWe, addrWe,  srWe;

    wire [7:0] address;
    wire bufferin;

    inputconditioner ic0(.clk(clk),
    			 		 .noisysignal(mosi_pin),
						 .conditioned(conditioned_mosi),
						 .positiveedge(dummy0),
						 .negativeedge(dummy1));

    inputconditioner ic1(.clk(clk),
    			 		 .noisysignal(sclk_pin),
						 .conditioned(dummy2),
						 .positiveedge(rising),
						 .negativeedge(falling));

	inputconditioner ic2(.clk(clk),
    			 		 .noisysignal(cs_pin),
						 .conditioned(conditioned_cs),
						 .positiveedge(dummy3),
						 .negativeedge(dummy5));

    fsmachine fsm(.clk(clk),
                  .sclk(rising),
                  .cs(conditioned_cs),
                  .rw(parallelDataOut[0]),
                  .misobuff(misoBufe),
                  .dm(dmWe),
                  .addr(addrWe),
                  .sr(srWe));

    // Instantiate with parameter width = 8
    shiftregister #(8) sr(.clk(clk),
    		           .peripheralClkEdge(rising),
    		           .parallelLoad(srWe),
    		           .parallelDataIn(dataOut),
    		           .serialDataIn(conditioned_mosi),
    		           .parallelDataOut(parallelDataOut),
    		           .serialDataOut(serialDataOut));

    dff_p #(8) addressLatch(.trigger(clk),
                    .enable(addrWe),
                    .d(parallelDataOut),
                    .q(address));

    datamemory dm(.clk(clk),
    			  .dataOut(dataOut),
    			  .address(address[6:0]),
    			  .writeEnable(dmWe),
    			  .dataIn(parallelDataOut[7:0]));

	dff_p #(1) dffm(.trigger(clk),
				   .enable(falling),
				   .d(serialDataOut),
				   .q(bufferin));
/*
    dff dff(.trigger(clk),
                    .enable(falling),               
                    .d(serialDataOut),
                    .q(bufferin));*/
 
    tristate_buffer buff(.in(bufferin),
                       .enable(misoBufe),
                       .out(miso_pin));

endmodule
