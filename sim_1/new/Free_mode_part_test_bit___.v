`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 22:44:54
// Design Name: 
// Module Name: Free_mode_part_test_bit___
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


module Free_mode_part_test_bit___(
        input clk,
        input[7:0] operation,
        output speaker 
    );
    wire [3:0] tmp;
    key_board key_board1(operation,{24'b000_001_010_011_100_101_110_111},tmp);
    Buzzer buzzer1(clk,tmp,speaker);
endmodule


