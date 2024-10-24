
module Xge_top(
    //Clock & Rst
    input serdes1_tx_rstn,
    input serdes1_rx_rstn,
    input serdes2_tx_rstn,
    input serdes2_rx_rstn,

    //SFP Module Signals
    input  [1:0] sfp_los,
    output [1:0] sfp_tx_disable,

    input  serdes1_ber_clear,
    input  serdes1_blkerr_clear,
    input  serdes2_ber_clear,
    input  serdes2_blkerr_clear,

    //Status
    output serdes1_pll_lock,
    output serdes1_CDR_lock,
    output serdes1_signal_detected,
    output serdes2_pll_lock,
    output serdes2_CDR_lock,
    output serdes2_signal_detected
);

    wire serdes_refclk;
    wire xge_clk;
    wire xge_clk_lock;

    Xge_pll Xge_pll(
        .clkout0(xge_clk), //output clkout0
        .lock(xge_clk_lock), //output lock
        .clkin(serdes_refclk) //input clkin
    );


    wire xgmii_1_tx_clk;
    wire xgmii_1_rx_clk;
    wire [7:0]  xgmii_1_txc;
    wire [63:0] xgmii_1_txd;
    wire [7:0]  xgmii_1_rxc;
    wire [63:0] xgmii_1_rxd;
    wire xge1_block_lock;
    
    wire xgmii_2_tx_clk;
    wire xgmii_2_rx_clk;
    wire [7:0]  xgmii_2_txc;
    wire [63:0] xgmii_2_txd;
    wire [7:0]  xgmii_2_rxc;
    wire [63:0] xgmii_2_rxd;
    wire xge2_block_lock;

    XGMII_top xgmii_serdes(
    //Clock & Rst
        .trx_clk_156r25M(xge_clk),
        .trx_clk_locked(xge_clk_lock),
        .serdes1_refclk(serdes_refclk),
        .serdes2_refclk(),
        .serdes1_tx_rstn(serdes1_tx_rstn),
        .serdes1_rx_rstn(serdes1_rx_rstn),
        .serdes2_tx_rstn(serdes2_tx_rstn),
        .serdes2_rx_rstn(serdes2_rx_rstn),
    //SFP Module Signals
        .sfp_los(sfp_los),
        .sfp_tx_disable(sfp_tx_disable),
    // XGMII 1
        .xgmii_1_tx_clk(xgmii_1_tx_clk),
        .xgmii_1_txc(xgmii_1_txc),
        .xgmii_1_txd(xgmii_1_txd),
        .xgmii_1_rx_clk(xgmii_1_rx_clk),
        .xgmii_1_rxc(xgmii_1_rxc),
        .xgmii_1_rxd(xgmii_1_rxd),
        .serdes1_block_lock(xge1_block_lock),
    // XGMII 2
        .xgmii_2_tx_clk(xgmii_2_tx_clk),
        .xgmii_2_txc(xgmii_2_txc),
        .xgmii_2_txd(xgmii_2_txd),
        .xgmii_2_rx_clk(xgmii_2_rx_clk),
        .xgmii_2_rxc(xgmii_2_rxc),
        .xgmii_2_rxd(xgmii_2_rxd),
        .serdes2_block_lock(xge2_block_lock),

        .serdes1_ber_clear(serdes1_ber_clear),
        .serdes1_blkerr_clear(serdes1_blkerr_clear),
        .serdes2_ber_clear(serdes2_ber_clear),
        .serdes2_blkerr_clear(serdes2_blkerr_clear),
    //Status
        .serdes1_pll_lock(serdes1_pll_lock),
        .serdes1_CDR_lock(serdes1_CDR_lock),
        .serdes1_signal_detected(serdes1_signal_detected),
        .serdes1_rx_IDLE_delete(),
        .serdes1_rx_SEQ_delete(),
        .serdes1_rx_IDLE_insert(),
        .serdes1_rx_BUF_Overflow(),
        .serdes1_rx_BUF_Underflow(),
        .serdes1_gearbox_bitslip(),
        .serdes2_pll_lock(serdes2_pll_lock),
        .serdes2_CDR_lock(serdes2_CDR_lock),
        .serdes2_signal_detected(serdes2_signal_detected),
        .serdes2_rx_IDLE_delete(),
        .serdes2_rx_SEQ_delete(),
        .serdes2_rx_IDLE_insert(),
        .serdes2_rx_BUF_Overflow(),
        .serdes2_rx_BUF_Underflow(),
        .serdes2_gearbox_bitslip()
    );


    Xge_MAC_top#(
        .SRC_MAC(48'h03_08_35_01_AE_C2),        //Source MAC Address
	    .SRC_IP({8'd169,8'd254,8'd102,8'd114}),   //Source IP Address
	    .SRC_PORT(16'h8000),                    //Source UDP Port
	    .DES_MAC(48'hff_ff_ff_ff_ff_ff),        //Destination MAC address
	    .DES_IP({8'd169,8'd254,8'd102,8'd56}),    //Destination IP address
	    .DES_PORT(16'h8000),                    //Destination PORT
	    .DATA_SIZE(16'd1024)                    //Data Length
    )TenGbE_MAC_1_inst(
        .xgmii_rx_clk(xgmii_1_rx_clk),
        .xgmii_tx_clk(xgmii_1_tx_clk),
        .xge_block_lock(xge1_block_lock),
        .xgmii_txc(xgmii_1_txc),
        .xgmii_txd(xgmii_1_txd),
        .xgmii_rxc(xgmii_1_rxc),
        .xgmii_rxd(xgmii_1_rxd)
    );


    Xge_MAC_top#(
        .SRC_MAC(48'h03_08_35_01_AE_C2),        //Source MAC Address
	    .SRC_IP({8'd169,8'd254,8'd5,8'd114}),   //Source IP Address
	    .SRC_PORT(16'h8000),                    //Source UDP Port
	    .DES_MAC(48'hff_ff_ff_ff_ff_ff),        //Destination MAC address
	    .DES_IP({8'd169,8'd254,8'd5,8'd62}),    //Destination IP address
	    .DES_PORT(16'h8000),                    //Destination PORT
	    .DATA_SIZE(16'd1024)                    //Data Length
    )TenGbE_MAC_2_inst(
        .xgmii_rx_clk(xgmii_2_rx_clk),
        .xgmii_tx_clk(xgmii_2_tx_clk),
        .xge_block_lock(xge2_block_lock),
        .xgmii_txc(xgmii_2_txc),
        .xgmii_txd(xgmii_2_txd),
        .xgmii_rxc(xgmii_2_rxc),
        .xgmii_rxd(xgmii_2_rxd)
    );
        
endmodule

