//------------------------------------------------------------------------
// Midpoint Module
//------------------------------------------------------------------------

`include "inputconditioner.v"
`include "shiftregister.v"

module midpoint
#(parameter width = 8)
(
input button0,
input switch0,
input switch1,
output [width-1:0] leds
);
    reg clk;
    wire btn_to_prl_ld, swt_to_srl_in, swt_to_clk_edg;
    always #10 clk=!clk; // 50MHz Clock
    inputconditioner ic0(
        .clk(clk),
        .noisysignal(button0),
        .conditioned(),
        .positiveedge(),
        .negativeedge(btn_to_prl_ld)
    );
    inputconditioner ic1(
        .clk(clk),
        .noisysignal(switch0),
        .conditioned(swt_to_srl_in),
        .positiveedge(),
        .negativeedge()
    );
    inputconditioner ic2(
        .clk(clk),
        .noisysignal(switch1),
        .conditioned(),
        .positiveedge(swt_to_clk_edg),
        .negativeedge()
    );
    shiftregister sr0(
        .clk(clk),
        .peripheralClkEdge(swt_to_clk_edg),
        .parallelLoad(btn_to_prl_ld),
        .parallelDataIn(),
        .serialDataIn(swt_to_srl_in),
        .parallelDataOut(leds),
        .serialDataOut()
    );

endmodule
