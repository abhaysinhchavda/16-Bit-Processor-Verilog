/*--------------------------------------------------------------------------
    File Name :clock.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 25-01-2020
    Last Modified : Saturday 21 March 2020 12:48:01 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module clock(
	output reg clk);

	initial begin
				clk = 1'b0;
		forever #100 	clk = ~clk;
	
		end

endmodule
