//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.9 Beta-3
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Tue Aug 08 22:39:16 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    gowin_clkdiv your_instance_name(
        .clkout0(clkout0_o), //output clkout0
        .clkout1(clkout1_o), //output clkout1
        .clkin(clkin_i), //input clkin
        .reset_i(reset_i_i) //input reset_i
    );

//--------Copy end-------------------
