//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.9 Beta-4
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Wed Sep 13 16:24:44 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Customized_PHY_Top your_instance_name(
		.Q1_LANE0_PCS_RX_O_FABRIC_CLK(Q1_LANE0_PCS_RX_O_FABRIC_CLK_i), //input Q1_LANE0_PCS_RX_O_FABRIC_CLK
		.Q1_LANE0_FABRIC_RX_CLK(Q1_LANE0_FABRIC_RX_CLK_o), //output Q1_LANE0_FABRIC_RX_CLK
		.Q1_FABRIC_LN0_RXDATA_O(Q1_FABRIC_LN0_RXDATA_O_i), //input [87:0] Q1_FABRIC_LN0_RXDATA_O
		.Q1_LANE0_RX_IF_FIFO_RDEN(Q1_LANE0_RX_IF_FIFO_RDEN_o), //output Q1_LANE0_RX_IF_FIFO_RDEN
		.Q1_LANE0_RX_IF_FIFO_RDUSEWD(Q1_LANE0_RX_IF_FIFO_RDUSEWD_i), //input [4:0] Q1_LANE0_RX_IF_FIFO_RDUSEWD
		.Q1_LANE0_RX_IF_FIFO_AEMPTY(Q1_LANE0_RX_IF_FIFO_AEMPTY_i), //input Q1_LANE0_RX_IF_FIFO_AEMPTY
		.Q1_LANE0_RX_IF_FIFO_EMPTY(Q1_LANE0_RX_IF_FIFO_EMPTY_i), //input Q1_LANE0_RX_IF_FIFO_EMPTY
		.Q1_FABRIC_LN0_RX_VLD_OUT(Q1_FABRIC_LN0_RX_VLD_OUT_i), //input Q1_FABRIC_LN0_RX_VLD_OUT
		.Q1_LANE0_PCS_TX_O_FABRIC_CLK(Q1_LANE0_PCS_TX_O_FABRIC_CLK_i), //input Q1_LANE0_PCS_TX_O_FABRIC_CLK
		.Q1_LANE0_FABRIC_TX_CLK(Q1_LANE0_FABRIC_TX_CLK_o), //output Q1_LANE0_FABRIC_TX_CLK
		.Q1_FABRIC_LN0_TXDATA_I(Q1_FABRIC_LN0_TXDATA_I_o), //output [79:0] Q1_FABRIC_LN0_TXDATA_I
		.Q1_FABRIC_LN0_TX_VLD_IN(Q1_FABRIC_LN0_TX_VLD_IN_o), //output Q1_FABRIC_LN0_TX_VLD_IN
		.Q1_LANE0_TX_IF_FIFO_WRUSEWD(Q1_LANE0_TX_IF_FIFO_WRUSEWD_i), //input [4:0] Q1_LANE0_TX_IF_FIFO_WRUSEWD
		.Q1_LANE0_TX_IF_FIFO_AFULL(Q1_LANE0_TX_IF_FIFO_AFULL_i), //input Q1_LANE0_TX_IF_FIFO_AFULL
		.Q1_LANE0_TX_IF_FIFO_FULL(Q1_LANE0_TX_IF_FIFO_FULL_i), //input Q1_LANE0_TX_IF_FIFO_FULL
		.Q1_LANE0_FABRIC_C2I_CLK(Q1_LANE0_FABRIC_C2I_CLK_o), //output Q1_LANE0_FABRIC_C2I_CLK
		.Q1_LANE0_CHBOND_START(Q1_LANE0_CHBOND_START_o), //output Q1_LANE0_CHBOND_START
		.Q1_FABRIC_LN0_RSTN_I(Q1_FABRIC_LN0_RSTN_I_o), //output Q1_FABRIC_LN0_RSTN_I
		.Q1_LANE0_PCS_RX_RST(Q1_LANE0_PCS_RX_RST_o), //output Q1_LANE0_PCS_RX_RST
		.Q1_LANE0_PCS_TX_RST(Q1_LANE0_PCS_TX_RST_o), //output Q1_LANE0_PCS_TX_RST
		.Q1_FABRIC_LANE0_CMU_CK_REF_O(Q1_FABRIC_LANE0_CMU_CK_REF_O_i), //input Q1_FABRIC_LANE0_CMU_CK_REF_O
		.Q1_FABRIC_LN0_ASTAT_O(Q1_FABRIC_LN0_ASTAT_O_i), //input [5:0] Q1_FABRIC_LN0_ASTAT_O
		.Q1_FABRIC_LN0_PMA_RX_LOCK_O(Q1_FABRIC_LN0_PMA_RX_LOCK_O_i), //input Q1_FABRIC_LN0_PMA_RX_LOCK_O
		.Q1_LANE0_ALIGN_LINK(Q1_LANE0_ALIGN_LINK_i), //input Q1_LANE0_ALIGN_LINK
		.Q1_LANE0_K_LOCK(Q1_LANE0_K_LOCK_i), //input Q1_LANE0_K_LOCK
		.Q1_FABRIC_LANE0_CMU_OK_O(Q1_FABRIC_LANE0_CMU_OK_O_i), //input Q1_FABRIC_LANE0_CMU_OK_O
		.q1_ln0_rx_pcs_clkout_o(q1_ln0_rx_pcs_clkout_o_o), //output q1_ln0_rx_pcs_clkout_o
		.q1_ln0_rx_clk_i(q1_ln0_rx_clk_i_i), //input q1_ln0_rx_clk_i
		.q1_ln0_rx_data_o(q1_ln0_rx_data_o_o), //output [87:0] q1_ln0_rx_data_o
		.q1_ln0_rx_fifo_rden_i(q1_ln0_rx_fifo_rden_i_i), //input q1_ln0_rx_fifo_rden_i
		.q1_ln0_rx_fifo_rdusewd_o(q1_ln0_rx_fifo_rdusewd_o_o), //output [4:0] q1_ln0_rx_fifo_rdusewd_o
		.q1_ln0_rx_fifo_aempty_o(q1_ln0_rx_fifo_aempty_o_o), //output q1_ln0_rx_fifo_aempty_o
		.q1_ln0_rx_fifo_empty_o(q1_ln0_rx_fifo_empty_o_o), //output q1_ln0_rx_fifo_empty_o
		.q1_ln0_rx_valid_o(q1_ln0_rx_valid_o_o), //output q1_ln0_rx_valid_o
		.q1_ln0_tx_pcs_clkout_o(q1_ln0_tx_pcs_clkout_o_o), //output q1_ln0_tx_pcs_clkout_o
		.q1_ln0_tx_clk_i(q1_ln0_tx_clk_i_i), //input q1_ln0_tx_clk_i
		.q1_ln0_tx_data_i(q1_ln0_tx_data_i_i), //input [79:0] q1_ln0_tx_data_i
		.q1_ln0_tx_fifo_wren_i(q1_ln0_tx_fifo_wren_i_i), //input q1_ln0_tx_fifo_wren_i
		.q1_ln0_tx_fifo_wrusewd_o(q1_ln0_tx_fifo_wrusewd_o_o), //output [4:0] q1_ln0_tx_fifo_wrusewd_o
		.q1_ln0_tx_fifo_afull_o(q1_ln0_tx_fifo_afull_o_o), //output q1_ln0_tx_fifo_afull_o
		.q1_ln0_tx_fifo_full_o(q1_ln0_tx_fifo_full_o_o), //output q1_ln0_tx_fifo_full_o
		.q1_ln0_pma_rstn_i(q1_ln0_pma_rstn_i_i), //input q1_ln0_pma_rstn_i
		.q1_ln0_pcs_rx_rst_i(q1_ln0_pcs_rx_rst_i_i), //input q1_ln0_pcs_rx_rst_i
		.q1_ln0_pcs_tx_rst_i(q1_ln0_pcs_tx_rst_i_i), //input q1_ln0_pcs_tx_rst_i
		.q1_ln0_refclk_o(q1_ln0_refclk_o_o), //output q1_ln0_refclk_o
		.q1_ln0_signal_detect_o(q1_ln0_signal_detect_o_o), //output q1_ln0_signal_detect_o
		.q1_ln0_rx_cdr_lock_o(q1_ln0_rx_cdr_lock_o_o), //output q1_ln0_rx_cdr_lock_o
		.q1_ln0_pll_lock_o(q1_ln0_pll_lock_o_o), //output q1_ln0_pll_lock_o
		.Q1_LANE1_PCS_RX_O_FABRIC_CLK(Q1_LANE1_PCS_RX_O_FABRIC_CLK_i), //input Q1_LANE1_PCS_RX_O_FABRIC_CLK
		.Q1_LANE1_FABRIC_RX_CLK(Q1_LANE1_FABRIC_RX_CLK_o), //output Q1_LANE1_FABRIC_RX_CLK
		.Q1_FABRIC_LN1_RXDATA_O(Q1_FABRIC_LN1_RXDATA_O_i), //input [87:0] Q1_FABRIC_LN1_RXDATA_O
		.Q1_LANE1_RX_IF_FIFO_RDEN(Q1_LANE1_RX_IF_FIFO_RDEN_o), //output Q1_LANE1_RX_IF_FIFO_RDEN
		.Q1_LANE1_RX_IF_FIFO_RDUSEWD(Q1_LANE1_RX_IF_FIFO_RDUSEWD_i), //input [4:0] Q1_LANE1_RX_IF_FIFO_RDUSEWD
		.Q1_LANE1_RX_IF_FIFO_AEMPTY(Q1_LANE1_RX_IF_FIFO_AEMPTY_i), //input Q1_LANE1_RX_IF_FIFO_AEMPTY
		.Q1_LANE1_RX_IF_FIFO_EMPTY(Q1_LANE1_RX_IF_FIFO_EMPTY_i), //input Q1_LANE1_RX_IF_FIFO_EMPTY
		.Q1_FABRIC_LN1_RX_VLD_OUT(Q1_FABRIC_LN1_RX_VLD_OUT_i), //input Q1_FABRIC_LN1_RX_VLD_OUT
		.Q1_LANE1_PCS_TX_O_FABRIC_CLK(Q1_LANE1_PCS_TX_O_FABRIC_CLK_i), //input Q1_LANE1_PCS_TX_O_FABRIC_CLK
		.Q1_LANE1_FABRIC_TX_CLK(Q1_LANE1_FABRIC_TX_CLK_o), //output Q1_LANE1_FABRIC_TX_CLK
		.Q1_FABRIC_LN1_TXDATA_I(Q1_FABRIC_LN1_TXDATA_I_o), //output [79:0] Q1_FABRIC_LN1_TXDATA_I
		.Q1_FABRIC_LN1_TX_VLD_IN(Q1_FABRIC_LN1_TX_VLD_IN_o), //output Q1_FABRIC_LN1_TX_VLD_IN
		.Q1_LANE1_TX_IF_FIFO_WRUSEWD(Q1_LANE1_TX_IF_FIFO_WRUSEWD_i), //input [4:0] Q1_LANE1_TX_IF_FIFO_WRUSEWD
		.Q1_LANE1_TX_IF_FIFO_AFULL(Q1_LANE1_TX_IF_FIFO_AFULL_i), //input Q1_LANE1_TX_IF_FIFO_AFULL
		.Q1_LANE1_TX_IF_FIFO_FULL(Q1_LANE1_TX_IF_FIFO_FULL_i), //input Q1_LANE1_TX_IF_FIFO_FULL
		.Q1_LANE1_FABRIC_C2I_CLK(Q1_LANE1_FABRIC_C2I_CLK_o), //output Q1_LANE1_FABRIC_C2I_CLK
		.Q1_LANE1_CHBOND_START(Q1_LANE1_CHBOND_START_o), //output Q1_LANE1_CHBOND_START
		.Q1_FABRIC_LN1_RSTN_I(Q1_FABRIC_LN1_RSTN_I_o), //output Q1_FABRIC_LN1_RSTN_I
		.Q1_LANE1_PCS_RX_RST(Q1_LANE1_PCS_RX_RST_o), //output Q1_LANE1_PCS_RX_RST
		.Q1_LANE1_PCS_TX_RST(Q1_LANE1_PCS_TX_RST_o), //output Q1_LANE1_PCS_TX_RST
		.Q1_FABRIC_LANE1_CMU_CK_REF_O(Q1_FABRIC_LANE1_CMU_CK_REF_O_i), //input Q1_FABRIC_LANE1_CMU_CK_REF_O
		.Q1_FABRIC_LN1_ASTAT_O(Q1_FABRIC_LN1_ASTAT_O_i), //input [5:0] Q1_FABRIC_LN1_ASTAT_O
		.Q1_FABRIC_LN1_PMA_RX_LOCK_O(Q1_FABRIC_LN1_PMA_RX_LOCK_O_i), //input Q1_FABRIC_LN1_PMA_RX_LOCK_O
		.Q1_LANE1_ALIGN_LINK(Q1_LANE1_ALIGN_LINK_i), //input Q1_LANE1_ALIGN_LINK
		.Q1_LANE1_K_LOCK(Q1_LANE1_K_LOCK_i), //input Q1_LANE1_K_LOCK
		.Q1_FABRIC_LANE1_CMU_OK_O(Q1_FABRIC_LANE1_CMU_OK_O_i), //input Q1_FABRIC_LANE1_CMU_OK_O
		.q1_ln1_rx_pcs_clkout_o(q1_ln1_rx_pcs_clkout_o_o), //output q1_ln1_rx_pcs_clkout_o
		.q1_ln1_rx_clk_i(q1_ln1_rx_clk_i_i), //input q1_ln1_rx_clk_i
		.q1_ln1_rx_data_o(q1_ln1_rx_data_o_o), //output [87:0] q1_ln1_rx_data_o
		.q1_ln1_rx_fifo_rden_i(q1_ln1_rx_fifo_rden_i_i), //input q1_ln1_rx_fifo_rden_i
		.q1_ln1_rx_fifo_rdusewd_o(q1_ln1_rx_fifo_rdusewd_o_o), //output [4:0] q1_ln1_rx_fifo_rdusewd_o
		.q1_ln1_rx_fifo_aempty_o(q1_ln1_rx_fifo_aempty_o_o), //output q1_ln1_rx_fifo_aempty_o
		.q1_ln1_rx_fifo_empty_o(q1_ln1_rx_fifo_empty_o_o), //output q1_ln1_rx_fifo_empty_o
		.q1_ln1_rx_valid_o(q1_ln1_rx_valid_o_o), //output q1_ln1_rx_valid_o
		.q1_ln1_tx_pcs_clkout_o(q1_ln1_tx_pcs_clkout_o_o), //output q1_ln1_tx_pcs_clkout_o
		.q1_ln1_tx_clk_i(q1_ln1_tx_clk_i_i), //input q1_ln1_tx_clk_i
		.q1_ln1_tx_data_i(q1_ln1_tx_data_i_i), //input [79:0] q1_ln1_tx_data_i
		.q1_ln1_tx_fifo_wren_i(q1_ln1_tx_fifo_wren_i_i), //input q1_ln1_tx_fifo_wren_i
		.q1_ln1_tx_fifo_wrusewd_o(q1_ln1_tx_fifo_wrusewd_o_o), //output [4:0] q1_ln1_tx_fifo_wrusewd_o
		.q1_ln1_tx_fifo_afull_o(q1_ln1_tx_fifo_afull_o_o), //output q1_ln1_tx_fifo_afull_o
		.q1_ln1_tx_fifo_full_o(q1_ln1_tx_fifo_full_o_o), //output q1_ln1_tx_fifo_full_o
		.q1_ln1_pma_rstn_i(q1_ln1_pma_rstn_i_i), //input q1_ln1_pma_rstn_i
		.q1_ln1_pcs_rx_rst_i(q1_ln1_pcs_rx_rst_i_i), //input q1_ln1_pcs_rx_rst_i
		.q1_ln1_pcs_tx_rst_i(q1_ln1_pcs_tx_rst_i_i), //input q1_ln1_pcs_tx_rst_i
		.q1_ln1_refclk_o(q1_ln1_refclk_o_o), //output q1_ln1_refclk_o
		.q1_ln1_signal_detect_o(q1_ln1_signal_detect_o_o), //output q1_ln1_signal_detect_o
		.q1_ln1_rx_cdr_lock_o(q1_ln1_rx_cdr_lock_o_o), //output q1_ln1_rx_cdr_lock_o
		.q1_ln1_pll_lock_o(q1_ln1_pll_lock_o_o), //output q1_ln1_pll_lock_o
		.Q0_FABRIC_CMU_CK_REF_O(Q0_FABRIC_CMU_CK_REF_O_i), //input Q0_FABRIC_CMU_CK_REF_O
		.Q0_FABRIC_CMU1_CK_REF_O(Q0_FABRIC_CMU1_CK_REF_O_i), //input Q0_FABRIC_CMU1_CK_REF_O
		.Q0_FABRIC_CMU1_OK_O(Q0_FABRIC_CMU1_OK_O_i), //input Q0_FABRIC_CMU1_OK_O
		.Q0_FABRIC_CMU_OK_O(Q0_FABRIC_CMU_OK_O_i), //input Q0_FABRIC_CMU_OK_O
		.Q1_FABRIC_CMU_CK_REF_O(Q1_FABRIC_CMU_CK_REF_O_i), //input Q1_FABRIC_CMU_CK_REF_O
		.Q1_FABRIC_CMU1_CK_REF_O(Q1_FABRIC_CMU1_CK_REF_O_i), //input Q1_FABRIC_CMU1_CK_REF_O
		.Q1_FABRIC_CMU1_OK_O(Q1_FABRIC_CMU1_OK_O_i), //input Q1_FABRIC_CMU1_OK_O
		.Q1_FABRIC_CMU_OK_O(Q1_FABRIC_CMU_OK_O_i) //input Q1_FABRIC_CMU_OK_O
	);

//--------Copy end-------------------
