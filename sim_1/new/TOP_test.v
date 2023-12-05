`timescale 1ns / 1ps

module TOP_test();
    reg clk, rst, in;
    wire [1:0] mode, signal;

    ModeFSM ModeFSM(
        .clk(clk),
        .rst(rst),
        .in(in),
        .mode(mode),
        .signal(signal)
    );

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        in = 1'b1;
        #8 rst = 1'b0;
    end

    always begin
        #10 clk = ~clk;
    end

endmodule
