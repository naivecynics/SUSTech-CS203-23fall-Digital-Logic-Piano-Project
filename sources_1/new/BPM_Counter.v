`timescale 1ns / 1ps

module BPM_Counter(bpm, clk, rst, clk_bpm);

	input [7:0] bpm;
	input clk, rst;
	output clk_bpm;
	

	// 1 min == 6 * 10^9 ns
	// n bpm == 6 * 10^9 / n ns
	
	reg [24:0] cnt;
	reg clk_bpm;

	//assign bpm_cnt = 6'd6000000000 / bpm;
	
	always @(posedge clk, negedge rst) begin
    if (!rst) begin
        cnt <= 0;
		clk_bpm <= 0;
    end else begin
        cnt <= cnt + 1;
        //if (cnt * bpm >= 40'd6_00000_00_0000) begin
        if (cnt * bpm >= 40'd6_00000_00) begin
            clk_bpm <= 1;
            cnt <= 0;
        end else begin
            clk_bpm <= 0;
        end
    end
end

endmodule 
