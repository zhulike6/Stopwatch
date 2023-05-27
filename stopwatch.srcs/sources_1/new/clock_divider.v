`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/11 17:01:41
// Design Name: 
// Module Name: clock_divider
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
module clock_divider(clk_in,clk_out);
    input clk_in;
    output reg clk_out=0;
    reg [24:0] clk_divider_cnt=0;
    always@(posedge clk_in)
    begin
        if(clk_divider_cnt==499999)
        begin
            clk_out=~clk_out;
            clk_divider_cnt=0;
        end
        else
            clk_divider_cnt=clk_divider_cnt+1;
    end
endmodule

