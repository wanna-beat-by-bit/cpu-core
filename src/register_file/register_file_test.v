`timescale 1ns/1ps
`include "specs.vh"
`include "tools.v"

module rf_test #(
    parameter WIDTH = `WORD,
    parameter ZERO_REGISTER = 5'b00000,
    parameter ADDR_SPACE = 5,
    parameter REG_AMOUNT = 32
);

reg clk;
reg rst;
reg [ADDR_SPACE-1:0] r1_addr;
reg [ADDR_SPACE-1:0] r2_addr;
reg [ADDR_SPACE-1:0] wr_addr;
reg wr_en;
reg [WIDTH-1:0] wr_data;
wire [WIDTH-1:0] r1;
wire [WIDTH-1:0] r2;

register_file rf(
    .clk(clk),
    .rst(rst),
    .r1_addr(r1_addr),
    .r2_addr(r2_addr),
    .wr_addr(wr_addr),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .r1(r1),
    .r2(r2)
);

initial begin
    clk = 0;
    rst = 0;
    r1_addr = 0;
    r2_addr = 0;
    wr_addr = 0;
    wr_en = 0;
    wr_data = 0;
end

always #5 clk = ~clk;

task automatic tick;
    input int t_amount;
    begin
        repeat (t_amount) #5;
    end
endtask 

task automatic test_wr; 
    input logic [ADDR_SPACE-1:0] wr_a;
    input logic [WIDTH-1:0] wr_d;
    input logic wr_e;
    begin
        wr_addr = wr_a;
        wr_en = wr_e;
        wr_data = wr_d;
        r1_addr = wr_a;
        tick(2);
        `ASSERT(
            (wr_d == r1),
            $sformatf("wr_a = %b | wr_d = %d | wr_e = %b", wr_a, wr_d, wr_e), 
            $sformatf("+: wr_d = %d | -: r1 = %d ", wr_d, r1))
    end
endtask

initial begin
    tick(2);
    rst = 1; 
    tick(2);
    rst = 0;
    tick(2);
    r1_addr = 5'd3;
    r1_addr = 5'd5;
    wr_addr = 5'd7;
    wr_data = 32'd59;

    test_wr(5'd3, 7, 1'b1);

    tick(20);
    $finish;
end

endmodule