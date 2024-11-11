//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.03 (64-bit) 
//Created Time: 2024-11-11 22:06:09
create_clock -name PHY_CLKOUT -period 16.667 -waveform {0 8.333} [get_pins {u_pll_B/PLL_inst/CLKOUT1}]
create_clock -name sclk -period 8.333 -waveform {0 4.166} [get_nets {u_USB_SoftPHY_Top/usb2_0_softphy/u_usb_20_phy_utmi/u_usb2_0_softphy/u_usb_phy_hs/sclk}] -add
create_generated_clock -name fclk_960M -source [get_nets {PHY_CLKOUT}] -master_clock PHY_CLKOUT -divide_by 1 -multiply_by 16 [get_pins {u_pll_B/PLL_inst/CLKOUT0}]

set_clock_groups -asynchronous -group [get_clocks {PHY_CLKOUT}] -group [get_clocks {fclk_960M}] -group [get_clocks {sclk}]

//set_false_path -from [get_pins {u_UART/u_Integer_Division/integer_division_inst/integer_division_frac_inst/reg_divisor_*_s0/Q}]  -setup
//set_false_path -from [get_pins {u_UART/u_Integer_Division/integer_division_inst/integer_division_frac_inst/reg_dividend_*_s0/Q}]  -setup