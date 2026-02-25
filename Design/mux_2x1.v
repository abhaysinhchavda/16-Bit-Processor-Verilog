/*--------------------------------------------------------------------------
    File Name :mux_2x1.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Saturday 21 March 2020 10:45:42 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module mux_2x1(
	output [15:0] mux_out,
	input [15:0] val1,val2,
	input Sel);

	assign mux_out = (Sel == 1'b0) ? val1 : ((Sel == 1'b1) ? val2 : 16'bzzzz_zzzz_zzzz_zzzz);
					

endmodule
