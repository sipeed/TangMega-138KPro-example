//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Fri May 17 19:32:41 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	DDR3MI your_instance_name(
		.clk(clk), //input clk
		.pll_stop(pll_stop), //output pll_stop
		.memory_clk(memory_clk), //input memory_clk
		.pll_lock(pll_lock), //input pll_lock
		.rst_n(rst_n), //input rst_n
		.clk_out(clk_out), //output clk_out
		.ddr_rst(ddr_rst), //output ddr_rst
		.init_calib_complete(init_calib_complete), //output init_calib_complete
		.cmd_ready(cmd_ready), //output cmd_ready
		.cmd(cmd), //input [2:0] cmd
		.cmd_en(cmd_en), //input cmd_en
		.addr(addr), //input [28:0] addr
		.wr_data_rdy(wr_data_rdy), //output wr_data_rdy
		.wr_data(wr_data), //input [255:0] wr_data
		.wr_data_en(wr_data_en), //input wr_data_en
		.wr_data_end(wr_data_end), //input wr_data_end
		.wr_data_mask(wr_data_mask), //input [31:0] wr_data_mask
		.rd_data(rd_data), //output [255:0] rd_data
		.rd_data_valid(rd_data_valid), //output rd_data_valid
		.rd_data_end(rd_data_end), //output rd_data_end
		.sr_req(sr_req), //input sr_req
		.ref_req(ref_req), //input ref_req
		.sr_ack(sr_ack), //output sr_ack
		.ref_ack(ref_ack), //output ref_ack
		.burst(burst), //input burst
		.O_ddr_addr(O_ddr_addr), //output [14:0] O_ddr_addr
		.O_ddr_ba(O_ddr_ba), //output [2:0] O_ddr_ba
		.O_ddr_cs_n(O_ddr_cs_n), //output O_ddr_cs_n
		.O_ddr_ras_n(O_ddr_ras_n), //output O_ddr_ras_n
		.O_ddr_cas_n(O_ddr_cas_n), //output O_ddr_cas_n
		.O_ddr_we_n(O_ddr_we_n), //output O_ddr_we_n
		.O_ddr_clk(O_ddr_clk), //output O_ddr_clk
		.O_ddr_clk_n(O_ddr_clk_n), //output O_ddr_clk_n
		.O_ddr_cke(O_ddr_cke), //output O_ddr_cke
		.O_ddr_odt(O_ddr_odt), //output O_ddr_odt
		.O_ddr_reset_n(O_ddr_reset_n), //output O_ddr_reset_n
		.O_ddr_dqm(O_ddr_dqm), //output [3:0] O_ddr_dqm
		.IO_ddr_dq(IO_ddr_dq), //inout [31:0] IO_ddr_dq
		.IO_ddr_dqs(IO_ddr_dqs), //inout [3:0] IO_ddr_dqs
		.IO_ddr_dqs_n(IO_ddr_dqs_n) //inout [3:0] IO_ddr_dqs_n
	);

//--------Copy end-------------------
