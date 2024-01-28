`timescale 1ns / 1ns

module test_pattern_gen #(
	
	parameter video_hlength		= 2200,
	parameter video_vlength		= 1125,
	parameter video_hsync_pol	= 1,
	parameter video_hsync_len	= 44,
	parameter video_hbp_len		= 148,
	
	parameter video_h_visible	= 1920,
	parameter video_vsync_pol	= 1,
	parameter video_vsync_len	= 5,
	parameter video_vbp_len		= 36,
	parameter video_v_visible	= 1080
)
(
	input				pixel_clock,
	input				reset,
	
	output				video_vsync,
	output				video_hsync,
	output				video_den,
	output				video_line_start,
	output	[23 : 0]	video_pixel_even,
	output	[23 : 0]	video_pixel_odd
);
	
	wire	[3 : 0]		pattern_index;
	wire	[23 : 0]	pattern_value;
	
	reg		[23 : 0]	pattern_colours_t [15 : 0];
	
	wire				den_int;
	wire	[13 : 0]	pixel_x;
	wire	[13 : 0]	pixel_y;
	
	initial begin
		pattern_colours_t[0] <= 24'hFF0000;
		pattern_colours_t[1] <= 24'h00FF00;
		pattern_colours_t[2] <= 24'h0000FF;
		pattern_colours_t[3] <= 24'hFFFFFF;
		pattern_colours_t[3] <= 24'hFFFFFF;
		pattern_colours_t[4] <= 24'hAA0000;
		pattern_colours_t[5] <= 24'h00AA00;
		pattern_colours_t[6] <= 24'h0000AA;
		pattern_colours_t[7] <= 24'hAAAAAA;
		pattern_colours_t[8] <= 24'h550000;
		pattern_colours_t[9] <= 24'h005500;
		pattern_colours_t[10] <= 24'h000055;
		pattern_colours_t[11] <= 24'h555555;
		pattern_colours_t[12] <= 24'hFFFF00;
		pattern_colours_t[13] <= 24'hFF00FF;
		pattern_colours_t[14] <= 24'h00FFFF;
		pattern_colours_t[15] <= 24'h000000;
	end
	
	assign pattern_index = pixel_x[7 +: 4];
	assign pattern_value = pattern_colours_t[pattern_index];
	
	assign video_pixel_even = (den_int) ? pattern_value : 24'h000000;
	assign video_pixel_odd = (den_int) ? pattern_value : 24'h000000;
	
	assign video_den = den_int;
	
	video_timing_ctrl #(
		
		.video_hlength(video_hlength),
		.video_vlength(video_vlength),
		
		.video_hsync_pol(video_hsync_pol),
		.video_hsync_len(video_hsync_len),
		.video_hbp_len(video_hbp_len),
		.video_h_visible(video_h_visible),
		
		.video_vsync_pol(video_vsync_pol),
		.video_vsync_len(video_vsync_len),
		.video_vbp_len(video_vbp_len),
		.video_v_visible(video_v_visible)
		
	)video_timing_ctrl_inst0(
		
		.pixel_clock		(pixel_clock),
		.reset				(reset),
		.ext_sync			(1'b0),
		
		.timing_h_pos		(),
		.timing_v_pos		(),
		.pixel_x			(pixel_x),
		.pixel_y			(pixel_y),
		
		.video_vsync		(video_vsync),
		.video_hsync		(video_hsync),
		.video_den			(den_int),
		.video_line_start	(video_line_start)
	);
	
endmodule
