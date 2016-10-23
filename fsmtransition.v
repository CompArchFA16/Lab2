
//------------------------------------------------------------------------
// fsmtransition
// this module is responsible for changing the states of the fsm based on the
// current state of the fsm and the inputs.
//------------------------------------------------------------------------

module fsmtransition
(	
	input [2:0] currentState,
	input sclk,
	input cs, // chip select -- 
	input rw,
	output[2:0] nextState
);

parameter state_GETTING_ADDRESS     = 0;
parameter state_GOT_ADDRESS         = 1;
parameter state_READ_1              = 2;
parameter state_READ_2              = 3;
parameter state_READ_3              = 4;
parameter state_WRITE_1             = 5;
parameter state_WRITE_2             = 6;
parameter state_DONE                = 7;

reg[3:0] counter = 0; // starts with 0

always @(posedge sclk) begin
	if(cs) begin // cs high, unconditional reset
		next <= state_GETTING_ADDRESS;
		counter <= 0;
	end else begin
		case(currentState)

			state_GETTING_ADDRESS: begin
				if(counter == 8) begin
					nextState <= state_GOT_ADDRESS;
				end else begin
					counter <= counter + 1;
				end
			end

			state_GOT_ADDRESS: begin
				counter <= 0; // reset counter
				if(rw == 1) begin
					nextState <= state_READ_1;
				end else begin
					nextState <= state_WRITE_1;
				end
			end

			state_READ_1: begin
				nextState <= state_READ_2;
			end

			state_READ_2: begin
				nextState <= state_READ_3;
			end

			state_READ_3: begin
				if(counter == 8) begin
					nextState <= state_DONE;
				end else begin
					counter <= counter + 1;
				end
			end

			state_WRITE_1: begin
				if(counter == 8) begin
					nextState <= state_WRITE_2;
				end else begin
					counter <= counter + 1;
				end
			end

			state_WRITE_2: begin
				nextState <= state_DONE;
			end

			state_DONE: begin
				counter <= 0;
				nextState <= state_DONE;
			end

		endcase
	end

end

endmodule
