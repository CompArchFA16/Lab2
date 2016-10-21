`include "shiftregister.v"
`include "inputconditioner.v"

module midpoint
(
input 	    clk, 
input       button0,
input       switch0,
input       switch1,
output[7:0] leds      
);

    wire negativeedge;
    wire positiveedge;
    wire conditioned;

    inputconditioner conditioner1(.negativeedge(negativeedge), .clk(clk), .noisysignal(button0));
    inputconditioner conditioner2(.conditioned(conditioned), .clk(clk), .noisysignal(switch0));
    inputconditioner conditioner3(.positiveedge(positiveedge), .clk(clk), .noisysignal(switch1));
    
    shiftregister register(
        .parallelDataOut(leds), 
        .clk(clk), 
        .peripheralClkEdge(positiveedge), 
        .parallelDataIn(8'hA5), 
        .parallelLoad(negativeedge), 
        .serialDataIn(conditioned)
    );

endmodule
