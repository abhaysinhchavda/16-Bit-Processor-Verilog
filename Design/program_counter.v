/*--------------------------------------------------------------------------
    File Name :program_counter.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 26-01-2020
    Last Modified : Saturday 21 March 2020 10:45:55 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module program_counter(
	output [15:0] inst_addr,
	input clk,Pc_Rst,Pc_Ld,
	input [15:0] Pc_addr_in);

reg [15:0] addr;

assign inst_addr = addr;

initial addr = 6'd0;
	
always @(posedge clk or negedge Pc_Rst)
			if(Pc_Rst == 1'b0)
				addr <= 16'd0;
			else if(Pc_Ld == 1'b1)
				addr <= Pc_addr_in;
	
endmodule
