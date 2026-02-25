/*--------------------------------------------------------------------------
    File Name :status_register_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 20-03-2020
    Last Modified : Saturday 21 March 2020 10:46:31 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module status_reg_tb();
wire [4:0]flags_out;
reg [4:0]flags_in;
reg clk,ld,rst;

status_reg m(.flags_out,.flags_in,.clk,.ld,.rst);

always #10 clk=~clk;

initial begin
  $dumpfile("status_register.vcd");
  $dumpvars;
  $monitor("clk=%b ld=%b rst=%b flags_in=%b flags_out=%b",clk,ld,rst,flags_in,flags_out);
  
  clk<=0;
  ld<=1;
  flags_in=5'b01010;

  #20 rst<=0;
  #30 rst<=1;
  #50 ld<=0; flags_in<=5'b10101;

  #50 ld<=1;

  #100 $finish;

end

endmodule
