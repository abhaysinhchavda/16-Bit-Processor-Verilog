/*--------------------------------------------------------------------------
    File Name :alu_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 18-03-2020
    Last Modified : Thursday 19 March 2020 09:30:31 AM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/
`timescale 10ns/10ns

module alu_tb();
wire [15:0]result;
wire [4:0]flags;
reg [15:0]operand1,operand2;
reg [5:0]opcode;

alu m(.result,.flags,.operand1,.operand2,.opcode);

initial begin
  $dumpfile("alu.vcd");
  $dumpvars;
  $monitor("opcode=%b operand1=%b operand2=%b flags=%b result=%b",opcode,operand1,operand2,flags,result);

  operand1<=16'b0000_1111_1111_1111;operand2<=16'b0001_1111_1111_0000;

  #10 opcode<=6'b001_001;  // ADD
  #10 opcode<=6'b010_001;  // ADDi
  
  #10 opcode<=6'b001_111;  // MUL
  
  #10 opcode<=6'b001_010;  // SUB
  #10 opcode<=6'b010_010;  // SUBi
  #10 opcode<=6'b001_110;  // CMP
  #10 opcode<=6'b010_110;  // CMPi
  
  #10 opcode<=6'b001_011;  // XOR
  #10 opcode<=6'b010_011;  // XORi
  
  #10 opcode<=6'b001_100;  // AND
  #10 opcode<=6'b010_100;  // ANDi
  
  #10 opcode<=6'b001_101;  // OR
  #10 opcode<=6'b010_101;  // ORi

  #10 opcode<=6'b011_001; // COM
  #10 opcode<=6'b011_000; // NEG
  #10 opcode<=6'b011_010; // SRL
  #10 opcode<=6'b011_011; // SLL
  #10 opcode<=6'b011_110; // ASR
  
  #10 opcode<=6'b011_111;  // CLR
  #10 opcode<=6'b011_101;  // INC
  #10 opcode<=6'b011_100;  // DEC

  #10 operand1<=16'b1000_1111_1111_1111;operand2<=16'b0001_1111_1111_0000;
  
  #10 opcode<=6'b001_001;  // ADD
  #10 opcode<=6'b010_001;  // ADDi
  
  #10 opcode<=6'b001_111;  // MUL
  
  #10 opcode<=6'b001_010;  // SUB
  #10 opcode<=6'b010_010;  // SUBi
  #10 opcode<=6'b001_110;  // CMP
  #10 opcode<=6'b010_110;  // CMPi
  
  #10 opcode<=6'b001_011;  // XOR
  #10 opcode<=6'b010_011;  // XORi
  
  #10 opcode<=6'b001_100;  // AND
  #10 opcode<=6'b010_100;  // ANDi
  
  #10 opcode<=6'b001_101;  // OR
  #10 opcode<=6'b010_101;  // ORi

  #10 opcode<=6'b011_001; // COM
  #10 opcode<=6'b011_000; // NEG
  #10 opcode<=6'b011_010; // SRL
  #10 opcode<=6'b011_011; // SLL
  #10 opcode<=6'b011_110; // ASR
  
  #10 opcode<=6'b011_111;  // CLR
  #10 opcode<=6'b011_101;  // INC
  #10 opcode<=6'b011_100;  // DEC
  
  #10 operand1<=16'b0000_1111_1111_1111;operand2<=16'b1001_1111_1111_0000;
  
  #10 opcode<=6'b001_001;  // ADD
  #10 opcode<=6'b010_001;  // ADDi
  
  #10 opcode<=6'b001_111;  // MUL
  
  #10 opcode<=6'b001_010;  // SUB
  #10 opcode<=6'b010_010;  // SUBi
  #10 opcode<=6'b001_110;  // CMP
  #10 opcode<=6'b010_110;  // CMPi
  
  #10 opcode<=6'b001_011;  // XOR
  #10 opcode<=6'b010_011;  // XORi
  
  #10 opcode<=6'b001_100;  // AND
  #10 opcode<=6'b010_100;  // ANDi
  
  #10 opcode<=6'b001_101;  // OR
  #10 opcode<=6'b010_101;  // ORi

  #10 opcode<=6'b011_001; // COM
  #10 opcode<=6'b011_000; // NEG
  #10 opcode<=6'b011_010; // SRL
  #10 opcode<=6'b011_011; // SLL
  #10 opcode<=6'b011_110; // ASR
  
  #10 opcode<=6'b011_111;  // CLR
  #10 opcode<=6'b011_101;  // INC
  #10 opcode<=6'b011_100;  // DEC
 
  #10 operand1<=16'b1000_1111_1111_1111;operand2<=16'b1001_1111_1111_0000;
  
  #10 opcode<=6'b001_001;  // ADD
  #10 opcode<=6'b010_001;  // ADDi
  
  #10 opcode<=6'b001_111;  // MUL
  
  #10 opcode<=6'b001_010;  // SUB
  #10 opcode<=6'b010_010;  // SUBi
  #10 opcode<=6'b001_110;  // CMP
  #10 opcode<=6'b010_110;  // CMPi
  
  #10 opcode<=6'b001_011;  // XOR
  #10 opcode<=6'b010_011;  // XORi
  
  #10 opcode<=6'b001_100;  // AND
  #10 opcode<=6'b010_100;  // ANDi
  
  #10 opcode<=6'b001_101;  // OR
  #10 opcode<=6'b010_101;  // ORi

  #10 opcode<=6'b011_001; // COM
  #10 opcode<=6'b011_000; // NEG
  #10 opcode<=6'b011_010; // SRL
  #10 opcode<=6'b011_011; // SLL
  #10 opcode<=6'b011_110; // ASR
  
  #10 opcode<=6'b011_111;  // CLR
  #10 opcode<=6'b011_101;  // INC
  #10 opcode<=6'b011_100;  // DEC

  #10 $finish;
  end

endmodule
