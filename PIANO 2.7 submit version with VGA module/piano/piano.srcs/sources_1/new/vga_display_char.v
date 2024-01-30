`timescale 1ns / 1ps

module vga_display_char(
input wire         vga_clk     ,
input wire         sys_rst_n   ,
input wire  [9:0]  pix_x       ,
input wire  [9:0]  pix_y       ,
input [2:0] state,
input [2:0]song_num,
input [6:0]keyboard,

output reg   [11:0]    pix_data
    );
    //parameter define
    parameter H_DISP = 10'd640;   //分辨率 行
    parameter V_DISP = 10'd480;   //分辨率 列
    
    //center box
    parameter POS_X  = 10'd288,   //字符区 域起始点横坐标
                POS_Y  = 10'd232,   //字符区域起始点纵坐标
                WIDTH  = 10'd64,     //字符区域宽度
                HEIGHT = 10'd16,    //字符区域高度
                RED    = 16'b11111_000000_00000,    //字符颜色
                BLUE   = 16'b00000_000000_11111 ,  //字符区域背景 色
                BLACK  = 16'b00000_000000_00000;  //屏幕背景色
     // song_library box          
     parameter POS_X1  = 10'd0,   //字符区 域起始点横坐标
                 POS_Y1  = 10'd0,   //字符区域起始点纵坐标
                 WIDTH_1  = 10'd160,     //字符区域宽度
                 HEIGHT_1 = 10'd16;    //字符区域高度
                 
     parameter POS_X2  = 10'd0,   //字符区 域起始点横坐标
                POS_Y2  = 10'd50,   //字符区域起始点纵坐标
                WIDTH_2  = 10'd64,     //字符区域宽度
                HEIGHT_2 = 10'd16;    //字符区域高度

    
    //字符数组
     reg[63:0] char[15:0];
     
     reg[159:0] char_1[15:0];
     reg[63:0] char_2[15:0];
    
    //wire define
    wire [ 9:0] x_cnt;
    wire [ 9:0] y_cnt;
    
    wire [ 9:0] x_cnt1;
    wire [ 9:0] y_cnt1;
    wire [ 9:0] x_cnt2;
    wire [ 9:0] y_cnt2;

    
    //main code
    assign x_cnt = pix_x - POS_X;  //像素点相对于字符区域起始点水平坐标
    assign y_cnt = pix_y - POS_Y;     //像素点相对于字符区域起始点竖直坐标
    
    assign x_cnt1 = pix_x - POS_X1;  //像素点相对于字符区域起始点水平坐标
    assign y_cnt1 = pix_y - POS_Y1;     //像素点相对于字符区域起始点竖直坐标   
     assign x_cnt2 = pix_x - POS_X2;  //像素点相对于字符区域起始点水平坐标
     assign y_cnt2 = pix_y - POS_Y2;     //像素点相对于字符区域起始点竖直坐标
       
    
    //给字符数组赋值
    always@(posedge vga_clk)begin
        char[0]<=    64'h0100000010000000; 
        char[1]<=    64'h01007ff811fcfefe; 
        char[2]<=    64'h010000103d041010;
        char[3]<=    64'h3ff8002021041010; 
        char[4]<=    64'h2108004041947c7c; 
        char[5]<=    64'h21080180bd541010; 
        char[6]<=    64'h2108010011541010; 
        char[7]<=    64'h3ff8fffe1124fefe; 
        char[8]<=    64'h21080100fd240100; 
        char[9]<=    64'h21080100115406c0; 
        char[10]<=   64'h2108010011541a30; 
        char[11]<=   64'h3ff801001194e10e; 
        char[12]<=   64'h210a010015041fe0; 
        char[13]<=   64'h0102010019040040; 
        char[14]<=   64'h0102050011140080; 
        char[15]<=   64'h00fe020001080100;   
    end
  
    //song library
    always@(posedge vga_clk) begin
    char_1[0]  <= 160'h0000010000000000000000000100010010000440;
    char_1[1]  <= 160'h000001001ff01ff000000000010001003ffc0440;
    char_1[2]  <= 160'h000001001010101000000000010011f84aa00440;
    char_1[3]  <= 160'h080001001ff01ff000003c00010011000aa00440;
    char_1[4]  <= 160'h380001001010101000004200010011007ffc7ffc;
    char_1[5]  <= 160'h080011101ff01ff000004200111011000aa04444;
    char_1[6]  <= 160'h0800110801000100000042001108fffe0aa04444;
    char_1[7]  <= 160'h080011041100110000000200110401007ffc4444;
    char_1[8]  <= 160'h080021041ff81ff8000004002104010010104444;
    char_1[9]  <= 160'h0800210221002100000008002102110810107ffc;
    char_1[10] <= 160'h080041024100410000001000410211103efc4444;
    char_1[11] <= 160'h080081021ff01ff0000020008102212042104444;
    char_1[12] <= 160'h080001000100010000004200010040c014904444;
    char_1[13] <= 160'h3e0001000100010000007e000100030008fe4444;
    char_1[14] <= 160'h000005007ffc7ffc0000000005001c0030107ffc;
    char_1[15] <= 160'h0000020000000000000000000200e000c0104004;
    end
    
//    wire  note1 =4'b0001;
    always@(posedge vga_clk)begin
    case (keyboard)
    7'b0000001: begin
        // "do"
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000; 
        char_2[3] <= 64'hf8000000;  
        char_2[4] <= 64'h44000000; 
        char_2[5] <= 64'h42000000;
        char_2[6] <= 64'h42000000;  
        char_2[7] <= 64'h42003c00; 
        char_2[8] <= 64'h42004200;  
        char_2[9] <= 64'h42004200; 
        char_2[10] <= 64'h42004200; 
        char_2[11] <= 64'h42004200; 
        char_2[12] <= 64'h44004200; 
        char_2[13] <= 64'hf8003c00; 
        char_2[14] <= 64'h00000000; 
        char_2[15] <= 64'h00000000; 
    end
    7'b0000010: begin
        // "re"
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'hfc000000;
        char_2[4] <= 64'h42000000;
        char_2[5] <= 64'h42000000;
        char_2[6] <= 64'h42000000;
        char_2[7] <= 64'h7c003c00;
        char_2[8] <= 64'h48004200;
        char_2[9] <= 64'h48004200;
        char_2[10] <= 64'h44007e00;
        char_2[11] <= 64'h44004000;
        char_2[12] <= 64'h42004200;
        char_2[13] <= 64'he3003c00;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    7'b0000100: begin
        // "mi"
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'hee003000;
        char_2[4] <= 64'h6c003000;
        char_2[5] <= 64'h6c000000;
        char_2[6] <= 64'h6c000000;
        char_2[7] <= 64'h6c007000;
        char_2[8] <= 64'h6c001000;
        char_2[9] <= 64'h54001000;
        char_2[10] <= 64'h54001000;
        char_2[11] <= 64'h54001000;
        char_2[12] <= 64'h54001000;
        char_2[13] <= 64'hd6007c00;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    7'b0001000: begin
        // "fa"的字模数据
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'hfc000000;
        char_2[4] <= 64'h42000000;
        char_2[5] <= 64'h48000000;
        char_2[6] <= 64'h48000000;
        char_2[7] <= 64'h78003800;
        char_2[8] <= 64'h48004400;
        char_2[9] <= 64'h48000c00;
        char_2[10] <= 64'h40003400;
        char_2[11] <= 64'h40004400;
        char_2[12] <= 64'h40004c00;
        char_2[13] <= 64'he0003600;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    7'b0010000: begin
        // "so"的字模数据
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'h3e000000;
        char_2[4] <= 64'h42000000;
        char_2[5] <= 64'h42000000;
        char_2[6] <= 64'h40000000;
        char_2[7] <= 64'h20003c00;
        char_2[8] <= 64'h18004200;
        char_2[9] <= 64'h04004200;
        char_2[10] <= 64'h02004200;
        char_2[11] <= 64'h42004200;
        char_2[12] <= 64'h42004200;
        char_2[13] <= 64'h7c003c00;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    7'b0100000: begin
        // "la"的字模数据
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'he0000000;
        char_2[4] <= 64'h40000000;
        char_2[5] <= 64'h40000000;
        char_2[6] <= 64'h40000000;
        char_2[7] <= 64'h40003800;
        char_2[8] <= 64'h40004400;
        char_2[9] <= 64'h40000c00;
        char_2[10] <= 64'h40003400;
        char_2[11] <= 64'h40004400;
        char_2[12] <= 64'h42004c00;
        char_2[13] <= 64'hfe003600;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    7'b1000000: begin
        // "si"的字模数据
        char_2[0] <= 64'h00000000;
        char_2[1] <= 64'h00000000;
        char_2[2] <= 64'h00000000;
        char_2[3] <= 64'he7003000;
        char_2[4] <= 64'h42003000;
        char_2[5] <= 64'h24000000;
        char_2[6] <= 64'h24000000;
        char_2[7] <= 64'h18007000;
        char_2[8] <= 64'h18001000;
        char_2[9] <= 64'h18001000;
        char_2[10] <= 64'h24001000;
        char_2[11] <= 64'h24001000;
        char_2[12] <= 64'h42001000;
        char_2[13] <= 64'he7007c00;
        char_2[14] <= 64'h00000000;
        char_2[15] <= 64'h00000000;
    end
    default:begin
    char_2[0] <= 64'h0000;
    char_2[1] <= 64'h0000; 
    char_2[2] <= 64'h0000; 
    char_2[3] <= 64'h1800; 
    char_2[4] <= 64'h2400; 
    char_2[5] <= 64'h4200; 
    char_2[6] <= 64'h4200; 
    char_2[7] <= 64'h4200; 
    char_2[8] <= 64'h4200; 
    char_2[9] <= 64'h4200; 
    char_2[10] <= 64'h4200; 
    char_2[11] <= 64'h4200; 
    char_2[12] <= 64'h2400; 
    char_2[13] <= 64'h1800; 
    char_2[14] <= 64'h0000; 
    char_2[15] <= 64'h0000;
    end
        endcase
    end

//    wire [63:0] char_data;
//    reg [3:0] row=0;
   
//   //get info from char_library 
//       char_library char_lib (
//         .state(state),
//         .song_num(song_num),
//         .row(row),
//         .char_data(char_data)
//     );
//     always @(state) begin
//             // 更新char数组的逻辑
//             char[row] <= char_data;
 
//             // 更新row索引，确保它在0到15之间循环
//             if (row < 15) begin
//                 row <= row + 1;
//             end else begin
//                 row <= 0; // 或者在完成一轮更新后触发其他操作
//             end
//         end
    
 
//drawing

    always @ (posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            pix_data <= BLACK;
        else begin
               // 先检查char_2
        if( (pix_x >= POS_X2) && (pix_x < POS_X2 + WIDTH_2)
           &&(pix_y >= POS_Y2) && (pix_y < POS_Y2 + HEIGHT_2) ) begin
            if (char_2[y_cnt2] [10'd63 - x_cnt2] )
                pix_data <= RED;   // char_2 draw red
            else
                pix_data <= BLUE;  // bg draw blue 
        end
        // 再检查char
        else if( (pix_x >= POS_X) && (pix_x < POS_X + WIDTH)
               &&(pix_y >= POS_Y) && (pix_y < POS_Y + HEIGHT) ) begin
            if (char[y_cnt] [10'd63 - x_cnt] )
                pix_data <= RED;   // char draw red
            else
                pix_data <= BLUE;  // bg draw blue 
        end
        // 最后检查char_1
        else if( (pix_x >= POS_X1) && (pix_x < POS_X1 + WIDTH_1)
               &&(pix_y >= POS_Y1) && (pix_y < POS_Y1 + HEIGHT_1) ) begin
            if (char_1[y_cnt1] [10'd159 - x_cnt1] )
                pix_data <= RED;   // char_1 draw red
            else
                pix_data <= BLUE;  // bg draw blue 
        end
            else
               pix_data <= BLACK;  //screen 
        end
    end
    // Inside vga_display_char module
//     reg note_reg;
//    always @(posedge vga_clk) begin
//        if (sys_rst_n) begin
//            // 打印note值，每次note改变时
//            if (note !== note_reg) begin
//                $display("Time: %t, Note changed to: %b", $time, note);
//                note_reg <= note;
//            end
//        end
//    end

    endmodule

