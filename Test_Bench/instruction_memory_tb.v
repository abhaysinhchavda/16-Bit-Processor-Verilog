/*--------------------------------------------------------------------------
    File Name :instruction_memory_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 21-03-2020
    Last Modified : Saturday 21 March 2020 10:45:09 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module inst_mem_tb();
wire [15:0]inst;
reg [15:0]inst_addr;
reg clk;
integer i;

inst_mem m(.inst,.inst_addr,.clk);

always #10 clk=~clk;

initial begin
  $dumpfile("instruction_memory.vcd");
  $dumpvars;
  $monitor("clk=%b inst_addr=%b inst=%b",clk,inst_addr,inst);

  clk<=0;
  for(i=0;i<10;i++)
    #40 inst_addr=i;
  #50 $finish;
end

endmodule
