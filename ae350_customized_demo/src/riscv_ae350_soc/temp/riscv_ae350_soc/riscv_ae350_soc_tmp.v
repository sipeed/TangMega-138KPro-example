//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Sat Oct 26 23:45:30 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	RiscV_AE350_SOC_Top your_instance_name(
		.FLASH_SPI_CSN(FLASH_SPI_CSN), //inout FLASH_SPI_CSN
		.FLASH_SPI_MISO(FLASH_SPI_MISO), //inout FLASH_SPI_MISO
		.FLASH_SPI_MOSI(FLASH_SPI_MOSI), //inout FLASH_SPI_MOSI
		.FLASH_SPI_CLK(FLASH_SPI_CLK), //inout FLASH_SPI_CLK
		.FLASH_SPI_HOLDN(FLASH_SPI_HOLDN), //inout FLASH_SPI_HOLDN
		.FLASH_SPI_WPN(FLASH_SPI_WPN), //inout FLASH_SPI_WPN
		.DDR_HRDATA(DDR_HRDATA), //input [63:0] DDR_HRDATA
		.DDR_HREADY(DDR_HREADY), //input DDR_HREADY
		.DDR_HRESP(DDR_HRESP), //input DDR_HRESP
		.DDR_HADDR(DDR_HADDR), //output [31:0] DDR_HADDR
		.DDR_HBURST(DDR_HBURST), //output [2:0] DDR_HBURST
		.DDR_HPROT(DDR_HPROT), //output [3:0] DDR_HPROT
		.DDR_HSIZE(DDR_HSIZE), //output [2:0] DDR_HSIZE
		.DDR_HTRANS(DDR_HTRANS), //output [1:0] DDR_HTRANS
		.DDR_HWDATA(DDR_HWDATA), //output [63:0] DDR_HWDATA
		.DDR_HWRITE(DDR_HWRITE), //output DDR_HWRITE
		.DDR_HCLK(DDR_HCLK), //output DDR_HCLK
		.DDR_HRSTN(DDR_HRSTN), //output DDR_HRSTN
		.TCK_IN(TCK_IN), //input TCK_IN
		.TMS_IN(TMS_IN), //input TMS_IN
		.TRST_IN(TRST_IN), //input TRST_IN
		.TDI_IN(TDI_IN), //input TDI_IN
		.TDO_OUT(TDO_OUT), //output TDO_OUT
		.TDO_OE(TDO_OE), //output TDO_OE
		.UART2_TXD(UART2_TXD), //output UART2_TXD
		.UART2_RTSN(UART2_RTSN), //output UART2_RTSN
		.UART2_RXD(UART2_RXD), //input UART2_RXD
		.UART2_CTSN(UART2_CTSN), //input UART2_CTSN
		.UART2_DCDN(UART2_DCDN), //input UART2_DCDN
		.UART2_DSRN(UART2_DSRN), //input UART2_DSRN
		.UART2_RIN(UART2_RIN), //input UART2_RIN
		.UART2_DTRN(UART2_DTRN), //output UART2_DTRN
		.UART2_OUT1N(UART2_OUT1N), //output UART2_OUT1N
		.UART2_OUT2N(UART2_OUT2N), //output UART2_OUT2N
		.GPIO(GPIO), //inout [31:0] GPIO
		.CORE_CLK(CORE_CLK), //input CORE_CLK
		.DDR_CLK(DDR_CLK), //input DDR_CLK
		.AHB_CLK(AHB_CLK), //input AHB_CLK
		.APB_CLK(APB_CLK), //input APB_CLK
		.RTC_CLK(RTC_CLK), //input RTC_CLK
		.POR_RSTN(POR_RSTN), //input POR_RSTN
		.HW_RSTN(HW_RSTN) //input HW_RSTN
	);

//--------Copy end-------------------
