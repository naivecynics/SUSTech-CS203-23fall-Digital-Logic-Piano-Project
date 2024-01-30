`timescale 1ns / 1ps


module vga_character(
    input wire        sys_clk,
    input wire        sys_rst_n,
    input [2:0] state,
    input [2:0]song_num,
    input [6:0]keyboard,

    output wire       hsync,
    output wire       vsync,
    output wire  [11:0] vga_rgb
    
);


wire        vga_clk;
wire        locked;
wire        rst_n_w;

   wire clk_150;
   wire clk_100;

wire    [9:0]    pix_x;
wire    [9:0]    pix_y;
wire    [11:0]   pix_data;


assign  rst_n_w = (sys_rst_n && locked);

clk_wiz_0 clk_wiz
(
  // Clock out ports
  .clk_out1(clk_100),     // output clk_out1
  .clk_150(clk_150),     // output clk_150
  .clk_out3(vga_clk),
  // Status and control signals
  .reset(~sys_rst_n), // input reset
  .locked(locked),       // output locked
 // Clock in ports
  .clk_in1(sys_clk)
);

vga_ctrl vga_ctrl_inst
(
    .vga_clk  (vga_clk) ,
    .sys_rst_n(rst_n_w) ,
    .pix_data (pix_data) ,

    .pix_x    (pix_x  ),
    .pix_y    (pix_y  ),
    .hsync    (hsync  ),
    .vsync    (vsync  ),
    .vga_rgb  (vga_rgb)
);

vga_display_char u1
(
    .vga_clk(vga_clk),
    .sys_rst_n(rst_n_w),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .state(state),
    .song_num(song_num),
    .keyboard(keyboard),

    .pix_data(pix_data)
);
endmodule

