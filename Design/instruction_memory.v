/*--------------------------------------------------------------------------
    File Name :instruction_memory.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 22-03-2020
    Last Modified : Friday 03 April 2020 06:03:23 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module inst_mem(
  output reg [15:0] inst,
	input [15:0] inst_addr,
	input clk);

initial inst = 16'bzzzzzz_zzzzz_zzzzz;

always @(negedge clk)
begin
  case(inst_addr)
    		16'd0:
      			inst <= 16'b001010_00000_00001; //SUB #R0, #R1
		16'd1:
			inst <= 16'b000000_00001_00001; //LD #R1, DM[1]
		16'd2:
			inst <= 16'b000000_00000_00000; //LD #R0, DM[0]
		16'd3:
			inst <= 16'b100001_00000_00101; //BRZ 16'd5
		16'd4:
			inst <= 16'b010000_00000_00101; //MOVi #R0, 5
		16'd5:
			inst <= 16'b010000_00000_00110; //MOVi #R0, 6
		16'd6:
			inst <= 16'b000001_00010_00000; //ST DM[2], #R0

	default:
    inst <= 16'bzzzzzz_zzzzz_zzzzz;

  endcase
end
endmodule





