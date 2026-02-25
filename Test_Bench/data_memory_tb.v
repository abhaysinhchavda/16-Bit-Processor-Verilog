/*--------------------------------------------------------------------------
    File Name :data_memory_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Saturday 21 March 2020 12:49:13 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module data_memory_tb();
wire [15:0]mem_d_out;
reg [15:0]mem_d_in;
reg [4:0]mem_addr;
reg mem_wr,clk;

data_memory m(.mem_d_out,.mem_d_in,.mem_addr,.mem_wr,.clk);
always #10 clk=~clk;
initial begin
  $dumpfile("data_memory.vcd");
  $dumpvars;
  $monitor("clk=%b mem_d_in=%b mem_addr=%b mem_wr=%b mem_d_out=%b",clk,mem_d_in,mem_addr,mem_wr,mem_d_out);
  
  clk<=0;
  mem_wr<=0;
  
  #10 mem_addr<=0;
  #40 mem_addr<=1;

  #80 mem_wr<=1; 
  mem_d_in<=16'b0000_0000_0000_1111;
  #100 $finish;
end


endmodule
