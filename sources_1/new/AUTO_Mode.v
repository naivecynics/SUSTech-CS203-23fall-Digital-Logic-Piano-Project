`timescale 1ns / 1ps

module AUTO_Mode(
    input wire clk,
    input wire rst,
    input wire enable,
    output wire signal
);


    // Buzzer instantiation
    wire [3:0] notes;
    reg [3:0] note;

    Buzzer buzzer(
        .clk(clk),
        .note(notes),
        .speaker(signal)
    );

    // BPM_Counter instantiation
    wire clk_bpm;

    BPM_Counter BPM_counter(
        .bpm(8'd120),
        .clk(clk),
        .rst(rst),
        .clk_bpm(clk_bpm)
    );

	
    // scale playing
    always @(posedge clk_bpm, negedge rst) begin
        if (!rst) 
            note <= 0;
        else begin
            if (enable) begin
                note <= note + 1;
                if (note > 7) begin
                    note <= 1;
                end
            end
        end
    end

    assign notes = note;

endmodule
