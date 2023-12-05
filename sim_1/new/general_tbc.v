`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 21:52:21
// Design Name: 
// Module Name: general_tbc
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


module general_tbc(

    );
    reg clk=1'b0;

    reg rst,in;
    reg[7:0]key_board_in;
    wire[1:0]mode;
    wire signal;
    ModeFSM Dev(clk,rst,key_board_in,in,mode,signal);
        initial begin
    forever
    #5 clk=~clk;
    end
    initial begin
    key_board_in=8'b0000_0000;
    $monitor("%d %d %d %d %d %d",clk,rst,key_board_in,in,mode,signal);
    rst=1'b0;
    #3rst=1'b1;
    #5in=1'b1;
    #7in=1'b1;
    #10in=1'b1;
     repeat(255) #10 key_board_in=key_board_in+1;
           #10 $finish;
    end
    
    
endmodule
