`timescale 1ns / 1ps

`include "CONSTANT.v"

module Button_Debouncer(
    input clk,
    input rst,
    input btn,
    output reg btn_out
);

    reg [1:0] state;
    reg [22:0] cnt;
    reg slow_clk;

    initial begin
        state = 2'b00;
        cnt = 0;
        slow_clk = 1'b0;
    end

    always @ (posedge clk) begin
        if (cnt == `BUTTON_SLOW) begin
            cnt <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            cnt <= cnt + 1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00; 
            btn_out <= 1'b0;
        end else begin
            state <= {state[0], btn};
        end
    end

    always @(posedge clk) begin
        if (state == 2'b00 || state == 2'b11) begin
            btn_out <= state[0];
        end
    end

endmodule
