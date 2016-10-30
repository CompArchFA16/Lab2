//------------------------------------------------------------------------
// Miso Soup Test Bench
//------------------------------------------------------------------------

`include "misoSoup.v"

module testMisoSoup();

    wire q;
    reg d;
    reg writeEnable;
    reg misoBufe;
    reg clk;
    
   
    misoSoup  dut(.q(q), 
    		      .d(d),
    		      .writeEnable(writeEnable), 
    		      .misoBufe(misoBufe), 
    		      .clk(clk)
                  );
   
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    reg dutPassed;

    initial begin
        $dumpfile("misoSoup.vcd");
        $dumpvars;

        dutPassed = 1; 


        //First Test Case, when writeEnable and misoBufe are high
        writeEnable = 1; //false
        misoBufe = 1; //false
        d = 1'b1;
        #10

        if (q !== d) begin
            dutPassed = 0;
            $display("Sad, misoSoup Test 1 failed.");
            $display("q: %b", q);
            $display("What q should be: %b", d);
        end 


        //Second Test Case, when writeEnable is low and misoBufe is high
        writeEnable = 0; //false
        misoBufe = 1; //false
        d = 1'b1;
        #10

        if (q !== d) begin
            $display("q: %b", q);
            $display("What q should be: %b", d);
        end 


        //Third Test Case, when writeEnable is high and misoBufe is low
        writeEnable = 1; //false
        misoBufe = 0; //false
        d = 1'b1;
        #10

        if (q !== d) begin
            $display("q: %b", q);
            $display("What q should be: %b", d);
        end 


        //Fourth Test Case, when writeEnable and misoBufe are low
        writeEnable = 0; //false
        misoBufe = 0; //false
        d = 1'b1;
        #10

        if (q !== d) begin
            $display("q: %b", q);
            $display("What q should be: %b", d);
        end 

    $finish();    
    end

endmodule

