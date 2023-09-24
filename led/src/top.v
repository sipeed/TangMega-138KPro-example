module top(
    input           clk,
    input           rst,
    output [5:0]    led
);

led led_inst(
    .clk(clk),
    .led(led),
    .rst_n(!rst)
);

endmodule