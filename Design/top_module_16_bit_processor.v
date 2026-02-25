/*--------------------------------------------------------------------------
    File Name :top_module_16_bit_processor.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 21-03-2020
    Last Modified : Tuesday 07 April 2020 12:32:44 AM IST
    Version :
    Organization :        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module top_module_processor(
	input Rst);

wire [4:0] mem_addr,reg_addr1,reg_addr2,imd_operand;
wire mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,clk, st_reg_ld,pc_addr_sel,Rst;
wire [5:0] opcode;
wire [1:0] Din_Sel;
wire [15:0] imd_addr;
wire [4:0] flags_out;
wire [15:0] inst;
wire UTX_UBusy,UTX_SOut;

clock clk_obj(clk);

control_unit cu_obj(mem_addr,reg_addr1,reg_addr2,imd_operand,opcode,imd_addr,mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,st_reg_ld,pc_addr_sel,Din_Sel,inst,Rst,clk,flags_out);

data_path dp_unit_obj(flags_out,inst,mem_addr,reg_addr1,reg_addr2,imd_operand,mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,clk,st_reg_ld,pc_addr_sel,Rst,opcode,Din_Sel,imd_addr);

endmodule
