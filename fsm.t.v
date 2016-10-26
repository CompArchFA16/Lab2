// test bench for finite state machine logic control

`include "fsm.v"

module testFsm();
    wire miso_bufe, dm_we, addre_we, sr_we;
    reg clkedge, cs, lsbsrop;

    fsm fsm0 (miso_bufe, dm_we, addre_we, sr_we, clkedge, cs, lsbsrop);

    // Generate clock (50MHz)
    initial clkedge=0;
    always #50 clkedge=!clkedge;    // 5MHz Clock

    initial begin
        cs=1; lsbsrop=1; #1000
        $display("cs  lsbsrop | miso_bufe  dm_we  addre_we  sr_we | state");
        $display("%b   %b       | %b          %b      %b         %b     | DONE", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        cs=0; #200
        $display("%b   %b       | %b          %b      %b         %b     | GET", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #800
        $display("%b   %b       | %b          %b      %b         %b     | GOT", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #100
        $display("%b   %b       | %b          %b      %b         %b     | READ1", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #100
        $display("%b   %b       | %b          %b      %b         %b     | READ2", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #100
        $display("%b   %b       | %b          %b      %b         %b     | READ3", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #700
        cs=1; lsbsrop=0;#100
        $display("%b   %b       | %b          %b      %b         %b     | DONE", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        cs=0; #200
        $display("%b   %b       | %b          %b      %b         %b     | GET", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #800
        $display("%b   %b       | %b          %b      %b         %b     | GOT", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #100
        $display("%b   %b       | %b          %b      %b         %b     | WRITE1", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #800
        $display("%b   %b       | %b          %b      %b         %b     | WRITE2", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        #100
        $display("%b   %b       | %b          %b      %b         %b     | DONE", cs, lsbsrop, miso_bufe, dm_we, addre_we, sr_we);

        $finish;
    end

endmodule
