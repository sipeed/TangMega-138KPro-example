//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.01 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Thu Oct 17 12:51:52 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    SerDes_Top your_instance_name(
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rxc_o(Ten_Giga_Serial_Ethernet_Top_xgmii_rxc_o), //output [7:0] Ten_Giga_Serial_Ethernet_Top_xgmii_rxc_o
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rxd_o(Ten_Giga_Serial_Ethernet_Top_xgmii_rxd_o), //output [63:0] Ten_Giga_Serial_Ethernet_Top_xgmii_rxd_o
        .Ten_Giga_Serial_Ethernet_Top_ref_clk_o(Ten_Giga_Serial_Ethernet_Top_ref_clk_o), //output Ten_Giga_Serial_Ethernet_Top_ref_clk_o
        .Ten_Giga_Serial_Ethernet_Top_clk_out0_o(Ten_Giga_Serial_Ethernet_Top_clk_out0_o), //output Ten_Giga_Serial_Ethernet_Top_clk_out0_o
        .Ten_Giga_Serial_Ethernet_Top_clk_out1_o(Ten_Giga_Serial_Ethernet_Top_clk_out1_o), //output Ten_Giga_Serial_Ethernet_Top_clk_out1_o
        .Ten_Giga_Serial_Ethernet_Top_block_lock_o(Ten_Giga_Serial_Ethernet_Top_block_lock_o), //output Ten_Giga_Serial_Ethernet_Top_block_lock_o
        .Ten_Giga_Serial_Ethernet_Top_hi_ber_o(Ten_Giga_Serial_Ethernet_Top_hi_ber_o), //output Ten_Giga_Serial_Ethernet_Top_hi_ber_o
        .Ten_Giga_Serial_Ethernet_Top_pcs_status_o(Ten_Giga_Serial_Ethernet_Top_pcs_status_o), //output Ten_Giga_Serial_Ethernet_Top_pcs_status_o
        .Ten_Giga_Serial_Ethernet_Top_ber_count_o(Ten_Giga_Serial_Ethernet_Top_ber_count_o), //output [5:0] Ten_Giga_Serial_Ethernet_Top_ber_count_o
        .Ten_Giga_Serial_Ethernet_Top_errored_block_count_o(Ten_Giga_Serial_Ethernet_Top_errored_block_count_o), //output [7:0] Ten_Giga_Serial_Ethernet_Top_errored_block_count_o
        .Ten_Giga_Serial_Ethernet_Top_debug_vector_o(Ten_Giga_Serial_Ethernet_Top_debug_vector_o), //output [15:0] Ten_Giga_Serial_Ethernet_Top_debug_vector_o
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxc_o(Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxc_o), //output [7:0] Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxc_o
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxd_o(Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxd_o), //output [63:0] Ten_Giga_Serial_Ethernet_Top_1_xgmii_rxd_o
        .Ten_Giga_Serial_Ethernet_Top_1_ref_clk_o(Ten_Giga_Serial_Ethernet_Top_1_ref_clk_o), //output Ten_Giga_Serial_Ethernet_Top_1_ref_clk_o
        .Ten_Giga_Serial_Ethernet_Top_1_clk_out0_o(Ten_Giga_Serial_Ethernet_Top_1_clk_out0_o), //output Ten_Giga_Serial_Ethernet_Top_1_clk_out0_o
        .Ten_Giga_Serial_Ethernet_Top_1_clk_out1_o(Ten_Giga_Serial_Ethernet_Top_1_clk_out1_o), //output Ten_Giga_Serial_Ethernet_Top_1_clk_out1_o
        .Ten_Giga_Serial_Ethernet_Top_1_block_lock_o(Ten_Giga_Serial_Ethernet_Top_1_block_lock_o), //output Ten_Giga_Serial_Ethernet_Top_1_block_lock_o
        .Ten_Giga_Serial_Ethernet_Top_1_hi_ber_o(Ten_Giga_Serial_Ethernet_Top_1_hi_ber_o), //output Ten_Giga_Serial_Ethernet_Top_1_hi_ber_o
        .Ten_Giga_Serial_Ethernet_Top_1_pcs_status_o(Ten_Giga_Serial_Ethernet_Top_1_pcs_status_o), //output Ten_Giga_Serial_Ethernet_Top_1_pcs_status_o
        .Ten_Giga_Serial_Ethernet_Top_1_ber_count_o(Ten_Giga_Serial_Ethernet_Top_1_ber_count_o), //output [5:0] Ten_Giga_Serial_Ethernet_Top_1_ber_count_o
        .Ten_Giga_Serial_Ethernet_Top_1_errored_block_count_o(Ten_Giga_Serial_Ethernet_Top_1_errored_block_count_o), //output [7:0] Ten_Giga_Serial_Ethernet_Top_1_errored_block_count_o
        .Ten_Giga_Serial_Ethernet_Top_1_debug_vector_o(Ten_Giga_Serial_Ethernet_Top_1_debug_vector_o), //output [15:0] Ten_Giga_Serial_Ethernet_Top_1_debug_vector_o
        .Ten_Giga_Serial_Ethernet_Top_rx_rstn_i(Ten_Giga_Serial_Ethernet_Top_rx_rstn_i), //input Ten_Giga_Serial_Ethernet_Top_rx_rstn_i
        .Ten_Giga_Serial_Ethernet_Top_tx_rstn_i(Ten_Giga_Serial_Ethernet_Top_tx_rstn_i), //input Ten_Giga_Serial_Ethernet_Top_tx_rstn_i
        .Ten_Giga_Serial_Ethernet_Top_signal_detect_i(Ten_Giga_Serial_Ethernet_Top_signal_detect_i), //input Ten_Giga_Serial_Ethernet_Top_signal_detect_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_i(Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_i), //input Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_i(Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_i), //input Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_ready_i(Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_ready_i), //input Ten_Giga_Serial_Ethernet_Top_xgmii_rx_clk_ready_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_ready_i(Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_ready_i), //input Ten_Giga_Serial_Ethernet_Top_xgmii_tx_clk_ready_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_txc_i(Ten_Giga_Serial_Ethernet_Top_xgmii_txc_i), //input [7:0] Ten_Giga_Serial_Ethernet_Top_xgmii_txc_i
        .Ten_Giga_Serial_Ethernet_Top_xgmii_txd_i(Ten_Giga_Serial_Ethernet_Top_xgmii_txd_i), //input [63:0] Ten_Giga_Serial_Ethernet_Top_xgmii_txd_i
        .Ten_Giga_Serial_Ethernet_Top_clear_ber_count_i(Ten_Giga_Serial_Ethernet_Top_clear_ber_count_i), //input Ten_Giga_Serial_Ethernet_Top_clear_ber_count_i
        .Ten_Giga_Serial_Ethernet_Top_clear_errored_block_count_i(Ten_Giga_Serial_Ethernet_Top_clear_errored_block_count_i), //input Ten_Giga_Serial_Ethernet_Top_clear_errored_block_count_i
        .Ten_Giga_Serial_Ethernet_Top_1_rx_rstn_i(Ten_Giga_Serial_Ethernet_Top_1_rx_rstn_i), //input Ten_Giga_Serial_Ethernet_Top_1_rx_rstn_i
        .Ten_Giga_Serial_Ethernet_Top_1_tx_rstn_i(Ten_Giga_Serial_Ethernet_Top_1_tx_rstn_i), //input Ten_Giga_Serial_Ethernet_Top_1_tx_rstn_i
        .Ten_Giga_Serial_Ethernet_Top_1_signal_detect_i(Ten_Giga_Serial_Ethernet_Top_1_signal_detect_i), //input Ten_Giga_Serial_Ethernet_Top_1_signal_detect_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_i), //input Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_i), //input Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_ready_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_ready_i), //input Ten_Giga_Serial_Ethernet_Top_1_xgmii_rx_clk_ready_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_ready_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_ready_i), //input Ten_Giga_Serial_Ethernet_Top_1_xgmii_tx_clk_ready_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_txc_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_txc_i), //input [7:0] Ten_Giga_Serial_Ethernet_Top_1_xgmii_txc_i
        .Ten_Giga_Serial_Ethernet_Top_1_xgmii_txd_i(Ten_Giga_Serial_Ethernet_Top_1_xgmii_txd_i), //input [63:0] Ten_Giga_Serial_Ethernet_Top_1_xgmii_txd_i
        .Ten_Giga_Serial_Ethernet_Top_1_clear_ber_count_i(Ten_Giga_Serial_Ethernet_Top_1_clear_ber_count_i), //input Ten_Giga_Serial_Ethernet_Top_1_clear_ber_count_i
        .Ten_Giga_Serial_Ethernet_Top_1_clear_errored_block_count_i(Ten_Giga_Serial_Ethernet_Top_1_clear_errored_block_count_i) //input Ten_Giga_Serial_Ethernet_Top_1_clear_errored_block_count_i
    );

//--------Copy end-------------------
