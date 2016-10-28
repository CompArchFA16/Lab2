module misoSoup
(
  output reg q,
  input d,
  input writeEnable,
  input misoBufe,
  input clk
);
  always @(posedge clk) begin
    if (writeEnable && misoBufe) begin
      q = d;
    end
  end
endmodule
