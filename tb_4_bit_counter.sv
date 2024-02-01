module tb_4_bit_count ();

reg clk;
reg reset;
reg enable;
wire [3:0] count;

always #5 clk = ~clk;


FourBitCounter counter(.clk(clk), .reset(reset), .enable(enable), .count(count));

initial
begin
    clk = 0;
    reset = 1'b1;
    enable = 0;

    #10 reset = 0;
    #10 reset = 1'b1;
    #10 reset = 0;

    #10 enable = 1'b1;

    #100000 enable = 0;

    #100 $finish;
end

endmodule