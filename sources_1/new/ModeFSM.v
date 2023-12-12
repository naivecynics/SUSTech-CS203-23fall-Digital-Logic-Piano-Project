`timescale 1ns / 1ps

module ModeFSM(
    input wire clk,         // Clock signal connected to P17
    input wire rst,         // Reset signal
    input wire[0:7] key_board_in,//Key board of playing signal
    input wire in,          // Mode signal
    input wire mode_switch_btn,  // �����л�ģʽ�İ�ť
    input wire confirm_btn,      // ����ȷ�Ͻ���ģʽ�İ�ť
    output wire [1:0] mode, // State signal
    output wire signal      // Buzzer signal
);
    reg[2:0] play_mode[0:8];//���ڴ��水ť״̬
    

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
            {play_mode[0],play_mode[1],play_mode[2],play_mode[3],play_mode[4],play_mode[5],play_mode[6],play_mode[7]}=24'b000_001_010_011_100_101_110_111;
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
                MENU_enable = 1'b0;
                FREE_enable = 1'b1;
                AUTO_enable = 1'b0;
                LERN_enable = 1'b0;
            end
            AUTO: begin
                MENU_enable = 1'b0;
                FREE_enable = 1'b0;
                AUTO_enable = 1'b1;
                LERN_enable = 1'b0;
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
