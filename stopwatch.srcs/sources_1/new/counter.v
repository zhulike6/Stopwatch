`timescale 1ns / 1ps
module m10_counter(clr,clk,en,cout,carry);
    input clr,clk;
    input en;
    output carry;
    output reg [3:0] cout;
    always@(posedge clk or negedge clr)
        begin
            if(!clr)
                begin
                    cout<=0;
                end          //完成清零操作，计数器输出为0
            else if(en==1)  //使能有效
                begin
                    if (cout==9)    //计数+1，若低位已经到最大数9
                        begin 
                            cout<=0;      //输出跳转到最小数0
                        end
                    else cout<=cout+1;       //若输出未到最大数，则只加1
                end
            end
               //计到最大数9，同时使能有效，输出Carry为1
            assign carry=((en==1)&&(cout==9))?1'b1:1'b0;
endmodule

module m6_counter(clr,clk,en,cout,carry);
	input clk,clr;
	input en;               //使能信号
	output carry;              //计数器进位输出
	output reg [3:0] cout=0;     // 计数器的输出
         always @(posedge clk or negedge clr)  //异步清零
              begin
                  if(!clr)       //清零有效
                      begin 
                          cout<=0;
                      end          //完成清零操作，计数器输出为0
                  else if(en==1)  //使能有效
                      begin
                          if (cout==5)    //计数+1，若低位已经到最大数5
                              begin 
                                  cout<=0;      //输出跳转到最小数0
                              end
                          else cout<=cout+1;       //若输出未到最大数，则加1
                      end
              end
               //计到最大数5，同时使能有效，输出Carry为1
              assign carry=((en==1)&&(cout==5))?1'b1:1'b0;
endmodule
