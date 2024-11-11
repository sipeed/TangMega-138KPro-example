//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.01 (64-bit)
//Part Number: GW5AT-LV60PG484AC1/I0
//Device: GW5AT-60
//Device Version: B
//Created Time: Fri Oct 25 16:50:50 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL your_instance_name(
        .lock(lock), //output lock
        .clkout0(clkout0), //output clkout0
        .clkin(clkin), //input clkin
        .reset(reset) //input reset
    );

//--------Copy end-------------------
