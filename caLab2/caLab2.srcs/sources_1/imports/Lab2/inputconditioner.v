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

    initial begin //set start values
      conditioned <= 0;
      positiveedge <= 0;
      negativeedge <= 0;
    end

    always @(posedge clk ) begin
     	positiveedge <= 0; //reset at the beginning when the positive edge of the clock is triggered
     	negativeedge <= 0;

      if(conditioned == synchronizer1)begin
        counter <= 0;
     	end

      else begin
        if(counter == waittime)begin
          counter <= 0;
          conditioned <= synchronizer1;
     		  if (synchronizer1) begin //simpler than checking if one is greater than the other
            positiveedge <= 1;
            //negativeedge <= 0; //default is 0
            //can't do set the other value only here because it will be done simultaneously(messes up waveform)
            //it needs to reset every clock cycle and can't change during that cycle
          end
          else begin
     			  negativeedge <= 1;
            //positiveedge <= 0;
     		  end

        end

        else
          counter <= counter + 1;
     end
     synchronizer0 <= noisysignal; //simultaneous because nonblocking, so debounces for 3 clock cycle period
     synchronizer1 <= synchronizer0;
    end
endmodule
