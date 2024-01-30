`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/16 23:24:31
// Design Name: 
// Module Name: AUTO_MODE_V2
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


module AUTO_MODE_V2(
        input clk,
        input confirm,
        input rst,
        input sel_up,
        input sel_down,
        output[3:0] out_note
    );
    /////////////////////////////////////////////////////operation for music
    parameter idle=3'b000,sel=3'b001,play=3'b010;
    reg [9:0]size;reg[9:0] index;
    wire[3:0] note; 
    /////////////////////////////////////////////////////operation for library
    reg[3:0] index_lib;
    wire[19:0] star_t_end;
    /////////////////////////////////////////////////////
    blk_mem_gen_2 music(.clka(clk),.addra(index),.ena(state[1]),.douta(note));
    blk_mem_gen_1 lib(.clka(clk),.addra(index_lib),.ena(state[0]),.douta(star_t_end));
    
    //////////////////////////////////////////////////////
    reg[2:0] state;//play when state is play , ready to play when state is idle :if confirm then play
    assign out_note=note&{state[1]&~state[0]&~state[2],state[1]&~state[0]&~state[2],state[1]&~state[0]&~state[2],state[1]&~state[0]&~state[2]};
    always@(posedge rst)begin
        if(rst)begin
            state<=idle;
            index<=0;
            end
    end
    always@(posedge sel_up,posedge sel_down)
    begin
    case(state)
    sel:
        case({sel_up,sel_down})
        2'b10:index_lib=index_lib+1==16?0:index_lib+1;
        2'b01:index_lib=index_lib-1==-1?16:index_lib-1;
        endcase
      default index_lib=index_lib;  
    endcase    
    end
    
    always@(posedge clk)
    begin
        case(state)
            play:
            begin
                index<=index+1'b1;
                if(index==size)
                begin
                    index<=0;
                    state<=idle;
                end
            end
        endcase
    end
    always@(posedge confirm)
    begin
    if(confirm)
        case(state)
        idle:begin
            state=sel;
            index_lib=0;
        end
        sel:
        begin
            state=play;
            index=star_t_end[9:0];
            size=star_t_end[19:10];
        end
        endcase
    end
endmodule
