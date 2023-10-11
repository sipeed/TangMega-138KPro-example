module top#(
	parameter BOARD_MAC 	= 48'h03_08_35_01_AE_C2 		,//开发板MAC地址
	parameter BOARD_IP 		= {8'd192,8'd168,8'd3,8'd2}	,//开发板IP地址
	parameter BOARD_PORT	= 16'h8000, 					 //开发板IP地址-端口 
	parameter DES_MAC 		= 48'hff_ff_ff_ff_ff_ff 		,//目的MAC地址
	parameter DES_IP 		= {8'd192,8'd168,8'd3,8'd3} 	,//目的IP地址
	parameter DES_PORT		= 16'h8000, 					 //目的IP地址-端口 
	parameter DATA_SIZE		= 16'd256						 //数据包长度 46~1500 B
	)(
	input 			sys_clk,
	input 			rst_n, 			


	output 			PHY_CLK,
	output 			RGMII_GTXCLK,
	output 			RGMII_RST_N, 	
	output [3:0] 	RGMII_TXD, 		
	output reg		RGMII_TXEN		
	);
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    GMII发送子模块 	        /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
GMII_pll GMII_pll_m0(
	.clkin 		(sys_clk 	 	),
	.clkout0 	(RGMII_GTXCLK 	),
	.clkout1 	(PHY_CLK 		)
	);

wire GMII_TXEN;
wire [7:0] GMII_TXD;
GMII_send #(
	.BOARD_MAC 	(BOARD_MAC  ),//开发板MAC地址
	.BOARD_IP 	(BOARD_IP 	),//开发板IP地址
	.BOARD_PORT (BOARD_PORT ),
	.DES_MAC 	(DES_MAC 	),//目的MAC地址
	.DES_IP 	(DES_IP 	),//目的IP地址
	.DES_PORT 	(DES_PORT 	),
	.DATA_SIZE	(DATA_SIZE	) //数据包长度 50~1500B
	)GMII_send_m0(
	.rst_n 			(rst_n 				),

	.GMII_GTXCLK 	(RGMII_GTXCLK 		),
	.GMII_TXD 		(GMII_TXD 			),
	.GMII_TXEN 		(GMII_TXEN 			),
	.GMII_TXER 		(	 				)
	);
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    GMII 2 RGMII	        /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
ODDR#(
	.TXCLK_POL (1'B0 		)
	) GMII2RGMII_m0(
	.CLK 	(RGMII_GTXCLK 	),
	.D0 	(GMII_TXD[0] 	),
	.D1 	(GMII_TXD[4] 	),
	.Q0 	(RGMII_TXD[0] 	)
	);

ODDR#(
	.TXCLK_POL (1'B0 		)
	) GMII2RGMII_m1(
	.CLK 	(RGMII_GTXCLK 	),
	.D0 	(GMII_TXD[1] 	),
	.D1 	(GMII_TXD[5] 	),
	.Q0 	(RGMII_TXD[1] 	)
	);

ODDR#(
	.TXCLK_POL (1'B0 		)
	) GMII2RGMII_m2(
	.CLK 	(RGMII_GTXCLK 	),
	.D0 	(GMII_TXD[2] 	),
	.D1 	(GMII_TXD[6] 	),
	.Q0 	(RGMII_TXD[2] 	)
	);

ODDR#(
	.TXCLK_POL (1'B0 		)
	) GMII2RGMII_m3(
	.CLK 	(RGMII_GTXCLK 	),
	.D0 	(GMII_TXD[3] 	),
	.D1 	(GMII_TXD[7] 	),
	.Q0 	(RGMII_TXD[3] 	)
	);

reg GMII_TXEN_D0;
always@(posedge RGMII_GTXCLK) GMII_TXEN_D0 <= GMII_TXEN;
always@(posedge RGMII_GTXCLK) RGMII_TXEN <= GMII_TXEN_D0;

assign RGMII_RST_N = rst_n;

endmodule