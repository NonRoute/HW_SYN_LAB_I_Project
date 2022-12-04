`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 07:45:31 PM
// Design Name: 
// Module Name: singlePulser
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


module clockDiv(
    output clkDiv,
    input clk
    );
    
reg clkDiv;
    
initial
begin
    clkDiv = 0;
end;

always @(posedge clk)
begin
    clkDiv = ~clkDiv;
end;

endmodule

module singlePulser(
    output reg debouncedBtn,
    input rawBtn,
    input clk
    );

reg state;

initial state = 0;

wire targetClk;
wire [18:0] tclk;

assign tclk[0] = clk;

genvar c;

generate for(c = 0; c < 18; c = c + 1)
    begin
        clockDiv fdiv(tclk[c+1], tclk[c]);
    end
endgenerate

clockDiv fdivTarget(targetClk, tclk[18]);

always@(posedge targetClk)
begin
    debouncedBtn = 0;
    case({rawBtn, state})
//        2'b00,
        2'b01: state = 0;
        2'b10: 
            begin
                state = 1;
                debouncedBtn = 1;
            end
//        2'b11,
    endcase
end

    
endmodule
