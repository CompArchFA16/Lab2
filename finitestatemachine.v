//`include "fsmtransition.v"

//------------------------------------------------------------------------
// Finite State Machine
// this module is responsible for raising the flags for the spimemory module
// to respond to and react appropriately to the submodules
//------------------------------------------------------------------------

module finitestatemachine
(
	input clk,
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

reg [3:0] counter = 0;

reg [2:0] state = s_GET; // current state, default to s_GET

reg [7:0] p_out; // either address or data for data memory
reg [7:0] d_addr; // address for data memory

// fsmtransition t(state, peripheralClkEdge, cs, rw, state);

assign miso_buff = (state == s_READ2);
assign dm_we = (state == s_WRITE1);
assign addr_we = (state == s_GOT);
assign sr_we = (state == s_READ1);

always @(posedge clk) begin
	if (cs == 1) begin
		state <= s_GET;
		counter <= 0;
	end else begin
		//if cs == 1 then reset counter and go back to s_GET
		case (state)
			s_GET: begin
				if (peripheralClkEdge) begin
					// transition
					if(counter >= 7) begin
						state <= s_GOT;
					end else begin
						state <= s_GET;
						counter <= counter + 1;
					end // otherwise stay the same

				end
			end
			s_GOT: begin
				if (peripheralClkEdge) begin
					counter <= 0; // reset counter
					if(rw == 1) begin
						state <= s_READ0;
					end else begin
						state <= s_WRITE0;
					end
				end
				// output

				// finished reading address, now addr buffer is valid
				// thus write-enable address to data memory
			end
			s_READ0: begin
				// read data memory
				//if (peripheralClkEdge) begin
				state <= s_READ1;
					// transition
				//end
			end
			s_READ1: begin
				// parallelLoad to shift register
				//if (peripheralClkEdge) begin
					// transition
					state <= s_READ2;
				//end
			end
			s_READ2: begin
				if (peripheralClkEdge) begin
					// transition
					if(counter == 8) begin
						state <= s_DONE;
					end else begin
						counter <= counter + 1;
						state <= s_READ2;
					end
				end
			end
			s_WRITE0: begin
				if (peripheralClkEdge) begin
					if(counter >= 6) begin // WRITE1 at counter == 7
						state <= s_WRITE1;
					end else begin
						state <= s_WRITE0;
						counter <= counter + 1;
					end
				end
			end
			s_WRITE1: begin
				state <= s_DONE;
				counter <= 0;
			end
			s_DONE: begin
				counter <= 0;
				state <= s_DONE;
			end
			default: begin

			end
		endcase
	end
end

endmodule
