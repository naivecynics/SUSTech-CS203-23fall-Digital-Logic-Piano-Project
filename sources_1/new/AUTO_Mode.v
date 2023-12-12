`timescale 1ns / 1ps

module AUTO_Mode(
    input wire clk,
    input wire rst,
    output wire speaker
);

    // parameter SELECTING = 1b'0,
    //             PLAYING = 1b'1;
    // reg state, next_state;

    wire [3:0] Note;
    wire clk_bpm;
    wire [7:0] bpm;

    // Music Libary connection
    Music_Lib music_lib(
        .id(0),
        .rst(rst),
        .clk_bpm(clk_bpm),
        .note(Note),
        .bpm(bpm)
    );

    // BPM_Counter instantiation
    BPM_Counter BPM_counter(
        .bpm(bpm),
        .clk(clk),
        .rst(rst),
        .clk_bpm(clk_bpm)
    );

    // Buzzer instantiation
    Buzzer buzzer(
        .clk(clk),
        .note(Note),
        .speaker(speaker)
    );


    // always @ (posedge clk, posedge rst) begin
    //     if (rst) begin
    //         state <= 0;
    //     end else begin
    //         state <= next_state;
    //     end
    // end

    // always @ (posedge MID, posedge ESC) begin
    //     if (MID && state == 1'b0) 
    //         next_state <= 1'b1;
    //     if (ESC && state == 1'b1)
    //         next_state <= 1'b0;
    // end

    // always @ (state) begin
    //     case (state)
    //         SELECTING: begin
                
    //         end
    //         PLAYING: begin
    //             // Playing
    //         end
    //     endcase
    // end


endmodule
