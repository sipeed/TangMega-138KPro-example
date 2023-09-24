module top(
	input			rst_n,
    input           uset_key,
    input           clk,

	output			lcd_clk,
	output			lcd_en,
	output	[5:0]   lcd_r,
	output	[5:0]   lcd_b,
	output	[5:0]   lcd_g
);

    Gowin_PLL Gowin_PLL_inst(
        .clkout0(lcd_clk), //10M
        .clkin(clk)        //50M
    );

	lcd_timing	lcd_timing_inst(
		.lcd_clk	(	lcd_clk		 ),
		.rst_n		(	rst_n        ),

		.lcd_en		(	lcd_en	 	 ),

		.lcd_r		(	lcd_r		 ),
		.lcd_b		(	lcd_b		 ),
		.lcd_g		(	lcd_g		 )
	);

endmodule