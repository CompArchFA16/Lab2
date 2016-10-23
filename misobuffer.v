module misobuffer
(
  input d,
  input en,
  output q
);

assign q = d&en;


endmodule
