add R1, R0, R0 ; int sum = 0;
add R2, R0, R0 ; int i = 0;

Loop:
  slti R3, R2, 11 ; i <= 10;
  beq R3, R0, Exit ; if > 10, quit loop
  add R1, R1, R2 ; sum += i;
  addi R2, R2, 1 ; i++;
  j Loop ; repeat loop
  
Exit:
  sr R1, 0x10