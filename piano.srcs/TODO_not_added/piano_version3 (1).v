`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/19 19:23:22
// Design Name: 
// Module Name: piano_version3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module piano_version3(
        input clk,
        input[7:0] key_board_in,
        input[2:0] mode_selection,
        input[1:0] eight,
        input select_down,
        input select_up,
        input confirm,
        input rst,
        output speaker,
        output seg_light,
        output [2:0]mode_light
    );
        parameter idle=3'b000,setting=3'b110,free=3'b100,auto=3'b001,learn=3'b011;
         reg[2:0] state,next_state;  
         assign mode_light=state;
         /////////////////////////////////////////////////////////////////////////////////////////////////////////
         reg[7:0] setted; reg[3:0] buzzer_note;reg[1:0] setting_state;wire[3:0] buzzer_note_;wire[3:0] pose_key;wire buzzer_work;
         alreay_setting_block play_m(key_board_in,state,pose_key);
          blk_mem_gen_0 play_mode(.addra(pose_key[2:0]),.clka(clk),.dina(buzzer_note),.douta(buzzer_note_),.ena((state[2]&(~state[1])|(confirm))),.wea(state[1]));
          Buzzer4 buzzer(clk,buzzer_note|buzzer_note_,eight,state,speaker);
         /////////////////////////////////////////////////////////////////////////////////////////////////////////
         always@(posedge clk,posedge rst)begin
            if(~rst)begin
                state<=idle;
            end    
            else
                state<=next_state;    
         end
         always@*begin
            case (state)
                idle:begin 

                if(confirm)begin
                    case(mode_selection)
                        3'b100:begin
                            setted=8'b0000_0000;
                            buzzer_note=4'b0001;
                            setting_state=2'b00;
                            next_state=setting;
                        end
                        3'b010:begin
                            next_state=free;
                        end
                    endcase
                    end
                end
                setting:begin
                    case(setting_state)
                    2'b00:begin
                        if(~setted[pose_key]&~pose_key[3])
                                    begin
                                        setting_state=2'b01;
                                    end
                                    end
                    2'b01:begin
                              if(confirm)
                                      begin
                                   setted[pose_key]=1'b1;
                                    buzzer_note=buzzer_note+1;
                                   if(buzzer_note==9)begin
                                          next_state=idle;
                                         buzzer_note=0;
                                            end
                                             setting_state=2'b00;
                                  end
                             end                
                    
                      endcase
                  
                     end
                free:begin
                   if(~rst)
                         next_state=idle;    
                   end  
            default next_state=idle;    
            endcase    
         end
endmodule
