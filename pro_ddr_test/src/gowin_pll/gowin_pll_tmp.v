//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Wed Dec 20 23:53:05 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL your_instance_name(
        .lock(lock_o), //output lock
        .clkout0(clkout0_o), //output clkout0
        .clkout1(clkout1_o), //output clkout1
        .clkout2(clkout2_o), //output clkout2
        .clkin(clkin_i), //input clkin
        .reset(reset_i), //input reset
        .enclk0(enclk0_i), //input enclk0
        .enclk1(enclk1_i), //input enclk1
        .enclk2(enclk2_i) //input enclk2
    );

//--------Copy end-------------------
