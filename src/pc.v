module pc #(
    parameter INS_AS = `INS_ADDRESS_SPACE-1;
)(
    input wire clk;
    input wire rst;
    input wire [INS_AS:0] next_pc; // width for 8 bit word, mean 256 byte memory.
    output reg [INS_AS:0] current_pc; 
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_pc <= 0;
    end else begin
        current_pc <= next_pc; 
    end
end

endmodule