`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 22:20:41
// Design Name: 
// Module Name: Buzzer_tbc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Buzzer_tbc(

    );
     reg clk=1'b0;
     reg[3:0] in,tmp;
     wire out;
     reg clk2=1'b1;
     always@(negedge clk )
     begin
      clk2<=~clk2;
     end
     always@(posedge clk2)
     begin
     tmp=in+1;
     end
     Buzzer buz(clk,in,out);
           initial begin
       forever
       #5 clk=~clk;
       end
       initial begin
       in=4'b0000;
       $monitor("%d %d %d %d",clk,in,out,clk2);
       repeat(15)begin
       #10 
       in=tmp;
       #10
       in=4'b0000;
       end
       #10$finish;
       end
endmodule
