`timescale 1ns / 1ps
module zhuangtaiji(
input clk,
input rst,

input key_start,
input key_reset,
input key_cnt,
input key_timer,
output reg en_right,//����λ����ʹ���ź�
output reg en_left,//����λ����ʹ���ź�
output reg load,//��λʹ���ź�
output reg en_cnt,//�ƴ�ʹ���ź�
output reg en_shu,//��ʾ����ʱ�����ź�
output reg en_down,//��������ʹ��
output reg en_stop//��ͣ
    );
    parameter IDLE=3'b000;//��ʼΪ0̬
    parameter START=3'b001;//��ʱ״̬
    parameter STOP=3'b010;//��ͣ״̬
    parameter CNT=3'b011;//�ƴ�״̬
    parameter TIME=3'b100;//��ʱ��ʱ����ʾ
    parameter COUNTDOWN=3'b101;//����ʱ״̬
    parameter STOP_1=3'b110;//����ʱ״̬����ͣ
    parameter IDLE_1=3'b111;//����ʱ״̬�µĸ�λ��̬
    reg[3:0]cstate;
    reg[3:0]nstate=0;
 
 //cstate
 always @(posedge clk or negedge rst)
 if(!rst)
    cstate<=IDLE;
 else
    cstate<=nstate;
 
 //nstate
 always @*
 case(cstate)
    IDLE:
      if(key_start==1) nstate=START;
      else if(key_timer==1)nstate=TIME;
      else nstate=cstate;
    START:
      if(key_start==1)nstate=STOP;
      else if(key_cnt==1)nstate=CNT;
      else nstate=cstate;
    STOP:
       if(key_start==1)nstate=START;
       else if(key_reset==1)nstate=IDLE;
       else nstate=cstate;
    CNT:
       if(key_start==1)nstate=STOP;
       else nstate=cstate;
    TIME:
        if(key_start==1) nstate=COUNTDOWN;
        else nstate=cstate;
    COUNTDOWN:
        if(key_start==1)nstate=STOP_1;
        else nstate=cstate;
    STOP_1:
       if(key_start==1)nstate=COUNTDOWN;
       else if(key_reset==1)nstate=IDLE_1;
       else nstate=cstate;
    IDLE_1:
      if(key_start==1) nstate=COUNTDOWN;
      else nstate=cstate;
    default:nstate=IDLE;
 endcase
 
 
 //output
always @(posedge clk or negedge rst)

 if(!rst)
 begin
     en_right<=0;
     en_left<=0;
     load<=1;
     en_shu<=0;
     en_down<=0;
     en_stop<=0;
     en_cnt<=0;                                       
 end
 
  else
  begin
     case(cstate)
        IDLE:begin
             en_right<=0;
             load<=1;
             en_left<=0;
             en_shu<=0;
             en_down<=0;
             en_stop<=0;
             en_cnt<=0;
             end
        START:begin
              en_right<=1;
              load<=0;
              en_left<=1;
              en_shu<=0;
              en_down<=0;
              en_stop<=0;
              en_cnt<=0;
              end
        STOP:begin
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=0;
             en_down<=0;
             en_stop<=0;
             en_cnt<=0;
             end
        CNT:begin//�ƴε�״̬
            en_right<=1;
            load<=0;
            en_left<=0;
            en_shu<=0;
            en_down<=0;
            en_stop<=0;
            en_cnt<=1;
            end
        TIME:begin//��ʾ����ʱ��״̬
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=1;
             en_down<=0;
             en_stop<=0;
             en_cnt<=0;
             end
        COUNTDOWN:begin//����ʱ״̬
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=0;
             en_down<=1;
             en_stop<=0;
             en_cnt<=0;
             end
       STOP_1:begin//����ʱ״̬����ͣ
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=0;
             en_down<=0;
             en_stop<=1;
             en_cnt<=0;
             end
       IDLE_1:begin//����ʱ״̬�µĸ�λ��̬
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=1;
             en_down<=0;
             en_stop<=0;
             en_cnt<=0;
             end
        default:begin
              en_right<=0;
              load<=1;
              en_left<=0;
              en_shu<=0;
              en_down<=0;
              en_stop<=0;
              en_cnt<=0;
              end
   endcase
   end

endmodule

