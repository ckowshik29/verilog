`timescale 1ns/1ps
module counter (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [3:0] count
);
    always @(posedge clk) begin
        if (reset)
            count <= 0;
        else if (enable) begin
            if (count == 9)
                count <= 0;
            else
                count <= count + 1'b1;
        end
    end
endmodule
