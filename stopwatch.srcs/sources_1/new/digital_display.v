`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 10:57:34
// Design Name: 
// Module Name: digital_display
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


module digital_display(
    input clk,
    input rst,
    input [7:0] x,
    output reg [6:0] a_to_g,
    output reg [1:0] an
    );
    reg [20:0] clkdiv;
    always @ (posedge clk or negedge rst)begin
        if (!rst)
            clkdiv<=21'd0;
        else
            clkdiv=clkdiv+1;
    end
    wire  bitcnt; //位扫描信号
    assign bitcnt=clkdiv[20];
    reg [3:0] digit;//当前显示的数字
    always @* begin
        if (!rst)
            an=2'd0;
        else begin
            an=2'd0;
            an[bitcnt]=1;
        end
    end
    always @* begin
        if (!rst)
            digit=4'd0;
        else
            case(bitcnt)
                2'd0:digit=x[3:0];
                2'd1:digit=x[7:4];
                default:digit=2'd0;
            endcase
    end
    always @(*)begin
    if (!rst)
        a_to_g=7'b1111111;
    else
        case(digit)
        0:a_to_g=7'b1111110;
        1:a_to_g=7'b0110000;
        2:a_to_g=7'b1101101;
        3:a_to_g=7'b1111001;
        4:a_to_g=7'b0110011;
        5:a_to_g=7'b1011011;
        6:a_to_g=7'b1011111;
        7:a_to_g=7'b1110000;
        8:a_to_g=7'b1111111;
        9:a_to_g=7'b1111011;
        default:a_to_g=7'b1111110;
        endcase
    end
endmodule
