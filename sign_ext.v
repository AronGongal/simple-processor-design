module sign_ext (
  input [11:0] a,
  output [35:0] y
);

  assign y = {24'b0, a};
  
endmodule