`ifndef SPECS_VH
`define SPECS_VH

// supported opcodes
`define OP_SUM  3'b000
`define OP_SUB  3'b001
`define OP_AND  3'b010
`define OP_XOR  3'b011
`define OP_NOP  3'b100

// supported cpu bit width
`define WORD 32

`define OP_WIDTH 3

`define REG_ADDRESS_SPACE 5

`define INS_ADDRESS_SPACE = 4

// opcode map
function string opname;
    input [`OP_WIDTH-1:0] op;
    case(op)
        `OP_SUM: opname = "SUM";
        `OP_SUB: opname = "SUB";
        `OP_AND: opname = "AND";
        `OP_XOR: opname = "XOR";
        default: opname = "???";
    endcase
endfunction

`endif // SPECS_VH