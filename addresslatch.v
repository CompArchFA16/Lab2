module addressLatch
(
	output reg [6:0] addressLatchOut,
	input clk,
	input writeEnable,
	input[6:0] addressLatchIn
);
	always @(posedge clk) begin
		if (writeEnable == 1) begin
			addressLatchOut <= addressLatchIn;
		end
	end
endmodule
