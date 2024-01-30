`include "CONSTANT.v"

module led_ctrl(
    input clk,
    input rst_n,
    input [2:0] state,
    input [6:0] keyboard,
    input [5:0] note,
    output reg [6:0] led
);

    always @ * begin
        case (state)
            `IDLE: begin
                led <= 7'b0000000;
            end
            `FREE: begin
                case (keyboard)
                    7'b0000001: led <= 7'b0000001;
                    7'b0000010: led <= 7'b0000010;
                    7'b0000100: led <= 7'b0000100;
                    7'b0001000: led <= 7'b0001000;
                    7'b0010000: led <= 7'b0010000;
                    7'b0100000: led <= 7'b0100000;
                    7'b1000000: led <= 7'b1000000;
                    default: led <= 7'b0000000;
                endcase
            end
            `AUTO: begin
                case (note[3:0])
                    4'b0001: led <= 7'b0000001;
                    4'b0010: led <= 7'b0000010;
                    4'b0011: led <= 7'b0000100;
                    4'b0100: led <= 7'b0001000;
                    4'b0101: led <= 7'b0010000;
                    4'b0110: led <= 7'b0100000;
                    4'b0111: led <= 7'b1000000;
                    default: led <= 7'b0000000;
                endcase
            end
            `LERN: begin
                case (note[3:0])
                    4'b0001: led <= 7'b0000001;
                    4'b0010: led <= 7'b0000010;
                    4'b0011: led <= 7'b0000100;
                    4'b0100: led <= 7'b0001000;
                    4'b0101: led <= 7'b0010000;
                    4'b0110: led <= 7'b0100000;
                    4'b0111: led <= 7'b1000000;
                    default: led <= 7'b0000000;
                endcase
            end
            // `AUTO_SL: begin
            //     case (note)
            //         4'b0001: led <= 7'b0000001;
            //         4'b0010: led <= 7'b0000010;
            //         4'b0011: led <= 7'b0000100;
            //         4'b0100: led <= 7'b0001000;
            //         4'b0101: led <= 7'b0010000;
            //         4'b0110: led <= 7'b0100000;
            //         4'b0111: led <= 7'b1000000;
            //         default: led <= 7'b0000000;
            //     endcase
            // end
            // `LERN_SL: begin
            //     case (note)
            //         4'b0001: led <= 7'b0000001;
            //         4'b0010: led <= 7'b0000010;
            //         4'b0011: led <= 7'b0000100;
            //         4'b0100: led <= 7'b0001000;
            //         4'b0101: led <= 7'b0010000;
            //         4'b0110: led <= 7'b0100000;
            //         4'b0111: led <= 7'b1000000;
            //         default: led <= 7'b0000000;
            //     endcase
            // end
            default: led <= 7'b0000000;
        endcase
    end

endmodule
