`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/15 10:22:14
// Design Name: 
// Module Name: alreay_setting_block
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


module alreay_setting_block(
input wire[7:0] key_board_in,
input wire[2:0] state,
    output wire[3:0] out
    );
    reg[3:0] tmp=4'd15;
    assign out=tmp;
    always@(key_board_in)
     begin
     case(state)
        3'b110:begin
         case(key_board_in) 
              8'b1000_0000: tmp=4'd1;
              8'b0100_0000: tmp=4'd2;
              8'b0010_0000: tmp=4'd3;
              8'b0001_0000: tmp=4'd4;
              8'b0000_1000: tmp=4'd5;
              8'b0000_0100: tmp=4'd6;
              8'b0000_0010: tmp=4'd7;
              default tmp=4'd15;//avoid illegal input
         endcase
         end
         3'b100:begin
         case(key_board_in) 
                       8'b1000_0000: tmp=4'd1;
                       8'b0100_0000: tmp=4'd2;
                       8'b0010_0000: tmp=4'd3;
                       8'b0001_0000: tmp=4'd4;
                       8'b0000_1000: tmp=4'd5;
                       8'b0000_0100: tmp=4'd6;
                       8'b0000_0010: tmp=4'd7;
                       default tmp=0;//avoid illegal input
                  endcase
         end
         default tmp=0;
      endcase   
    end
endmodule
