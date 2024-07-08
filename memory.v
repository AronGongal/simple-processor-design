module memory 
  #(parameter MEM_FILE = "mem_file.txt", DATA_FILE = "") (
  input clk,
  input write_enable,
  input [11:0] addr,
  input [35:0] write_data,
  output reg [35:0] read_data
);

  reg [35:0] mem_array [4095:0];
  
  initial
  begin
    $readmemb(MEM_FILE, mem_array, 2048, 4095);
    if (DATA_FILE != "")
      $readmemh(DATA_FILE, mem_array, 0, 32);
  end
  
  always @(*)
    read_data = mem_array[addr];
  
  always @(posedge clk)
    if (write_enable)
      mem_array[addr] <= write_data;
  
endmodule
