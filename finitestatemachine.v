//`include "fsmtransition.v"

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
	output reg miso_buff,
	output reg dm_we,
	output reg addr_we, //address 
	output reg sr_we //write enable for shift register
);

parameter s_GET = 0;
parameter s_GOT = 1;
parameter s_READ0 = 2;
parameter s_READ1 = 3;
parameter s_READ2 = 4;
parameter s_WRITE0 = 5;
parameter s_WRITE1 = 6;
parameter s_DONE = 7;

reg [3:0] counter = 0;

reg [2:0] state = s_GET; // current state, default to s_GET
reg [2:0] next = s_GET; // next state

reg [7:0] p_out; // either address or data for data memory
reg [7:0] d_addr; // address for data memory

// fsmtransition t(state, peripheralClkEdge, cs, rw, next);

always @(posedge peripheralClkEdge) begin
	miso_buff <= 0;
	dm_we <= 0;
	addr_we <= 0;
	sr_we <= 0;

	state <= next;

	if (cs == 1) begin
		next <= s_GET;
		counter <= 0;
	end else begin
		//if cs == 1 then reset counter and go back to s_GET
		case (state)
			s_GET: begin
				// transition
				if(counter >= 7) begin
					next <= s_GOT;
				end else begin
					next <= s_GET;
					counter <= counter + 1;
				end
				// no output
			end
			s_GOT: begin
				// transition
				counter <= 0; // reset counter
				if(rw == 1) begin
					next <= s_READ0;
				end else begin
					next <= s_WRITE0;
				end
				// output
				
				// finished reading address, now addr buffer is valid
				// thus write-enable address to data memory
				addr_we <= 1;
			end
			s_READ0: begin
				// transition
				next <= s_READ1;
			end
			s_READ1: begin
				// transition
				next <= s_READ2;
				sr_we <= 1;
			end
			s_READ2: begin
				// transition
				if(counter == 8) begin
					next <= s_DONE;
				end else begin
					next <= s_READ2;
					counter <= counter + 1;
				end

				// output
				miso_buff <= 1;
			end
			s_WRITE0: begin
				if(counter == 8) begin
					next <= s_WRITE1;
				end else begin
					next <= s_WRITE0;
					counter <= counter + 1;
				end
			end
			s_WRITE1: begin
				next <= s_DONE;
				dm_we <= 1; // write to data memory
			end
			s_DONE: begin
				counter <= 0;
				next <= s_DONE;
			end
			default: begin

			end
		endcase
	end
end

endmodule
