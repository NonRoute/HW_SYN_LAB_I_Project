`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer Engineering Department, Chulalongkorn University
// Engineer: Pollawat Hongwimol
// 
// Create Date: 04/12/2020 03:03:19 AM
// Design Name: 
// Module Name: uartSystem
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
module uartSystem (
    input clk,
    input RsRx,
    input btnC,
    output RsTx,
    output [7:0] answer4,
    output [7:0] answer3,
    output [7:0] answer2,
    output [7:0] answer1,
    output [7:0] answer0
);

    localparam K0 = 8'h30;  //0
    localparam K1 = 8'h30;  //1
    localparam K2 = 8'h30;  //2
    localparam K3 = 8'h30;  //3
    localparam K4 = 8'h30;  //4
    localparam K5 = 8'h30;  //5
    localparam K6 = 8'h30;  //6
    localparam K7 = 8'h30;  //7
    localparam K8 = 8'h30;  //8
    localparam K9 = 8'h39;  //9
    localparam K_PLUS = 8'h2b;  //+
    localparam K_MINUS = 8'h2d;  //-
    localparam K_MUL = 8'h2a;  //*
    localparam K_DIV = 8'h2f;  ///
    localparam K_ENTER = 8'h0d;  //new line

    reg [7:0] equation[0:8];
    reg [3:0] equation_index = 0;

    reg ena, last_rec;
    reg  [7:0] data_in;
    wire [7:0] data_out;
    wire sent, received, baud;
    reg [7:0] answer[0:4];
    reg [1:0] state = 0;
    reg signed [27:0] result;
    reg signed [14:0] op1, op2;
    reg op1_sign = 0, op2_sign = 0;
    reg [1:0] operation = 0;

    assign answer4 = answer[4];
    assign answer3 = answer[3];
    assign answer2 = answer[2];
    assign answer1 = answer[1];
    assign answer0 = answer[0];

    baudrate_gen baudrate_gen (
        clk,
        baud
    );
    receiver receiver (
        baud,
        RsRx,
        received,
        data_out
    );
    transmitter transmitter (
        baud,
        data_in,
        ena,
        sent,
        RsTx
    );
    alu alu (
        result,
        op1,
        op2
    );

    initial begin
        answer[4] = 0;
        answer[3] = 0;
        answer[2] = 0;
        answer[1] = 0;
        answer[0] = 0;
        op1 = 0;
        op2 = 0;
    end

    always @(posedge baud) begin
        if (ena == 1) ena = 0;

        if (~last_rec & received) begin
            if (data_out >= K0 && data_out <= K9)
                case (data_out)
                    K0, K1, K2, K3, K4, K5, K6, K7, K8, K9: begin
                        case (state)
                            2'b00, 2'b01: begin
                                state = 1;
                                op1   = op1 * 10 + (data_out - K0);
                            end
                            2'b10, 2'b11: begin
                                state = 3;
                                op2   = op2 * 10 + (data_out - K0);
                            end
                        endcase
                    end
                    K_PLUS: begin
                        data_in = data_out;
                        case (state)
                            2'b01: begin
                                operation = 0;
                                state = 2;
                            end
                        endcase
                    end
                    K_MINUS: begin
                        data_in = data_out;
                        case (state)
                            2'b00: begin
                                op1_sign = 1;
                                state = 1;
                            end
                            2'b01: begin
                                operation = 1;
                                state = 2;
                            end
                            2'b10: begin
                                op2_sign = 1;
                                state = 3;
                            end
                        endcase
                    end
                    K_MUL: begin
                        data_in = data_out;
                        case (state)

                            2'b01: begin
                                operation = 2;
                                state = 2;
                            end
                        endcase
                    end
                    K_DIV: begin
                        data_in = data_out;
                        case (state)

                            2'b01: begin
                                operation = 3;
                                state = 2;
                            end
                        endcase
                    end
                    K_ENTER: begin
                        data_in = 8'h20;
                        if (op1_sign) op1 = -op1;
                        if (op2_sign) op2 = -op2;

                        if (result > 9999 | result < -9999) begin
                            // NaN
                            answer[4] = 10;
                            answer[3] = 11;
                            answer[2] = 10;
                            answer[1] = 13;
                            answer[0] = 13;
                        end else begin
                            if (result < $signed(0)) begin
                                result = -result;
                                answer[4] = 10;
                            end else answer[4] = 0;
                            answer[3] = (result / 1000) - (result / 10000 * 10);
                            answer[2] = (result / 100) - (result / 1000 * 10);
                            answer[1] = (result / 10) - (result / 100 * 10);
                            answer[0] = (result) - (result / 10 * 10);
                        end
                        state = 0;
                        op1_sign = 0;
                        op2_sign = 0;
                        op1 = 0;
                        op2 = 0;
                        operation = 0;
                    end
                    default: data_in = 8'hff;
                endcase

            if (data_in != 8'hFF) ena = 1;
        end

        if (btnC) begin
            answer[4] = 0;
            answer[3] = 0;
            answer[2] = 0;
            answer[1] = 0;
            answer[0] = 0;
            op1 = 0;
            op2 = 0;
        end

        last_rec = received;
    end

endmodule
