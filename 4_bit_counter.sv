module FourBitCounter (
    input reset, clk, enable,
    output reg [3:0] count
);

wire [3:0] count_plus_one;

RippleAdder4Bit adder(.A(count), .B(4'b0001), .S(count_plus_one));

always @(posedge clk, posedge reset) begin
    if (reset) begin
        count <= 4'b0000;
    end 
    else if (enable) begin
        count <= count_plus_one;
    end
end

endmodule