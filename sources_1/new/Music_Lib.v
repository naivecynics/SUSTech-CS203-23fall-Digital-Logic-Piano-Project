`timescale 1ns / 1ps

module Music_Lib(
    input id,
    input rst,
    input clk_bpm,
    input enable,
    output [3:0] note,
    output [7:0] bpm
    );

    reg [7:0] music_lengths [3:0];  // music lengths
    reg [7:0] music_speed [3:0];    // music speed
    reg [3:0] music_lib [100:0] [3:0]; // music library
    // [100:0] - music progress [3:0] - id

    // MUSIC LIBRARY
    //-------------------------------------------------
    // length of music
    initial begin
        music_lengths[0] = 8'd16;
        music_lengths[1] = 8'd8;
        music_lengths[2] = 8'd8;
        music_lengths[3] = 8'd8;
    end
    // speed of music
    initial begin
        music_speed[0] = 8'd120;
        music_speed[1] = 8'd1;
        music_speed[2] = 8'd1;
        music_speed[3] = 8'd1;
    end
    // NO.0 little star
    initial begin
        music_lib[0][0] =  0;
        music_lib[1][0] =  1;
        music_lib[2][0] =  1;
        music_lib[3][0] =  5;
        music_lib[4][0] =  5;
        music_lib[5][0] =  6;
        music_lib[6][0] =  6;
        music_lib[7][0] =  5;
        music_lib[8][0] =  0;
        music_lib[9][0] =  4;
        music_lib[10][0] = 4;
        music_lib[11][0] = 3;
        music_lib[12][0] = 3;
        music_lib[13][0] = 2;
        music_lib[14][0] = 2;
        music_lib[15][0] = 1;
        music_lib[16][0] = 0;
    end
    //-------------------------------------------------

    reg [3:0] Note ; // return note
    reg [7:0] cnt ; // counter
    reg [7:0] length ; // length of music
    reg [7:0] speed ; // speed of music

    initial begin
        Note = 0;
        cnt = 0;
        length = music_lengths[id];
        speed = music_speed[id];
    end

    always @(posedge clk_bpm, negedge rst) begin
        if (!rst) 
            Note <= 0;
        else begin
            if (enable) begin
                if (cnt > length) begin
                    cnt <= 0;
                    Note <= 0;
                end else begin
                    cnt <= cnt + 1;
                    Note <= music_lib[cnt][id];
                end
            end
        end
    end

    assign note = Note;
    assign bpm = speed;

endmodule
