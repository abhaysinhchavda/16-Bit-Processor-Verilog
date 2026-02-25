/*--------------------------------------------------------------------------
    File Name :mux_2x1_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Saturday 21 March 2020 10:45:46 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module mux_2x1_tb();
wire [15:0] mux_out;
reg [15:0]val1,val2;
reg Sel;

mux_2x1 m(.mux_out,.val1,.val2,.Sel);

initial begin
  $dumpfile("mux_2x1.vcd");
  $dumpvars;
  $monitor("val1=%b val2=%b mux_out=%b Sel=%b",val1,val2,mux_out,Sel);
  
  val1<=16'b0000_1111_0000_1111;
  val2<=16'b1111_0000_1111_0000;
  #10 Sel=0;
  #20 Sel=1;
  #10 $finish;

end

endmodule
