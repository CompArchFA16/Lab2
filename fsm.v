// Finite State Machine for logic control

`define GET 3'd0
`define GOT 3'd1
`define READ1 3'd2
`define READ2 3'd3
`define READ3 3'd4
`define WRITE1 3'd5
`define WRITE2 3'd6
`define DONE 3'd7

module fsm 
(
    output reg miso_bufe,
    output reg dm_we,
    output reg addre_we,
    output reg sr_we,
    input clkedge,
    input cs,
    input lsbsrop
);
    reg [3:0] count;
    reg [2:0] state;
    initial count = 4'd0;
    initial state = `DONE;
    initial miso_bufe = 0;
    initial dm_we = 0;
    initial addre_we = 0;
    initial sr_we = 0;

    always @(posedge clkedge) begin
        // $display("state:%d  count:%d", state, count);
        case (state)
          `GET :    begin
                        count++;
                        if (count == 4'd8) begin
                            state <= `GOT;
                        end
                    end
          `GOT :     begin
                        addre_we <= 1;
                        count <= 0;
                        if (lsbsrop == 1) begin
                            state <= `READ1;
                        end
                        else begin
                            if (lsbsrop == 0) begin
                                state <= `WRITE1;
                            end
                        end
                    end
          `READ1:   begin
                        state <= `READ2;
                    end
          `READ2:   begin
                        sr_we <= 1;
                        state <= `READ3;
                    end
          `READ3:   begin
                        count++;
                        miso_bufe <= 1;
                        if (count == 4'd8) begin
                            state <= `DONE;
                        end
                    end
          `WRITE1:  begin
                        count++;
                        if (count == 4'd8) begin
                            state <= `WRITE2;
                        end
                    end
          `WRITE2:  begin
                        dm_we <= 1;
                        state <= `DONE;
                    end
          `DONE:    begin
                        count <= 0;
                        sr_we <= 0;
                        dm_we <= 0;
                        addre_we <= 0;
                        miso_bufe <= 0;
                        if (cs == 0) begin
                            state <= `GET;
                        end
                    end
            default: begin end
        endcase
    end

endmodule
