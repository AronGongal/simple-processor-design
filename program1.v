`include "top.v"

module program1();
  reg clk, reset;
  
  top #("mem_file1.txt", "data_file1.txt") uut(clk, reset);
  
  integer i;
  
  initial
  begin
    $dumpfile("program1.vcd");
    $dumpvars(0, program1);
    
    clk <= 0; #5;
    clk <= 1; reset <= 1; #5;
    reset <= 0;
    for (i = 0; i < 15; i = i + 1)
    begin
      clk <= 0; #5;
      clk <= 1; #5;
    end
  end

endmodule