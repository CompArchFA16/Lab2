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
`include "inputconditioner.v"


/*overall structure:
three input conditioners in parallel, each taking in the same clock
button0 goes into NoisySignal of 1, switch 0 goes into NoisySignal of 2, switch 1 goes into NoisySignal of 3.
negativeedge of 1 goes into parallelLoad, conditioned of 2 goes into serial in, positive edge of 3 goes into clk edge and same clock goes into clk.
Parallel out goes to LEDs, serial out isn't connected?
Parallel in "xA5"
*/
