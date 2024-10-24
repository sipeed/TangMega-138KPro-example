
module XGMII_top(
    //Clock & Rst
    input trx_clk_156r25M,
    input trx_clk_locked,
    output serdes1_refclk,
    output serdes2_refclk,

    input serdes1_tx_rstn,
    input serdes1_rx_rstn,
    input serdes2_tx_rstn,
    input serdes2_rx_rstn,

    //SFP Module Signals
    input  [1:0] sfp_los,
    output [1:0] sfp_tx_disable,

    // XGMII 1
    output xgmii_1_tx_clk,
    input  [7:0]  xgmii_1_txc,
    input  [63:0] xgmii_1_txd,
    output xgmii_1_rx_clk,
    output [7:0]  xgmii_1_rxc,
    output [63:0] xgmii_1_rxd,
    output serdes1_block_lock,

    // XGMII 2
    output xgmii_2_tx_clk,
    input  [7:0]  xgmii_2_txc,
    input  [63:0] xgmii_2_txd,
    output xgmii_2_rx_clk,
    output [7:0]  xgmii_2_rxc,
    output [63:0] xgmii_2_rxd,
    output serdes2_block_lock,

    //input
    input  serdes1_ber_clear,
    input  serdes1_blkerr_clear,
    input  serdes2_ber_clear,
    input  serdes2_blkerr_clear,

    //Status
    output serdes1_pll_lock,
    output serdes1_CDR_lock,
    output serdes1_signal_detected,
    output serdes1_rx_IDLE_delete,
    output serdes1_rx_SEQ_delete,
    output serdes1_rx_IDLE_insert,
    output serdes1_rx_BUF_Overflow,
    output serdes1_rx_BUF_Underflow,
    output serdes1_gearbox_bitslip,

    output serdes2_pll_lock,
    output serdes2_CDR_lock,
    output serdes2_signal_detected,
    output serdes2_rx_IDLE_delete,
    output serdes2_rx_SEQ_delete,
    output serdes2_rx_IDLE_insert,
    output serdes2_rx_BUF_Overflow,
    output serdes2_rx_BUF_Underflow,
    output serdes2_gearbox_bitslip
);
    
    /* SFP Control */
    assign sfp_tx_disable = 2'd0;

    // XGMII Interface
    assign xgmii_1_rx_clk = trx_clk_156r25M;
    assign xgmii_1_tx_clk = trx_clk_156r25M;

    assign xgmii_2_rx_clk = trx_clk_156r25M;
    assign xgmii_2_tx_clk = trx_clk_156r25M;

    //Serdes Status
    wire        serdes_1_clk_out0_o;
    wire        serdes_1_clk_out1_o;
    wire        serdes_1_hi_ber;
    wire [5:0]  serdes_1_ber_count; 
    wire [7:0]  serdes_1_errored_block_count; 
    wire        serdes_1_pcs_status;
    wire [15:0] serdes_1_debug_vector;

    wire        serdes_2_clk_out0_o;
    wire        serdes_2_clk_out1_o;
    wire        serdes_2_hi_ber;
    wire [5:0]  serdes_2_ber_count; 
    wire [7:0]  serdes_2_errored_block_count; 
    wire        serdes_2_pcs_status;
    wire [15:0] serdes_2_debug_vector;

    SerDes_Top u_SerDes_Top(
        // XGMII 1
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_i(xgmii_1_rx_clk),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_ready_i(trx_clk_locked),
        .Ten_Giga_Serial_Ethernet_Top_rx_rstn_i(serdes1_rx_rstn),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rxc_o(xgmii_1_rxc),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rxd_o(xgmii_1_rxd),

        .Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_i(xgmii_1_tx_clk),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_ready_i(trx_clk_locked),
        .Ten_Giga_Serial_Ethernet_Top_tx_rstn_i(serdes1_tx_rstn),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_txc_i(xgmii_1_txc),
        .Ten_Giga_Serial_Ethernet_Top_xgmii_txd_i(xgmii_1_txd),

        .Ten_Giga_Serial_Ethernet_Top_ref_clk_o(serdes1_refclk),       //Serdes Refclk
        .Ten_Giga_Serial_Ethernet_Top_clk_out0_o(serdes_1_clk_out0_o),   //Internal Clk, 162M
        .Ten_Giga_Serial_Ethernet_Top_clk_out1_o(serdes_1_clk_out1_o),   //Internal Clk, 162M
        .Ten_Giga_Serial_Ethernet_Top_signal_detect_i(sfp_los[0]),

        .Ten_Giga_Serial_Ethernet_Top_block_lock_o(serdes1_block_lock), //  64b66b block locked
        .Ten_Giga_Serial_Ethernet_Top_hi_ber_o(serdes_1_hi_ber),         //  Hi BER
        .Ten_Giga_Serial_Ethernet_Top_ber_count_o(serdes_1_ber_count),   //  MAX 63
        .Ten_Giga_Serial_Ethernet_Top_errored_block_count_o(serdes_1_errored_block_count),
        .Ten_Giga_Serial_Ethernet_Top_clear_ber_count_i(serdes1_ber_clear),
        .Ten_Giga_Serial_Ethernet_Top_clear_errored_block_count_i(serdes1_blkerr_clear),

        .Ten_Giga_Serial_Ethernet_Top_pcs_status_o(serdes_1_pcs_status), //  1: normal
        .Ten_Giga_Serial_Ethernet_Top_debug_vector_o(serdes_1_debug_vector),

        // XGMII 2
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_i(xgmii_2_rx_clk),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_ready_i(trx_clk_locked),
        .Ten_Giga_Serial_Ethernet_Top_1_rx_rstn_i(serdes2_rx_rstn),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxc_o(xgmii_2_rxc),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxd_o(xgmii_2_rxd),

        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_i(xgmii_2_tx_clk),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_ready_i(trx_clk_locked),
        .Ten_Giga_Serial_Ethernet_Top_1_tx_rstn_i(serdes2_tx_rstn),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_txc_i(xgmii_2_txc),
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_txd_i(xgmii_2_txd),

        .Ten_Giga_Serial_Ethernet_Top_1_ref_clk_o(serdes2_refclk),       //Serdes Refclk
        .Ten_Giga_Serial_Ethernet_Top_1_clk_out0_o(serdes_2_clk_out0_o),   //Internal Clk, 162M
        .Ten_Giga_Serial_Ethernet_Top_1_clk_out1_o(serdes_2_clk_out1_o),   //Internal Clk, 162M
        .Ten_Giga_Serial_Ethernet_Top_1_signal_detect_i(sfp_los[1]),

        .Ten_Giga_Serial_Ethernet_Top_1_block_lock_o(serdes2_block_lock), //  64b66b block locked
        .Ten_Giga_Serial_Ethernet_Top_1_hi_ber_o(serdes_2_hi_ber),         //  Hi BER
        .Ten_Giga_Serial_Ethernet_Top_1_ber_count_o(serdes_2_ber_count),   //  MAX 63
        .Ten_Giga_Serial_Ethernet_Top_1_errored_block_count_o(serdes_2_errored_block_count),
        .Ten_Giga_Serial_Ethernet_Top_1_clear_ber_count_i(serdes2_ber_clear),
        .Ten_Giga_Serial_Ethernet_Top_1_clear_errored_block_count_i(serdes2_blkerr_clear),

        .Ten_Giga_Serial_Ethernet_Top_1_pcs_status_o(serdes_2_pcs_status), //  1: normal
        .Ten_Giga_Serial_Ethernet_Top_1_debug_vector_o(serdes_2_debug_vector)
        
    );

    assign serdes1_pll_lock          = serdes_1_debug_vector[0];
    assign serdes1_CDR_lock          = serdes_1_debug_vector[1];
    assign serdes1_signal_detected   = serdes_1_debug_vector[2];
    assign serdes1_rx_IDLE_delete    = serdes_1_debug_vector[3];
    assign serdes1_rx_SEQ_delete     = serdes_1_debug_vector[4];
    assign serdes1_rx_IDLE_insert    = serdes_1_debug_vector[5];
    assign serdes1_rx_BUF_Overflow   = serdes_1_debug_vector[6];
    assign serdes1_rx_BUF_Underflow  = serdes_1_debug_vector[7];
    assign serdes1_gearbox_bitslip   = serdes_1_debug_vector[8];

    assign serdes2_pll_lock          = serdes_2_debug_vector[0];
    assign serdes2_CDR_lock          = serdes_2_debug_vector[1];
    assign serdes2_signal_detected   = serdes_2_debug_vector[2];
    assign serdes2_rx_IDLE_delete    = serdes_2_debug_vector[3];
    assign serdes2_rx_SEQ_delete     = serdes_2_debug_vector[4];
    assign serdes2_rx_IDLE_insert    = serdes_2_debug_vector[5];
    assign serdes2_rx_BUF_Overflow   = serdes_2_debug_vector[6];
    assign serdes2_rx_BUF_Underflow  = serdes_2_debug_vector[7];
    assign serdes2_gearbox_bitslip   = serdes_2_debug_vector[8];

        
endmodule

