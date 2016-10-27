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

    if (chipSelect) begin //if this is high, do not pay attention
        state <= Get_State;
        counter <= 0;
    end
    else begin
        case (state)
            Get_State: begin

                MISO_Buff <= 0; //you're not ouputting info
                if (counter != 7) begin //wait for full address (8 bits, 1 per sclk cycle) to be sent
                    ADDR_WE <= 1;
                    counter <= counter + 1; //on sclk, update counter
                end
                else begin //if we have a full address
                    counter <= 0; //set it to 0 to reuse counter
                    ADDR_WE <= 0; // Set Write enable for address latch
                    //SR_WE <= 1; // Set Parallel Load for shift register
                    if (readWrite) begin
                        state <= Read3_State;
                        SR_WE <= 1;
                        DM_WE <= 0; // Set Data Memory to read
                    end
                    else begin
                        state <= Write1_State;
                    end
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
            Read3_State: begin
                //ADDR_WE <= 0;
                SR_WE <= 0; // Unset Parallel Load for shift register
                MISO_Buff <= 1;
                if (counter == 1) begin
                    ADDR_WE <= 0;
                end
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
                SR_WE <= 0;
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
            Done_State: begin
                if (chipSelect) begin
                    state <= Get_State;
                end
            end
        endcase
    end
end
endmodule
