`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2022 09:13:35 PM
// Design Name: 
// Module Name: system
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


module system(
    output wire [11:0] rgb,
    output wire hsync, vsync,
    input wire RsRx,
    input wire btnC, //reset
    input wire clk
    );

// 0-9, 10=N, 11=a, 12=-
wire [4:0] number4, number3, number2, number1, number0;

// for debug	
assign number4 = 0;
assign number3 = 11;
assign number2 = 10;
assign number1 = 4;
assign number0 = 5;

vga v(rgb, hsync, vsync, clk, btnC, number4, number3, number2, number1, number0);

endmodule
