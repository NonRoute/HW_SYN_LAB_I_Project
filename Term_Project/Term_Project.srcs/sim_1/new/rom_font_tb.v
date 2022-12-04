`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:38:35 PM
// Design Name: 
// Module Name: rom_font_tb
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


module rom_font_tb();
    
wire [11:0] z;
reg [3:0] row;
reg [3:0] col;
reg [4:0] number; //0-9,N,a,-

rom_font r(z,row,col,number);

initial
begin
    #0;
    row = 0;
    col = 0;
    number = 0;
    #10;
    row = 0;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 1;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 2;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 3;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 4;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 5;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 6;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    row = 7;
    col = 0;
    #10;
    col = 1;
    #10;
    col = 2;
    #10;
    col = 3;
    #10;
    col = 4;
    #10;
    $finish;
end

endmodule
