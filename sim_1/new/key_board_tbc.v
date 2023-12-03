`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/28 22:29:24
// Design Name: 
// Module Name: key_board_tbc
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


module key_board_tbc(

    );
    reg[7:0] in;
    wire[2:0] out;
    key_board div(in,{24'b000_001_010_011_100_101_110_111},out);
    initial begin
        in=8'b0000_0000;
        $monitor("%d %d",in,out);
        repeat(255) #10 in=in+1;
        #10 $finish;
    end
endmodule