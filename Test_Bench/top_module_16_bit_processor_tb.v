/*--------------------------------------------------------------------------
    File Name :top_module_16_bit_processor_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 21-03-2020
    Last Modified : Friday 03 April 2020 06:05:35 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module top_module_processor_tb();
reg Rst;

top_module_processor m(.Rst);

initial begin
  $dumpfile("top_module_16_bit_processor.vcd");
  $dumpvars;
  $monitor("rst=%b",Rst);

  Rst<=0;
  #300 Rst<=1;

  #5000000 $finish;
end


endmodule
