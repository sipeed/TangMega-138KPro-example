//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.01 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Thu Oct 17 12:51:51 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Ten_Giga_Serial_Ethernet_Top_1 your_instance_name(
		.rx_rstn_i(rx_rstn_i), //input rx_rstn_i
		.tx_rstn_i(tx_rstn_i), //input tx_rstn_i
		.signal_detect_i(signal_detect_i), //input signal_detect_i
		.xgmii_rx_clk_i(xgmii_rx_clk_i), //input xgmii_rx_clk_i
		.xgmii_tx_clk_i(xgmii_tx_clk_i), //input xgmii_tx_clk_i
		.xgmii_rx_clk_ready_i(xgmii_rx_clk_ready_i), //input xgmii_rx_clk_ready_i
		.xgmii_tx_clk_ready_i(xgmii_tx_clk_ready_i), //input xgmii_tx_clk_ready_i
		.xgmii_txc_i(xgmii_txc_i), //input [7:0] xgmii_txc_i
		.xgmii_txd_i(xgmii_txd_i), //input [63:0] xgmii_txd_i
		.xgmii_rxc_o(xgmii_rxc_o), //output [7:0] xgmii_rxc_o
		.xgmii_rxd_o(xgmii_rxd_o), //output [63:0] xgmii_rxd_o
		.ref_clk_o(ref_clk_o), //output ref_clk_o
		.clk_out0_o(clk_out0_o), //output clk_out0_o
		.clk_out1_o(clk_out1_o), //output clk_out1_o
		.block_lock_o(block_lock_o), //output block_lock_o
		.hi_ber_o(hi_ber_o), //output hi_ber_o
		.pcs_status_o(pcs_status_o), //output pcs_status_o
		.clear_ber_count_i(clear_ber_count_i), //input clear_ber_count_i
		.ber_count_o(ber_count_o), //output [5:0] ber_count_o
		.clear_errored_block_count_i(clear_errored_block_count_i), //input clear_errored_block_count_i
		.errored_block_count_o(errored_block_count_o), //output [7:0] errored_block_count_o
		.debug_vector_o(debug_vector_o), //output [15:0] debug_vector_o
		.serdes_pma_rx_lock_i(serdes_pma_rx_lock_i), //input serdes_pma_rx_lock_i
		.serdes_qpll0_pll_lock_i(serdes_qpll0_pll_lock_i), //input serdes_qpll0_pll_lock_i
		.serdes_qpll1_pll_lock_i(serdes_qpll1_pll_lock_i), //input serdes_qpll1_pll_lock_i
		.serdes_cpll_pll_lock_i(serdes_cpll_pll_lock_i), //input serdes_cpll_pll_lock_i
		.serdes_pcs_tx_clk_i(serdes_pcs_tx_clk_i), //input serdes_pcs_tx_clk_i
		.serdes_pcs_tx_clk_o(serdes_pcs_tx_clk_o), //output serdes_pcs_tx_clk_o
		.serdes_txdata_o(serdes_txdata_o), //output [79:0] serdes_txdata_o
		.serdes_pcs_rx_clk_i(serdes_pcs_rx_clk_i), //input serdes_pcs_rx_clk_i
		.serdes_pcs_rx_clk_o(serdes_pcs_rx_clk_o), //output serdes_pcs_rx_clk_o
		.serdes_rxdata_i(serdes_rxdata_i), //input [87:0] serdes_rxdata_i
		.serdes_refclk0_i(serdes_refclk0_i), //input serdes_refclk0_i
		.serdes_refclk1_i(serdes_refclk1_i), //input serdes_refclk1_i
		.serdes_pma_rstn_o(serdes_pma_rstn_o), //output serdes_pma_rstn_o
		.serdes_pcs_tx_rst_o(serdes_pcs_tx_rst_o), //output serdes_pcs_tx_rst_o
		.serdes_pcs_rx_rst_o(serdes_pcs_rx_rst_o), //output serdes_pcs_rx_rst_o
		.serdes_pcs_rx_rden_o(serdes_pcs_rx_rden_o), //output serdes_pcs_rx_rden_o
		.serdes_pcs_rx_aempty_i(serdes_pcs_rx_aempty_i), //input serdes_pcs_rx_aempty_i
		.serdes_pcs_tx_wren_o(serdes_pcs_tx_wren_o), //output serdes_pcs_tx_wren_o
		.serdes_pcs_tx_afull_i(serdes_pcs_tx_afull_i), //input serdes_pcs_tx_afull_i
		.serdes_astat_i(serdes_astat_i) //input [5:0] serdes_astat_i
	);

//--------Copy end-------------------
