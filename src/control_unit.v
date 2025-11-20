// control unit

module control_unit #(
    parameter OP_WIDTH = 3,
    parameter OP_TYPE = 3'b000
)(
    input wire [OP_WIDTH-1:0] opcode,
    output wire reg_write,
    output wire alu_src, // registers - 0, immediate - 1
    output wire [OP_WIDTH-1:0] alu_op
);

assign reg_write = (opcode == OP_TYPE);
assign alu_src = 0; // default - registers
assign alu_op = opcode;

endmodule