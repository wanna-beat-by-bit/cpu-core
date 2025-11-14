`timescale 1ns/1ps
`include "specs.vh"
`include "tools.v"

module test_alu #(
    parameter WIDTH = `WORD,
    parameter OP_WIDTH = `OP_WIDTH
);

reg [WIDTH-1:0] t_a, t_b;
reg [OP_WIDTH-1:0] t_opcode;

wire [WIDTH-1:0] o_result;
wire o_zero;
wire o_cf;

// Инстанцирование тестируемого модуля
alu alu_inst (
    .i_a(t_a),
    .i_b(t_b),
    .i_opcode(t_opcode),
    .o_result(o_result),
    .o_zero(o_zero),
    .o_cf(o_cf)
);

task automatic tick;
    input int tick_amount;
    begin
        repeat(tick_amount) #5;
    end
endtask

task automatic test_op;
    input [WIDTH-1:0] a, b, exp_res;
    input [OP_WIDTH-1:0] op;
    input       exp_cf;
    begin
        t_a = a; t_b = b; t_opcode = op;
        tick(1);
         `ASSERT(
             (o_result === exp_res) && (o_cf === exp_cf) && (o_zero === (exp_res == 0)),
             $sformatf("ALU: %b %s %b", a, opname(op), b),
             $sformatf("got: res=%b, cf=%b, zero=%b | exp: res=%b, cf=%b, zero=%b",
                 o_result, o_cf, o_zero, exp_res, exp_cf, (exp_res==0))
         );
    end
endtask

initial begin
    test_op(3, 4, 7, `OP_SUM, 0);
    test_op(255, 1, 0, `OP_SUM, 1); // carry due to overflow
    test_op(5, 3, 2, `OP_SUB, 0);
    test_op(3, 5, 254, `OP_SUB, 1); // assert CF=1
    test_op(8'b11110000, 8'b10101010, 8'b10100000, `OP_AND, 0);
    test_op(8'b11110000, 8'b10101010, 8'b01011010, `OP_XOR, 0);
    test_op(5, 5, 0, `OP_SUB, 1); // assert zero=1 || CF=1

    $finish;
end

endmodule