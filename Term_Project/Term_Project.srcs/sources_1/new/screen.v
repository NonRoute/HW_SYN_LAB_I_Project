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
    output reg [3:0] row, col, //debug
    input wire [9:0] y, x, // /20
    input wire p_tick,
    input wire [4:0] number4, number3, number2, number1, number0
    );
    
    reg [3:0] row, col;
    reg [4:0] number;
    reg [3:0] digit;
    wire [11:0] z;
    reg [11:0] screen[0:23][0:31];
    
    rom_font r(z,row,col,number);
    
//    genvar l;
//    generate for (l = 0; l < 24; l = l+1) 
//        begin
//            genvar m;
//            for (m = 0; m < 32; m = m+1)
//                begin
//                always @(number4 or number3 or number2 or number1 or number0) begin
//                    if (l >= 8 && l <= 15 && m>= 2 && (m-2)%6 >= 0 && (m-2)%6 <= 4)
//                        begin
//                            row = l-8;
//                            col = (m-2)%6;
//                            digit = 4-(m-2)/6;
//                            case(digit)
//                                    4: number = 0;
//                                    3: number = 0;
//                                    2: number = 0;
//                                    1: number = 0;
//                                    0: number = 0;
//                            endcase
//                            screen[l][m] = z;
//                            $display("%b %b %b %b %b %b",l,m,row,col,number,z);
//                       end
//                   else 
//                        screen[l][m] = 12'h00b;
//                end
//            end
//        end
//    endgenerate

    always @(p_tick) begin
       if (y >= 8 && y <= 15 && x>= 2 && (x-2)%6 >= 0 && (x-2)%6 <= 4) begin
           row = y-8;
           col = (x-2)%6;
           digit = 4-(x-2)/6;
           case(digit)
                4: number = number4;
                3: number = number3;
                2: number = number2;
                1: number = number1;
                0: number = number0;
           endcase
           rgb_reg[11:0] = z;
       end else begin
           rgb_reg[11:0] = 12'h00f; //000
       end
//        rgb_reg[11:0] = screen[y][x];
    end
	
endmodule
