module fsm
(
	output reg misoBufferEnable,
	output reg DMWriteEnable,
	output reg addressWriteEnable,
	output reg SRWriteEnable,

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
        addressWriteEnable <= 1;

        if (readWriteEnable === 1) begin
          // Here, we set read signals to high.
          SRWriteEnable <= 1;
          misoBufferEnable <= 1;
        end
        else begin
          // Here we set circuit into write mode.
          DMWriteEnable <= 1;
        end
      end

      counter <= counter + 1;
    end
    else begin
      // It will reset everything.
      counter <= 0;
      misoBufferEnable <= 0;
      DMWriteEnable <= 0;
      addressWriteEnable <= 0;
      SRWriteEnable <= 0;
    end
  end
endmodule
