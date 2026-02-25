/*--------------------------------------------------------------------------
    File Name :status_register.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 01-03-2020
    Last Modified : Saturday 21 March 2020 10:46:28 PM IST
    Version :
    Organization :         
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module status_reg(
		output [4:0]flags_out,
		input [4:0]flags_in,
		input clk,ld,rst);

reg [4:0]st_reg;

assign flags_out = st_reg;

initial st_reg = 5'b00000;

always @(posedge clk or negedge rst)
begin
  if(rst == 1'b0)
    st_reg <= 5'b00000;
	else
		if(ld == 1'b1)
      st_reg <= flags_in;
		end

endmodule
