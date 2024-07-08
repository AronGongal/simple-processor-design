`include "decode.v"
`include "register_file.v"
`include "alu.v"
`include "zero_detect.v"

`include "flop.v"
`include "flopen.v"
`include "flopenr.v"
`include "mux2.v"
`include "mux4.v"
`include "sign_ext.v"

module datapath (
  input clk, reset,
  input ir_write, pc_write, branch, rf_write,
  input mem_to_reg, i_or_d, pc_src, alu_sel_a,
  input [1:0] alu_sel_b,
  input [2:0] alu_op,
  input [35:0] read_data,
  
  output zero,
  output [5:0] op,
  output [11:0] addr,
  output [35:0] write_data
);
  
  wire [4:0] ra1, ra2, wr_addr;
  wire [11:0] imm, pc, pc_ro;
  wire [32:0] instr;
  wire [35:0] mem_data, rf_wr, rf_a, rf_b, a, b, imm_ext,
    alu_src_a, alu_src_b, alu_result, reg_result, pc_ext;
  
  flopen #(33) instr_reg(clk, ir_write, read_data[32:0], instr);
  decode instr_dec(instr, op, ra1, ra2, wr_addr, imm);
  
  flop mem_reg(clk, read_data, mem_data);
  mux2 mux_mtr(reg_result, mem_data, mem_to_reg, rf_wr);
  
  register_file reg_file(clk, rf_write, ra1, ra2, wr_addr,
    rf_wr, rf_a, rf_b);
  
  flop reg_a(clk, rf_a, a);
  flop reg_b(clk, rf_b, b);
  sign_ext se_imm(imm, imm_ext);
  
  mux2 alu_mux_a(pc_ext, a, alu_sel_a, alu_src_a);
  mux4 alu_mux_b(36'b1, b, imm_ext, 36'b0, alu_sel_b, alu_src_b);
  alu alu1(alu_src_a, alu_src_b, alu_op, alu_result);
  
  flop alu_reg(clk, alu_result, reg_result);
  
  zero_detect zd(alu_result, zero);
  
  mux2 #(12) pc_mux(alu_result[11:0], {1'b1, imm[10:0]}, pc_src, pc);
  flopenr #(12, 2048) pc_reg(clk, reset, pc_write, pc, pc_ro);
  
  sign_ext se_pc(pc_ro, pc_ext);
  
  mux2 #(12) addr_mux(pc_ro, imm, i_or_d, addr);
  
  assign write_data = a;
    
endmodule