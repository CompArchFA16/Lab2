`include "fsmtransition.v"

//------------------------------------------------------------------------
// Finite State Machine
// this module is responsible for raising the flags for the spimemory module
// to respond to and react appropriately to the submodules
//------------------------------------------------------------------------

module finitestatemachine
(
	input peripheralClkEdge,
	input cs, // chip select, nullify everything
	input rw,
	output miso_buff,
	output dm_we,
	output addr_we, //address 
	output sr_we //write enable for shift register
);

parameter s_GET = 0;
parameter s_GOT = 1;
parameter s_READ0 = 2;
parameter s_READ1 = 3;
parameter s_READ2 = 4;
parameter s_WRITE0 = 5;
parameter s_WRITE1 = 6;
parameter s_DONE = 7;

reg [2:0] state = s_GET; // current state, default to s_GET
reg [2:0] next;

reg [7:0] p_out; // either address or data for data memory
reg [7:0] d_addr; // address for data memory

fsmtransition t(state, sclk, cs, rw, next);

always @(posedge peripheralClkEdge) begin
	miso_buff <= 0;
	dm_we <= 0;
	addr_we <= 0;
	sr_we <= 0;

	//if cs == 1 then reset counter and go back to s_GET
	case (state)
		s_GET: begin // GETTING THE ADDRESS

		end
		s_GOT: begin
			// finished reading address, now addr buffer is valid
			// thus write-enable address to data memory
			addr_we <= 1;
		end
		s_READ0: begin

		end
		s_READ1: begin
			sr_we <= 1;
		end
		s_READ2: begin
			miso_buff <= 1;
		end
		s_WRITE0: begin

		end
		s_WRITE1: begin
			dm_we <= 1; // write to data memory
		end
		s_DONE: begin

		end
		default: begin

		end
	endcase

	state <= next;
end

endmodule
