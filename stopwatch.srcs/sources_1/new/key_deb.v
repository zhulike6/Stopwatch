`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/20 11:14:07
// Design Name: 
// Module Name: key_deb
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
module key_deb(
input clk,   //ϵͳʱ��
input rst,  
input key_in,  //����İ����ź�
output wire key_out  //���������İ����ź�
    );
 reg key_value;
 reg key_p_flag;
 reg key_reg;
 reg [20:0]delay_cnt;
 parameter DELAY_TIME=21'd1500000; //��������ʱ��1/100M  s

//key_reg:��������Ĵ���
always@(posedge clk or negedge rst)
if(!rst)
    key_reg<=1'b0;
else
    key_reg<=key_in;

//delay_cnt:��ʱ������
always@(posedge clk or negedge rst)
    if(!rst)
        delay_cnt<=21'b0;
    else if(key_in!=key_reg)
        delay_cnt<=DELAY_TIME;
    else if(delay_cnt>0)
        delay_cnt<=delay_cnt-1'b1;
    else
        delay_cnt<=21'd0;
        
//key_value
always@(posedge clk or negedge rst)
    if(!rst)
        key_value<=1'b0;
    else if(delay_cnt==1'b1)
        key_value<=key_in;
    else
        key_value<=key_value;

//key_p_falg:���������ر�־�ź�
always@(posedge clk or negedge rst)
    if(!rst)
        key_p_flag<=1'b0;
    else if(delay_cnt==1'b1&&key_in==1)
        key_p_flag<=1'b1;
    else
        key_p_flag<=1'b0;

assign key_out=key_p_flag;
endmodule
