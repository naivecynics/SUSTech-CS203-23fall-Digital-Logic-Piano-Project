`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 21:09:14
// Design Name: 
// Module Name: FREE_MODE
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


module FREE_MODE(
        input clk,
        input[7:0] operation,
        input  [23:0] assign_modul,
        output speaker 
    );
    wire [3:0] tmp;
    key_board key_board1(operation,assign_modul,tmp);
    Buzzer buzzer1(clk,tmp,speaker);
endmodule
