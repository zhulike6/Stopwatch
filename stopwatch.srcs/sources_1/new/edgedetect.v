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
//input clk,   //ϵͳʱ��
//input rst,  
//input key_in,  //����İ����ź�
//output wire key_out  //���������İ����ź�
//    );
// reg key_value;
// reg key_p_flag;
// reg key_reg;
// reg [20:0]delay_cnt;
// parameter DELAY_TIME=21'd1500000; //��������ʱ��1/100M  s

////key_reg:��������Ĵ���
//always@(posedge clk or negedge rst)
//if(!rst)
//    key_reg<=1'b0;
//else
//    key_reg<=key_in;

////delay_cnt:��ʱ������
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

////key_p_flag:���������ر�־�ź�
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
 
//        parameter       N  =  1;                      //Ҫ�����İ���������
 
//	input             clk;
//        input             rst;
//        input 	[N-1:0]   key_in;                        //����İ���					
//	output  [N-1:0]   key_out;                  //������������������	
 
//        reg     [N-1:0]   key_rst_pre;                //����һ���Ĵ����ͱ����洢��һ������ʱ�İ���ֵ
//        reg     [N-1:0]   key_rst;                    //����һ���Ĵ����������洢��ǰʱ�̴����İ���ֵ
 
//        wire    [N-1:0]   key_edge;                   //��⵽�����ɸߵ��ͱ仯�ǲ���һ��������
 
//        //���÷�������ֵ�ص㣬������ʱ�Ӵ���ʱ����״̬�洢�������Ĵ���������
//        always @(posedge clk  or  negedge rst)
//          begin
//             if (!rst) begin
//                 key_rst <= {N{1'b1}};                //��ʼ��ʱ��key_rst��ֵȫΪ1��{}�б�ʾN��1
//                 key_rst_pre <= {N{1'b1}};
//             end
//             else begin
//                 key_rst <= key_in;                     //��һ��ʱ�������ش���֮��key��ֵ����key_rst,ͬʱkey_rst��ֵ����key_rst_pre
//                 key_rst_pre <= key_rst;             //��������ֵ���൱�ھ�������ʱ�Ӵ�����key_rst�洢���ǵ�ǰʱ��key��ֵ��key_rst_pre�洢����ǰһ��ʱ�ӵ�key��ֵ
//             end    
//           end
 
//        assign  key_edge = key_rst_pre & (~key_rst);//������ؼ�⡣��key��⵽�½���ʱ��key_edge����һ��ʱ�����ڵĸߵ�ƽ
 
//        reg	[17:0]	  cnt;                       //������ʱ���õļ�������ϵͳʱ��12MHz��Ҫ��ʱ20ms����ʱ�䣬������Ҫ18λ������     
 
//        //����20ms��ʱ������⵽key_edge��Ч�Ǽ��������㿪ʼ����
//        always @(posedge clk or negedge rst)
//           begin
//             if(!rst)
//                cnt <= 18'h0;
//             else if(key_edge)
//                cnt <= 18'h0;
//             else
//                cnt <= cnt + 1'h1;
//             end  
 
//        reg     [N-1:0]   key_sec_pre;                //��ʱ�����ƽ�Ĵ�������
//        reg     [N-1:0]   key_sec;                    
 
 
//        //��ʱ����key���������״̬��Ͳ���һ��ʱ�ӵĸ����塣�������״̬�ǸߵĻ�˵��������Ч
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