module zero_detect #(parameter WIDTH = 36) (
  input [WIDTH-1:0] a,
  output y
);

  assign y = (a == 0);
  
endmodule
