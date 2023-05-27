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
                end          //���������������������Ϊ0
            else if(en==1)  //ʹ����Ч
                begin
                    if (cout==9)    //����+1������λ�Ѿ��������9
                        begin 
                            cout<=0;      //�����ת����С��0
                        end
                    else cout<=cout+1;       //�����δ�����������ֻ��1
                end
            end
               //�Ƶ������9��ͬʱʹ����Ч�����CarryΪ1
            assign carry=((en==1)&&(cout==9))?1'b1:1'b0;
endmodule

module m6_counter(clr,clk,en,cout,carry);
	input clk,clr;
	input en;               //ʹ���ź�
	output carry;              //��������λ���
	output reg [3:0] cout=0;     // �����������
         always @(posedge clk or negedge clr)  //�첽����
              begin
                  if(!clr)       //������Ч
                      begin 
                          cout<=0;
                      end          //���������������������Ϊ0
                  else if(en==1)  //ʹ����Ч
                      begin
                          if (cout==5)    //����+1������λ�Ѿ��������5
                              begin 
                                  cout<=0;      //�����ת����С��0
                              end
                          else cout<=cout+1;       //�����δ������������1
                      end
              end
               //�Ƶ������5��ͬʱʹ����Ч�����CarryΪ1
              assign carry=((en==1)&&(cout==5))?1'b1:1'b0;
endmodule
