// basically this is a top

module cpu #(
    parameter PC_WIDTH = INS_ADDRESS_SPACE-1,
    parameter INSTR_WIDTH = 16-1,
    parameter DATA_WIDTH = `WORD;
    parameter ADDR_SPACE = `REG_ADDRESS_SPACE-1;
)(
    input wire clk;
    input wire rst;
);

// signals
wire [PC_WIDTH:0] pc_next = pc_current + 1;
reg [PC_WIDTH:0] pc_current;

// single instruction 
wire [INSTR_WIDTH:0] instruction;

// instruction slicing
wire [2:0] opcode = instruction[15:13];
wire [ADDR_SPACE:0] r_src_addr = instruction[12:8];
wire [ADDR_SPACE:0] r_dst_addr = instruction[7:3];
wire [2:0] funct = instruction[2:0];

// ctrl signals
wire reg_write = (opcode == 3'b000); // r-type
wire alu_src = 0; // keep default a register for now
wire [2:0] alu_op = funct;

// data
wire [DATA_WIDTH-1:0] r_src_data;
wire [DATA_WIDTH-1:0] r_dst_data;
wire [DATA_WIDTH-1:0] alu_in_b; // pick second operand
wire [DATA_WIDTH-1:0] alu_result;
wire alu_zero, alu_cf;

pc pc_inst(
    .clk(clk),
    .rst(rst),
    .next_pc(pc_next), 
    .current_pc(pc_current) 
);

rom rom_inst(
    .addr(pc_current),
    .r_data(instruction)
);

register_file rf_inst (
    .clk(clk),
    .rst(rst),
    .r1_addr(r_src_addr),
    .r2_addr(r_dst_addr),
    .wr_addr(r_dst_addr),
    .wr_en(reg_write),
    .wr_data(alu_result),
    .r1(r_src_data),
    .r2(r_dst_data)
);

control_unit cunit(
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src), // registers - 0, immediate - 1
    .alu_op(alu_op)
);

alu alu_inst(
    .i_a(r_src_addr),
    .i_b(r_dst_addr),
    .i_opcode(opcode),
    .o_result(),
    .o_zero,
    .o_cf
);

endmodule