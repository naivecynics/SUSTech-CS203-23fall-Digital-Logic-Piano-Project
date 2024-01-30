`include "CONSTANT.v"

module seg_light_7 ( 
    input clk,
    input rst_n,
    input [2:0] state,
    input [2:0] next,
    input [4:0] index, 
    input [1:0] grade,
    input left_or_right, // 0: left, 1: right
    output [3:0] seg_ena, 
    output [7:0] seg_out
);

    reg clkout;
    reg [3:0] seg_en;
    reg [31:0] cnt;
    reg [1:0] scan_cnt;

    //parameter period=2; //500HZ stable 
    //parameter period=250000;   //400HZ stable
    // parameter period =5000000; //20HZ loop one by one 
    //parameter period=2500000; //40HZ twenkle
    //parsmeter period =1000000; //100HZ twenkle

    // clock delay
    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
            clkout <= 0; 
        end
        else begin
            if (cnt == (`SCAN_PEROID >> 1) - 1) begin
                clkout <= ~clkout;
                cnt <= 0;
            end
            else cnt<=cnt+1;
        end
    end

    // scan signal
    always @(posedge clkout, negedge rst_n) begin
        if (~rst_n)
            scan_cnt<=0;
        else begin
            if(scan_cnt==3'd7) scan_cnt<=0;
            else scan_cnt<=scan_cnt+1;
        end
    end
    
    // enable signal scan
    always @ (scan_cnt) begin
        case(scan_cnt)
            2'b00: seg_en = 4'b0001;
            2'b01: seg_en = 4'b0010;
            2'b10: seg_en = 4'b0100;
            2'b11: seg_en = 4'b1000;
        endcase
    end

    // 7-segment light signal scan
    tub_7_library tub_7_library_ (
        .state(state),
        .next(next),
        .index(index),
        .grade(grade),
        .seg_en(seg_ena),
        .left_or_right(left_or_right),
        .seg_out(seg_out)
    );
    
    assign seg_ena = seg_en;

endmodule
