/*--------------------------------------------------------------------------
    File Name :data_memory.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-02-2020
    Last Modified : Sunday 22 March 2020 12:20:34 AM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module data_memory(	
	output reg [15:0] mem_d_out,
	input [15:0] mem_d_in,
	input [4:0] mem_addr,
	input mem_wr,clk);
	
reg [15:0] memory [31:0];

initial begin
  	memory[0] = 16'b0000_0000_0000_0110; // 6 stored on location 0
	memory[1] = 16'b0000_0000_0000_0101; // 5 stored on location 1
	mem_d_out = 16'bzzzz_zzzz_zzzz_zzzz; 
end
	
always @(posedge clk)
				
			case(mem_wr)	
					1'b0:
						mem_d_out <= memory[mem_addr];		
						
					1'b1:
						memory[mem_addr] <= mem_d_in;
							
					default:
						mem_d_out = 16'bzzzz_zzzz_zzzz_zzzz;

			endcase
				
endmodule
