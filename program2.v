`include "top.v"

module program2();
  reg clk, reset;
  
  top #("mem_file2.txt") uut(clk, reset);
  
  integer i;
  
  initial
  begin
    $dumpfile("program2.vcd");
    $dumpvars(0, program2);
    
    clk <= 0; reset <= 1; #5;
    clk <= 1; #5;
    reset <= 0;
    
    for (i = 0; i < 220; i = i + 1)
    begin
      clk <= 0; #5;
      clk <= 1; #5;
    end
  end
  
endmodule