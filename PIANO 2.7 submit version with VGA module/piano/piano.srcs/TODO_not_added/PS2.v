`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/19 09:58:33
// Design Name: 
// Module Name: PS2
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

module PS2 (
    input           clk,
    input           rst,
    input           PS2D,
    input           PS2C,
    output [15:0]   key
);

reg         ps2c;               //clock transfer to slave
reg         ps2d;               //data ready to slave
reg  [7:0]  ps2c_fliter;
reg  [7:0]  ps2d_fliter;
reg  [10:0] shift1;
reg  [10:0] shift2;

assign      key = { shift2[8:1], shift1[8:1] };

always@( posedge clk or posedge rst )
begin
    if( rst )
    begin
        ps2c            <= 1;
        ps2d            <= 1;
        ps2c_fliter     <= 0;
        ps2d_fliter     <= 0;
    end
    else begin
        ps2c_fliter[7]  <= PS2C;
        ps2d_fliter[7]  <= PS2D;
        ps2c_fliter[6:0]<= ps2c_fliter[7:1];
        ps2d_fliter[6:0]<= ps2d_fliter[7:1];
        if( ps2c_fliter == 8'b11111111 )
            ps2c <= 1;
        else if( ps2c_fliter == 8'b00000000 )
            ps2c <= 0;
        else
            ps2c <= ps2c;
        if( ps2d_fliter == 8'b11111111 )
            ps2d <= 1;
        else if( ps2d_fliter == 8'b00000000 )
            ps2d <= 0; 
        else
            ps2d <= ps2d;
    end
end

always@( negedge ps2c or posedge rst )
begin
    if ( rst )
    begin
        shift1 <= 0;
        shift2 <= 0;
    end
    else
    begin
        shift1 <= { ps2d, shift1[10:1] };
        shift2 <= { shift1[0], shift2[10:1] };         
    end
end
endmodule
