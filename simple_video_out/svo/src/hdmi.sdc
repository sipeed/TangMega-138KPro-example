//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.9 Beta-3
//Created Time: 2023-08-09 12:10:50
create_clock -name clk_50 -period 20 -waveform {0 10} [get_ports {clk}]
//create_clock -name clk_hdmi -period 7.944 -waveform {0 3.972} [get_ports {Gowin_PLL_inst/clkout1_o}]
