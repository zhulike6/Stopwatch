`timescale 1ns / 1ps
module digi_display(
    input clk,
    input rst,
    
    input [3:0] disp_data_right0,//低四位显示
    input [3:0] disp_data_right1,
    input [3:0] disp_data_right2,
    input [3:0] disp_data_right3,
    input [3:0] disp_data_left0,//高四位显示
    input [3:0] disp_data_left1,
    input [3:0] disp_data_left2,
    input [3:0] disp_data_left3,
    
    input en_shu,//显示倒计时数的信号
    input en_down,//减法计数使能
    input en_stop,//暂停
    input en_cnt,//计次使能信号
    input en_right,//低四位计数使能信号
    input en_left,//高四位计数使能信号
    
    input [3:0]t1, //1s    
    input [3:0]t2, //10s   
    input [3:0]t3, //0.01s 
    input [3:0]t4, //0.1s   
    
    output reg [7:0] seg_right,//段信号
    output reg [3:0] dig_right,//位选信号
    output reg [7:0] seg_left,//段信号
    output reg [3:0] dig_left//位选信号
    );
    
    reg [20:0] clk_divider;
    always @ (posedge clk or negedge rst)begin
        if (!rst)
            clk_divider<=21'd0;
        else
            clk_divider<=clk_divider+1;
    end
    

    wire  [1:0]bitcnt_right; 
    assign bitcnt_right=clk_divider[20:19];
    wire  [1:0]bitcnt_left; 
    assign bitcnt_left=clk_divider[20:19];
    
    reg [3:0] digit_right;
    always @* begin
        if (!rst)
            dig_right=4'd0;
        else begin
            dig_right=4'd0;
            dig_right[bitcnt_right]=1;
        end
    end
    
    reg [3:0] digit_left;
    always @* begin
        if (!rst)
            dig_left=4'd0;
        else begin
            dig_left=4'd0;
            dig_left[bitcnt_left]=1;
        end
    end
    
    //位选信号显示
    reg [7:0] decimal_point_right=8'b00000000;
    reg [7:0] decimal_point_left=8'b00000000;
    
    always @* 
        if (!rst) 
            digit_right<=4'd0;
            
        else if(en_shu) 

            case(bitcnt_right)
                2'd0:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                default:digit_right<=4'd0;
            endcase
            
        else if(en_down) 

            case(bitcnt_right)
                2'd0:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_right<=0;
                    decimal_point_right<=8'b00000000;
                    end
                default:digit_right<=4'd0;
            endcase
            
           else if(en_stop) 
           case(bitcnt_right)
                2'd0:
                    begin
                    digit_right<=disp_data_right0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_right<=disp_data_right1;
                    decimal_point_right<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_right<=disp_data_right2;
                    decimal_point_right<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_right<=disp_data_right3;
                    decimal_point_right<=8'b00000000;
                    end
                default:digit_right<=4'd0;
            endcase
            
            else if(en_cnt) 
           case(bitcnt_right)
                2'd0:
                    begin
                    digit_right<=disp_data_right0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_right<=disp_data_right1;
                    decimal_point_right<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_right<=disp_data_right2;
                    decimal_point_right<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_right<=disp_data_right3;
                    decimal_point_right<=8'b00000000;
                    end
                default:digit_right<=4'd0;
            endcase
            
           else if(en_right) 

            case(bitcnt_right)
                2'd0:
                    begin
                    digit_right<=disp_data_right0;
                    decimal_point_right<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_right<=disp_data_right1;
                    decimal_point_right<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_right<=disp_data_right2;
                    decimal_point_right<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_right<=disp_data_right3;
                    decimal_point_right<=8'b00000000;
                    end
                default:digit_right<=4'd0;
            endcase
            
    
    
    
    always @* 
        if (!rst) 
            digit_left<=4'd0;
            
        else if(en_shu) 

            case(bitcnt_left)
                2'd0:
                    begin
                    digit_left<=0;
                    decimal_point_left<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_left<=0;
                    decimal_point_left<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_left<=0;
                    decimal_point_left<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_left<=0;
                    decimal_point_left<=8'b00000000;
                    end
                default:digit_left<=4'd0;
            endcase
            
        else if(en_down) 

            case(bitcnt_left)
                2'd0:
                    begin
                    digit_left<=t3;
                    decimal_point_left<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_left<=t4;
                    decimal_point_left<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_left<=t1;
                    decimal_point_left<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_left<=t2;
                    decimal_point_left<=8'b00000000;
                    end
                default:digit_left<=4'd0;
            endcase
            
        else if(en_stop) 

            case(bitcnt_left)
                2'd0:
                    begin
                    digit_left<=disp_data_left0;
                    decimal_point_left<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_left<=disp_data_left1;
                    decimal_point_left<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_left<=disp_data_left2;
                    decimal_point_left<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_left<=disp_data_left3;
                    decimal_point_left<=8'b00000000;
                    end
                default:digit_left<=4'd0;
                endcase
            
            else if(en_cnt) 

            case(bitcnt_left)
                2'd0:
                    begin
                    digit_left<=disp_data_left0;
                    decimal_point_left<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_left<=disp_data_left1;
                    decimal_point_left<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_left<=disp_data_left2;
                    decimal_point_left<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_left<=disp_data_left3;
                    decimal_point_left<=8'b00000000;
                    end
                default:digit_left<=4'd0;
                endcase
            
        else if(en_left) 

            case(bitcnt_left)
                2'd0:
                    begin
                    digit_left<=disp_data_left0;
                    decimal_point_left<=8'b00000000;
                    end
                2'd1:
                    begin
                    digit_left<=disp_data_left1;
                    decimal_point_left<=8'b00000000;
                    end
                2'd2:
                    begin
                    digit_left<=disp_data_left2;
                    decimal_point_left<=8'b00000001;
                    end
                2'd3:
                    begin
                    digit_left<=disp_data_left3;
                    decimal_point_left<=8'b00000000;
                    end
                default:digit_left<=4'd0;
            endcase
            
    
    
    //段信号显示
    always @(*)begin
    if (!rst) 
        seg_right=8'b11111110;
        
    else
        
        case(digit_right)
        0:seg_right=8'b11111100+decimal_point_right;
        1:seg_right=8'b01100000+decimal_point_right;
        2:seg_right=8'b11011010+decimal_point_right;
        3:seg_right=8'b11110010+decimal_point_right;
        4:seg_right=8'b01100110+decimal_point_right;
        5:seg_right=8'b10110110+decimal_point_right;
        6:seg_right=8'b10111110+decimal_point_right;
        7:seg_right=8'b11100000+decimal_point_right;
        8:seg_right=8'b11111110+decimal_point_right;
        9:seg_right=8'b11110110+decimal_point_right;
        default:seg_right=8'b11111100;
        endcase
        
    end
    
    always @(*)begin
    if (!rst) 
        seg_left=8'b11111110;
        
    else    
        
        case(digit_left)
        0:seg_left=8'b11111100+decimal_point_left;
        1:seg_left=8'b01100000+decimal_point_left;
        2:seg_left=8'b11011010+decimal_point_left;
        3:seg_left=8'b11110010+decimal_point_left;
        4:seg_left=8'b01100110+decimal_point_left;
        5:seg_left=8'b10110110+decimal_point_left;
        6:seg_left=8'b10111110+decimal_point_left;
        7:seg_left=8'b11100000+decimal_point_left;
        8:seg_left=8'b11111110+decimal_point_left;
        9:seg_left=8'b11110110+decimal_point_left;
        default:seg_left=8'b11111100;
        endcase
        
    end
endmodule
