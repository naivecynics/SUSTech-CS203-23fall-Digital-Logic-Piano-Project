`timescale 1ns / 1ps

module ModeFSM(
    input wire clk,         // Clock signal connected to P17
    input wire rst,         // Reset signal
    input wire[7:0] key_board_in,//Key board of playing signal
    input wire in,          // Mode signal
    input wire setting,     //Setting sinal
    output wire [1:0] mode, // State signal
    output wire signal     // Buzzer signal
);
    
////////////////////////////////////////////////////////////////////////////////////////////
//
//output [3:0]justfortesting1,
//output [3:0]justfortesting2,
//output [3:0]justfortesting3,
//output [3:0]justfortesting4,
//output [3:0]justfortesting5,
//output [3:0]justfortesting6,
//output [3:0]justfortesting7,
//output [3:0]justfortesting8
//
reg[3:0] play_mode[0:8];
reg[3:0] play_mode_curr[0:8];
//assign justfortesting1=play_mode[0];
//assign justfortesting2=play_mode[1];
//assign justfortesting3=play_mode[2];
//assign justfortesting4=play_mode[3];
//assign justfortesting5=play_mode[4];
//assign justfortesting6=play_mode[5];
//assign justfortesting7=play_mode[6];
//assign justfortesting8=play_mode[7];
reg[3:0] music [0:1023];
integer i=1;
wire [3:0] tmp_restting;
resetting_using_block resetting(key_board_in,tmp_restting);
always@(clk,posedge key_board_in)
begin
if(setting==1'b1)begin
    if(i==1'b0)
         {play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]}=32'b0000_1111_1111_1111_1111_1111_1111_1111;
    if(tmp_restting!=4'd15)
        begin
        if(play_mode[tmp_restting]==4'b1111)
             begin
                  play_mode[tmp_restting]=i+1'b1;
                  i=i+1'b1;
                  if(i>9)
                      i=1;
            end
        end
    end
end
////////////////////////////////////////////////////////////////////////////////////////////  

//  About Time:
//      P17 : 1 ^ -10 s
//      1 ns : 1 ^ -9 s
//      #500 change: 1 ms (sim) = 1 s (reality)


    // 4 States
    parameter MENU = 2'b00, FREE = 2'b01, 
                AUTO = 2'b10, LERN = 2'b11;

    // activation signal for MODEs
    reg AUTO_enable = 1'b0;
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
            {play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]}=32'b0000_0001_0010_0011_0100_0101_0110_0111;
            i=0;
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
    FREE_MODE FREE_MODE(clk, key_board_in,{play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]},FREE_enable,signal);

    // AUTO_Mode instantiation
    AUTO_Mode AUTO_Mode(
        .clk(clk),
        .rst(rst),
        .enable(AUTO_wire),
        .signal(signal)
    );

    // FREE_Mode instantiation
    // FREE_Mode FREE_Mode(
    //     .clk(clk),
    //     .rst(rst),
    //     .enable(FREE_wire),
    //     .signal(signal)
    // );
    
    // Module activation
    always @* begin
        case (state)
            MENU: begin
                // todo
            end
            FREE: begin
                {AUTO_enable, FREE_enable, LERN_enable}=3'b010;
            end
            AUTO: begin
                {AUTO_enable, FREE_enable, LERN_enable}=3'b100;
            end
            LERN: begin
                // todo
            end
        endcase
    end
    


endmodule
