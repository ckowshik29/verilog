module not_gate_tb;

    reg a;
    wire y;

    not_gate uut(
        .a(a),
        .y(y)
    );

    initial begin
        $dumpfile("not_gate.vcd");
        $dumpvars(0, not_gate_tb);

        $display("A | Y");

        a = 0;
        #10;
        $display("%b | %b", a, y);

        a = 1;
        #10;
        $display("%b | %b", a, y);

        $finish;
    end

endmodule