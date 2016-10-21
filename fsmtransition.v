module fsmtransition
(
  input[2:0] currentState;
  input sclk;
  input rw;
  output[2:0] nextState;
);

  parameter state_GETTING_ADDRESS     = 0;
  parameter state_GOT_ADDRESS         = 1;
  parameter state_READ_1              = 2;
  parameter state_READ_2              = 3;
  parameter state_READ_3              = 4;
  parameter state_WRITE_1             = 5;
  parameter state_WRITE_2             = 6;
  parameter state_DONE                = 7;

  reg[3:0] counter;

  always @(posedge sclk) begin

    case(currentState)
    
      state_GETTING_ADDRESS: begin
          if(counter == 8) begin
            nextState <= state_GOT_ADDRESS;
          else
            counter <= counter + 1;
          end

      state_GOT_ADDRESS: begin
          if(rw == 1) begin
            nextState <= state_READ_1;
          else
            nextState <= state_WRITE_1;
          end

      state_READ_1: begin
            nextState <= state_READ_2;
          end

      state_READ_2: begin
            nextState <= state_READ_3;
          end

      state_READ_3: begin
          if(counter == 8) begin
            nextState <= state_DONE;
          else
            counter <= counter + 1;
          end

      state_WRITE_1: begin
          if(counter == 8) begin
            nextState <= state_WRITE_2;
          else
            counter <= counter + 1;
          end

      state_WRITE_2: begin
            nextState <= state_DONE;
          end

      state_DONE: begin
            nextState <= state_DONE;
          end

     endcase
  end
endmodule
