//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9.01 (64-bit)
//Part Number: GW5AST-LV138FPG676AC2/I1
//Device: GW5AST-138
//Device Version: B
//Created Time: Thu Jan  4 10:17:08 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Ten_Giga_Ethernet_MAC_Top your_instance_name(
		.rx_rstn_i(rx_rstn_i_i), //input rx_rstn_i
		.tx_rstn_i(tx_rstn_i_i), //input tx_rstn_i
		.xgmii_rx_clk_i(xgmii_rx_clk_i_i), //input xgmii_rx_clk_i
		.xgtx_clk_i(xgtx_clk_i_i), //input xgtx_clk_i
		.xgmii_rxc_i(xgmii_rxc_i_i), //input [7:0] xgmii_rxc_i
		.xgmii_rxd_i(xgmii_rxd_i_i), //input [63:0] xgmii_rxd_i
		.xgmii_txc_o(xgmii_txc_o_o), //output [7:0] xgmii_txc_o
		.xgmii_txd_o(xgmii_txd_o_o), //output [63:0] xgmii_txd_o
		.rx_fcs_fwd_ena_i(rx_fcs_fwd_ena_i_i), //input rx_fcs_fwd_ena_i
		.rx_jumbo_ena_i(rx_jumbo_ena_i_i), //input rx_jumbo_ena_i
		.tx_fcs_fwd_ena_i(tx_fcs_fwd_ena_i_i), //input tx_fcs_fwd_ena_i
		.tx_fault_ena_i(tx_fault_ena_i_i), //input tx_fault_ena_i
		.tx_ifg_delay_ena_i(tx_ifg_delay_ena_i_i), //input tx_ifg_delay_ena_i
		.tx_ifg_delay_i(tx_ifg_delay_i_i), //input [7:0] tx_ifg_delay_i
		.rx_mac_clk_o(rx_mac_clk_o_o), //output rx_mac_clk_o
		.rx_mac_valid_o(rx_mac_valid_o_o), //output rx_mac_valid_o
		.rx_mac_data_o(rx_mac_data_o_o), //output [63:0] rx_mac_data_o
		.rx_mac_byte_o(rx_mac_byte_o_o), //output [7:0] rx_mac_byte_o
		.rx_mac_last_o(rx_mac_last_o_o), //output rx_mac_last_o
		.rx_mac_error_o(rx_mac_error_o_o), //output rx_mac_error_o
		.rx_statistics_valid_o(rx_statistics_valid_o_o), //output rx_statistics_valid_o
		.rx_statistics_vector_o(rx_statistics_vector_o_o), //output [19:0] rx_statistics_vector_o
		.tx_mac_clk_o(tx_mac_clk_o_o), //output tx_mac_clk_o
		.tx_mac_valid_i(tx_mac_valid_i_i), //input tx_mac_valid_i
		.tx_mac_data_i(tx_mac_data_i_i), //input [63:0] tx_mac_data_i
		.tx_mac_byte_i(tx_mac_byte_i_i), //input [7:0] tx_mac_byte_i
		.tx_mac_last_i(tx_mac_last_i_i), //input tx_mac_last_i
		.tx_mac_error_i(tx_mac_error_i_i), //input tx_mac_error_i
		.tx_mac_ready_o(tx_mac_ready_o_o), //output tx_mac_ready_o
		.tx_statistics_valid_o(tx_statistics_valid_o_o), //output tx_statistics_valid_o
		.tx_statistics_vector_o(tx_statistics_vector_o_o), //output [18:0] tx_statistics_vector_o
		.local_fault_o(local_fault_o_o), //output local_fault_o
		.remote_fault_o(remote_fault_o_o) //output remote_fault_o
	);

//--------Copy end-------------------
