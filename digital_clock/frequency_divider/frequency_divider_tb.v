`timescale 1ns/1ps
module frequency_divider_tb;
    localparam integer DIVIDE = 4;
    reg clk = 0;
    reg reset = 1;
    wire clk_out;
    integer cycle;
    reg expected_clk_out;

    frequency_divider #(.DIVIDE(DIVIDE)) dut (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("frequency_divider.vcd");
        $dumpvars(0, frequency_divider_tb);

        @(posedge clk);
        #1 reset = 0;
        expected_clk_out = 0;
        for (cycle = 1; cycle <= 16; cycle = cycle + 1) begin
            @(posedge clk);
            #1;
            if (cycle % (DIVIDE / 2) == 0)
                expected_clk_out = ~expected_clk_out;
            if (clk_out !== expected_clk_out)
                $fatal(1, "Divider mismatch after input cycle %0d", cycle);
        end

        $display("Frequency divider: divide-by-%0d waveform passed.", DIVIDE);
        $finish;
    end
endmodule
