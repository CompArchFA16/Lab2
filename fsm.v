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
    input clkedge,
    input cs,
    input lsbsrop,
    output reg miso_bufe,
    output reg dm_we,
    output reg addre_we,
    output reg sr_we
);
    reg [2:0] count, state;
    //count <= 0;
    //state <= `GET;

    always @(posedge clkedge) begin
        case (state)
          `GET :    begin
                        count <= count + 1;
                        if (count == 3'd8) begin
                            count <= 0;
                            state <= `GOT;
                        end
                    end
          `GOT :     begin
                        if (lsbsrop == 1) begin
                            state <= `READ1;
                        end
                        else begin
                            if (lsbsrop == 0) begin
                                addre_we <= 1;
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
                        count <= count + 1;
                        miso_bufe <= 1;
                        if (count == 3'd8) begin
                            state <= `DONE;
                            count <= 0;
                        end
                    end
          `WRITE1:  begin
                        count <= count + 1;
                        if (count == 3'd8) begin
                            state <= `WRITE2;
                            count <= 0;
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
                        if (cs == 1) begin
                            state <= `GET;
                        end
                    end
            default: begin end
        endcase
    end

endmodule
