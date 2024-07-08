module register_file (
  input clk,
  input wr_en,
  input [4:0] ra1, ra2, wr_addr,
  input [35:0] wr_data,
  output [35:0] rd1, rd2
);

  reg [35:0] rf [31:0];
  
  always@(posedge clk)
    if (wr_en)
      rf[wr_addr] <= wr_data;

  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
	  
endmodule