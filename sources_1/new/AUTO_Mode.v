`timescale 1ns / 1ps

module AUTO_Mode(
    input wire clk,
    input wire rst,
    input wire enable,
    output wire signal
);

    wire [3:0] Note;
    wire clk_bpm;
    wire [7:0] bpm;

    // Music Selection FSM Menu
    
    // todo

    // Music Libary connection
    Music_Lib music_lib(
        .id(0),
        .rst(rst),
        .clk_bpm(clk_bpm),
        .enable(enable),
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
        .speaker(signal)
    );

	
    // scale playing TEST
    // always @(posedge clk_bpm, negedge rst) begin
    //     if (!rst) 
    //         note <= 0;
    //     else begin
    //         if (enable) begin
    //             note <= note + 1;
    //             if (note > 6) begin
    //                 note <= 1;
    //             end
    //         end
    //     end
    // end
    //assign Note = note;

endmodule
