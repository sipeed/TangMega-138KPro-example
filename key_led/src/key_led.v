module key_led(
    input           clk,
    input           rst,
    output [5:0]    led,

    input  [3:0]    key
);

wire rst_n = (&key[3:0])&(!rst);

led led_inst(
    .clk(clk),
    .led(led),
    .rst_n(rst_n)
);

endmodule