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
    always @(posedge clk) begin
        // Your Code Here
        if (parallelLoad) begin
        	shiftregistermem <= parallelDataIn;
        end
        else if (peripheralClkEdge) begin
        	shiftregistermem <= shiftregistermem << 1;
        	shiftregistermem[0] <= serialDataIn;
        end
    end
    assign parallelDataOut = shiftregistermem;
    assign serialDataOut = shiftregistermem[width-1];

endmodule


// module shiftregister // done w mux
// #(parameter width = 8)
// (
// input               clk,                // FPGA Clock
// input               peripheralClkEdge,  // Edge indicator
// input               parallelLoad,       // 1 = Load shift reg with parallelDataIn
// input  [width-1:0]  parallelDataIn,     // Load shift reg in parallel
// input               serialDataIn,       // Load shift reg serially
// output [width-1:0]  parallelDataOut,    // Shift reg data contents
// output              serialDataOut       // Positive edge synchronized
// );

//     reg [width-1:0]      shiftregistermem;
//     reg [width-1:0]      shiftregistermem1;
//     reg [width-1:0]      shiftregistermem2;
//     reg [width-1:0]      for_i;
//     always @(posedge clk) begin
//         // Your Code Here
//         shiftregistermem2 <= parallelDataIn;

//         if (peripheralClkEdge) begin
//             shiftregistermem1 <= shiftregistermem <<1;
//             shiftregistermem1[0] <= serialDataIn;
//             // shiftregistermem1 = {}
//         end


//         if (parallelLoad) begin
//             shiftregistermem <= shiftregistermem2;
//         end
//         else begin
//             shiftregistermem <= shiftregistermem1;
//         end



//     end
//     assign parallelDataOut = shiftregistermem;
//     assign serialDataOut = shiftregistermem[width-1];

// endmodule
