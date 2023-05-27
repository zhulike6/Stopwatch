`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/17 17:32:35
// Design Name: 
// Module Name: edgedetect
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
//module edgedetect(
//input clk,   //系统时钟
//input rst,  
//input key_in,  //输入的按键信号
//output wire key_out  //输出消抖后的按键信号
//    );
// reg key_value;
// reg key_p_flag;
// reg key_reg;
// reg [20:0]delay_cnt;
// parameter DELAY_TIME=21'd1500000; //按键持续时间1/100M  s

////key_reg:按键输入寄存器
//always@(posedge clk or negedge rst)
//if(!rst)
//    key_reg<=1'b0;
//else
//    key_reg<=key_in;

////delay_cnt:延时计数器
//always@(posedge clk or negedge rst)
//    if(!rst)
//        delay_cnt<=21'b0;
//    else if(key_in!=key_reg)
//        delay_cnt<=DELAY_TIME;
//    else if(delay_cnt>0)
//        delay_cnt<=delay_cnt-1'b1;
//    else
//        delay_cnt<=21'd0;
        
////key_value
//always@(posedge clk or negedge rst)
//    if(!rst)
//        key_value<=1'b0;
//    else if(delay_cnt==1'b1)
//        key_value<=key_in;
//    else
//        key_value<=key_value;

////key_p_flag:按键上升沿标志信号
//always@(posedge clk or negedge rst)
//    if(!rst)
//        key_p_flag<=1'b0;
//    else if(delay_cnt==1'b1&&key_in==1)
//        key_p_flag<=1'b1;
//    else
//        key_p_flag<=1'b0;

//assign key_out=key_p_flag;
//endmodule
//module edgedetect (clk,rst,key_in,key_out);
 
//        parameter       N  =  1;                      //要消除的按键的数量
 
//	input             clk;
//        input             rst;
//        input 	[N-1:0]   key_in;                        //输入的按键					
//	output  [N-1:0]   key_out;                  //按键动作产生的脉冲	
 
//        reg     [N-1:0]   key_rst_pre;                //定义一个寄存器型变量存储上一个触发时的按键值
//        reg     [N-1:0]   key_rst;                    //定义一个寄存器变量储存储当前时刻触发的按键值
 
//        wire    [N-1:0]   key_edge;                   //检测到按键由高到低变化是产生一个高脉冲
 
//        //利用非阻塞赋值特点，将两个时钟触发时按键状态存储在两个寄存器变量中
//        always @(posedge clk  or  negedge rst)
//          begin
//             if (!rst) begin
//                 key_rst <= {N{1'b1}};                //初始化时给key_rst赋值全为1，{}中表示N个1
//                 key_rst_pre <= {N{1'b1}};
//             end
//             else begin
//                 key_rst <= key_in;                     //第一个时钟上升沿触发之后key的值赋给key_rst,同时key_rst的值赋给key_rst_pre
//                 key_rst_pre <= key_rst;             //非阻塞赋值。相当于经过两个时钟触发，key_rst存储的是当前时刻key的值，key_rst_pre存储的是前一个时钟的key的值
//             end    
//           end
 
//        assign  key_edge = key_rst_pre & (~key_rst);//脉冲边沿检测。当key检测到下降沿时，key_edge产生一个时钟周期的高电平
 
//        reg	[17:0]	  cnt;                       //产生延时所用的计数器，系统时钟12MHz，要延时20ms左右时间，至少需要18位计数器     
 
//        //产生20ms延时，当检测到key_edge有效是计数器清零开始计数
//        always @(posedge clk or negedge rst)
//           begin
//             if(!rst)
//                cnt <= 18'h0;
//             else if(key_edge)
//                cnt <= 18'h0;
//             else
//                cnt <= cnt + 1'h1;
//             end  
 
//        reg     [N-1:0]   key_sec_pre;                //延时后检测电平寄存器变量
//        reg     [N-1:0]   key_sec;                    
 
 
//        //延时后检测key，如果按键状态变低产生一个时钟的高脉冲。如果按键状态是高的话说明按键无效
//        always @(posedge clk  or  negedge rst)
//          begin
//             if (!rst) 
//                 key_sec <= {N{1'b1}};                
//             else if (cnt==18'h3ffff)
//                 key_sec <= key_in;  
//          end
//       always @(posedge clk  or  negedge rst)
//          begin
//             if (!rst)
//                 key_sec_pre <= {N{1'b1}};
//             else                   
//                 key_sec_pre <= key_sec;             
//         end      
//       assign  key_out = key_sec_pre & (~key_sec);     
 
//endmodule
module edgedetect(
    input clk,
    input key_in,
    input rst,
    output reg key_out
    );
    parameter DELAY_TIME=2000000;
    reg [20:0]delay_cnt;
    reg key_reg;
    reg key_store;
    initial begin key_out<=1'b0; end
    always@(posedge clk or negedge rst)
    if(!rst) key_reg<=1'b0;
    else key_reg<=key_in;
    always@(posedge clk or negedge rst)
    if(!rst)delay_cnt<=21'b0;
    else if(key_in!=key_reg)delay_cnt<=DELAY_TIME;
    else if(delay_cnt>0)delay_cnt<=delay_cnt-1'b1;
    else delay_cnt<=21'b0;
    always@(posedge clk or negedge rst)
    if(!rst)key_store<=1'b0;
    else if(delay_cnt==1'b1)key_store<=key_in;
    else key_store<=key_store;
    always@(posedge key_store or negedge rst)
    begin
        if(!rst)
        key_out<=1'b0;
        else
        key_out<=~key_out;
    end
endmodule