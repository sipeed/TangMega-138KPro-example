module top(
  input clk,
  input resetn,

  output       tmds_clk_n_0,
  output       tmds_clk_p_0,
  output [2:0] tmds_d_n_0,
  output [2:0] tmds_d_p_0,

  output       tmds_clk_n_1,
  output       tmds_clk_p_1,
  output [2:0] tmds_d_n_1,
  output [2:0] tmds_d_p_1
);

Gowin_PLL Gowin_PLL_inst(
    .lock(pll_lock), //output lock
    .clkout0(clk_p5), //output clkout0
    .clkin(clk) //input clkin
);

gowin_clkdiv gowin_clkdiv_inst(
    .clkout0(clkout0_o), //output clkout0
    .clkout1(clk_p), //output clkout1
    .clkin(clk_p5), //input clkin
    .reset_i(pll_lock) //input reset_i
);

Reset_Sync u_Reset_Sync (
  .resetn(sys_resetn),
  .ext_reset(resetn & pll_lock),
  .clk(clk_p)
);
 
svo_hdmi svo_hdmi_inst_0 (
	.clk(clk_p),
	.resetn(sys_resetn),

	// video clocks
	.clk_pixel(clk_p),
	.clk_5x_pixel(clk_p5),
	.locked(pll_lock),

	// output signals
	.tmds_clk_n(tmds_clk_n_0),
	.tmds_clk_p(tmds_clk_p_0),
	.tmds_d_n(tmds_d_n_0),
	.tmds_d_p(tmds_d_p_0)
);
 
svo_hdmi svo_hdmi_inst_1 (
	.clk(clk_p),
	.resetn(sys_resetn),

	// video clocks
	.clk_pixel(clk_p),
	.clk_5x_pixel(clk_p5),
	.locked(pll_lock),

	// output signals
	.tmds_clk_n(tmds_clk_n_1),
	.tmds_clk_p(tmds_clk_p_1),
	.tmds_d_n(tmds_d_n_1),
	.tmds_d_p(tmds_d_p_1)
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