module FullAdder (
    input a, b, cin,
    output sum, count
);

assign sum = a ^ b ^ cin;
assign count = (a & b) | (cin & (a ^ b));
    
endmodule