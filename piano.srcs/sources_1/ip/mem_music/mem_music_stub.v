// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Jan  2 01:52:38 2024
// Host        : CHU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top mem_music -prefix
//               mem_music_ mem_music_stub.v
// Design      : mem_music
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module mem_music(clka, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[11:0],dina[5:0],douta[5:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [11:0]addra;
  input [5:0]dina;
  output [5:0]douta;
endmodule
