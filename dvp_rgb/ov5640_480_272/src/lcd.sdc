//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.9 Beta-3
//Created Time: 2023-08-16 14:38:46
create_clock -name clk_24 -period 41.667 -waveform {0 20.834} [get_ports {cmos_pclk}]
create_clock -name clk_50 -period 20 -waveform {0 10} [get_ports {clk}]
//create_clock -name cmos_vsync -period 1000 -waveform {0 500} [get_ports {cmos_vsync}] -add
