//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW1N-LV2LQ144XC7/I6
//Device: GW1N-2
//Created Time: Sat Nov  9 01:10:28 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Fixed_Point_Divider_Top your_instance_name(
		.dividend(dividend), //input [31:0] dividend
		.divisor(divisor), //input [31:0] divisor
		.start(start), //input start
		.clk(clk), //input clk
		.quotient_out(quotient_out), //output [31:0] quotient_out
		.complete(complete) //output complete
	);

//--------Copy end-------------------
