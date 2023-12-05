`timescale 1ns / 1ps

module ModeFSM(
    input wire clk,         // Clock signal
    input wire rst,         // Reset signal
    input wire[0:7] key_board_in,//Key board of playing signal
    input wire in,          // Mode signal
    output wire [1:0] mode, // State signal
    output wire signal      // Buzzer signal
);
    reg[2:0] play_mode[0:8];
    
    // 4 States
    parameter MENU = 2'b00, FREE = 2'b01, 
                AUTO = 2'b10, LERN = 2'b11;

    // activation signal for MODEs
    reg AUTO_enable = 1'b1;
    reg FREE_enable = 1'b0;
    reg LERN_enable = 1'b0;
    wire AUTO_wire;
    wire FREE_wire;
    wire LERN_wire;
    assign AUTO_wire = AUTO_enable;
    assign FREE_wire = FREE_enable;
    assign LERN_wire = LERN_enable;

    
    // State register
    reg [1:0] state, next_state;
    assign mode = state;

    // Return to MENU state when rst on POSITIVE edge
    always @(posedge clk or posedge rst) begin
        if (rst)
        begin
            state <= MENU;
            {play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]}=24'b000_001_010_011_100_101_110_111;
        end    
        else
            state <= next_state;
    end

    // todo: change all to auto for now
    // all to auto for now
    always @* begin
        case (state)
            MENU: next_state = in ?  FREE :  FREE;
            FREE: next_state = in ?  FREE :  FREE;
            AUTO: next_state = in ?  FREE :  FREE;
            LERN: next_state = in ?  FREE :  FREE;
        endcase
    end
    FREE_MODE FREE_MODE(clk, key_board_in,{play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]},signal);

    // AUTO_Mode instantiation
    AUTO_Mode AUTO_Mode(
        .clk(clk),
        .rst(rst),
        .enable(AUTO_wire),
        .signal(signal)
    );
    
    // Module activation
    always @* begin
        case (state)
            MENU: begin
                // todo
            end
            FREE: begin
                // todo
            end
            AUTO: begin
                AUTO_enable = 1'b1;
            end
            LERN: begin
                // todo
            end
        endcase
    end


endmodule
