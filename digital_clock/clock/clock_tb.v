`timescale 1ns/1ps
module clock_tb;
    reg clk = 0;
    reg reset = 1;
    wire [4:0] hours;
    wire [5:0] minutes, seconds;
    integer tick;

    clock dut (
        .clk(clk),
        .reset(reset),
        .hours(hours),
        .minutes(minutes),
        .seconds(seconds)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, clock_tb);

        @(posedge clk);
        #1 reset = 0;
        for (tick = 1; tick <= 86400; tick = tick + 1) begin
            @(posedge clk);
            #1;
            if (tick < 86400) begin
                if (seconds !== tick % 60 ||
                    minutes !== (tick / 60) % 60 ||
                    hours !== (tick / 3600) % 24)
                    $fatal(1, "Clock mismatch at tick %0d: %02d:%02d:%02d",
                           tick, hours, minutes, seconds);
            end else if ({hours, minutes, seconds} !== 17'b0) begin
                $fatal(1, "Clock did not wrap to 00:00:00 after one day");
            end
        end

        $display("Digital clock: all 86400 seconds and 24-hour rollover passed.");
        $finish;
    end
endmodule
