module RippleAdder4Bit (
    input [3:0] A,
    input [3:0] B,
    output [3:0] S,
    output carry
);
    wire C[3:0];

    FullAdder F0 (.a(A[0]), .b(B[0]), .cin(1'b0), .sum(S[0]), .count(C[0]));
    FullAdder F1 (.a(A[1]), .b(B[1]), .cin(C[0]), .sum(S[1]), .count(C[1]));
    FullAdder F2 (.a(A[2]), .b(B[2]), .cin(C[1]), .sum(S[2]), .count(C[2]));
    FullAdder F3 (.a(A[3]), .b(B[3]), .cin(C[2]), .sum(S[3]), .count(C[3]));
    assign carry = C[3];
    
endmodule