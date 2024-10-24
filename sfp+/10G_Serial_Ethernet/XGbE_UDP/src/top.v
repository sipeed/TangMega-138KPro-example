
module top(
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    output [5:0] leds,
    input  [1:0] sfp_los,
    output [1:0] sfp_tx_disable  
);
    wire [5:0] led_active_high;

    Xge_top Xge_2x(
    //Clock & Rst
        .serdes1_tx_rstn(1'b1),
        .serdes1_rx_rstn(1'b1),
        .serdes2_tx_rstn(1'b1),
        .serdes2_rx_rstn(1'b1),
    //SFP Module Signals
        .sfp_los(sfp_los),
        .sfp_tx_disable(sfp_tx_disable),

        .serdes1_ber_clear(sw1),
        .serdes1_blkerr_clear(sw2),
        .serdes2_ber_clear(sw3),
        .serdes2_blkerr_clear(sw4),
    //Status
        .serdes1_pll_lock(led_active_high[0]),
        .serdes1_CDR_lock(led_active_high[1]),
        .serdes1_signal_detected(led_active_high[2]),
        .serdes2_pll_lock(led_active_high[3]),
        .serdes2_CDR_lock(led_active_high[4]),
        .serdes2_signal_detected(led_active_high[5])
    );

    assign leds = ~led_active_high;

endmodule

