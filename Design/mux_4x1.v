/*--------------------------------------------------------------------------
    File Name :mux_4x1.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Tuesday 09 June 2020 07:09:27 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module mux_4x1(
	output [15:0] mux_out,
	input [15:0] val1,val2,val3,
	input [1:0] Sel);

assign mux_out = (Sel == 2'b00) ? val1 : ((Sel == 2'b01) ? val2 : ((Sel == 2'b10) ? val3 : 16'bzzzz_zzzz_zzzz_zzzz) );

endmodule
