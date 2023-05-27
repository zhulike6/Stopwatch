`timescale 1ns / 1ps
//分频器：
module clk_divider(clk_in,clk_out);
	input clk_in;
	output reg clk_out=0;//用reg后面always中需要改变数值
 	reg [25:0] clk_div_cnt=0;
//分频为100Hz的信号
        always @ (posedge clk_in)
        begin
            if (clk_div_cnt==499999)
            begin
                clk_out=~clk_out;
                clk_div_cnt=0;
            end
            else 
                clk_div_cnt=clk_div_cnt+1;
       end
endmodule