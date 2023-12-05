//`timescale 10s / 1ps
`timescale 1ns / 1ps

module BPM_Counter_test();
    reg clk, rst;
    wire clk_bpm;
    
    BPM_Counter BPM_counter(
        .bpm(8'd120),
        .clk(clk),
        .rst(rst),
        .clk_bpm(clk_bpm)
    );
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;

        #8 rst = 1'b1;
    end
    
    always begin
        #500 clk = ~clk;
    end
endmodule