
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
	output reg [2:0] next
);

parameter s_GET     = 0;
parameter s_GOT     = 1;
parameter s_READ1   = 2;
parameter s_READ2   = 3;
parameter s_READ3   = 4;
parameter s_WRITE1  = 5;
parameter s_WRITE2  = 6;
parameter s_DONE    = 7;

reg[3:0] counter = 0; // starts with 0

always @(posedge sclk) begin
	if(cs == 1) begin // cs high, unconditional reset
		next <= s_GET;
		counter <= 0;
	end else begin
		case(currentState)

			s_GET: begin
				if(counter == 8) begin
					next <= s_GOT;
				end else begin
					next <= s_GET;
					$display("!!: %b", next);
					counter <= counter + 1;
				end
				$display("!: %b", next);
			end

			s_GOT: begin
				counter <= 0; // reset counter
				if(rw == 1) begin
					next <= s_READ1;
				end else begin
					next <= s_WRITE1;
				end
			end

			s_READ1: begin
				next <= s_READ2;
			end

			s_READ2: begin
				next <= s_READ3;
			end

			s_READ3: begin
				if(counter == 8) begin
					next <= s_DONE;
				end else begin
					counter <= counter + 1;
				end
			end

			s_WRITE1: begin
				if(counter == 8) begin
					next <= s_WRITE2;
				end else begin
					counter <= counter + 1;
				end
			end

			s_WRITE2: begin
				next <= s_DONE;
			end

			s_DONE: begin
				counter <= 0;
				next <= s_DONE;
			end

			default: begin

			end
		endcase
	end
	$display("NEXT : %b", next);
end

endmodule
