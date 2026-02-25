/*--------------------------------------------------------------------------
    File Name :control_unit.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 04-04-2020
    Last Modified : Tuesday 07 April 2020 12:30:05 AM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module control_unit(
	output reg [4:0] mem_addr,reg_addr1,reg_addr2,imd_operand,
	output reg [5:0] opcode,
	output reg [15:0] imd_addr,
	output reg mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,st_reg_ld,pc_addr_sel,
	output reg [1:0] Din_Sel,
	input [15:0] inst,
	input Rst,clk,
	input [4:0] flags_in);

	reg [4:0] state;
	reg M_Type,M_Type_LD;
  reg R_Type,SR_Type;
  reg B_Arth,I_Type,Imd_Arth;
  reg B_Type,B_Type_JMP,B_Type_BRZ,B_Type_BRN,B_Type_BRC,B_Type_BRV;
	reg [4:0] SrcA,DestA;


	parameter S_RESET = 5'b00000,S_FETCH = 5'b00001,S_DECODE = 5'b00010,
            S_EXEC_LD = 5'b00011, S_EXEC_ST = 5'b00100,
		        S_EXEC_B_ARTH = 5'b00101,
            S_WB = 5'b00110,S_EXEC_MOV = 5'b00111,S_WB_MOV = 5'b01000,
            S_EXEC_IMD_ARTH = 5'b01001,S_EXEC_IMD_MOV = 5'b01010,
            S_EXEC_SR = 5'b01011,
            S_INC_PC = 5'b01100, S_LD_PC = 5'b01101,
            S_PRE_FETCH = 5'b01110, S_POST_DECODE = 5'b01111,
		        S_POST_WB = 5'b10000,S_POST_EXEC_MOV = 5'b10001,
            S_EXEC_BR = 5'b10010;

	initial
		begin
		state = S_RESET;
		end

	always @(posedge clk or negedge Rst)
		if(Rst == 1'b0)
			state <= S_RESET;
		else
			case(state)
				S_RESET:
					state <= S_FETCH;
				S_FETCH:
					state <= S_DECODE;
				S_DECODE:
					state <= S_POST_DECODE;
				S_POST_DECODE:
					begin
						if(M_Type == 1'b1)  //MEMORY INSTRUCTION
							begin
							if(M_Type_LD == 1'b1)  // LOAD ( LD )
								state <= S_EXEC_LD;
							else if(M_Type_LD == 1'b0) // STORE ( ST )
								state <= S_EXEC_ST;
							end
						else if(R_Type == 1'b1) // TWO REGISTER INSTRUCTION
							begin
							if(B_Arth == 1'b1)  // FOR ARTHMETIC ( ADD,SUB,XOR,AND,SUB,OR,CMP,MUL )
								state <= S_EXEC_B_ARTH;
             					else if(B_Arth == 1'b0) // FOR MOVE ( MOV ) 
								state <= S_EXEC_MOV;
							end
						else if(I_Type == 1'b1) // IMEDIATE INSTRUCTION
							begin
							if(Imd_Arth == 1'b1) // IMEDIATE ARITHMATHIC ( ADDi,SUBi,ORi,XORi,ANDi,CMPi ) 
								state <= S_EXEC_IMD_ARTH;
							else if(Imd_Arth == 1'b0) // IMEDIATE MOVE ( MOVi )
								state <= S_EXEC_IMD_MOV;
							end
						else if(SR_Type == 1'b1) // SINGLE REGISTER INSTRUCTION
								state <= S_EXEC_SR;
						else if(B_Type == 1'b1) // BRANCH INSTRUCTION
							begin

								if(B_Type_JMP == 1'b1) // JMP
									state <= S_EXEC_BR;
								else if(B_Type_BRZ == 1'b1 && flags_in[3] == 1'b1) // BRZ
									state <= S_EXEC_BR;
								else if(B_Type_BRN == 1'b1 && flags_in[2] == 1'b1) // BRN
									state <= S_EXEC_BR;
								else if(B_Type_BRC == 1'b1 && flags_in[0] == 1'b1) // BRC
									state <= S_EXEC_BR;
								else if(B_Type_BRV == 1'b1 && flags_in[1] == 1'b1) // BRV
									state <= S_EXEC_BR;
								else
									state <= S_INC_PC;
								
							end
            end
				S_WB,S_WB_MOV:
					state <= S_POST_WB;

				S_EXEC_LD,S_EXEC_ST,S_POST_WB:
					state <= S_INC_PC;

				S_EXEC_B_ARTH,S_EXEC_IMD_ARTH,S_EXEC_SR:
					state <= S_WB;

				S_EXEC_MOV,S_EXEC_IMD_MOV:
					state <= S_POST_EXEC_MOV;

				S_POST_EXEC_MOV:
					state <= S_WB_MOV;

				S_INC_PC,S_EXEC_BR:
					state <= S_LD_PC;

				S_LD_PC:
					state <= S_PRE_FETCH;

				S_PRE_FETCH:
					state <= S_FETCH;
      
      endcase

////////////////////////////////////////////////      

	always @(posedge clk or negedge Rst)
	
			case(state)
				S_RESET:
					begin
						Pc_Rst <= 1'b0;
					end

				S_FETCH:
					begin
						Pc_Rst <= 1'b1;
          end

				S_DECODE:
					begin
						opcode <= inst[15:10];
						SrcA <= inst[4:0];
						DestA <= inst[9:5];
						imd_operand <= inst[4:0];
						imd_addr <= {6'b000000,inst[9:0]};
						{M_Type,M_Type_LD} <= 2'b00;
						R_Type <= 1'b0;	
						B_Arth <= 1'b0;
						I_Type <= 1'b0;
						Imd_Arth <= 1'b0;
						SR_Type <= 1'b0;
						B_Type <= 1'b0;
						pc_addr_sel <= 1'b0;
						{B_Type_JMP,B_Type_BRZ,B_Type_BRN,B_Type_BRC,B_Type_BRV} <= 5'b00000;
																
						if(inst[15:13] == 3'b000)
							M_Type <= 1'b1;
						
						if(inst[15:10] == 6'b000_000)
							M_Type_LD <= 1'b1;
							
						if(inst[15:13] == 3'b001)
							R_Type <= 1'b1;
						
						if(inst[15:10] != 6'b001_000)
							B_Arth <= 1'b1;

						if(inst[15:13] == 3'b010)
							I_Type <= 1'b1;
						
						if(inst[15:10] != 6'b010_000)
							Imd_Arth <= 1'b1;

						if(inst[15:13] == 3'b011)
							SR_Type <= 1'b1;
						
						if(inst[15:13] == 3'b100)
							B_Type <= 1'b1;

						if(inst[15:10] == 6'b100_000)
							B_Type_JMP <= 1'b1;

						if(inst[15:10] == 6'b100_001)
							B_Type_BRZ <= 1'b1;

						if(inst[15:10] == 6'b100_010)
							B_Type_BRN <= 1'b1;

						if(inst[15:10] == 6'b100_011)
							B_Type_BRC <= 1'b1;

						if(inst[15:10] == 6'b100_100)
							B_Type_BRV <= 1'b1;


          end

				S_EXEC_LD:
					begin
						mem_wr <= 1'b0;
						mem_addr <= SrcA;
						reg_addr1 <= DestA;
						Din_Sel <= 1'b0;
						reg_wr <= 1'b1;
					end

				S_EXEC_ST:
					begin
						mem_wr <= 1'b1;
						mem_addr <= DestA;
						reg_addr1 <= SrcA;
						reg_wr <= 1'b0;
					end

				S_EXEC_B_ARTH:
					begin
						reg_addr1 <= DestA;
						reg_addr2 <= SrcA;
						reg_wr <= 1'b0;
						IorR <= 1'b1;
						PcorR <= 1'b0;
					end

				S_EXEC_MOV:
					begin
						reg_addr1 <= DestA;
						reg_addr2 <= SrcA;
						IorR <= 1'b1;
						reg_wr <= 1'b0;
					end

				S_POST_EXEC_MOV:
					begin
						reg_wr <= 1'b0;
					end

				S_WB_MOV:
					begin
						Din_Sel = 2'b10;
						reg_wr <= 1'b1;
					end

				S_EXEC_IMD_ARTH:
					begin
						reg_addr1 = DestA;
						reg_wr <= 1'b0;
						IorR <= 1'b0;
						PcorR <= 1'b0;
					end

				S_EXEC_IMD_MOV:
					begin
						reg_addr1 <= DestA;
						IorR <= 1'b0;
						reg_wr <= 1'b0;
					end

				S_EXEC_SR:
					begin
						reg_addr1 <= SrcA;
						reg_wr <= 1'b0;
						PcorR <= 1'b0;
					end

				S_WB:
					begin
						Din_Sel <= 1'b1;
						reg_wr <= 1'b1;
						if(R_Type == 1'b1 || I_Type == 1'b1 || SR_Type == 1'b1)
							st_reg_ld <= 1'b1;
					end

				S_POST_WB:
					begin
						reg_wr <= 1'b0;
						st_reg_ld <= 1'b0;
					end

				S_INC_PC:
					begin
						PcorR <= 1'b1;
						opcode <= 6'b011_101;
						
					end

				S_LD_PC:
					begin
						Pc_Ld <= 1'b1;
					end

				S_PRE_FETCH:
					begin
						Pc_Ld <= 1'b0;
						PcorR <= 1'b0;
					end

				S_EXEC_BR:
					begin
						pc_addr_sel <= 1'b1;
          end


			endcase
		
		
endmodule
