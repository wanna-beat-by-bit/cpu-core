`timescale 1ns/1ps
`include "specs.vh"

module alu #(
    parameter WIDTH = `WORD,
    parameter OP_WIDTH = `OP_WIDTH
)(
    input wire [WIDTH-1:0] i_a,
    input wire [WIDTH-1:0] i_b,
    input wire [OP_WIDTH-1:0] i_opcode,

    output wire [WIDTH-1:0] o_result,
    output wire o_zero,
    output wire o_cf
);

reg [WIDTH-1:0] r_result;
wire [WIDTH+1-1:0] extended_sum = {1'b0, i_a} + {1'b0, i_b};
wire [WIDTH+1-1:0] extended_sub = {1'b0, i_a} - {1'b0, i_b};

assign o_zero = (r_result == 0);
assign o_cf = (i_opcode == `OP_SUM)  ? extended_sum[WIDTH]   :  
              (i_opcode == `OP_SUB)  ? (i_a < i_b)       : 1'b0;
assign o_result = r_result;

always @(*) begin
    case(i_opcode)
        `OP_SUM: r_result = i_a + i_b;
        `OP_SUB: r_result = i_a - i_b;
        `OP_AND: r_result = i_a & i_b;
        `OP_XOR: r_result = i_a ^ i_b;
        default: r_result = 0;
    endcase
end

endmodule