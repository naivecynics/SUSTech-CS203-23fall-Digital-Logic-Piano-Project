`include "CONSTANT.v"

module BPM_Counter(
	input clk, 
    input rst_n,
	input [7:0] bpm,
	output reg clk_bpm
);

	reg [40:0] cnt_1;
    reg [40:0] cnt_2;
	
	always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt_1 <= 0;
            cnt_2 <= 0;
            clk_bpm <= 0;
        end else begin
            cnt_1 <= cnt_1 + 1;
            if (cnt_1 >= `CLK_PERIOD_REAL) begin
                cnt_2 <= cnt_2 + 1;
                //if (cnt_2 * bpm >= 4) begin
                if (cnt_2 * bpm >= `VALUE) begin
                    cnt_2 <= 0;
                    clk_bpm <= 1;
                end
                cnt_1 <= 0;
            end else begin
                clk_bpm <= 0;
            end
        end
    end

endmodule 
