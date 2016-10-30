// Finite State Machine for SPI memory
module fsm
(
	input clk,
	input msb_sr,				// Most significant bit of Shift Register
	input c_cs,					// Conditioned chip select signal put thru input conditioner
	input peripheralClkEdge,	// Posedge of sclk

	output reg MISO_BUFF, 		// MISO enable
	output reg DM_WE,			// Data Memory Enable
	output reg ADDR_WE,			// Address Enable (for address latch)
	output reg SR_WE			// Shift Register Enable
);

	// One-hot encoding of 8 possible states
	reg[7:0] state;
	localparam GET = 8'b00000001,
			   GOT = 8'b00000010,
			   READ1 = 8'b00000100,
			   READ2 = 8'b00001000,
			   READ3 = 8'b00010000,
			   WRITE1 = 8'b00100000,
			   WRITE2 = 8'b01000000,
			   DONE = 8'b10000000;

	// Intermediate variables
	reg [3:0] counter;
	reg counter_reset;
	reg reset_flg;

	// Initial state of FSM
	initial begin
		counter = 4'b0000;
		counter_reset = 0;
		state = GET;
		MISO_BUFF = 0;
		DM_WE =0;
		ADDR_WE =0;
		SR_WE =0;
	end

	// Main clocked loop
	always @(posedge clk) begin

		// Reset counter flag (for debugging purposes)
		if (counter_reset) begin
			counter <= 0;
			counter_reset <= 0;
		end

		// Reset everything if CS = high
		if (c_cs) begin
			state <= GET;
			counter_reset <= 1;
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		// Go through FSM if CS = low
		else begin
			case (state)
				GET: begin
					if (counter==4'b1000) begin
						state <= GOT;
					end
					else begin
						if (peripheralClkEdge) begin
							counter <= counter + 1;
						end
						state <= GET;
					end
				end

				GOT: begin
					if (msb_sr ) begin
						state <= READ1;
					end
					else begin
						if (!msb_sr ) begin
							state <= WRITE1;
						end
					end
				end

				READ1: begin
					state <= READ2;
				end

				READ2: begin
					state <= READ3;
				end

				READ3: begin
					if (counter == 4'b1000) begin
						state <= DONE;
					end
					else begin
						if (peripheralClkEdge) begin
							counter <= counter + 1;
						end
						state <= READ3;
					end
				end

				WRITE1: begin
					if (counter == 4'b1000) begin
						state <= WRITE2;
					end
					else begin
						if (peripheralClkEdge) begin
							counter <= counter + 1;
						end
						state <= WRITE1;
					end
				end

				WRITE2: begin
					state <= DONE;
				end

				DONE: begin
					state <= DONE;
				end
			endcase
	//end // @ peripheralclkedge
	end
	end
	always @(state) begin
		case (state)
			GET: begin
				MISO_BUFF <= 0;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 0;
			end

			GOT: begin
				MISO_BUFF <= 0;
				ADDR_WE <= 1;
				DM_WE <= 0;
				SR_WE <= 0;
				counter_reset <= 1;
			end

			READ1: begin
				MISO_BUFF <= 0;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 0;
			end

			READ2: begin
				MISO_BUFF <= 0;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 1;
			end

			READ3: begin
				MISO_BUFF <= 1;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 0;
			end

			WRITE1: begin
				MISO_BUFF <= 0;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 0;
			end

			WRITE2: begin
				MISO_BUFF <= 0;
				DM_WE <= 1;
				ADDR_WE <= 0;
				SR_WE <= 0;
			end

			DONE: begin
				MISO_BUFF <= 0;
				DM_WE <= 0;
				ADDR_WE <= 0;
				SR_WE <= 0;
				counter_reset <= 1;
				counter <= 4'b0000;
			end
		endcase
	end
endmodule
