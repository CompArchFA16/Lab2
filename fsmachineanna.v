 module fsmachine
(	
	input clk,
	input sclk, //clk edge
	input cs, //conditioned
	input rw, //shift register output[0]
	output reg misobuff, //MISO enable
	output reg dm, //data memory write enable
	output reg addr, //address latch enable
	output reg sr //shift register write enable
);

reg [3:0] state;
reg [5:0] count;

localparam Get = 4'd0,
		   Got = 4'd1,
		   Read = 4'd2,
		   Read1 = 4'd3,
		   Read2 = 4'd4,
		   Write = 4'd5,
		   Write2 = 4'd6,
		   Done = 4'd7;

initial begin
	state <= 0;
	count <= 0;
	misobuff <= 0;
	dm <= 0;
	addr <= 0;
	sr <= 0;

end

always @(posedge clk) begin
	

	//reset counter and state when cs is de-asserted
	if (cs) begin
		state <= 0;
		count <= 0;
		misobuff <= 0;
		dm <= 0;
		addr <= 0;
		sr <= 0;

	end

	else begin
		case(state)

			Get: begin
				if (sclk) begin
				$display("sclk");
					if (count < 8) begin
						count = count + 1;
						state <= Get;
						end 
					else begin
						state <= Got;
					end
				end
				else begin
					state <= Get;
				end
			end

			Got: begin
				if (rw) begin
					state <= Read;
				end
				else begin
					state <= Write;
				end
			end

			Read: begin 
				state <= Read1;
			end

			Read1: begin
				sr <= 1;
				state <= Read2;
			end

			Read2: begin
				misobuff <= 1;
				if (cs == 8) begin
					state <= Done;
				end
				else if (sclk) begin
					count <= count + 1;
				end
			end

			Write: begin
				if (cs == 8) begin
					state <= Write2;
				end
				else if (sclk) begin
					count <= count + 1;
				end
			end

			Write2: begin
				state <= Done;
				dm <= 1;
			end

			Done: begin //Done
				count <= 0;
			end

		endcase
	end

end

endmodule