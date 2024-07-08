module control (
  input clk, reset,
  input zero,
  input [5:0] op,
  // enables
  output ir_write, mem_write, pc_write, branch, reg_write,
  // mux select inputs
  output reg mem_to_reg, i_or_d, pc_src, alu_src_a, // PC or reg_a
  output reg [1:0] alu_src_b, // 1, reg_b, immediate
  output reg [2:0] alu_op
);
  `include "ctrl_params.v"
  
  reg [3:0] state, next_state;
  
  
  always @(posedge clk)
    if (reset)
      state <= 0;
    else
      state <= next_state;

  // next state logic
  always @(*)
    if (state == FETCH)
      next_state = DECODE;
    else if (state == DECODE)
      case (op)
        LR: next_state = MEM_RD;
        SR: next_state = MEM_WR;
        BEQ: next_state = BRANCH;
        JMP: next_state = JUMP;
      default:
        if (op <= SLT) // register alu
          next_state = EXE;
        else // immediate alu
          next_state = IMM_EXE;
      endcase
    else if (state == MEM_RD)
      next_state = WR_BK;
    else if (state == EXE || state == IMM_EXE)
      next_state = ALU_WR;
    else
      next_state = FETCH;
  
  
  // output logic
  
  // enables
  assign ir_write = (state == FETCH);
  assign mem_write = (state == MEM_WR);
  assign pc_write = (state == FETCH || state == JUMP || (branch & zero));
  assign branch = (state == BRANCH);
  assign reg_write = (state == WR_BK || state == ALU_WR);	

  // other logic
  always @(*)
    case (state)
    FETCH: // Fetch
    begin
      i_or_d = 0;
      pc_src = 0;
      alu_src_a = 0;
      alu_src_b = 0;
      alu_op = 0;
    end
        
    MEM_RD: i_or_d = 1;
    WR_BK: mem_to_reg = 1;
    
    MEM_WR: i_or_d = 1;
    
    EXE: // ALU Execution
    begin
      alu_src_a = 1;
      alu_src_b = 1;
      alu_op = op[2:0];
      end
      
    ALU_WR: mem_to_reg = 0;
      
    BRANCH:
    begin
      alu_src_a = 1;
      alu_src_b = 1;
      alu_op = 1;
      pc_src = branch & zero;
    end
      
    IMM_EXE:
    begin
      alu_src_a = 1;
      alu_src_b = 2;
      case (op)
        ADDI: alu_op = 0;
        ANDI: alu_op = 2;
        ORI: alu_op = 3;
        SLTI: alu_op = 6;
        default: alu_op = 0;
      endcase
    end
      
    JUMP: pc_src = 1;
      
    endcase

endmodule