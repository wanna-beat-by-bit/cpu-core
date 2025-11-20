module rom #(
    parameter WIDTH = `WORD,
    parameter INS_AS = `INS_ADDRESS_SPACE-1;
)(
    input wire [INS_AS:0] addr; // amount of address space for 16 instructions.
    output reg [WIDTH-1:0] r_data;
);

reg [WIDTH-1:0] rom [0:15];

initial begin
        rom[0] = 32'h00000013;
        rom[1] = 32'h000101B3;
        rom[2] = 32'h00018233;
        rom[3] = 32'h000202B3;
        rom[4] = 32'h00028333;
        rom[5] = 32'h000303B3;
        rom[6] = 32'h00038433;
        rom[7] = 32'h000404B3;
        rom[8] = 32'h00048533;
        rom[9] = 32'h000505B3;
        rom[10] = 32'h00058633;
        rom[11] = 32'h000606B3;
        rom[12] = 32'h00068733;
        rom[13] = 32'h000707B3;
        rom[14] = 32'h00078833;
        rom[15] = 32'h000808B3;
end

always_comb begin
    r_data = rom[addr]
end


endmodule