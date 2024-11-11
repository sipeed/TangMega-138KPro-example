//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Mon Nov 11 01:01:31 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	USB_Device_Controller_Top your_instance_name(
		.clk_i(clk_i), //input clk_i
		.reset_i(reset_i), //input reset_i
		.usbrst_o(usbrst_o), //output usbrst_o
		.highspeed_o(highspeed_o), //output highspeed_o
		.suspend_o(suspend_o), //output suspend_o
		.online_o(online_o), //output online_o
		.txdat_i(txdat_i), //input [7:0] txdat_i
		.txval_i(txval_i), //input txval_i
		.txdat_len_i(txdat_len_i), //input [11:0] txdat_len_i
		.txiso_pid_i(txiso_pid_i), //input [3:0] txiso_pid_i
		.txcork_i(txcork_i), //input txcork_i
		.txpop_o(txpop_o), //output txpop_o
		.txact_o(txact_o), //output txact_o
		.txpktfin_o(txpktfin_o), //output txpktfin_o
		.rxdat_o(rxdat_o), //output [7:0] rxdat_o
		.rxval_o(rxval_o), //output rxval_o
		.rxrdy_i(rxrdy_i), //input rxrdy_i
		.rxact_o(rxact_o), //output rxact_o
		.rxpktval_o(rxpktval_o), //output rxpktval_o
		.setup_o(setup_o), //output setup_o
		.endpt_o(endpt_o), //output [3:0] endpt_o
		.sof_o(sof_o), //output sof_o
		.inf_alter_i(inf_alter_i), //input [7:0] inf_alter_i
		.inf_alter_o(inf_alter_o), //output [7:0] inf_alter_o
		.inf_sel_o(inf_sel_o), //output [7:0] inf_sel_o
		.inf_set_o(inf_set_o), //output inf_set_o
		.descrom_raddr_o(descrom_raddr_o), //output [15:0] descrom_raddr_o
		.desc_index_o(desc_index_o), //output [7:0] desc_index_o
		.desc_type_o(desc_type_o), //output [7:0] desc_type_o
		.descrom_rdata_i(descrom_rdata_i), //input [7:0] descrom_rdata_i
		.desc_dev_addr_i(desc_dev_addr_i), //input [15:0] desc_dev_addr_i
		.desc_dev_len_i(desc_dev_len_i), //input [15:0] desc_dev_len_i
		.desc_qual_addr_i(desc_qual_addr_i), //input [15:0] desc_qual_addr_i
		.desc_qual_len_i(desc_qual_len_i), //input [15:0] desc_qual_len_i
		.desc_fscfg_addr_i(desc_fscfg_addr_i), //input [15:0] desc_fscfg_addr_i
		.desc_fscfg_len_i(desc_fscfg_len_i), //input [15:0] desc_fscfg_len_i
		.desc_hscfg_addr_i(desc_hscfg_addr_i), //input [15:0] desc_hscfg_addr_i
		.desc_hscfg_len_i(desc_hscfg_len_i), //input [15:0] desc_hscfg_len_i
		.desc_oscfg_addr_i(desc_oscfg_addr_i), //input [15:0] desc_oscfg_addr_i
		.desc_hidrpt_addr_i(desc_hidrpt_addr_i), //input [15:0] desc_hidrpt_addr_i
		.desc_hidrpt_len_i(desc_hidrpt_len_i), //input [15:0] desc_hidrpt_len_i
		.desc_bos_addr_i(desc_bos_addr_i), //input [15:0] desc_bos_addr_i
		.desc_bos_len_i(desc_bos_len_i), //input [15:0] desc_bos_len_i
		.desc_strlang_addr_i(desc_strlang_addr_i), //input [15:0] desc_strlang_addr_i
		.desc_strvendor_addr_i(desc_strvendor_addr_i), //input [15:0] desc_strvendor_addr_i
		.desc_strvendor_len_i(desc_strvendor_len_i), //input [15:0] desc_strvendor_len_i
		.desc_strproduct_addr_i(desc_strproduct_addr_i), //input [15:0] desc_strproduct_addr_i
		.desc_strproduct_len_i(desc_strproduct_len_i), //input [15:0] desc_strproduct_len_i
		.desc_strserial_addr_i(desc_strserial_addr_i), //input [15:0] desc_strserial_addr_i
		.desc_strserial_len_i(desc_strserial_len_i), //input [15:0] desc_strserial_len_i
		.desc_have_strings_i(desc_have_strings_i), //input desc_have_strings_i
		.utmi_dataout_o(utmi_dataout_o), //output [7:0] utmi_dataout_o
		.utmi_txvalid_o(utmi_txvalid_o), //output utmi_txvalid_o
		.utmi_txready_i(utmi_txready_i), //input utmi_txready_i
		.utmi_datain_i(utmi_datain_i), //input [7:0] utmi_datain_i
		.utmi_rxactive_i(utmi_rxactive_i), //input utmi_rxactive_i
		.utmi_rxvalid_i(utmi_rxvalid_i), //input utmi_rxvalid_i
		.utmi_rxerror_i(utmi_rxerror_i), //input utmi_rxerror_i
		.utmi_linestate_i(utmi_linestate_i), //input [1:0] utmi_linestate_i
		.utmi_opmode_o(utmi_opmode_o), //output [1:0] utmi_opmode_o
		.utmi_xcvrselect_o(utmi_xcvrselect_o), //output [1:0] utmi_xcvrselect_o
		.utmi_termselect_o(utmi_termselect_o), //output utmi_termselect_o
		.utmi_reset_o(utmi_reset_o) //output utmi_reset_o
	);

//--------Copy end-------------------
