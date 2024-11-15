//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Tue Nov 12 02:23:59 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Integer_Division_Top your_instance_name(
		.clk(clk), //input clk
		.rstn(rstn), //input rstn
		.dividend(dividend), //input [31:0] dividend
		.divisor(divisor), //input [31:0] divisor
		.remainder(remainder), //output [2:0] remainder
		.quotient(quotient) //output [31:0] quotient
	);

//--------Copy end-------------------
