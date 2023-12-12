`timescale 1ns / 1ps

module Button_Debouncer_tbc();
    reg clk, rst, btn;
    wire btn_out;

    Button_Debouncer Button_Debouncer(
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .btn_out(btn_out)
    );

    initial begin
        rst = 1'b0;
        clk = 1'b0;
        btn = 1'b0;

        #4 rst = 1'b1;
        #4 rst = 1'b0;
        #5000000 btn = 1'b1;
        #1000000 btn = 1'b0;
    end

    initial fork
        forever begin
            #5 clk = ~clk;
        end
    join
endmodule
