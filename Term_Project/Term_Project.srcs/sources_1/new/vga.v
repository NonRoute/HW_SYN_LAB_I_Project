`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2022 09:28:15 PM
// Design Name: 
// Module Name: vga
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


module vga(
    output wire [11:0] rgb,
    output wire hsync, vsync,
//    input wire [7:0] numbers [5:0],
    input wire clk, btnC,
    output row, col, y, x
    );
    parameter WIDTH = 640;
	parameter HEIGHT = 480;
	
	reg [4:0] number4, number3, number2, number1, number0;
	
	initial
	begin
        number4 = 0;
        number3 = 1;
        number2 = 2;
        number1 = 3;
        number0 = 4;
	end
	// register for Basys 2 8-bit RGB DAC 
	wire [11:0] rgb_reg;
	reg reset = 0;
	wire [9:0] x, y;

	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;
    wire p_tick;
	// instantiate vga_sync
	vga_sync vga_sync_unit (.clk(clk), .reset(btnC), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
		
	screen s(rgb_reg,y/20,x/20,p_tick,number4,number3,number2,number1,number0);	        
//	output
	assign rgb = (video_on) ? rgb_reg : 12'b0;
endmodule