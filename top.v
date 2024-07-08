`include "cpu.v"
`include "memory.v"

module top
  #(parameter MEM_FILE = "mem_file.txt", DATA_FILE = "") (
  input clk, reset
);
  
  wire write_enable;
  wire [11:0] addr;
  wire [35:0] write_data, read_data;
  
  cpu #() proc(clk, reset, read_data, write_enable, addr, write_data);
  memory #(MEM_FILE, DATA_FILE) mem(clk, write_enable, addr, write_data, read_data);
  
endmodule