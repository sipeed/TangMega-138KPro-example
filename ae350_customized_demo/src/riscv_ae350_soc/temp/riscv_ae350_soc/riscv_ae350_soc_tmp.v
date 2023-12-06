//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Mon Nov 27 08:28:19 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	RiscV_AE350_SOC_Top your_instance_name(
		.FLASH_SPI_CSN(FLASH_SPI_CSN_io), //inout FLASH_SPI_CSN
		.FLASH_SPI_MISO(FLASH_SPI_MISO_io), //inout FLASH_SPI_MISO
		.FLASH_SPI_MOSI(FLASH_SPI_MOSI_io), //inout FLASH_SPI_MOSI
		.FLASH_SPI_CLK(FLASH_SPI_CLK_io), //inout FLASH_SPI_CLK
		.FLASH_SPI_HOLDN(FLASH_SPI_HOLDN_io), //inout FLASH_SPI_HOLDN
		.FLASH_SPI_WPN(FLASH_SPI_WPN_io), //inout FLASH_SPI_WPN
		.DDR_HRDATA(DDR_HRDATA_i), //input [63:0] DDR_HRDATA
		.DDR_HREADY(DDR_HREADY_i), //input DDR_HREADY
		.DDR_HRESP(DDR_HRESP_i), //input DDR_HRESP
		.DDR_HADDR(DDR_HADDR_o), //output [31:0] DDR_HADDR
		.DDR_HBURST(DDR_HBURST_o), //output [2:0] DDR_HBURST
		.DDR_HPROT(DDR_HPROT_o), //output [3:0] DDR_HPROT
		.DDR_HSIZE(DDR_HSIZE_o), //output [2:0] DDR_HSIZE
		.DDR_HTRANS(DDR_HTRANS_o), //output [1:0] DDR_HTRANS
		.DDR_HWDATA(DDR_HWDATA_o), //output [63:0] DDR_HWDATA
		.DDR_HWRITE(DDR_HWRITE_o), //output DDR_HWRITE
		.DDR_HCLK(DDR_HCLK_o), //output DDR_HCLK
		.DDR_HRSTN(DDR_HRSTN_o), //output DDR_HRSTN
		.TCK_IN(TCK_IN_i), //input TCK_IN
		.TMS_IN(TMS_IN_i), //input TMS_IN
		.TRST_IN(TRST_IN_i), //input TRST_IN
		.TDI_IN(TDI_IN_i), //input TDI_IN
		.TDO_OUT(TDO_OUT_o), //output TDO_OUT
		.TDO_OE(TDO_OE_o), //output TDO_OE
		.UART2_TXD(UART2_TXD_o), //output UART2_TXD
		.UART2_RTSN(UART2_RTSN_o), //output UART2_RTSN
		.UART2_RXD(UART2_RXD_i), //input UART2_RXD
		.UART2_CTSN(UART2_CTSN_i), //input UART2_CTSN
		.UART2_DCDN(UART2_DCDN_i), //input UART2_DCDN
		.UART2_DSRN(UART2_DSRN_i), //input UART2_DSRN
		.UART2_RIN(UART2_RIN_i), //input UART2_RIN
		.UART2_DTRN(UART2_DTRN_o), //output UART2_DTRN
		.UART2_OUT1N(UART2_OUT1N_o), //output UART2_OUT1N
		.UART2_OUT2N(UART2_OUT2N_o), //output UART2_OUT2N
		.GPIO(GPIO_io), //inout [31:0] GPIO
		.CORE_CLK(CORE_CLK_i), //input CORE_CLK
		.DDR_CLK(DDR_CLK_i), //input DDR_CLK
		.AHB_CLK(AHB_CLK_i), //input AHB_CLK
		.APB_CLK(APB_CLK_i), //input APB_CLK
		.RTC_CLK(RTC_CLK_i), //input RTC_CLK
		.POR_RSTN(POR_RSTN_i), //input POR_RSTN
		.HW_RSTN(HW_RSTN_i) //input HW_RSTN
	);

//--------Copy end-------------------
