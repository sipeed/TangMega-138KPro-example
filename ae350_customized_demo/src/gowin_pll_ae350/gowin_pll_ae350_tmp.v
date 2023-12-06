//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Mon Nov 27 08:27:33 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL_AE350 your_instance_name(
        .clkout0(clkout0_o), //output clkout0
        .clkout1(clkout1_o), //output clkout1
        .clkout2(clkout2_o), //output clkout2
        .clkout3(clkout3_o), //output clkout3
        .clkout4(clkout4_o), //output clkout4
        .clkin(clkin_i), //input clkin
        .enclk0(enclk0_i), //input enclk0
        .enclk1(enclk1_i), //input enclk1
        .enclk2(enclk2_i), //input enclk2
        .enclk3(enclk3_i), //input enclk3
        .enclk4(enclk4_i) //input enclk4
    );

//--------Copy end-------------------
