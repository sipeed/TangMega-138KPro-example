module top(
	input clk,
	input resetn,
	
	output       tmds_clk_n_0,
	output       tmds_clk_p_0,
	output [2:0] tmds_d_n_0,
	output [2:0] tmds_d_p_0
	
	// output       tmds_clk_n_1,
	// output       tmds_clk_p_1,
	// output [2:0] tmds_d_n_1,
	// output [2:0] tmds_d_p_1
);
	wire 	[23 : 0]	dvi_data;
	wire				dvi_den;
	wire				dvi_hsync;
	wire				dvi_vsync;
	
	wire				pll_lock;
	wire				clk_p5;
	wire				clk_p;
	wire				sys_resetn;
	
	Gowin_PLL Gowin_PLL_inst(
		.lock(pll_lock), //output lock
		.clkout0(clk_p), //output clkout0
		.clkout1(clk_p5), //output clkout0
		.clkin(clk) //input clkin
	);

	Reset_Sync u_Reset_Sync (
		.resetn(sys_resetn),
		.ext_reset(resetn & pll_lock),
		.clk(clk_p)
	);
	
	dvi_tx_top dvi_tx_top_inst0(
		
		.pixel_clock		(clk_p),
		.ddr_bit_clock		(clk_p5),
		.reset				(~sys_resetn),
		
		.den				(dvi_den),
		.hsync				(dvi_hsync),
		.vsync				(dvi_vsync),
		.pixel_data			(dvi_data),
		
		.tmds_clk			({tmds_clk_p_0, tmds_clk_n_0}),
		.tmds_d0			({tmds_d_p_0[0], tmds_d_n_0[0]}),
		.tmds_d1			({tmds_d_p_0[1], tmds_d_n_0[1]}),
		.tmds_d2			({tmds_d_p_0[2], tmds_d_n_0[2]})
	);
	
	test_pattern_gen test_gen0(
		
		.pixel_clock		(clk_p),
		.reset				(~sys_resetn),
		
		.video_vsync		(dvi_vsync),
		.video_hsync		(dvi_hsync),
		.video_den			(dvi_den),
		.video_pixel_even	(dvi_data)
	);

endmodule

module Reset_Sync (
 input clk,
 input ext_reset,
 output resetn
);

 reg [3:0] reset_cnt = 0;
 
 always @(posedge clk or negedge ext_reset) begin
     if (~ext_reset)
         reset_cnt <= 4'b0;
     else
         reset_cnt <= reset_cnt + !resetn;
 end
 
 assign resetn = &reset_cnt;

endmodule