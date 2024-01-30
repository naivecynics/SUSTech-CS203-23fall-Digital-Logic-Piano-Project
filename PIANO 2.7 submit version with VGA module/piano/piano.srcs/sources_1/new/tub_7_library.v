`include <CONSTANT.v>

module tub_7_library (
    input [2:0] state,
    input [2:0] next,
    input [4:0] index,
    input [1:0] grade,
    input [3:0] seg_en,
    input left_or_right,
    output [7:0] seg_out
);
    reg [7:0] seg;

    always @ * begin
        case (left_or_right) 
        1'b0: begin
            case (next)
                `FREE: case (seg_en)
                    4'b0001: seg = 8'b1000_1110; // F
                    4'b0010: seg = 8'b0000_1010; // r
                    4'b0100: seg = 8'b0000_0010;
                    4'b1000: begin
                        case (state)
                            `FREE: seg = 8'b1000_1110; // F
                            `AUTO: seg = 8'b1110_1110; // A
                            `LERN: seg = 8'b0001_1100; // L
                            `SETT: seg = 8'b1011_0110; // S
                            default: seg = 8'b0000_0010;
                        endcase
                    end
                endcase
                `AUTO: case (seg_en)
                    4'b0001: seg = 8'b1110_1110; // A
                    4'b0010: seg = 8'b0011_1000; // u
                    4'b0100: seg = 8'b0000_0010;
                    4'b1000: begin
                        case (state)
                            `FREE: seg = 8'b1000_1110; // F
                            `AUTO: seg = 8'b1110_1110; // A
                            `LERN: seg = 8'b0001_1100; // L
                            `SETT: seg = 8'b1011_0110; // S
                            default: seg = 8'b0000_0010;
                        endcase
                    end
                endcase
                `LERN: case (seg_en)
                    4'b0001: seg = 8'b0001_1100; // L
                    4'b0010: seg = 8'b0010_1010; // n
                    4'b0100: seg = 8'b0000_0010; 
                    4'b1000: begin
                        case (state)
                            `FREE: seg = 8'b1000_1110; // F
                            `AUTO: seg = 8'b1110_1110; // A
                            `LERN: seg = 8'b0001_1100; // L
                            `SETT: seg = 8'b1011_0110; // S
                            default: seg = 8'b0000_0010;
                        endcase
                    end
                endcase
                `SETT: case (seg_en)
                    4'b0001: seg = 8'b1011_0110; // S
                    4'b0010: seg = 8'b0001_1110; // t
                    4'b0100: seg = 8'b0000_0010;
                    4'b1000: begin
                        case (state)
                            `FREE: seg = 8'b1000_1110; // F
                            `AUTO: seg = 8'b1110_1110; // A
                            `LERN: seg = 8'b0001_1100; // L
                            `SETT: seg = 8'b1011_0110; // S
                            default: seg = 8'b0000_0010;
                        endcase
                    end
                endcase
                // AUTO_SL: case (seg_en)
                //     4'b0001: seg = 8'b1110_1100; // A
                //     4'b0010: seg = 8'b0011_1000; // u
                //     4'b0100: seg = 8'b0000_0010;
                //     4'b1000: seg = 8'b1011_0110; // S
                // endcase
                // AUTO_PL: case (seg_en)
                //     4'b0001: seg = 8'b1110_1100; // A
                //     4'b0010: seg = 8'b0011_1000; // u
                //     4'b0100: seg = 8'b0000_0010;
                //     4'b1000: seg = 8'b1100_1110; // P
                // endcase
                // LERN_SL: case (seg_en)
                //     4'b0001: seg = 8'b0001_1100; // L
                //     4'b0010: seg = 8'b0010_1010; // n
                //     4'b0100: seg = 8'b0000_0010;
                //     4'b1000: seg = 8'b1011_0110; // S
                // endcase
                // LERN_PL: case (seg_en)
                //     4'b0001: seg = 8'b0001_1100; // L
                //     4'b0010: seg = 8'b0010_1010; // n
                //     4'b0100: seg = 8'b0000_0010;
                //     4'b1000: seg = 8'b1100_1110; // P
                // endcase
                default: seg = 8'b0000_0010;
            endcase
        end
        1'b1: begin
            case (seg_en)
                4'b0001:begin
                    if (state == `LERN) begin
                    case (grade)
                        2'b00: seg = 8'b1001_1100; // C
                        2'b01: seg = 8'b1111_1110; // B
                        2'b10: seg = 8'b1110_1100; // A
                        2'b11: seg = 8'b1011_0110; // S
                        default: seg = 8'b0000_0010;
                    endcase
                    end
                end
                4'b0010:begin
                    seg = 8'b0000_0010;
                end
                4'b0100:begin
                    seg = 8'b0000_0010;
                end
                4'b1000:begin
                    case (index)
                        5'b00000: seg = 8'b1111_1100; // 0
                        5'b00001: seg = 8'b0110_0000; // 1
                        5'b00010: seg = 8'b1101_1010; // 2
                        5'b00011: seg = 8'b1111_0010; // 3
                        5'b00100: seg = 8'b0110_0110; // 4
                        5'b00101: seg = 8'b1011_0110; // 5
                        5'b00110: seg = 8'b1011_1110; // 6
                        5'b00111: seg = 8'b1110_0000; // 7
                        5'b01000: seg = 8'b1111_1110; // 8
                        5'b01001: seg = 8'b1111_0110; // 9
                        default: seg = 8'b0000_0010;
                    endcase
                end
            endcase
        end
        endcase
    end

    assign seg_out = seg;
endmodule
