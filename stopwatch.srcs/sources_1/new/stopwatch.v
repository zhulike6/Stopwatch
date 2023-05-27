`timescale 1ns / 1ps

module stopwatch(
    input clk_50M,rst,
    input key_1,
    input key_2,
    input key_3,
    input key_4,
    output [7:0] seg_right,
    output [3:0] dig_right,
    output [7:0] seg_left,
    output [3:0] dig_left
    );
    
    wire key_1_out;
    wire key_2_out;
    wire key_3_out;   
    wire key_4_out;
    wire en_right;
    wire en_shu;
    wire en_left;
    wire en_down;
    wire en_stop;
    wire en_cnt;
    wire load;
 
    
    wire clk_100;//100Hz
    clk_divider u1(
                   .clk_in(clk_50M),
                   .clk_out(clk_100)
                   );
    //计数器
    wire [3:0] cout_left0,cout_left1,cout_left2,cout_left3;
    wire [3:0] cout_right0,cout_right1,cout_right2,cout_right3;
    wire carry_left0,carry_left1,carry_left2,carry_left3;
    wire carry_right0,carry_right1,carry_right2,carry_right3;
 
    m10_counter u2(
                    .clk(clk_100),
                    .clr(load),
                    .en(en_right),
                    .carry(carry_right0),
                    .cout(cout_right0)
                    );
    m10_counter u3(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_right0),
                    .carry(carry_right1),
                    .cout(cout_right1)
                    );
    m10_counter u4(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_right1),
                    .carry(carry_right2),
                    .cout(cout_right2)
                    );
    m6_counter u5(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_right2),
                    .carry(carry_right3),
                    .cout(cout_right3)
                    );
    m10_counter u6(
                    .clk(clk_100),
                    .clr(load),
                    .en(en_left),
                    .carry(carry_left0),
                    .cout(cout_left0)
                    );
    m10_counter u7(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_left0),
                    .carry(carry_left1),
                    .cout(cout_left1)
                    );
    m10_counter u8(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_left1),
                    .carry(carry_left2),
                    .cout(cout_left2)
                    );
    m6_counter u9(
                    .clk(clk_100),
                    .clr(load),
                    .en(carry_left2),
                    .carry(carry_left3),
                    .cout(cout_left3)
                    );
    

    wire[3:0] disp_data_right0,disp_data_right1,disp_data_right2,disp_data_right3;
    wire[3:0] disp_data_left0,disp_data_left1,disp_data_left2,disp_data_left3;
    assign disp_data_right0=cout_right0;
    assign disp_data_right1=cout_right1;
    assign disp_data_right2=cout_right2; 
    assign disp_data_right3=cout_right3;
    assign disp_data_left0=cout_left0;
    assign disp_data_left1=cout_left1;
    assign disp_data_left2=cout_left2; 
    assign disp_data_left3=cout_left3;
    
    wire[3:0] t1,t2,t3,t4;
    //数码管显示
    digi_display u10(
                    .disp_data_right0(disp_data_right0),
                    .disp_data_right1(disp_data_right1),
                    .disp_data_right2(disp_data_right2),
                    .disp_data_right3(disp_data_right3),
                    .disp_data_left0(disp_data_left0),
                    .disp_data_left1(disp_data_left1),
                    .disp_data_left2(disp_data_left2),
                    .disp_data_left3(disp_data_left3), 
                    
                    .t1(t1),
                    .t2(t2),
                    .t3(t3),
                    .t4(t4), 
                    
                    .clk(clk_50M),
                    .seg_right(seg_right),
                    .dig_right(dig_right),
                    .seg_left(seg_left),
                    .dig_left(dig_left),
                    .rst(rst),
                    
                    .en_shu(en_shu),
                    .en_down(en_down),
                    .en_stop(en_stop),
                    .en_cnt(en_cnt),
                    .en_right(en_right),
                    .en_left(en_left)
                    );
     //按键消抖               
     edgedetect deb_U1(
     .clk(clk_50M),
     .rst(rst),
     .key_in(key_1),
     .key_out(key_1_out)
     );
     
     edgedetect  deb_U2(
     .clk(clk_50M),
     .rst(rst),
     .key_in(key_2),
     .key_out(key_2_out)
     );
     
      edgedetect  deb_U3(
     .clk(clk_50M),
     .rst(rst),
     .key_in(key_3),
     .key_out(key_3_out)
     );
     
     edgedetect  deb_U4(
     .clk(clk_50M),
     .rst(rst),
     .key_in(key_4),
     .key_out(key_4_out)
     );
     //倒计时
     cnt_down cnt_down(
        .clk(clk_100),
        .rst(en_shu),
        .en_down(en_down),
        .t1(t1),//1s
        .t2(t2),//10s
        .t3(t3),//0.01s
        .t4(t4)//0.1s
        );
     //状态机设计   
     zhuangtaiji zhuangtaiji(
         .key_start(key_1_out),
         .key_reset(key_2_out),
         .key_cnt(key_3_out),
         .key_timer(key_4_out),
         .clk(clk_50M),
         .rst(rst),
         .en_right(en_right),
         .en_left(en_left),
         .load(load),
         .en_shu(en_shu),
         .en_down(en_down),
         .en_stop(en_stop),
         .en_cnt(en_cnt)
        //使能信号
         );
endmodule
