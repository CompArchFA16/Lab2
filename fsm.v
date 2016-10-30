// Define FSM states
`define Q_GET     3'd0
`define Q_GOT     3'd1
`define Q_READ1   3'd2
`define Q_READ2   3'd3
`define Q_READ3   3'd4
`define Q_WRITE1  3'd5
`define Q_WRITE2  3'd6
`define Q_DONE    3'd7

module fsm
(
output reg sr_we,
output reg dm_we,
output reg addr_le,
output reg miso_enable,
input      cs,
input      sclk,
input      read_write_bit
);
  reg [3:0] counter = 0;
  reg [3:0] state = `Q_GET;

  always @(posedge sclk) begin

    case (state)
      `Q_GET:
        begin
          sr_we = 0; dm_we = 0; addr_le = 0; miso_enable = 0;
          counter = counter + 1;
          if (counter == 8) begin
            state = `Q_GOT;
            counter = 0;
          end
        end
      `Q_GOT:
        begin
          sr_we = 0; dm_we = 0; addr_le = 1; miso_enable = 0;
          if (read_write_bit)
            state = `Q_READ1;
          else
            state = `Q_WRITE1;
        end
      `Q_READ1:
        begin
          sr_we = 0; dm_we = 0; addr_le = 0; miso_enable = 0;
          state = `Q_READ2;
        end
      `Q_READ2:
        begin
          sr_we = 1; dm_we = 0; addr_le = 0; miso_enable = 0;
          state = `Q_READ2;
        end
      `Q_READ3:
        begin
          sr_we = 0; dm_we = 0; addr_le = 0; miso_enable = 1;
          counter = counter + 1;
          if (counter == 8) begin
            state = `Q_DONE;
            counter = 0;
          end
        end
      `Q_WRITE1:
        begin
          sr_we = 0; dm_we = 0; addr_le = 0; miso_enable = 0;
          counter = counter + 1;
          if (counter == 8) begin
            state = `Q_WRITE2;
            counter = 0;
          end
        end
      `Q_WRITE2:
        begin
          sr_we = 0; dm_we = 1; addr_le = 0; miso_enable = 0;
          state = `Q_DONE;
        end
      `Q_DONE:
        begin
          sr_we = 0; dm_we = 0; addr_le = 0; miso_enable = 0;
        end
    endcase

    if (cs) begin
      counter = 0;
      state = `Q_GET;
    end
  end
endmodule