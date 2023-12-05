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
     reg[3:0] in;
     wire out;
     Buzzer buz(clk,in,out);
           initial begin
       forever
       #5 clk=~clk;
       end
       initial begin
       in=4'b0000;
       $monitor("%d %d %d",clk,in,out);
       repeat(15)#10 in=in+1;
       #10$finish;
       end
endmodule
