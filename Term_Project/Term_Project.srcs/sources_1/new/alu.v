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
    input op1_sign,
    input op2_sign,
    input [1:0] alu_ops
);
    
    reg signed [15:0] op1;
    reg signed [15:0] op2;
    
    assign z = ~|S;
    always @(A or B or alu_ops) begin
        op1 = (op1_sign) ? -A : A;
        op2 = (op2_sign) ? -B : B;
        case (alu_ops)
            2'b00: begin
                S = op1 + op2;
            end
            2'b01: begin
                S = op1 - op2;
            end
            2'b10: begin
                S = op1 * op2;
            end
            2'b11: begin
                S = op1 / op2;
            end

        endcase
    end

endmodule