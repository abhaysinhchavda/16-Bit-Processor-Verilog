/*--------------------------------------------------------------------------
    File Name :program_counter_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Saturday 21 March 2020 10:45:59 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module program_counter_tb();
wire [15:0]inst_addr;
reg clk,Pc_Rst,Pc_Ld;
reg [15:0]Pc_addr_in;

program_counter m(.inst_addr,.clk,.Pc_Rst,.Pc_Ld,.Pc_addr_in);

always #10 clk=~clk;

initial begin
  $dumpfile("program_counter.vcd");
  $dumpvars;
  $monitor($time,"clk=%b Pc_Rst=%b Pc_Ld=%b Pc_addr_in=%b inst_addr=%b",clk,Pc_Rst,Pc_Ld,Pc_addr_in,inst_addr);

  clk<=0;
  Pc_Rst<=0; Pc_Ld<=0;
  Pc_addr_in<=16'b0000_1111_0000_1111;

  #20 Pc_Rst<=1;
  #20 Pc_Ld<=1;

  #50 $finish;

end

endmodule
