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
    reg setting;
    wire[1:0]mode;
    wire signal;
    wire[3:0] signal1;
    wire[3:0] signal2;
    wire[3:0] signal3;
    wire[3:0] signal4;
    wire[3:0] signal5;
    wire[3:0] signal6;
    wire[3:0] signal7;
    wire[3:0] signal8;
    ModeFSM Dev(clk,rst,key_board_in,in,setting,mode,signal,signal1,signal2,signal3,signal4,signal5,signal6,signal7,signal8);
        initial begin
    forever
    #5 clk=~clk;
    end
    initial begin
    $monitor("%d %d %d %d %d %d %d %d",signal1,signal2,signal3,signal4,signal5,signal6,signal7,signal8);
    key_board_in=8'b0000_0000;
    rst=1'b0;
    setting=1'b0;
    #3rst=1'b1;
    #7rst=1'b0;
    #10 setting=1'b1;
    
    #10key_board_in=8'b0010_0000;
    
    #10key_board_in=8'b0000_1000;
    
    #10key_board_in=8'b0100_0000;
    
    #10key_board_in=8'b0000_0010;
    
    #10key_board_in=8'b0001_0000;
    
    #10key_board_in=8'b0000_0001;
    
    #10key_board_in=8'b0000_0100;
    
    #10key_board_in=8'b1000_0000;
    
    #10$finish;
    end
    
    
endmodule
