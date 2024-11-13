//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Mon Nov 11 00:22:04 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	USB2_0_SoftPHY_Top your_instance_name(
		.clk_i(clk_i), //input clk_i
		.rst_i(rst_i), //input rst_i
		.fclk_i(fclk_i), //input fclk_i
		.pll_locked_i(pll_locked_i), //input pll_locked_i
		.utmi_data_out_i(utmi_data_out_i), //input [7:0] utmi_data_out_i
		.utmi_txvalid_i(utmi_txvalid_i), //input utmi_txvalid_i
		.utmi_op_mode_i(utmi_op_mode_i), //input [1:0] utmi_op_mode_i
		.utmi_xcvrselect_i(utmi_xcvrselect_i), //input [1:0] utmi_xcvrselect_i
		.utmi_termselect_i(utmi_termselect_i), //input utmi_termselect_i
		.utmi_data_in_o(utmi_data_in_o), //output [7:0] utmi_data_in_o
		.utmi_txready_o(utmi_txready_o), //output utmi_txready_o
		.utmi_rxvalid_o(utmi_rxvalid_o), //output utmi_rxvalid_o
		.utmi_rxactive_o(utmi_rxactive_o), //output utmi_rxactive_o
		.utmi_rxerror_o(utmi_rxerror_o), //output utmi_rxerror_o
		.utmi_linestate_o(utmi_linestate_o), //output [1:0] utmi_linestate_o
		.usb_dxp_io(usb_dxp_io), //inout usb_dxp_io
		.usb_dxn_io(usb_dxn_io), //inout usb_dxn_io
		.usb_rxdp_i(usb_rxdp_i), //input usb_rxdp_i
		.usb_rxdn_i(usb_rxdn_i), //input usb_rxdn_i
		.usb_pullup_en_o(usb_pullup_en_o), //output usb_pullup_en_o
		.usb_term_dp_io(usb_term_dp_io), //inout usb_term_dp_io
		.usb_term_dn_io(usb_term_dn_io) //inout usb_term_dn_io
	);

//--------Copy end-------------------
