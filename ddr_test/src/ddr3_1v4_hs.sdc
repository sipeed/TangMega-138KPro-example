//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.9 Beta-3
//Created Time: 2023-08-20 22:58:25
create_clock -name clk100 -period 10 -waveform {0 5} [get_nets {clk50m}]
create_clock -name clk_x1 -period 20 -waveform {10 20} [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]
create_clock -name mem400 -period 2.5 -waveform {0 1.25} [get_nets {memory_clk}]
set_clock_groups -asynchronous -group [get_clocks {clk100}] -group [get_clocks {clk_x1}]
set_clock_groups -asynchronous -group [get_clocks {clk_x1}] -group [get_clocks {mem400}]
