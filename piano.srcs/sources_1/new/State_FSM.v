`include "CONSTANT.v"

module State_FSM(
    input clk,
    input rst_n,
    input U, D, L, R, C,
    output [2:0] next,
    output [2:0] state
);  
    reg [2:0] nxt; assign next = nxt;
    reg [2:0] stt; assign state = stt;

    reg [2:0] woc;

    initial begin
        stt <= `IDLE;
    end

    // reset & initialize
    always @ (negedge rst_n, posedge clk) begin
        if (~rst_n) begin
            //stt <= `IDLE;
            nxt <= `FREE;
        end else begin
            nxt <= woc;
        end
    end

    // confirn
    always @ (posedge C) begin 
        case (nxt)
            `FREE: stt <= `FREE;
            `AUTO: stt <= `AUTO;
            `LERN: stt <= `LERN;
            `SETT: stt <= `SETT;
            // `AUTO_SL: stt <= `AUTO_SL;
            // `AUTO_PL: stt <= `AUTO_PL;
            // `LERN_SL: stt <= `LERN_SL;
            // `LERN_PL: stt <= `LERN_PL;
            default: stt <= stt;
        endcase
    end

    // state transition
    always @ (U, D, L, R, woc) begin 
        case  ({U, D, L, R, nxt})
            // UP
            {4'b1000, `FREE}: woc <= `AUTO;
            {4'b1000, `AUTO}: woc <= `LERN;
            {4'b1000, `LERN}: woc <= `SETT;
            {4'b1000, `SETT}: woc <= `FREE;
            // {4'b1000, `AUTO_SL}: woc <= `AUTO_PL;
            // {4'b1000, `AUTO_PL}: woc <= `AUTO_SL;
            // {4'b1000, `LERN_SL}: woc <= `LERN_PL;
            // {4'b1000, `LERN_PL}: woc <= `LERN_SL;
            // DOWN
            {4'b0100, `FREE}: woc <= `SETT;
            {4'b0100, `AUTO}: woc <= `FREE;
            {4'b0100, `LERN}: woc <= `AUTO;
            {4'b0100, `SETT}: woc <= `LERN;
            // {4'b0100, `AUTO_SL}: woc <= `AUTO_PL;
            // {4'b0100, `AUTO_PL}: woc <= `AUTO_SL;
            // {4'b0100, `LERN_SL}: woc <= `LERN_PL;
            // {4'b0100, `LERN_PL}: woc <= `LERN_SL;
            // LEFT: backward
            // {4'b0010, `LERN_SL}: woc <= `LERN;
            // {4'b0010, `AUTO_SL}: woc <= `AUTO;
            // {4'b0010, `AUTO_PL}: woc <= `AUTO;
            // {4'b0010, `LERN_PL}: woc <= `LERN;
            // RIGHT: forward
            // {4'b0001, `AUTO}: woc <= `AUTO_SL;
            // {4'b0001, `LERN}: woc <= `LERN_SL;
            // otherwise
            default: woc <= nxt;
        endcase
    end

endmodule
