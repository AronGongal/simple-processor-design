module flop #(parameter WIDTH = 36) (
  input clk,
  input [WIDTH-1:0] d,
  output reg [WIDTH-1:0] q
);

  always @(posedge clk)
    q <= d;
	
endmodule