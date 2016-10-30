module fsm
(
	output reg misoBufferEnable,
	output reg DMWriteEnable,
	output reg addressWriteEnable,
	output reg SRWriteEnable,

  input  clk,
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

  parameter waitTime = 7;
  reg [3:0] counter = 0;
  reg [2:0] currentState = state_GET;

  initial begin
    misoBufferEnable <= 0;
    DMWriteEnable <= 0;
    addressWriteEnable <= 0;
    SRWriteEnable <= 0;
  end

  // Peripheral clock dependent.
  always @ (posedge clk) begin
    if (chipSelectConditioned === 1) begin
      counter <= 0;
      currentState <= state_GET;
      misoBufferEnable <= 0;
      DMWriteEnable <= 0;
      addressWriteEnable <= 0;
      SRWriteEnable <= 0;
    end
    else begin
      if (sClkPosEdge === 1) begin
        case (currentState)
          state_GET: begin
            if (counter !== waitTime) begin
              counter <= counter + 1;
              currentState <= state_GET;
            end
            else begin
              counter <= 0;
              currentState <= state_GOT;
            end
          end
          state_READ_3: begin
            SRWriteEnable <= 0;
            if (counter != waitTime) begin
              misoBufferEnable <= 1;
              counter <= counter + 1;
              currentState <= state_READ_3;
            end
            else begin
              misoBufferEnable <= 0;
              counter <= 0;
              currentState <= state_DONE;
            end
          end
          state_WRITE_1: begin
            addressWriteEnable <= 0;
            if (counter !== waitTime) begin
              counter <= counter + 1;
              currentState <= state_WRITE_1;
            end
            else begin
              counter <= 0;
              currentState <= state_WRITE_2;
            end
          end
        endcase
      end
      else begin
        case (currentState)
          state_GOT: begin
            addressWriteEnable <= 1;
            if (readWriteEnable === 1) begin
              currentState <= state_READ_1;
            end
            else begin
              currentState <= state_WRITE_1;
            end
          end
          state_READ_1: begin
            addressWriteEnable <= 0;
            currentState <= state_READ_2;
          end
          state_READ_2: begin
            SRWriteEnable <= 1;
            currentState <= state_READ_3;
          end
          state_READ_3: begin
            SRWriteEnable <= 0;
            misoBufferEnable <= 1;
          end
          state_WRITE_2: begin
            DMWriteEnable <= 1;
            currentState <= state_DONE;
          end
          state_DONE: begin
            DMWriteEnable <= 0;
          end
        endcase
      end
    end
  end
endmodule
