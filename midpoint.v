// Create a top-level module with the following structure and load it onto the FPGA:
//
// Midpoint Check In Structure
//
// The parallel data input of the shift register is tied to a constant value, and the load is triggered when button 0 is pressed.
//
// Switches 0 and 1 allow manual control of the serial input.
//
// LEDs show the state of the shift register (note: you only have 4 to work with, so you will have to show a subset of bits, use the Lab 0 trick, or borrow an external LED board)
`include "shiftregister.v"

module midpoint(
    input button0,
    input switch0,
    input switch1,
    input clk,
    input [7:0] parallelDataIn,
    output serialOut,
    output [7:0] leds //4 LED's
    );

    //instantiate wires and reg's
    wire conditioned1, positiveedge1, negativeedge1;
    wire conditioned2, positiveedge2, negativeedge2;
    wire conditioned3, positiveedge3, negativeedge3;
    wire parallelLoad;

    //three input conditioners
    inputconditioner inputC1(clk, button0, conditioned1, positiveedge1, negativeedge1 );
    inputconditioner inputC2(clk, switch0, conditioned2, positiveedge2, negativeedge2 );
    inputconditioner inputC3(clk, switch1, conditioned3, positiveedge3, negativeedge3 );

    //shiftregister
    shiftregister shiftie(clk, positiveedge3,negativeedge1,parallelDataIn, conditioned2,  leds, serialOut);

/*overall structure:
three input conditioners in parallel, each taking in the same clock
button0 goes into NoisySignal of 1, switch 0 goes into NoisySignal of 2, switch 1 goes into NoisySignal of 3.
negativeedge of 1 goes into parallelLoad, conditioned of 2 goes into serial in, positive edge of 3 goes into clk edge and same clock goes into clk.
Parallel out goes to LEDs, serial out isn't connected?
Parallel in "xA5"
*/
endmodule
