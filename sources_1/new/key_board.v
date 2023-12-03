`timescale 1ns / 1ps

module key_board(
    input [7:0] in,
    input  [23:0] assign_modul,
    output reg [2:0] out
    );
    always@(in)
    begin
    case (in)
        8'b0000_0001: out={assign_modul[20],assign_modul[19],assign_modul[18]}; 
        8'b0000_0010: out={assign_modul[17],assign_modul[16],assign_modul[15]}; 
        8'b0000_0100: out={assign_modul[14],assign_modul[13],assign_modul[12]}; 
        8'b0000_1000: out={assign_modul[11],assign_modul[10],assign_modul[9]}; 
        8'b0001_0000: out={assign_modul[8],assign_modul[7],assign_modul[6]};
        8'b0010_0000: out={assign_modul[5],assign_modul[4],assign_modul[3]}; 
        8'b0100_0000: out={assign_modul[2],assign_modul[1],assign_modul[0]}; 
        default: out={assign_modul[23],assign_modul[22],assign_modul[21]};
    endcase
    end
    
    

    
endmodule
