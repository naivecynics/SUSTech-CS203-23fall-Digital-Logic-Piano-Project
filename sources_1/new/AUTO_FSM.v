`timescale 1ns / 1ps

module AUTO_FSM(
    input wire clk,
    input wire rst,
    input wire MID, ESC,
    output speaker
    );

    // first FSM
    // 0: Selecting
    // 1: Playing
    reg state, next_state;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @ (posedge MID, posedge ESC) begin
        if (MID && state == 1'b0) 
            next_state <= 1'b1;
        if (ESC && state == 1'b1)
            next_state <= 1'b0;
    end

    always @ (state) begin
        case (state)
            1'b0: begin
                // Selecting
            end
            1'b1: begin
                // Playing
            end
        endcase
    end

endmodule