/*--------------------------------------------------------------------------
    File Name :data_path.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 03-04-2020
    Last Modified : Tuesday 07 April 2020 12:32:42 AM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module data_path(
	output [4:0] flags_out,
	output [15:0] inst,
	input [4:0] mem_addr,reg_addr1,reg_addr2,imd_operand,
	input mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,clk, st_reg_ld,pc_addr_sel,Rst,
	input [5:0] opcode,
	input [1:0] Din_Sel,
	input [15:0] imd_addr);

	wire [15:0] inst_addr; 
  wire [15:0] se_op;
	wire [15:0] reg_out_1,reg_out_2,mem_d_out,reg_d_in,temp_out,result,operand1,operand2,pc_addr;
	wire [4:0] flags_in;

	program_counter pc_obj(inst_addr,clk,Pc_Rst,Pc_Ld,pc_addr);

	inst_mem instmem_obj(inst,inst_addr,clk);

	data_memory dm_obj(mem_d_out,reg_out_1,mem_addr,mem_wr,clk);
	
	mux_4x1 mux_obj1(reg_d_in,mem_d_out,result,temp_out,Din_Sel);

	reg_file regfile_obj(reg_out_1,reg_out_2,reg_addr1,reg_addr2,reg_d_in,reg_wr,clk);
	
	temp_storage ts_obj(temp_out,operand2,reg_wr, clk);

	sign_extend se_obj(se_op,imd_operand);

	mux_2x1 mux_obj2(operand2,se_op,reg_out_2,IorR);
	mux_2x1 mux_obj3(operand1,reg_out_1,inst_addr,PcorR);
	
	alu alu_obj(result,flags_in,operand1,operand2,opcode);
	
	status_reg st_reg_obj(flags_out,flags_in,st_reg_ld,Rst,clk);

	mux_2x1 mux_obj4(pc_addr,result,imd_addr,pc_addr_sel);


endmodule
