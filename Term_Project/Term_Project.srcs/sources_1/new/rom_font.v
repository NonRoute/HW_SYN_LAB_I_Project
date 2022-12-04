`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:36:42 PM
// Design Name: 
// Module Name: rom_font
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


module rom_font(
    output wire [11:0] z, //color
    input wire [3:0] row,
    input wire [3:0] col,
    input wire [4:0] number);
    
    // declares a memory rom of 120 5-bit registers.
    //The indices are 0 to 119
    (* synthesis, rom_block = "ROM_CELL XYZ01" *)    
    reg [4:0] rom[0:119];
    // NOTE: To infer combinational logic instead of a ROM, use
    // (* synthesis, logic_block *)

    initial $readmemb("rom.data", rom);
    
    wire [0:119] a;
    assign a = 8*number+row;
    assign z = rom[a][4-col] == 1 ? 12'h8ff: 12'h000;

endmodule
