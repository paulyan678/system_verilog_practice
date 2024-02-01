module tb_1_bit_count ();

reg clk;
reg reset;
reg enable;
wire count;

always #5 clk = ~clk;


OneBitCounter counter(.clk(clk), .reset(reset), .enable(enable), .count(count));

initial
begin
    clk = 0;
    reset = 1'b1;
    enable = 0;

    #10 reset = 0;
    #10 reset = 1'b1;
    #10 reset = 0;

    #20 enable = 1'b1;

    #100 enable = 0;

    #100 $finish;
end

endmodule