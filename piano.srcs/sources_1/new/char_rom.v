`timescale 1ns / 1ps
module char_rom(
    input [2:0] row,          // 字符行
    input [2:0] col,          // 字符列
    output reg pixel          // 对应像素值
);

    always @(*) begin
        case ({row, col})
            6'b000000, 6'b000111, // 第一行：两个边角像素点
            6'b001001, 6'b001110, // 第二行：...
            6'b010010, 6'b010101, // 第三行：...
            6'b011111,            // 第四行：全部像素点
            6'b100010, 6'b100101, // 第五行：...
            6'b101010, 6'b101101, // 第六行：...
            6'b110010, 6'b110101, // 第七行：...
            6'b111010, 6'b111101: // 第八行：...
                pixel = 1;        // 设置像素点为“亮”
            default: pixel = 0;   // 其他像素点为“暗”
        endcase
    end
endmodule
