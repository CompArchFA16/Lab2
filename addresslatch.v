module addresslatch
(
	input clk,
	input enable, // enable
	input [6:0] d,
	output reg [6:0] q
);

always @(posedge clk) begin
	if (enable) begin
		q <= d;
	end
end

endmodule
