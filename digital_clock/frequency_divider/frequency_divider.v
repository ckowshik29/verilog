`timescale 1ns/1ps
module frequency_divider #(
    parameter integer DIVIDE = 4
) (
    input  wire clk,
    input  wire reset,
    output reg  clk_out
);
    localparam integer HALF_PERIOD = DIVIDE / 2;
    localparam integer COUNT_WIDTH =
        (HALF_PERIOD <= 1) ? 1 : $clog2(HALF_PERIOD);

    reg [COUNT_WIDTH-1:0] count;

    initial begin
        if (DIVIDE < 2 || DIVIDE % 2 != 0)
            $fatal(1, "DIVIDE must be an even integer greater than or equal to 2");
    end

    always @(posedge clk) begin
        if (reset) begin
            count   <= 0;
            clk_out <= 0;
        end else if (count == HALF_PERIOD - 1) begin
            count   <= 0;
            clk_out <= ~clk_out;
        end else begin
            count <= count + 1'b1;
        end
    end
endmodule
