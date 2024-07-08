module mux4 #(parameter WIDTH = 36) (
  input [WIDTH-1:0] d0, d1, d2, d3,
  input [1:0] sel,
  output [WIDTH-1:0] y
);
  
  assign y = 
    (sel == 0) ? d0 :
    (sel == 1) ? d1 :
    (sel == 2) ? d2 :
    d3;
	
endmodule