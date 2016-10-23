module dff
(
    input clk,
    input en,
    input      d,
    output reg q
);
    always @(posedge clk) begin
        if(en) begin
            q <= d;
        end 
    end
endmodule
