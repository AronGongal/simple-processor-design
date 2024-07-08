module alu (
  input [35:0] A, B, 
  input [2:0] op, 
  output [35:0] result
);
    
  assign result =
    (op == 0) ? A + B :
    (op == 1) ? A - B :
    (op == 2) ? A & B :
    (op == 3) ? A | B :
    (op == 4) ? A ^ B :
    (op == 5) ? ~(A | B) :
    A < B;
    	
endmodule