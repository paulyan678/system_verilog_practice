module tb_ripple_adder();
    reg [3:0] A, B;
    wire [3:0] SUM;
    wire CARRY;

    RippleAdder4Bit Adder (
        .A(A),
        .B(B),
        .S(SUM),
        .carry(CARRY)
    );

    initial begin
        A = 4'b0000;
        B = 4'b0000;
        #10;

        A = 4'b0001;
        B = 4'b0001;
        #10;
        $display("A = %b, B = %b, SUM = %b, CARRY = %b", A, B, SUM, CARRY);

        A = 4'b0001;
        B = 4'b0010;
        #10;
        $display("A = %b, B = %b, SUM = %b, CARRY = %b", A, B, SUM, CARRY);

        A = 4'b0010;
        B = 4'b0010;
        #10;
        $display("A = %b, B = %b, SUM = %b, CARRY = %b", A, B, SUM, CARRY);

        $finish;

    end


endmodule
