module fsm
(
	output misoBufferEnable,
	output DMWriteEnable,
	output addressWriteEnable,
	output SRWriteEnable,

  input  sClkPosEdge,
	input  readWriteEnable, // This tells us read/write
	input  chipSelectConditioned
);

  parameter waitTime = 8;
  reg [2:0] counter = 0;

  always @ (negedge sClkPosEdge) begin
    if (chipSelectConditioned === 1'b0) begin
      if (counter === waitTime) begin
        counter <= 0;
      end
      else begin
      end
      counter <= counter + 1;
    end
    else begin
      // It will reset everything.
      counter <= 0;
    end
  end
endmodule
