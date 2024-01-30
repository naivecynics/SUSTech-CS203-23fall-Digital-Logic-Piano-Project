`include "CONSTANT.v"

module music_lib(
    input clk,
    input rst_n, 
    input UorD,     // the leftest switch, decide the direction of index change
    input C,        // when C is pressed, the index will be changed
    input L,
    input R,
    input [2:0] state,
    input [3:0] note_f,   // the note from keyboard
    output reg [7:0] speed,
    output  [3:0] note,
    output  [1:0] eight,
    output reg [4:0] lib_index,
    output clk_bpm,
    output reg [1:0] grade
);

    //use music_info to get the 4 characteristic

    //can store 32 music with characteristic
        //1,pace/speed [38:31] 
        //2,where is the first note [30:19] 
        //3,the end of the music[18:7]
        //4,the maxium goal [6:0] 
        //5,[39:39] indecate the block used when 1 or 0
    //when auto or learn enable
    //write in when recode mode (TODO)

    wire [39:0] music_info;
    mem_lib library (.addra(lib_index-1),.clka(clk),.douta(music_info),.ena(state==`AUTO|state==`LERN),.wea(state==`IDLE));

    // ip core to get the note
    wire [11:0] note_address;
    wire [5:0] notes_info;
    mem_music music(.addra(note_address),.clka(clk),.ena(state==`AUTO|state==`LERN),.douta(notes_info),.wea(state==`IDLE));

    assign eight = notes_info[5:4];
    assign note = notes_info[3:0];

    //------------------------------------------------
    // bpm counter input speed output beat
    BPM_Counter bpm (clk, rst_n, 7'b1111000, clk_bpm);
    
    // select music
    always @ (negedge rst_n, posedge L, posedge R) begin
        if(~rst_n)begin 
            lib_index = 0;
        end 
        else begin
            if (L && (state == `AUTO || state == `LERN)) begin
                lib_index = lib_index<1?9:lib_index-1;
            end else
            if (R && (state == `AUTO || state == `LERN)) begin
                lib_index = lib_index+1>9?0:lib_index+1;
            end
            else lib_index = lib_index;
        end
    end
    //learn clk trigger next note
    reg lern_clk;
    always @ (posedge clk) begin
        if (state == `LERN) begin
            if (note_f == note) begin
                lern_clk = 1;
            end
            else begin
                lern_clk = 0;
            end
        end
    end
    // MUX for clk (AUTO LERN)
    reg clkclk;
    always @ * begin
        case (state)
            `AUTO: clkclk = clk_bpm;
            `LERN: clkclk = lern_clk;
            default: clkclk = 0;
        endcase
    end
    // grade counter
    always @ (posedge clk_bpm, posedge lern_clk) begin
        if (~lern_clk) begin
            grade <= 2'b11;
        end
        else begin
            if (grade > 0) begin
                grade <= grade - 1;
            end 
        end
    end
    // note swift
    note_swift ns (clk, clkclk, music_info, C, note_address);
    // reg [11:0] note_address_begin;
    // reg [11:0] note_address_end;
    // always @ (posedge clk_bpm, posedge C) begin
    //     if (C) begin
    //         note_address <= music_info [30:19];
    //         note_address_begin <= music_info [30:19];
    //         note_address_end <= music_info [18:7];
    //     end
    //     else begin
    //         if (note_address == note_address_end) begin
    //             note_address <= note_address_begin;
    //         end
    //         else begin
    //             note_address <= note_address + 1;
    //         end
    //     end
    // end

endmodule
