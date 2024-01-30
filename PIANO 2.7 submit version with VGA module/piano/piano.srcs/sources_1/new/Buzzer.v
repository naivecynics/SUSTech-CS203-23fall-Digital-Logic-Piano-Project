`include "CONSTANT.v"

module Buzzer (
    input wire clk,         // Clock signal
    input wire [3:0] note, 
    input [1:0] eight,      // ottava alta / bassa
    input [2:0] state,
    output speaker     // Buzzer output signal
);

    // ottava alta / bassa
    integer n=0;
    always @ (clk, eight) begin
        case (eight) 
            2'b10: n =-1; // high
            2'b01: n = 1; // low
            default n = 0;
        endcase
    end

    wire [31:0] notes [7:0];
    reg [31:0] counter;
    reg pwm;

    // Frequencies of do , re , mi , fa , so , la , si
    // Obtain the ratio of how long the buzzer should be active in one second
    assign notes[1] = n>-1?381680<<n:190840;
    assign notes[2] = n>-1?340136<<n:170068;
    assign notes[3] = n>-1?303030<<n:151515;
    assign notes[4] = n>-1?285714<<n:142857;
    assign notes[5] = n>-1?255102<<n:127551;
    assign notes[6] = n>-1?227273<<n:113636;
    assign notes[7] = n>-1?202429<<n:101214;
    
    initial begin
        pwm = 0;
    end

    always @ ( posedge clk ) begin
        if (state == `FREE | state == `AUTO | state == `LERN) begin 
            if (counter < notes [note] || note == 1'b0) begin
                counter <= counter + 1'b1;
            end 
            else begin
                pwm = ~pwm;
                counter <= 0;
            end
            end
        else
            pwm <= 0;    
    end

    assign speaker = pwm;
endmodule
