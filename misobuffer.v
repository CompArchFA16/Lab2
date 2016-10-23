module misobuffer
(
  input d,
  input en,
  output q
);

  if (en == 1) begin
    q <= d;
  end

endmodule
