`timescale 1ns / 1ps
module cnt_down(
input clk,
input rst,
input en_down,
output reg [3:0]t1=4'b0000,//1s
output reg [3:0]t2=4'b0110,//10s
output reg [3:0]t3=4'b0000,//0.01s
output reg [3:0]t4=4'b0000//0.1s
    );
    
    always @(posedge clk or posedge rst)begin
    if(rst)begin
       t1<=4'b0000;
       t2<=4'b0110;
       t3<=4'b0000;
       t4<=4'b0000;
       end
    
     else   if(t1==0&&t2==0&&t3==0&&t4==0&&en_down==1)begin
       t1<=4'b0000;
       t2<=4'b0110;
       t3<=4'b0000;
       t4<=4'b0000;
       end
      else if(t1==0&&t4==0&&t3==0&&en_down==1)begin
       t1<=4'd9;
       t4<=4'd9;
       t3<=4'd9;
       t2<=t2-4'd1;
       end
      else if(t4==0&&t3==0&&en_down==1)begin
       t4<=4'd9;
       t3<=4'd9;
       t1<=t1-4'd1;
       end
      else if(t3==4'd0&&en_down==1)begin
       t3<=4'd9;
       t4<=t4-4'd1;
       end
    else if(en_down)
       t3<=t3-4'd1;
       end
endmodule
