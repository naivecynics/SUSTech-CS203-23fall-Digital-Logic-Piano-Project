`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 22:36:28
// Design Name: 
// Module Name: Free_mode_tbc
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


module Free_mode_tbc(

    );
    reg clk=1'b0; 
     reg[7:0] in;
    wire out;
   FREE_MODE div(clk,in,{24'b000_001_010_011_100_101_110_111},out);
    initial begin
        in=8'b0000_0000;
        $monitor("%d %d",in,out);
        repeat(255) #10 in=in+1;
        #10 $finish;
    end 
    initial begin
      forever
      #5 clk=~clk;
      end
      
endmodule
