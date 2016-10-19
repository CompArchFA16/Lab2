`include "inputconditioner.v"
`include "shiftregister.v"

module midpoint
(
	input clk,
	input [3:0] sw, // 2 switches, sw[0] for Serial Data In, sw[1] for Clk Ed
	input [3:0] btn, // btn[0] for parallel load, btn[1] for "show lower 4 bits" and btn[2] for "show higher 4 bits"
	output [3:0] led // 4 leds, display subset of status of shift register
);
