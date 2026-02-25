/*--------------------------------------------------------------------------
    File Name :sign_extend_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 20-03-2020
    Last Modified : Saturday 21 March 2020 10:46:24 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module sign_extend_tb();
wire [15:0]d_out;
reg [4:0]d_in;

sign_extend m(.d_out,.d_in);

initial begin
  $dumpfile("sign_extend.vcd");
  $dumpvars;
  $monitor("d_in=%b d_out=%b",d_in,d_out);

  #10 d_in<=5'b01010;
  #10 d_in<=5'b10101;
  
  #10 $finish;
end

endmodule
