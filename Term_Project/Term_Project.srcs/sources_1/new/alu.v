`timescale 1ns / 1ps
//-------------------------------------------------------
// File name    : alu.v
// Title        : ALU.
// Library      : nanoLADA
// Purpose      : Computer Architecture
// Developers   : Krerk Piromsopa, Ph. D.
//              : Chulalongkorn University.
module alu (
    output reg signed [31:0] S,
    input signed [15:0] A,
    input signed [15:0] B,
    input [1:0] alu_ops
);

    assign z = ~|S;
    always @(A or B or alu_ops) begin
        case (alu_ops)
            2'b00: begin
                S = A + B;
            end
            2'b01: begin
                S = A - B;
            end
            2'b10: begin
                S = A * B;
            end
            2'b11: begin
                S = A / B;
            end

        endcase
    end

endmodule
