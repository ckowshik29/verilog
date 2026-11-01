`timescale 1ns/1ps
module counter_tb;
    reg clk = 0;
    reg reset = 1;
    reg enable = 0;
    wire [3:0] count;
    integer tick;

    counter dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_tb);

        @(posedge clk);
        #1 reset = 0;
        enable = 1;
        for (tick = 1; tick <= 20; tick = tick + 1) begin
            @(posedge clk);
            #1;
            if (count !== tick % 10)
                $fatal(1, "Counter mismatch at tick %0d: count=%0d", tick, count);
        end

        enable = 0;
        repeat (2) begin
            @(posedge clk);
            #1;
            if (count !== 0)
                $fatal(1, "Counter changed while disabled");
        end

        $display("Modulo-10 counter: rollover and disabled hold passed.");
        $finish;
    end
endmodule
