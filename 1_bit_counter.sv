module OneBitCounter (
    input clk, reset, enable,
    output reg count
);

wire count_plus_1;

FullAdder Adder1(
    .a(count),
    .b(1'b1),
    .cin(1'b0),
    .sum(count_plus_1)
);

always @(posedge clk, posedge reset)
    if (reset)
        count <= 1'b0;
    else if (enable)
        count <= count_plus_1;
    else
        count <= count;
    
endmodule 