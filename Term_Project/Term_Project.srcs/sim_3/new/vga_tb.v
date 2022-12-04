`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 06:28:42 PM
// Design Name: 
// Module Name: vga_tb
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


module vga_tb();
    
wire [11:0] rgb;
wire hsync, vsync;
reg clk, btnC, reset;
wire [3:0] row;
wire [3:0] col;
wire [9:0] y;
wire [9:0] x;
    
vga v1(rgb, hsync, vsync, clk, btnC,row,col,y,x);
//vga_sync vs(clk, reset,hsync, vsync, video_on, p_tick,x, y);
always 
begin
    #1;
    clk=~clk;
end 

initial 
begin
    #0;
    clk = 0;
    btnC = 1;
    reset = 1;
    #10;
    btnC = 0;
    reset = 0;
    #100000;
    $finish;
end
endmodule
