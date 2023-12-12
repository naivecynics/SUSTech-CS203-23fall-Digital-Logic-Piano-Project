`timescale 1ns / 1ps

module ModeFSM(
    input wire clk,         // Clock signal connected to P17
    input wire rst,         // Reset signal
    input wire[7:0] key_board_in,//Key board of playing signal
    input wire in,          // Mode signal
<<<<<<< HEAD
    input wire setting,     //Setting sinal
=======
    input wire mode_switch_btn,  // �����л�ģʽ�İ�ť
    input wire confirm_btn,      // ����ȷ�Ͻ���ģʽ�İ�ť
>>>>>>> 20334eba996ee4003258a1b6b6e14a40d7c76619
    output wire [1:0] mode, // State signal
    output wire signal     // Buzzer signal
);
<<<<<<< HEAD
=======
    reg[2:0] play_mode[0:8];//���ڴ��水ť״̬
>>>>>>> 20334eba996ee4003258a1b6b6e14a40d7c76619
    
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
                
    // ����״̬����״̬
    
   // �����������ʾ��ģʽ����
    reg [6:0] mode_names [0:3];
    // L,U,A,F
    initial begin
        mode_names[0] = 7'b0111000;
        mode_names[1] = 7'b0111110;
        mode_names[2] = 7'b0110111;
        mode_names[3] = 7'b0110011;
    end

    reg [6:0] current_mode_name;


    // activation signal for MODEs
    reg MENU_enable = 1'b0;
    reg AUTO_enable = 1'b0;
    reg FREE_enable = 1'b0;
    reg LERN_enable = 1'b0;
    wire MENU_wire;
    wire AUTO_wire;
    wire FREE_wire;
    wire LERN_wire;
    assign MENU_wire = MENU_enable;
    assign AUTO_wire = AUTO_enable;
    assign FREE_wire = FREE_enable;
    assign LERN_wire = LERN_enable;

    // State register
    reg [1:0] state, next_state;
    assign mode = state;

    // Return to MENU state when rst on POSITIVE edge
    always @(posedge clk or posedge rst) begin
        if (rst)begin
            state <= MENU;
            {play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]}=32'b0000_0001_0010_0011_0100_0101_0110_0111;
            i=0;
        end    
        else begin
            state <= next_state;
        end
    end

    // todo: change all to auto for now
    // all to auto for now
    always @* begin
        if(confirm_btn)begin
            #10ms;//����
            if(confirm_btn)begin
            case (current_mode_name)
                  mode_names[0]: next_state<=MENU;
                  mode_names[1]: next_state<=AUTO;
                  mode_names[2]: next_state<=FREE;
                  mode_names[3]: next_state<=LERN;
                  default: next_state<=MENU;
    //            MENU: next_state = in ?  FREE :  FREE;
    //            FREE: next_state = in ?  FREE :  FREE;
    //            AUTO: next_state = in ?  FREE :  FREE;
    //            LERN: next_state = in ?  FREE :  FREE;
            endcase
            end
        end
    end
<<<<<<< HEAD
    FREE_MODE FREE_MODE(clk, key_board_in,{play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]},FREE_enable,signal);
=======
    
    //ѡ��ģʽ��ť
   always @* begin
       if(mode_switch_btn)begin
         #10ms;//����
         if(mode_switch_btn)begin
           case(current_mode_name)
                mode_names[0]: current_mode_name <= mode_names[1];
                mode_names[1]: current_mode_name <= mode_names[2];
                mode_names[2]: current_mode_name <= mode_names[3];
                mode_names[3]: current_mode_name <= mode_names[0];
                default: current_mode_name <= 7'b1111111; // Ĭ����ʾȫ��         
           endcase
         end
       end
   end
    
    
    // FREE_Mode instantiation
    FREE_MODE FREE_MODE(
        clk, key_board_in,{play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]},signal
    );
>>>>>>> 20334eba996ee4003258a1b6b6e14a40d7c76619

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
                MENU_enable = 1'b1;
                FREE_enable = 1'b0;
                AUTO_enable = 1'b0;
                LERN_enable = 1'b0;
            end
            FREE: begin
<<<<<<< HEAD
                {AUTO_enable, FREE_enable, LERN_enable}=3'b010;
            end
            AUTO: begin
                {AUTO_enable, FREE_enable, LERN_enable}=3'b100;
=======
                FREE_enable = 1'b1;
                AUTO_enable = 1'b0;
                LERN_enable = 1'b0;
            end
            AUTO: begin
                MENU_enable = 1'b0;
                FREE_enable = 1'b0;
                AUTO_enable = 1'b1;
                LERN_enable = 1'b0;
>>>>>>> 20334eba996ee4003258a1b6b6e14a40d7c76619
            end
            LERN: begin
                MENU_enable = 1'b0;
                FREE_enable = 1'b0;
                AUTO_enable = 1'b0;
                LERN_enable = 1'b1;
            end
        endcase
    end

endmodule
