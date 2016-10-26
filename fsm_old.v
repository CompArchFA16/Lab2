//------------------------------------------------------------------------
//Finite State Machine
//   
//
//------------------------------------------------------------------------

module fsm
(
input msb_sr,	// most significant bit shift register output
input c_cs,		// conditioned chip select signal put thru input conditioner
input peripheralClkEdge,	// peripheral clockedge of sclk
input clk,					// clk
output MISO_BUFF, 			// miso output enable
output DM_WE,				// Data Memory Write Enable
output ADDR_WE,				// Address Write Enable (for address latch)
output SR_WE				// Shift Register Write Enable
);

    reg [3:0]  counter;
    reg [10:0] LUT_command;
    reg [7:0]  one_hot_signal;
    reg 	   counter_full_holder;
    wire [3:0]  next_index_wire;
    reg [3:0]  next_index_reg;
    wire  	   Reset_counter;
    reg 		c_cs_reg;

    initial begin // set start values for one hot state and counter
    	counter <= 4'b0000;
    	next_index_reg <= 4'b0000;
    	one_hot_signal <= 8'b00000000;
    end

    always @(posedge clk) begin

    	if (c_cs_reg == c_cs && c_cs == 0) begin
			next_index_reg = next_index_wire;
    	end

	    // Post LUT, if reset counter, we reset clock, we start by updating
	    if (Reset_counter) begin
	    	counter <= 4'b0000;
	    	counter_full_holder <= 0;
	    	LUT_command[8] <= 0;
	    end
	    else if (peripheralClkEdge) begin
	    	counter <= counter + 4'b0001; 	// add 1 to the counter
	    	if (counter == 4'b0111) begin
	    		LUT_command[8] = 1;			// raise flag in command if counter is full
	    		counter_full_holder =1;

	    	end
	    	else begin
	    		LUT_command[8] = 0;			// don't raise flag if counter is not full
	    		counter_full_holder = 0;
	    	end
	    end

	    if (c_cs == 1) begin
	    	one_hot_signal = 8'b00000000;
	    end
	    else begin  // if not at done state, we will go to state indicated by next state
	    	one_hot_signal = 1<<next_index_reg; 
	    end

    	// update LUT command signal based upon inputs
    	LUT_command[10] = c_cs;
    	LUT_command[9] = msb_sr;
    	LUT_command[7:0] = one_hot_signal;

    c_cs_reg <= c_cs;

    end
    fsm_LUT	fms_lut(SR_WE, Reset_counter, DM_WE, ADDR_WE, MISO_BUFF, next_index_wire, LUT_command);

endmodule


// Table Abbreviations
// Key:
//      First bit is Cs, 2nd is msb, 3rd is counterfull
//		Last 8 are next state index (Which state the name lines up to) in one hot form	

`define RESET_1   11'b01000000000 // initial state with msb 1
`define RESET_2   11'b00000000000 // initial state with msb 0
`define RESET_3   11'b010xxxxxxxx // initial state with msb 1
`define RESET_4   11'b000xxxxxxxx // initial state with msb 0
`define RESET_5   11'b11000000000 // initial state with msb 1 cs off
`define RESET_6   11'b10000000000 // initial state with msb 0 cs off
`define RESET_7   11'b110xxxxxxxx // initial state with msb 1 cs off
`define RESET_8   11'b100xxxxxxxx // initial state with msb 0 cs off

`define Get_1     11'b00000000001 // Get state with msb 0, counter_full 0
`define Get_2     11'b01000000001 // Get state with msb 1, counter_full 0
`define Get_3     11'b00100000001 // Get state with msb 0, counter_full 1
`define Get_4     11'b01100000001 // Get state with msb 1, counter_full 1

`define Got_1     11'b01100000010 // Got state with msb 1, counter_full 1, goes to read
`define Got_2     11'b00100000010 // Got state with msb 0, counter_full 1, goes to write

`define Read1     11'b01000000100 // Read 1 state with msb 1, countefull 0

`define Read2     11'b01000001000 // Read 2 state with msb 1, counterfull 0

`define Read3_1   11'b00000010000 // Read 3 state with msb 0, counter_full 0
`define Read3_2   11'b01000010000 // Read 3 state with msb 1, counter_full 0
`define Read3_3   11'b00100010000 // Read 3 state with msb 0, counter_full 1
`define Read3_4   11'b01100010000 // Read 3 state with msb 1, counter_full 1

`define Write1_1  11'b00000100000 // Write 1 state with msb 0, counter_full 0
`define Write1_2  11'b01000100000 // Write 1 state with msb 1, counter_full 0
`define Write1_3  11'b00100100000 // Write 1 state with msb 0, counter_full 1
`define Write1_4  11'b01100100000 // Write 1 state with msb 1, counter_full 1

`define Write2_1  11'b00101000000 // Write 2 state with msb 0, counter_full 1
`define Write2_2  11'b01101000000 // Write 2 state with msb 1, counter_full 1

`define Done_1    11'b00110000000 // Done satate with msb 0, counter_full 1
`define Done_2    11'b01110000000 // Done satate with msb 1, counter_full 1


module fsm_LUT // Converts the commands to a more convenient format
(
    output reg  SR_WE,
    output reg  Reset_counter,
    output reg  DM_WE,
    output reg  ADDR_WE,
    output reg  MISO_BUFF,
    output reg [3:0]  next_index,
    input[10:0]  LUT_command
);

    always @(LUT_command) begin
      case (LUT_command)
      	
      	`RESET_1:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET_2:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
 		`RESET_3:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET_4:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET_5:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET_6:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
 		`RESET_7:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET_8:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end

        `Get_1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
		`Get_2:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
        `Get_3:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0001; end
        `Get_4:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0001; end

        `Got_1:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 1; MISO_BUFF = 0; next_index = 4'b0010; end
        `Got_2:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 1; MISO_BUFF = 0; next_index = 4'b0101; end

        `Read1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0011; end
        
        `Read2: 	begin SR_WE = 1; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0100; end
        
        `Read3_1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0100; end
        `Read3_2:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0100; end
        `Read3_3:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0111; end
        `Read3_4:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0111; end
        
 
        `Write1_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0101; end
        `Write1_2:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0101; end
        `Write1_3:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0110; end
        `Write1_4:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0110; end

        
        `Write2_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0111; end
        `Write2_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0111; end

        `Done_1:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
        `Done_2:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      endcase
    end
endmodule