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
    input wire [9:0] y, x, // 0-23,0-31
    input wire p_tick, btnC,
    input wire [4:0] number4, number3, number2, number1, number0
    );
    
    // rom for storing fonts
    wire [3:0] row, col;
    reg [4:0] number;
    wire [3:0] digit;
    wire [11:0] z;
    rom_font r(z,row,col,number);
         
    wire [11:0] next_rgb;
    
    // map fonts in rom to the position on screen   
    assign row = y-8;
    assign col = (x-2)%6;
    assign digit = 4-(x-2)/6;
    always @(digit) begin
        case(digit)
            4: number = number4;
            3: number = number3;
            2: number = number2;
            1: number = number1;
            0: number = number0;
        endcase
    end
    assign next_rgb = (y >= 8 && y <= 15 && x >= 2 && x <= 30 && (x-2)%6 >= 0 && (x-2)%6 <= 4) ? z : 
    (x>0 && x<32 && (y <= 4 || y >= 20)) ? gradient : 12'h0;
    
    // gradient rgb effect
    reg [11:0] gradient = 0;
    reg [15:0] count = 0;
    
    always @(posedge p_tick) begin
        if (y==0 && x==0)
            count <= count + 1;
        if (count == 0)
            gradient <= gradient + 1;
        if (btnC) begin //reset gradient rgb effect
            gradient = 0;
            count = 0;
        end     
    end    
    
    always @(posedge p_tick) begin
        rgb_reg[11:0] <= next_rgb;
    end
    

endmodule
