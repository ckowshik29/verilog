`timescale 1ns/1ps
module clock (
    input  wire       clk,
    input  wire       reset,
    output reg  [4:0] hours,
    output reg  [5:0] minutes,
    output reg  [5:0] seconds
);
    always @(posedge clk) begin
        if (reset) begin
            hours   <= 0;
            minutes <= 0;
            seconds <= 0;
        end else if (seconds == 59) begin
            seconds <= 0;
            if (minutes == 59) begin
                minutes <= 0;
                if (hours == 23)
                    hours <= 0;
                else
                    hours <= hours + 1'b1;
            end else begin
                minutes <= minutes + 1'b1;
            end
        end else begin
            seconds <= seconds + 1'b1;
        end
    end
endmodule
