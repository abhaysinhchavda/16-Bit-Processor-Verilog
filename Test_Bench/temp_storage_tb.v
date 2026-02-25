/*--------------------------------------------------------------------------
    File Name :temp_storage_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 20-03-2020
    Last Modified : Saturday 21 March 2020 10:46:37 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module temp_storage_tb();
wire [15:0]temp_out;
reg [15:0]temp_in;
reg reg_wr,clk;

temp_storage m(.temp_out,.temp_in,.reg_wr,.clk);

always #10 clk=~clk;

initial begin
  $dumpfile("temp_storage.vcd");
  $dumpvars;
  $monitor("clk=%b reg_wr=%b temp_in=%b temp_out=%b",clk,reg_wr,temp_in,temp_out);

  clk<=0;
  reg_wr<=0;temp_in<=16'b0011_0011_1100_1100;

  #40 reg_wr<=1;temp_in<=16'b1100_1100_0011_0011;

  #40 reg_wr<=0;

  #50 $finish;

end

endmodule
