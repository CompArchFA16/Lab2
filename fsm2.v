// Tom Lisa Anisha we so hawt
`timescale 1 ns / 1 ps

module finiteStateMachine(

    input perEdge,
    input chipSelect,
    input readWrite,
    input clk,
    output reg MISO_Buff,
    output reg DM_WE,
    output reg ADDR_WE,
    output reg SR_WE

);

reg [3:0] counter = 0000;
reg [7:0] state;
reg restart;
reg RW;
localparam GetAddr_State = 8'b00000001;
//localparam RW_State = 8'b00000010;
localparam Read1_State = 8'b00000100;
localparam Read2_State = 8'b00001000;
localparam Read3_State = 8'b00010000;
localparam Write1_State = 8'b00100000;
localparam Write2_State = 8'b01000000;
localparam Done_State = 8'b10000000;

always @(negedge chipSelect) begin
    counter <= 0;
end

//change states on the clk cycles
always @(posedge clk) begin

    if (chipSelect) begin //if this is high, do not pay attention
        MISO_Buff<=0;
        state <= GetAddr_State;
        counter <= 0;
        restart <=0;
    end
    else begin
        case (state)
            //Grab the address
            GetAddr_State: begin
            //turn off all control signals, we're just listening to address
                MISO_Buff <=0;
                ADDR_WE <=1;
                DM_WE <=0;
                SR_WE <=0;
                //if we got the address
                if (counter == 7) begin
                 RW <= readWrite;
                end
                if ((counter ==0) & (restart==1)) begin
                restart <=0;
                    if (RW) begin
                        state <= Read1_State;
                    end
                    else begin
                        state <=Write1_State;
                    end
                end
            end
            //Reading step 1: Wait for 8 bits of data (8 sclk cycles)
            Read1_State: begin
                ADDR_WE <=0; //save address into latch and therefore data memory address input
                SR_WE <=1;
                state <= Read2_State;

            end
            Read2_State: begin
                ADDR_WE <=0;
                SR_WE <=0; //to do: look here (if need clock cycle to go from parallel in enable to serial out)
                MISO_Buff <=1; //set miso pin out high
                if ((counter ==0) & (restart==1) ) begin
                    restart<=0;
                    state <= Done_State;
                end
            end
            Write1_State: begin
                ADDR_WE <=0;
                DM_WE <=1;
                state <= Write2_State;
            end
            Write2_State: begin
                ADDR_WE <= 0;
                if ((counter ==0) & (restart==1) ) begin
                    restart<=0;
                    DM_WE <= 1;
                    MISO_Buff<=0;
                    state <= Done_State;
                end
            end
            Done_State: begin
                DM_WE <=0;
                MISO_Buff <= 0;
                if (chipSelect) begin
                    state <= GetAddr_State;
                end
            end
        endcase
    end
end

//change counter on the sclk cycles
always @(posedge perEdge) begin
    if (counter >= 7 || chipSelect) begin
        counter <= 0;
    end
    else begin
    counter <= counter + 1;
    end
    if (counter ==7)begin
        restart <=1;
    end
end

endmodule
