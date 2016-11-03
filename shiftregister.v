//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module shiftregister
#(parameter width = 8)
(
input               clk,                // FPGA Clock
input               peripheralClkEdge,  // Edge indicator
input               parallelLoad,       // 1 = Load shift reg with parallelDataIn
input  [width-1:0]  parallelDataIn,     // Load shift reg in parallel
input               serialDataIn,       // Load shift reg serially
output [width-1:0]  parallelDataOut,    // Shift reg data contents
output              serialDataOut       // Positive edge synchronized
);

    reg [width-1:0]      shiftregistermem;
    // Have to add reg because using procedural assignment below
    reg [width-1:0]      parallelDataOut;
    reg                  serialDataOut;

    always @(posedge clk) begin
        // Four behaviors: 

    	// 1)
        // Check for parallelLoad assertion if not shifting
        if(parallelLoad == 1) begin
            shiftregistermem <= parallelDataIn;
        end

        // 2)
        // When peripheralClkEdge has an edge, the shift register advances one position
        else begin
            if(peripheralClkEdge == 1) begin
                // Using concatenation syntax
                shiftregistermem <= {{shiftregistermem[width-2:0]}, {serialDataIn}};
            end
        end

    	// 3)
    	// Get most significant bit
    	serialDataOut <= shiftregistermem [width-1];

    	// 4)
    	// Get entire shift register
    	parallelDataOut <= shiftregistermem;

    end
endmodule
