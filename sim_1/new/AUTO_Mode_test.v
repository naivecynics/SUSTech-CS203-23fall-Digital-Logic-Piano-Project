`timescale 1ns / 1ps

module AUTO_Mode_test();
    reg clk, rst;
    wire signal;
    
    AUTO_Mode AUTO_mode(
        .clk(clk),
        .rst(rst),
        .speaker(signal)
    );
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #8 rst = 1'b1;
    end
    
    always begin
        //#0.05 clk = ~clk;
        #500 clk = ~clk;
    end
endmodule
