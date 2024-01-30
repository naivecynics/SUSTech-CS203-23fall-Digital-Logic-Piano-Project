    `timescale 1ns / 1ps

module vga_controller(
    input wire clk,      // 100MHz ʱ���ź�
    input rst_n,
    output reg hs,       // ˮƽͬ���ź�
    output reg vs,       // ��ֱͬ���ź�
    output reg [2:0] color,
//    output reg [9:0] x, // ��ǰ����X����
//    output reg [9:0] y  // ��ǰ����Y����
    input  [2:0] state,
    input  [3:0] note
);
   wire clk_150;
   wire clk_100;
//   clock_divider u1(clk, rst_n,clk_out);
    wire     locked;
  //PLL IP call
  clk_wiz_0 clk_wiz_0_inst
     (
      .clk_out1(clk_100),                // OUT 100Mhz
      .clk_150(clk_150),               // OUT 150Mhz
      // Status and control signals     
      .reset(~rst_n),        // pll reset, high-active
      .locked(locked),
      .clk_in1(clk)      // input clk_in1
      );     // OUT

   reg [9:0] x;
   reg [9:0] y;  // ��ǰ����Y����

    // ��Щ����������Ҫ��������Ӧ100MHzʱ��
// 1080p ͬ������
    parameter h_sync_pulse = 44;
    parameter h_back_porch = 148;
    parameter h_disp_time = 1920;
    parameter h_front_porch = 88;
    parameter h_total_time = 2200;
    
    parameter v_sync_pulse = 5;
    parameter v_back_porch = 36;
    parameter v_disp_time = 1080;
    parameter v_front_porch = 4;
    parameter v_total_time = 1125;

    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    always @(posedge clk_150) begin
        // ˮƽ�������߼�
        if (h_counter < h_total_time - 1) h_counter <= h_counter + 1;
        else begin
            h_counter <= 0;
            // ��ֱ�������߼�
            if (v_counter < v_total_time - 1) v_counter <= v_counter + 1;
            else v_counter <= 0;
        end

        // ����ͬ���ź�
        hs <= (h_counter < h_sync_pulse) || (h_counter >= (h_sync_pulse + h_back_porch + h_disp_time) && h_counter < (h_sync_pulse + h_back_porch + h_disp_time + h_front_porch));
        vs <= (v_counter < v_sync_pulse) || (v_counter >= (v_sync_pulse + v_back_porch + v_disp_time) && v_counter < (v_sync_pulse + v_back_porch + v_disp_time + v_front_porch));

        // ������������
        x <= (h_counter < h_disp_time) ? h_counter : 0;
        y <= (v_counter < v_disp_time) ? v_counter : 0;
    end
    
    // �����ַ���ʾλ��
    parameter char_x = 100;  // �ַ���ʼ��X����
    parameter char_y = 100;  // �ַ���ʼ��Y����
    
    // ���㵱ǰ�����Ƿ����ַ�������
    wire in_char_area = (x >= char_x) && (x < char_x + 8) &&
                        (y >= char_y) && (y < char_y + 8);
    
    // ��ǰ�ַ�λ��
    wire [2:0] char_row = y - char_y;
    wire [2:0] char_col = x - char_x;
    
    // ����ROMʵ��
    wire pixel_out;
    char_rom char_rom_instance(
        .row(char_row),
        .col(char_col),
        .pixel(pixel_out)
    );
    
    // ������ɫ
    always @(posedge clk_150) begin
        if (in_char_area && pixel_out)
            color <= 3'b111;  // �ַ�������ʾ��ɫ
        else
            color <= 3'b000;  // ���ַ�������ʾ��ɫ
    end
endmodule

