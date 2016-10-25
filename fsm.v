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

  parameter state_GET       = 0;
  parameter state_GOT       = 1;
  parameter state_READ_1    = 2;
  parameter state_READ_2    = 3;
  parameter state_READ_3    = 4;
  parameter state_WRITE_1   = 5;
  parameter state_WRITE_2   = 6;
  parameter state_DONE      = 7;

  parameter waitTime = 8;
  reg [2:0] counter = 0;
  reg [2:0] currentState = state_GET;

  always @ (negedge sClkPosEdge) begin

    if (chipSelectConditioned === 0) begin

      if (currentState === state_GET) begin
        if (counter !== waitTime) begin
          currentState <= state_GET;
        end
        else begin
          currentState <= state_GOT;
          counter <= 0;
        end
      end

      if (currentState === state_GOT) begin
        if (readWriteEnable === 1) begin
          currentState <= state_READ_1;
        end
        else begin
          addressWriteEnable <= 1;
          currentState <= state_WRITE_1;
        end
      end

      if (currentState === state_READ_1) begin
        currentState <= state_READ_2;
      end

      if (currentState === state_READ_2) begin
        SRWriteEnable <= 1;
        currentState <= state_READ_3;
      end

      if (currentState === state_READ_3) begin
        if (counter != waitTime) begin
          currentState <= state_READ_3;
        end
        else begin
          misoBufferEnable <= 1;
          currentState <= state_DONE;
          counter <= 0;
        end
      end


      if (currentState === state_WRITE_1) begin
        if (counter !== waitTime) begin
          currentState <= state_WRITE_1;
        end
        else begin
          currentState <= state_WRITE_2;
          counter <= 0;
        end
      end

      if (currentState === state_WRITE_2) begin
        DMWriteEnable <= 1;
        currentState <= state_DONE;
      end

      // if (currentState === state_DONE) begin
      //   // chipSelectConditioned <= 1; 
      // end

    end
    else begin
      counter <= 0;
      // Fine, Bonnie...
      // misoBufferEnable <= 0;
      // DMWriteEnable <= 0;
      // addressWriteEnable <= 0;
      // SRWriteEnable <= 0;
      currentState <= state_GET;
    end
  end
endmodule
