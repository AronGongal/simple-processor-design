module decode (
  input [32:0] instruction,
  output [5:0] opcode,
  output [4:0] src1, src2, dst,
  output [11:0] immediate
);
	
  assign {opcode, src1, src2, dst, immediate} = instruction;
	
endmodule