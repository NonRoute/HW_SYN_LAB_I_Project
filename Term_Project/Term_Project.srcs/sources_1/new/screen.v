`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 02:43:54 PM
// Design Name: 
// Module Name: screen
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


module screen(
    output reg [11:0] rgb_reg,
//    output reg [3:0] row, col, //debug
    input wire [9:0] y, x, // /20
    input wire clk,
    input wire [4:0] number4, number3, number2, number1, number0
    );
    
    reg [3:0] row, col;
    reg [4:0] number;
    reg [3:0] digit;
    wire [11:0] z;
    reg [11:0] screen[0:23][0:31];
    
    rom_font r(z,row,col,number);
    
    reg [11:0] gradient = 0;
    reg [15:0] count = 0;
    
    always @(posedge clk) begin
       if (y >= 8 && y <= 15 && x>= 2 && (x-2)%6 >= 0 && (x-2)%6 <= 4) begin
           row <= y-8;
           col <= (x-2)%6;
           digit <= 4-(x-2)/6;
           case(digit)
                4: number <= number4;
                3: number <= number3;
                2: number <= number2;
                1: number <= number1;
                0: number <= number0;
           endcase
           rgb_reg[11:0] <= z;
       end 
       else if (y <= 4 || y >= 20) begin
           rgb_reg[11:0] <= gradient; //000
       end
       else 
           rgb_reg[11:0] <= 12'h0;
           
       if (y==0 && x==0)
            count <= count + 1;
       if (count == 0)
            gradient <= gradient + 1;
    end
	
endmodule
