// Finite State Machine for logic control

`define WAIT 3'd0
`define ADDR_READ 3'd1
`define GET_RW 3'd2
`define WRITE 3'd3
`define READ 3'd4

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
    initial state = `WAIT;
    initial miso_bufe = 0;
    initial dm_we = 0;
    initial addre_we = 0;
    initial sr_we = 0;

    always @(posedge clkedge) begin
        // $display("state:%d  count:%d", state, count);
        case (state)
            `WAIT: begin
                dm_we <= 0;
                if (cs == 0) begin
                    addre_we <= 1;
                    state <= `ADDR_READ;
                end
            end

            `ADDR_READ: begin
                count = count + 1;
                if (count == 4'd7) begin
                    state <= `GET_RW;
                    addre_we <= 0;
                    count <= 0;
                end

            end

            `GET_RW: begin
                if (lsbsrop == 0) begin
                    state <= `WRITE;
                    dm_we <= 1;
                end
                else begin
                    state <= `READ;
                    sr_we <= 1;
                    miso_bufe <=1;
                end
            end

            `WRITE: begin
                count = count + 1;
                if (count == 4'd7) begin
                    count <= 0;
                    dm_we <= 1;
                    state <= `WAIT;
                end

            end

            `READ: begin
                count = count + 1;
                sr_we <= 1;
                if (count == 4'd7) begin
                    count <= 0;
                    state <= `WAIT;
                    miso_bufe <= 0;
                end
            end

            default:  begin end
        endcase
    end

endmodule
