module xor_gate_tb;
    reg a, b;
    wire y;

    xor_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        $dumpfile("xor_gate.vcd");
        $dumpvars(0, xor_gate_tb);

        $display("A B | Y");
        a = 0; b = 0; #10; $display("%b %b | %b", a, b, y);
        a = 0; b = 1; #10; $display("%b %b | %b", a, b, y);
        a = 1; b = 0; #10; $display("%b %b | %b", a, b, y);
        a = 1; b = 1; #10; $display("%b %b | %b", a, b, y);

        $finish;
    end
endmodule