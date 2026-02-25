/*--------------------------------------------------------------------------
    File Name :register_file_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 20-03-2020
    Last Modified : Saturday 21 March 2020 10:46:10 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module reg_file_tb();
wire [15:0]reg_out_1,reg_out_2;
reg [4:0]reg_addr1,reg_addr2;
reg [15:0]reg_din;
reg reg_wr,clk;

reg_file m(.reg_out_1,.reg_out_2,.reg_addr1,.reg_addr2,.reg_din,.reg_wr,.clk);

always #10 clk=~clk;

initial begin
  $dumpfile("register_file.vcd");
  $dumpvars;
  $monitor("clk=%b reg_wr=%b reg_din=%b reg_addr1=%b reg_addr2=%b reg_out_1=%b reg_out_2=%b",clk,reg_wr,reg_din,reg_addr1,reg_addr2,reg_out_1,reg_out_2);

  clk<=0;reg_wr<=0;
  reg_din<=16'b0000_1111_0000_1111;

  reg_addr1<=5'b00011; reg_addr2<=5'b01000;
  
  #40 reg_wr<=1;

  #50 $finish;

end

endmodule
