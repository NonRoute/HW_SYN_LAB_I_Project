`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 05:24:16 PM
// Design Name: 
// Module Name: screen_tb
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


module screen_tb();
wire [11:0] rgb_reg;
reg [9:0] y, x; // /20
reg p_tick;
reg [4:0] number4, number3, number2, number1, number0;
wire [3:0] row,col;

screen s(rgb_reg,row,col,y,x,p_tick,number4,number3,number2,number1,number0);

always 
begin
    #3;
    p_tick=~p_tick;
end 

initial 
begin
    #0;
    number4 = 0;
    number3 = 1;
    number2 = 2;
    number1 = 3;
    number0 = 4;
    p_tick=0;
    y=8;
    x=0;
    
    #10;
    x=1;
    #10;
    x=2;
    #10;
    x=3;
    #10;
    x=4;
    #10;
    x=5;
    #10;
    x=6;
    #10;
    x=7;
    #10;
    x=8;
    
    #10;
    y=9;
    x=0;
    #10;
    x=1;
    #10;
    x=2;
    #10;
    x=3;
    #10;
    x=4;
    #10;
    x=5;
    #10;
    x=6;
    #10;
    x=7;
    #10;
    x=8;
    
    #10;
    y=10;
    x=0;
    #10;
    x=1;
    #10;
    x=2;
    #10;
    x=3;
    #10;
    x=4;
    #10;
    x=5;
    #10;
    x=6;
    #10;
    x=7;
    #10;
    x=8;
    
    #10;
    y=11;
    x=0;
    #10;
    x=1;
    #10;
    x=2;
    #10;
    x=3;
    #10;
    x=4;
    #10;
    x=5;
    #10;
    x=6;
    #10;
    x=7;
    #10;
    x=8;
end
endmodule
