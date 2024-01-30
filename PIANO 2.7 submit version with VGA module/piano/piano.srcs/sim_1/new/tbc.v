`timescale 1ns / 1ps
module tbc();
    reg clk;
    reg rst_n;
    reg U_, D_, L_, R_, C_;
    reg [7:0] keyboard;
    reg [1:0] eight_switch;
    wire [3:0] seg_ena;
    wire [7:0] seg_out;
    wire [3:0] seg_ena_r;
    wire [7:0] seg_out_r;
    wire [7:0] test_led;
    wire speaker;

    TOP top (
        .clk(clk),
        .rst_n(rst_n),
        .U_(U_),
        .D_(D_),
        .L_(L_),
        .R_(R_),
        .C_(C_),
        .keyboard(keyboard),
        .eight_switch(eight_switch),
        .seg_ena(seg_ena),
        .seg_out(seg_out),
        .seg_ena_r(seg_ena_r),
        .seg_out_r(seg_out_r),
        .led(test_led),
        .speaker(speaker)
    );

    initial begin 
        clk = 0; rst_n = 1;
        U_ = 0; D_ = 0; L_ = 0; R_ = 0; C_ = 0;
        keyboard = 8'b10000000;
        eight_switch = 2'b00;
        #5 rst_n = 0; #5 rst_n = 1;
        // -------------------------------------
        #40 U_ = 1; #40 U_ = 0;
        #40 U_ = 1; #40 U_ = 0;

       // #400 R_ = 1; #400 R_ = 0;
        #40 C_ = 1; #40 C_ = 0;
        #40 R_ = 1; #40 R_ = 0;
        #40 C_ = 1; #40 C_ = 0;
        #40 keyboard = 8'b00000001; #40 keyboard = 8'b10000000;
        #40 keyboard = 8'b00000001; #40 keyboard = 8'b10000000;

        #2000000;
        #40 keyboard = 8'b00010000; #40 keyboard = 8'b00010000;
        #40 keyboard = 8'b00010000; #40 keyboard = 8'b00010000;


        // #40 R_ = 1; #40 R_ = 0; 
        // #40 C_ = 1; #40 C_ = 0;

        //#40 C_ = 1; #40 C_ = 0;
        #40;
        // #10000000;
        // #40 C_ = 1; #40 C_ = 0;
        // #40 C_ = 1; #40 C_ = 0;
    end

    initial fork
        forever #5 clk = ~clk;
    join
endmodule
