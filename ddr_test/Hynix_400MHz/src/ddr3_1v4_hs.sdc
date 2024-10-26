//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.9.03 (64-bit) 
//Created Time: 2024-04-20 22:58:25
//create_clock -name clk100 -period 10 -waveform {0 5} [get_nets {clk50m}]
//create_clock -name clk_x1 -period 20 -waveform {10 20} [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]
//create_clock -name mem400 -period 2.5 -waveform {0 1.25} [get_nets {memory_clk}]
//set_clock_groups -asynchronous -group [get_clocks {clk_x1}] -group [get_clocks {mem400}] 
// -group [get_clocks {clk100}]


create_clock -name clk -period 20 -waveform {0 10} [get_ports {clk}] -add
create_generated_clock -name mem400 -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 8 [get_pins {Gowin_PLL_inst/PLL_inst/CLKOUT2}]
create_generated_clock -name clk_x1 -source [get_pins {Gowin_PLL_inst/PLL_inst/CLKOUT2}] -master_clock mem400 
                       -divide_by 4 -multiply_by 1 [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]

set_clock_groups -asynchronous -group [get_clocks {clk_x1}] -group [get_clocks {mem400}] -group [get_clocks {clk}]

//set_false_path -to [get_pins {u_rd/error_int1_s0/CE u_rd/error_int2_s0/CE}]  -setup
