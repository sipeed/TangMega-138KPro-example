//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Mon Nov 27 08:28:05 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL_DDR3 your_instance_name(
        .lock(lock_o), //output lock
        .clkout0(clkout0_o), //output clkout0
        .clkout2(clkout2_o), //output clkout2
        .clkin(clkin_i), //input clkin
        .reset(reset_i), //input reset
        .enclk0(enclk0_i), //input enclk0
        .enclk2(enclk2_i) //input enclk2
    );

//--------Copy end-------------------
