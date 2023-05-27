`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/14 00:15:12
// Design Name: 
// Module Name: dyLED
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


//动态显示模块：
module dynaLED(disp_data_right0,disp_data_right1,disp_data_right2,disp_data_right3,
               disp_data_left0,disp_data_left1,disp_data_left2,disp_data_left3,
               clk,seg_right,dig_right,seg_left,dig_left);
    input [3:0] disp_data_right0;
    input [3:0] disp_data_right1;
    input [3:0] disp_data_right2;
    input [3:0] disp_data_right3;
    input [3:0] disp_data_left0;
    input [3:0] disp_data_left1;
    input [3:0] disp_data_left2;
    input [3:0] disp_data_left3;
    
    input clk;
    output reg [7:0] seg_right;
    output reg [3:0] dig_right;
    output reg [7:0] seg_left;
    output reg [3:0] dig_left;
	
	//分频为1KHz，十分之一倍的最小计时单位
	reg [24:0] clock_divider_cnt=0;
	reg clock_divider=0;
	always@(posedge clk)
	begin
		if (clock_divider_cnt==24999)
		begin
			clock_divider=~(clock_divider);
			clock_divider_cnt=0;
		end
		else 
		    clock_divider_cnt=clock_divider_cnt+1;
	end
	//6进制计数器
	reg [2:0] num=0;
	always@(posedge clock_divider)
	begin
		if (num>=5)
			num=0;
		else
			num=num+1;
	end
	
	//译码器
	always@(num)
	begin	
		case(num)
		0:dig_right=4'b0001;
		1:dig_right=4'b0010;
		2:dig_right=4'b0100;
		3:dig_right=4'b1000;
		default: dig_right=0;
		endcase
	end
	
	always@(num)
	begin	
		case(num)
        0:dig_left=4'b0001;
		1:dig_left=4'b0010;
		2:dig_left=4'b0100;
		3:dig_left=4'b1000;
		default: dig_left=0;
		endcase
	end
	
	//选择器，确定显示数据
	reg [3:0] disp_data1=0;
	reg [3:0] disp_data2=0;
	always@(num)
	begin	
		case(num)
		0:disp_data1=disp_data_right0;
		1:disp_data1=disp_data_right1;
		2:disp_data1=disp_data_right2;
		3:disp_data1=disp_data_right3;
        default: disp_data1=0;
		endcase
	end
	
	always@(num)
	begin	
		case(num)
		0:disp_data2=disp_data_left0;
		1:disp_data2=disp_data_left1;
		2:disp_data2=disp_data_left2;
		3:disp_data2=disp_data_left3;
        default: disp_data2=0;
		endcase
	end
	
	//显示译码器
	always@(disp_data1)
	begin
		case(disp_data1)
		4'h0: seg_right= 8'h3f;// DP,GFEDCBA
		4'h1: seg_right= 8'h06;
		4'h2: seg_right= 8'h5b;
		4'h3: seg_right= 8'h4f;
		4'h4: seg_right= 8'h66;
		4'h5: seg_right= 8'h6d;
		4'h6: seg_right= 8'h7d;
		4'h7: seg_right= 8'h07;
		4'h8: seg_right= 8'h7f;
		4'h9: seg_right= 8'h6f;
		4'ha: seg_right= 8'h77;
		4'hb: seg_right= 8'h7c;
		4'hc: seg_right= 8'h39;
		4'hd: seg_right= 8'h5e;
		4'he: seg_right= 8'h79;
		4'hf: seg_right= 8'h71;
		default: seg_right=0;
		endcase
	end
	
	always@(disp_data2)
	begin
		case(disp_data2)
		4'h0: seg_left=8'h3f;// DP,GFEDCBA
		4'h1: seg_left=8'h06;
		4'h2: seg_left=8'h5b;
		4'h3: seg_left=8'h4f;
		4'h4: seg_left=8'h66;
		4'h5: seg_left=8'h6d;
		4'h6: seg_left=8'h7d;
		4'h7: seg_left=8'h07;
		4'h8: seg_left=8'h7f;
		4'h9: seg_left=8'h6f;
		4'ha: seg_left=8'h77;
		4'hb: seg_left=8'h7c;
		4'hc: seg_left=8'h39;
		4'hd: seg_left=8'h5e;
		4'he: seg_left=8'h79;
		4'hf: seg_left=8'h71;
		default: seg_left=0;
		endcase
	end
endmodule
