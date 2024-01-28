module dvi_tx_tmds_phy(
	
	input				pixel_clock,
	input				ddr_bit_clock,
	input				reset,
	input	[9 : 0]		data,
	output	[1 : 0]		tmds_lane
);
	
	reg reset_reg;
	
	wire dq_tmds;
	
	always@(posedge pixel_clock)begin
		if(reset)begin
			reset_reg <= 1'b1;
		end else begin
			reset_reg <= 1'b0;
		end
	end
	
	OSER10 tmds_serdes_inst0 (
		.Q(dq_tmds),
		.D0(data[0]),
		.D1(data[1]),
		.D2(data[2]),
		.D3(data[3]),
		.D4(data[4]),
		.D5(data[5]),
		.D6(data[6]),
		.D7(data[7]),
		.D8(data[8]),
		.D9(data[9]),
		.PCLK(pixel_clock),
		.FCLK(ddr_bit_clock),
		.RESET(reset_reg)
	);
	
	ELVDS_OBUF tmds_bufds_isnt0 (
		.I(dq_tmds),
		.O(tmds_lane[1]),
		.OB(tmds_lane[0])
	);
	
endmodule
