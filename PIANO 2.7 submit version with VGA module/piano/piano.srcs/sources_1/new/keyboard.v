`timescale 1ns / 1ps

module keyboard(
    input [7:0] in,
    //input  [4:0] assign_modul,//make input meaning varies with setting
    output reg [3:0] out
);
    always @ * begin
        case (in)
            8'b0000_0001: out=4'b0001; 
            8'b0000_0010: out=4'b0010; 
            8'b0000_0100: out=4'b0011; 
            8'b0000_1000: out=4'b0100; 
            8'b0001_0000: out=4'b0101;
            8'b0010_0000: out=4'b0110; 
            8'b0100_0000: out=4'b0111; 
            // 8'b1000_0001: out=4'b1001; 
            // 8'b1000_0010: out=4'b1010; 
            // 8'b1000_0100: out=4'b1011; 
            // 8'b1000_1000: out=4'b1100; 
            // 8'b1001_0000: out=4'b1101;
            // 8'b1010_0000: out=4'b1110; 
            // 8'b1100_0000: out=4'b1111;
            default: out=4'b0000;
        endcase
    end
endmodule

// `timescale 1ns / 1ps

// `include "CONSTANT.v"

// module keyboard(
//     input [7:0] in,
//     input clk,
//     input [2:0] state,
//     input confirm,
//     input rst,
//     output reg [3:0] out
// );
//     wire [2:0] number;
//     number_of_key n_o_k(in,state,number);
//     reg [1:0] key_s,key_s_n;
//     reg [7:0]used;
//     integer note; 
//     wire [3:0]out_note;
//     reg finial;
//     always@*begin
//         case(state)
//         `SETT:
//             out=note[3:0];
//        default out=out_note;    
//        endcase 
//     end
//     blk_mem_gen_0 key(.addra(number),.clka(clk),.dina(note[3:0]),.douta(out_note),.wea(state==`SETT),.ena((state==`SETT&key_s_n==`SETT_C&key_s==`SETT_P)|state==`FREE));
//    always@*begin
//    if(~rst)begin
//         note=1;
//         used=8'b0000_0000;
//         key_s_n=`SETT_P;
//    end else if(state==`SETT)begin
//        case(key_s)
//        `SETT_P:begin
//        if(~used[number]&number>0&confirm)
//                                            begin
//                                                key_s_n=`SETT_C;
//                                            end
//             end
//        `SETT_C:begin
//        used[number]=1'b1;     
//         note=note+1'b1;
//         key_s_n=`SETT_P;
//         end
//         endcase
//         end
//         else begin
//         end        
        
//         end
//    always@(posedge clk)begin
//         key_s<=key_s_n;
//    end

    
// endmodule
