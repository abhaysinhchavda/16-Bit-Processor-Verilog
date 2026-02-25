/*--------------------------------------------------------------------------
    File Name :temp_storage.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 02-03-2020
    Last Modified : Saturday 21 March 2020 10:46:34 PM IST
    Version :
    Organization :         
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module temp_storage(
	output [15:0] temp_out,
	input [15:0] temp_in,
	input reg_wr,clk);

wire comp_reg_wr;
reg [15:0] temp_register;

not g1(comp_reg_wr,reg_wr);

assign temp_out = temp_register;

initial temp_register = {16{1'b0}};
	
always @(negedge clk)
  if(comp_reg_wr == 1'b1)
  begin
    temp_register <= temp_in;
  end
	
endmodule
