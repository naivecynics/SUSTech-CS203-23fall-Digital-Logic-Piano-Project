`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 23:05:43
// Design Name: 
// Module Name: scan_seg
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


module scan_seg( 
    input rst_n,
    input clk,
    output reg[7:0] seg_en, 
   output [7:0]seg_out0,
   output [7:0]seg_out1
    );
    reg clkout;
reg [31:0] cnt;
reg [2:0]scan_cnt;

parameter period=200000;//500HZ stable // parameter period=250000://400HZ stable

// parameter period =5000000;//20HZ loop one by one //parameter period=2500000://40HZ twenkle

//parsmeter period =1000000; //100HZ twenkle

always @(posedge clk, negedge rst_n) 
begin
    if(!rst_n)begin
     cnt<=0;
     clkout <=0; 
     end

else begin
 if(cnt==(period>>1)-1) 
 begin
clkout <=clkout;
 cnt<=0;

end
 else
cnt<=cnt+1;
end
end
//freqency division : elk¡ú>clk_out...
always @(posedge clkout, negedge rst_n)//change scan_cnt based on clkout... 
begin
 if(~rst_n)
 scan_cnt<=0;
 else begin
 if(scan_cnt==3'd7)
 scan_cnt<=0;
 else 
 scan_cnt<=scan_cnt+1;
 end
 end
always@(scan_cnt)//select tube...
begin
case(scan_cnt)
3'b000:seg_en=8'h01;
3'b001:seg_en=8'h02;
3'b010:seg_en=8'h04;
3'b011:seg_en=8'h08;
3'b100:seg_en=8'h10;
3'b101:seg_en=8'h20;
3'b110:seg_en=8'h40;
3'b111:seg_en=8'h80;
endcase
end
//module light_7seg_egol(input [3:0]sw,output reg

 wire [7:0] useless_seg_en0, useless_seg_en1;
light_7seg_egol u0(.sw({1'b0,scan_cnt}),.seg_out(seg_out0),.seg_en(useless_seg_en0));
 light_7seg_egol ul(.sw({1'b0,scan_cnt}),.seg_out(seg_out1),.seg_en(useless_seg_en1));
  endmodule
