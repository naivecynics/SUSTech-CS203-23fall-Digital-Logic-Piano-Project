`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 16:40:50
// Design Name: 
// Module Name: resetting_using_block
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


module resetting_using_block(
    input wire[7:0] key_board_in,
    output wire[3:0] out
    );
    reg[3:0] tmp=4'd15;
    assign out=tmp;
    always@(key_board_in)
     begin
         case(key_board_in) 
              8'b0000_0001: tmp=4'd1;
              8'b0000_0010: tmp=4'd2;
              8'b0000_0100: tmp=4'd3;
              8'b0000_1000: tmp=4'd4;
              8'b0001_0000: tmp=4'd5;
              8'b0010_0000: tmp=4'd6;
              8'b0100_0000: tmp=4'd7;
              default tmp=4'd15;//avoid illegal input
         endcase
    end
endmodule
