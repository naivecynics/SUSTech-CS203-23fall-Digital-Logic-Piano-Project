`timescale 1ns / 1ps

module AUTO_Mode(
    input wire clk,
    input wire rst,
    input wire enable,
    output wire signal
);

    wire [3:0] notes;
    reg [3:0] note;

    Buzzer buzzer(
        .clk(clk),
        .note(notes),
        .speaker(signal)
    );

    // scale playing
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            note <= 0;
        end
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
