/*--------------------------------------------------------------------------
    File Name :control_unit_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Tuesday 09 June 2020 06:59:47 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module control_unit_tb();
wire [4:0] mem_addr,reg_addr1,reg_addr2,imd_operand;
wire [5:0]opcode;
wire [15:0]imd_addr;
wire mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,st_reg_ld,pc_addr_sel;
wire [1:0]Din_Sel;
reg [15:0]inst;
reg Rst,clk;
reg [4:0] flags_in;


control_unit m(.mem_addr,.reg_addr1,.reg_addr2,.imd_operand,.opcode,.imd_addr,.mem_wr,.reg_wr,.IorR,.PcorR,.Pc_Rst,.Pc_Ld,.st_reg_ld,.pc_addr_sel,.Din_Sel,.inst,.Rst,.clk,.flags_in);

always #10 clk=~clk;

initial begin
  $dumpfile("control_unit.vcd");
  $dumpvars;
  $monitor("mem_addr=%b reg_addr1=%b reg_addr2=%b imd_operand=%b opcode=%b imd_addr=%b mem_wr=%b reg_wr=%b IorR=%b PcorR=%b Pc_rst=%b Pc_Ld=%b st_reg_ld=%b pc_addr_sel=%b sel=%b inst=%b Rst=%b clk=%b flags_in=%b",mem_addr,reg_addr1,reg_addr2,imd_operand,opcode,imd_addr,mem_wr,reg_wr,IorR,PcorR,Pc_Rst,Pc_Ld,st_reg_ld,pc_addr_sel,Din_Sel,inst,Rst,clk,flags_in);

  inst <= 16'b000_000_00001_00000;
  Rst<=1'b1;
  clk<=1;
  flags_in<=5'b00000;

  #170 inst<=16'b001_011_00001_00000;
  //Rst<=1'b1;

  #170 inst<=16'b010_000_00001_01000;

  #170 inst<=16'b011_000_00001_00001;

  #170 inst<=16'b100_000_0000001010;

  #170 inst<=16'b101_000_00001_00010;

  #170 inst<=16'b110_000_00000_00000;

  #2000 $finish;
end

endmodule
