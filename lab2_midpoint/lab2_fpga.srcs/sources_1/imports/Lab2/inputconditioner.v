//------------------------------------------------------------------------
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
//------------------------------------------------------------------------

module inputconditioner
(
input 	    clk,            // Clock domain to synchronize input to
input	    noisysignal,    // (Potentially) noisy input signal
output reg  conditioned,    // Conditioned output signal
output reg  positiveedge,   // 1 clk pulse at rising edge of conditioned
output reg  negativeedge    // 1 clk pulse at falling edge of conditioned
);

    parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 3;     // Debounce delay, in clock cycles
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;
    reg dff0 = 0;
    reg dff1 = 0;
    
    always @(posedge clk ) begin
        positiveedge <= 0;
        negativeedge <= 0;

        if(conditioned == synchronizer1)
            counter <= 0;
        else begin
            if( counter == waittime) begin
                counter <= 0;
                conditioned <= synchronizer1;
                if (synchronizer1) begin
                    positiveedge <= synchronizer1;
                end
                else begin
                    negativeedge <= ~synchronizer1;
                end
            end
            else 
                counter <= counter+1;
        end
        synchronizer0 <= noisysignal;       // dflipflop1
        synchronizer1 <= synchronizer0;     //dflipflop2
    end
endmodule


// module d_flip_flop
// (
// input din;
// input clk;
// input reset;
// output reg dout
//     );

//     always @(posedge clk) begin
//         if(reset) begin
//             dout <= 0;
//         end
//         else
//             dout <= din;
//         end
//     end
// endmodule