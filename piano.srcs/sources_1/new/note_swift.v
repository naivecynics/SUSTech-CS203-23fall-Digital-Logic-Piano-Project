`include "CONSTANT.v"

module note_swift(
    input clk,
    input clk_bpm,
    input [39:0] music_info,
    input C,
    output reg [11:0] note_address
);

    reg [11:0] note_address_begin;
    reg [11:0] note_address_end;
    always @ (posedge clk_bpm, posedge C) begin
        if (C) begin
            note_address <= music_info [30:19];
            note_address_begin <= music_info [30:19];
            note_address_end <= music_info [18:7];
        end
        else begin
            if (note_address == note_address_end) begin
                note_address <= note_address_begin;
            end
            else begin
                note_address <= note_address + 1;
            end
        end
    end

endmodule