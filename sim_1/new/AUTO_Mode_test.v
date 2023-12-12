`timescale 1ns / 1ps

module AUTO_Mode_test();
    reg clk, rst, enable;
    wire signal;
    
    AUTO_Mode AUTO_mode(
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .signal(signal)
    );
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        enable = 1'b1;
        #8 rst = 1'b1;
    end
    
    always begin
        //#0.05 clk = ~clk;
        #500 clk = ~clk;
    end
endmodule
