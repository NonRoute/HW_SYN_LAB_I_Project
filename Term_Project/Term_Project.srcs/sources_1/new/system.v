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
    output wire [3:0] vgaRed, vgaGreen, vgaBlue,
    output wire Hsync, Vsync,
    input wire RsRx,
    input wire btnC, clk,
    input wire [11:0] sw
    );

//-9999 to 9999 or NaN    
wire [7:0] digits[4:0];

vga v(vgaRed, vgaGreen, vgaBlue, Hsync, Vsync, digits[4], digits[3], digits[2], digits[1], digits[0], sw, clk, btnC);
endmodule
