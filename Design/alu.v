/*--------------------------------------------------------------------------
    File Name :alu.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 13-01-2020
    Last Modified : Thursday 19 March 2020 09:29:39 AM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/
`timescale 10ns/10ns

module alu(
  output reg [15:0] result,
	output reg [4:0] flags,
	input [15:0] operand1,operand2,
	input [5:0] opcode);

	reg [15:0] temp;

	initial flags = 5'b00000;//[SZNVC] 
	
  always @(*)
	begin
		flags = 5'b00000; //[SZNVC]
		case(opcode)
			6'b001_001,6'b010_001: //ADD,ADDi
				begin
          if(operand1[15] == 1'b0 && operand2[15] == 1'b0) //ADDITION OF TWO POSITIVE NUMBERS  OR  TWO UNSIGNED NUMBERS
          begin
							result = operand1 + operand2;		
              if(result[15] == 1'b1) //OVERFLOW OCCURED 
								flags[1] = 1'b1;
          end
            
          else if((operand1[15] == 1'b0 && operand2[15] == 1'b1) || (operand1[15] == 1'b1 && operand2[15] == 1'b0)) //ADDITION OF POSITIVE AND NEGATIVE NUMBER  OR  TWO UNSINGED NUMBERS
					begin
							{flags[0],result} = operand1 + operand2; //CARRY FLAG OCCURED
							flags[4] = result[15];
					end
            
          else if(operand1[15] == 1'b1 && operand2[15] == 1'b1) //ADDITION TWO NEGATIVE NUMBERS  OR  TWO SIGNED NUMBERS
					begin
							{flags[0],result} = operand1 + operand2; //CARRY FLAG OCCURED
							flags[4] = 1'b1;
              if(result[15] == 1'b0)   //OVERFLOW OCCURED
								flags[1] = 1'b1;
	
						end
				end
		
			6'b001_111: //MUL
				begin
          {flags[0],result} = operand1 * operand2;
				end
				
			6'b001_010,6'b010_010,6'b001_110,6'b010_110: //SUB, SUBi, CMP, CMPi
				begin
					temp = (~operand2 + 1'b1);

					if(operand1[15] == 1'b0 && temp[15] == 1'b0) //ADDITION OF TWO POSITIVE NUMBERS  OR  TWO UNSIGNED NUMBERS
						begin
							result = operand1 + temp;
              if(result[15] == 1'b1) //OVERFLOW OCCURED 
								flags[1] = 1'b1;
            end
					
          else if((operand1[15] == 1'b0 && temp[15] == 1'b1) || (operand1[15] == 1'b1 && temp[15] == 1'b0)) //ADDITION OF POSITIVE AND NEGATIVE NUMBER  OR  ONE UNSINGED AND ONE SIGNED NUMBERS
          begin
							{flags[0],result} = operand1 + temp;
							flags[4] = result[15];
          end
					
          else if(operand1[15] == 1'b1 && temp[15] == 1'b1) //ADDITION TWO NEGATIVE NUMBERS  OR  TWO SIGNED NUMBERS
					begin
							{flags[0],result} = operand1 + temp;
							flags[4] = 1'b1;
							if(result[15] == 1'b0) //OVERFLOW OCCURED
								flags[1] = 1'b1;
          end


				end


			6'b001_011,010_011: //XOR,XORi
				begin
					result = operand1 ^ operand2;
					flags[4] = result[15];	
				end
			
      6'b001_100,010_100: //AND,ANDi
				begin
					result = operand1 & operand2;	
					flags[4] = result[15];	
        end
			
      6'b001_101,010_101: //OR,ORi
				begin
					result = operand1 | operand2;	
					flags[4] = result[15];	
				end

			6'b011_001: //COM
				begin
					result = ~operand1;
					flags[4] = result[15];
        end

			6'b011_000: //NEG
				begin
					result = ~operand1 + 1'b1;
					flags[4] = result[15];
        end

			6'b011_010: //SRL
				begin
					flags[0] = operand1[0];
					result = operand1 >> 1;
					flags[4] = result[15];	
				end

			6'b011_011: //SLL
				begin
					flags[0] = operand1[15];
					result = operand1 << 1;
					flags[4] = result[15];	
				end

			6'b011_110: //ASR
				begin
					result = operand1 >>> 1;
					flags[4] = result[15];	
				end

			6'b011_111: //CLR
				begin
					result = {16{1'b0}};
				end

			6'b011_101: //INC
				begin
          if(operand1[15] == 1'b0) 
          begin
							result = operand1 + 1;		

							if(result[15] == 1'b1) //OVERFLOW OCCURED 
								flags[1] = 1'b1;
	
					end

					else if(operand1[15] == 1'b1) 
					begin
							{flags[0],result} = operand1 + 1;
							flags[4] = result[15];
							
              if(result[15] == 1'b0) //OVERFLOW OCCURED
								flags[1] = 1'b1;
          end
        end

			6'b011_100: //DEC
				begin

					if(operand1[15] == 1'b0)  
						begin
							{flags[0],result} = operand1 + {16{1'b1}};	
							flags[4] = result[15];	
            end

					else if(operand1[15] == 1'b1) 
						begin
							{flags[0],result} = operand1 + {16{1'b1}};
							flags[4] = 1'b1;
							if(result[15] == 1'b0) //OVERFLOW OCCURED
								flags[1] = 1'b1;
            end


				end
		endcase
    
    if(result == 0)  //CHECK FOR ZERO FLAG
      flags[3] = 1'b1;
    if(result[15] == 1'b1)  //NEGATIVE NUMBER CHECK
			flags[2] = 1'b1;

		end	
	
endmodule
