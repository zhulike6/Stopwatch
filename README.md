# Stopwatch
A stopwatch based on Verilog
With EGO1 as the core, a stopwatch is designed using Verilog HDL hardware description language. Using the idea of state machine, to achieve the following functions: 
1. High four digits (four digital tubes on the left) Low four digits (four digital tubes on the right) 00.00s~59.99s at the same time timing;
2. High four-digit positive timing and countdown conversion;
3. Reset, the button reset function can be realized in the state of timing and countdown;
4. Count, high four (four digital tubes on the left) pause and count;

一款基于Verilog语言设计的秒表
以 FPGA 器件EGO1为核心，使用Verilog HDL硬件描述语言设计了一款秒表。利用状态机思想，实现以下功能：
1. 高四位（左侧四个数码管）低四位（右侧四个数码管）00.00s~59.99s同时正计时；
2. 高四位正计时和倒计时转换；
3. 复位，在正计时、倒计时状态下均能实现按键复位功能；
4. 计次，高四位（左侧四个数码管）暂停，计次。
