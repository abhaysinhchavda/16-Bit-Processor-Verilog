/*--------------------------------------------------------------------------
    File Name :sign_extend.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 25-02-2020
    Last Modified : Saturday 21 March 2020 10:46:13 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module sign_extend(
	output [15:0] d_out,
	input [4:0] d_in);

	assign d_out = (d_in[4] == 1'b0) ? {{11{1'b0}},d_in} : {{11{1'b1}},d_in};

endmodule
