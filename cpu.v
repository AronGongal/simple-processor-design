`include "control.v"
`include "datapath.v"

module cpu (
  input clk, reset,
  input [35:0] read_data,
  output mem_write,
  output [11:0] addr,
  output [35:0] write_data
);

  wire zero;
  wire [5:0] op;
  wire ir_write, pc_write, branch, reg_write,
    mem_to_reg, i_or_d, pc_src, alu_src_a;
  wire [1:0] alu_src_b;
  wire [2:0] alu_op;
  
  
  control ctrl(clk, reset, zero, op, ir_write, 
    mem_write, pc_write, branch, reg_write, mem_to_reg,
    i_or_d, pc_src, alu_src_a, alu_src_b, alu_op);

  datapath dp(clk, reset, ir_write, pc_write, branch, 
    reg_write, mem_to_reg, i_or_d, pc_src, alu_src_a,
    alu_src_b, alu_op, read_data, zero, op, addr, write_data);

endmodule