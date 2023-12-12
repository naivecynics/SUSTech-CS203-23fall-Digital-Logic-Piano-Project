`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 21:59:08
// Design Name: 
// Module Name: F_P_TBC
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


module F_P_TBC(

    );
            reg clk;
    reg[7:0] operation;
    wire speaker;
    Free_mode_part_test_bit___ div(clk,operation,speaker);
    initial begin
    clk=1'b0;
    forever #5 clk=~clk;
    end
    initial begin
    operation=8'b0000_0000;
    repeat(2000) #20 operation = operation+1;
    #20 $finish;
    end
endmodule
