// Tom Lisa Anisha we so hawt
`timescale 1 ns / 1 ps

module finiteStateMachine(

    input perEdge,
    input chipSelect,
    input readWrite,
    output reg MISO_Buff,
    output reg DM_WE,
    output reg ADDR_WE,
    output reg SR_WE

);

wire address;
reg [3:0] counter = 0000;
reg [7:0] state;
localparam Get_State = 8'b00000001;
localparam Got_State = 8'b00000010;
localparam Read1_State = 8'b00000100;
localparam Read2_State = 8'b00001000;
localparam Read3_State = 8'b00010000;
localparam Write1_State = 8'b00100000;
localparam Write2_State = 8'b01000000;
localparam Done_State = 8'b10000000;

always @(negedge chipSelect) begin
    counter <= 0;
end

always @(posedge perEdge) begin
    
    if (chipSelect) begin
        state <= Get_State;
        counter <= 0;
    end
    else begin
        case (state)
            Get_State: begin
                MISO_Buff <= 0;
                if (counter != 7) begin
                    counter <= counter + 1;
                end
                else begin
                    counter <= 0;
                    ADDR_WE <= 1; // Set Write enable for address latch
                    state <= Got_State;
                end
            end
            Got_State: begin
                ADDR_WE <= 0;
                if (readWrite) begin
                    state <= Read3_State;
                    SR_WE <= 1; // Set Parallel Load for shift register
                    DM_WE <= 0; // Set Data Memory to read
                end
                else begin
                    state <= Write1_State;
                end
            end
            Read1_State: begin
                SR_WE <= 1; // Set Parallel Load for shift register
                DM_WE <= 0; // Set Data Memory to read
                state <= Read3_State;
            end
            //Read2_State: begin
            //    SR_WE <= 0; // Unset Parallel Load for shift register
            //    state <= Read3_State;
            //end
            Read3_State: begin
                ADDR_WE <= 0;
                SR_WE <= 0; // Unset Parallel Load for shift register
                MISO_Buff <= 1;
                if (counter != 7) begin
                    counter <= counter + 1;
                end
                else begin
                    MISO_Buff <= 0;
                    counter <= 0;
                    state <= Done_State;
                end
            end
            Write1_State: begin
                ADDR_WE <= 0;
                DM_WE <= 1;
                if (counter != 7) begin
                    counter <= counter + 1;
                end
                else begin
                    counter <= 0;
                    DM_WE <= 0;
                    state <= Done_State;//Write2_State;
                end
            end
            Write2_State: begin
                DM_WE <= 0;
                state <= Done_State;
            end
            Done_State: begin
                if (chipSelect) begin
                    state <= Get_State;
                end
            end
        endcase
    end
end
endmodule
