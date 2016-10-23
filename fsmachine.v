module fsmachine
(	
	input clk,
	input sclk,
	input cs, 
	input rw, 
	output reg misobuff,
	output reg dm,
	output reg addr,
	output reg sr
);

reg state;
reg count;

initial begin
	state <= 0;
	count <= 0;
end

always @(posedge clk) begin
	
	misobuff <= 0;
	dm <= 0;
	addr <= 0;
	sr <= 0;

	//reset counter and state when cs is de-asserted
	if (cs) begin
		state <= 0;
		count <= 0;
	end

	else begin
		case(state)

			0: begin //Get
				if (count < 8 && sclk) begin
					count <= count + 1;
				end
				else if (sclk) begin
					state <= 1; //proceed to Got state
				end
			end

			1: begin //Got
				if (rw) begin
					state <= 2;
				end
				else begin
					state <= 5;
				end
			end

			2: begin //Read
				state <= 3;
			end

			3: begin //Read2
				sr <= 1;
				state <= 4;
			end

			4: begin //Read3
				misobuff <= 1;
				if (cs == 8) begin
					state <= 7;
				end
				else if (sclk) begin
					count <= count + 1;
				end
			end

			5: begin //Write
				if (cs == 8) begin
					state <= 6;
				end
				else if (sclk) begin
					count <= count + 1;
				end
			end

			6: begin //Write2
				state <= 7;
				dm <= 1;
			end

			7: begin //Done
				count <= 0;
			end

		endcase
	end

end

endmodule