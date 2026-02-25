/*--------------------------------------------------------------------------
    File Name :mux_4x1_tb.v
    File Description :
    Project Name :
    Author Name : abhaysinh chavda
    Creation Date : 19-03-2020
    Last Modified : Saturday 21 March 2020 10:45:52 PM IST
    Version :
    Organization : eitra        
--------------------------------------------------------------------------*/

`timescale 10ns/10ns

module mux_4x1_tb();
wire [15:0]mux_out;
reg [15:0]val1,val2,val3,val4;
reg [1:0]Sel;

mux_4x1 m(.mux_out,.val1,.val2,.val3,.val4,.Sel);

initial begin
  $dumpfile("mux_4x1.vcd");
  $dumpvars;
  $monitor("val1=%b val2=%b val3=%b val4=%b Sel=%b mux_out=%b",val1,val2,val3,val4,Sel,mux_out);

  Sel<=2'b00;
  val1<=16'b0000_0000_0000_1111;
  val2<=16'b0000_0000_1111_0000;
  val3<=16'b0000_1111_0000_0000;
  val4<=16'b1111_0000_0000_0000;

  #20 Sel<=2'b01;
  #20 Sel<=2'b10;
  #20 Sel<=2'b11;

  #20 $finish;

end

endmodule
