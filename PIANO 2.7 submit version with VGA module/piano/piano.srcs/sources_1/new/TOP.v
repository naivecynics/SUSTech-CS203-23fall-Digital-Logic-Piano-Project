`include "CONSTANT.v"

module TOP(
    // DO NOT change the order
    input clk,                  // p17
    input rst_n,                // rst button
    input U_, D_, L_, R_, C_,   // button input
    input [7:0] keyboard,       // keyborad input
    input [1:0] eight_switch,   // ottava alta / bassa
    output [3:0] seg_ena,       // left tub scan
    output [7:0] seg_out,       // left tub signal
    output [3:0] seg_ena_r,     // right tub scan
    output [7:0] seg_out_r,     // right tub signal
    output [7:0] led,           // led control
    output speaker,              // for speaker H17
    output wire vga_hsync,     
    output wire vga_vsync,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
);

    // button debouncer
    wire U, D, L, R, C;
    Button_Debouncer u (clk, rst_n, U_, U);
    Button_Debouncer d (clk, rst_n, D_, D);
    Button_Debouncer l (clk, rst_n, L_, L);
    Button_Debouncer r (clk, rst_n, R_, R);
    Button_Debouncer c (clk, rst_n, C_, C);
    or (led[7], U, D, L, R, C, ~rst_n);

    // top state FSM
    wire [2:0] next;     // selectable show_state
    wire [2:0] state;    // functioncal real_statse
    State_FSM s (clk, rst_n, U, D, L, R, C, next, state);

    // music library
    wire [7:0] speed;
    wire [1:0] eight;
    wire [4:0] lib_index;
    // notes
    wire [3:0] note_f;
    wire [3:0] note_a; 
    wire [5:0] note; // final note includes tone and eight
    wire bpm;
    wire [1:0] grade;
    music_lib ml (clk, rst_n, keyboard[7], C, L, R, state, note_f, speed, note_a, eight, lib_index, bpm, grade);

    // 7 tubs control - left
    seg_light_7 sl (clk, rst_n, state, next, lib_index, grade, 1'b0, seg_ena, seg_out);

    // 7 tubs control - right
    seg_light_7 sr (clk, rst_n, state, next, lib_index, grade, 1'b1, seg_ena_r, seg_out_r);

    // buzzer
    Buzzer b (clk, note[3:0], note[5:4], state, speaker);
    
    // VGA
    //    VGA VGA_inst(clk, rst_n, vga_hsync, vga_vsync, vga_r, vga_g, vga_b);
        wire  [11:0] rgb;
        wire  [2:0]song_num;
    //    vga_colorbar ttt(clk, rst_n ,vga_hsync ,vga_vsync, rgb);
        vga_character ttt(clk, rst_n ,state, song_num, keyboard[6:0], vga_hsync ,vga_vsync, rgb);
        assign vga_r={rgb[11],rgb[10],rgb[9],rgb[8]};
        assign vga_g={rgb[7],rgb[6],rgb[5],rgb[4]};
        assign vga_b={rgb[3],rgb[2],rgb[1],rgb[0]};

    // keyboard
    //keyboard k (keyboard, clk, state, C, rst_n, note_f); 
    keyboard k (keyboard, note_f);  


    // big led
    led_ctrl lc (clk, rst_n, state, keyboard[6:0], note_a, led[6:0]);

    // MUX for note
    note_MUX nm (state, {eight, note_a}, {eight_switch, note_f}, note);

    // the rest of the modules should be add here
    // implement different functions by state
    // menu state: next; instant state; state

    // test led
    // can be deleted
    // reg [3:0] led;
    // assign test_led = led;
    // always @ (next) begin
    //     case (next)
    //         `FREE: led = 4'b0001;
    //         `AUTO: led = 4'b0010;
    //         `LERN: led = 4'b0100;
    //         `SETT: led = 4'b1000;
    //         default: led = 4'b0000;
    //     endcase
    // end


endmodule
