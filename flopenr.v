module flopenr #(parameter WIDTH = 36, RES_VAL = 0) (
  input clk, reset, en,
  input [WIDTH-1:0] d,
  output reg [WIDTH-1:0] q
);

  always @(posedge clk)
    if (reset)
      q <= RES_VAL;
    else if (en)
      q <= d;
	  
endmodule