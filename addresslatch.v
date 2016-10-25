module addressLatch
(
	output reg [7:0] addressLatchOut,
	input clk,
	input writeEnable,
	input[7:0] addressLatchIn
);
	always @(posedge clk) begin
		if (writeEnable == 1) begin
			addressLatchOut <= addressLatchIn;
		end
	end
endmodule
