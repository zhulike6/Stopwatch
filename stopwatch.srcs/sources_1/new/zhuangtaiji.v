`timescale 1ns / 1ps
module zhuangtaiji(
input clk,
input rst,

input key_start,
input key_reset,
input key_cnt,
input key_timer,
output reg en_right,//低四位计数使能信号
output reg en_left,//高四位计数使能信号
output reg load,//复位使能信号
output reg en_cnt,//计次使能信号
output reg en_shu,//显示倒计时数的信号
output reg en_down,//减法计数使能
output reg en_stop//暂停
    );
    parameter IDLE=3'b000;//初始为0态
    parameter START=3'b001;//计时状态
    parameter STOP=3'b010;//暂停状态
    parameter CNT=3'b011;//计次状态
    parameter TIME=3'b100;//定时器时间显示
    parameter COUNTDOWN=3'b101;//倒计时状态
    parameter STOP_1=3'b110;//倒计时状态下暂停
    parameter IDLE_1=3'b111;//倒计时状态下的复位初态
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
        CNT:begin//计次的状态
            en_right<=1;
            load<=0;
            en_left<=0;
            en_shu<=0;
            en_down<=0;
            en_stop<=0;
            en_cnt<=1;
            end
        TIME:begin//显示倒计时数状态
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=1;
             en_down<=0;
             en_stop<=0;
             en_cnt<=0;
             end
        COUNTDOWN:begin//倒计时状态
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=0;
             en_down<=1;
             en_stop<=0;
             en_cnt<=0;
             end
       STOP_1:begin//倒计时状态下暂停
             en_right<=0;
             load<=0;
             en_left<=0;
             en_shu<=0;
             en_down<=0;
             en_stop<=1;
             en_cnt<=0;
             end
       IDLE_1:begin//倒计时状态下的复位初态
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

