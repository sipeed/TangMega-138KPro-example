module dvi_tx_clk_drv(
	
	input				pixel_clock,
	output	[1 : 0]		tmds_clk
);
	
	wire tmds_clk_pre;
	
	ELVDS_OBUF tmds_bufds_isnt0 (
		.I(pixel_clock),
		.O(tmds_clk[1]),
		.OB(tmds_clk[0])
	);
	
endmodule
