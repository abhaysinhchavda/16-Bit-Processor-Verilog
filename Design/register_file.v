/*--------------------------------------------------------------------------
    File Name :register_file.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 10-02-2020
    Last Modified : Saturday 21 March 2020 12:50:57 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module reg_file(
  output reg [15:0] reg_out_1,reg_out_2,
	input [4:0] reg_addr1,reg_addr2,
	input [15:0] reg_din,
	input reg_wr,clk);

reg [15:0] registers [31:0];
	
initial begin
  {reg_out_1,reg_out_2} = {32{1'b0}};
  registers[3]=16'b0101_0000_1111_0101;
  registers[8]=16'b1010_1111_0000_1010;
end
	
always @(negedge clk)
begin
  case(reg_wr)
    1'b0:
    begin
	reg_out_1 <= registers[reg_addr1];
	reg_out_2 <= registers[reg_addr2];
    end
    
    1'b1:
    begin
      registers[reg_addr1] <= reg_din;

    end

  endcase
end
endmodule
