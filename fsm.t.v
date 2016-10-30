//------------------------------------------------------------------------
// Finite State Machine test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

module testfsm();

    reg msb_sr;         // Most significant bit shift register output
    reg c_cs;           // Conditioned chip select signal put thru input conditioner
    reg clk;            // Faster clock
    reg sclk;           // Slower clock
    reg sclk_edge;      // Peripheral clock edge
    wire MISO_BUFF;     // MISO enable
    wire DM_WE;         // Data Memory enable
    wire ADDR_WE;       // Address enable (for address latch)
    wire SR_WE;         // Shift Register enable

    // Instantiate with parameter width = 8
    fsm dut(.clk(clk),
       .peripheralClkEdge(sclk_edge),
       .msb_sr(msb_sr),
       .c_cs(c_cs),
       .MISO_BUFF(MISO_BUFF),
       .DM_WE(DM_WE),
       .ADDR_WE(ADDR_WE),
       .SR_WE(SR_WE));

    reg sclk_prev = 0;
    always begin
        #1 clk = ~clk;

        // Gets posedge of sclk
        if (sclk_prev != sclk) begin
            sclk_edge = 1;
        end
        else begin
            sclk_edge = 0;
        end
        sclk_prev = sclk;
    end

    always begin
        #20 sclk = ~sclk;
    end

    initial begin
    	// Your Test Code
        $dumpfile("fsm.vcd");
        $dumpvars();

        // Initial conditions
        clk = 1; sclk = 0; c_cs = 1;

        // Write 8b'11111111 to address 7b'1111111
        c_cs = 0;
        msb_sr = 1; #150
        msb_sr = 0; #20
        msb_sr = 1; #200
        c_cs = 1; #50

        // Read 8b'11111111 from address 7b'1111111
        c_cs = 0;
        msb_sr = 1; #500
        c_cs = 1; #50

        #10 $finish;
    end

endmodule
