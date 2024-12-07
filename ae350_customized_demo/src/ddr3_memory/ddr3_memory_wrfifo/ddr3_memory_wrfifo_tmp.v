//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Sat Oct 26 20:50:18 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	ddr3_memory_wrfifo your_instance_name(
		.Data(Data), //input [127:0] Data
		.Reset(Reset), //input Reset
		.WrClk(WrClk), //input WrClk
		.RdClk(RdClk), //input RdClk
		.WrEn(WrEn), //input WrEn
		.RdEn(RdEn), //input RdEn
		.Almost_Empty(Almost_Empty), //output Almost_Empty
		.Almost_Full(Almost_Full), //output Almost_Full
		.Q(Q), //output [127:0] Q
		.Empty(Empty), //output Empty
		.Full(Full) //output Full
	);

//--------Copy end-------------------
