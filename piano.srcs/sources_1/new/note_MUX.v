`include "CONSTANT.v"

module note_MUX(
    input [2:0] state,
    input [5:0] auto,
    input [5:0] free,
    output reg [5:0] note
);
    always @ * begin
        case (state)
            `FREE: note = free;
            `AUTO: note = auto;
            `LERN: note = free;
            default: note = 6'b000000;
        endcase
    end
endmodule
