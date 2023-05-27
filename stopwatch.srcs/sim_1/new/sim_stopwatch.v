`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 00:38:22
// Design Name: 
// Module Name: sim_stopwatch
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
module sim_stopwatch();
    reg clk_50M;
    reg rst;    
    reg key_1;
    reg key_2;
    reg key_3;
    reg key_4;
    wire [7:0] seg_right;
    wire [3:0] dig_right;
    wire [7:0] seg_left;
    wire [3:0] dig_left;
    
    stopwatch uut1(clk_50M,key_1,key_2,key_3,key_4,seg_right,dig_right,seg_left,dig_left); 
    initial begin
    clk_50M=0;
    end
    always #10 clk_50M=~clk_50M; //每隔10ns反相一次，即50MHZ
    always #50 key_1=1'b1;
    always #80 key_1=1'b0;
    always #20 rst=1'b1;
    always #30 key_2=1'b1;
    always #40 key_2=1'b0;
    always #90 key_3=1'b1;
    always #100 key_3=1'b0;
    always #110 key_4=1'b1;
    always #2000 key_4=1'b0;
endmodule
