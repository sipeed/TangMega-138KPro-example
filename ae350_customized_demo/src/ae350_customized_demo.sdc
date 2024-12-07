//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.03 (64-bit) 
//Created Time: 2024-10-28 17:59:33
create_clock -name clk50m -period 20 -waveform {0 10} [get_ports {CLK}]
create_clock -name flash_spi_clk_iobuf -period 20 -waveform {0 10} [get_pins {u_RiscV_AE350_SOC_Top/FLASH_SPI_CLK_iobuf/I}]
create_clock -name flash_sysclk -period 20 -waveform {0 10} [get_nets {u_RiscV_AE350_SOC_Top/FLASH_SPI_CLK_in}]
create_generated_clock -name ddr3_sysclk -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_pins {u_gw_ahb_ddr3_top/u_gw_ahb_ddr3/u_DDR3_Memory_Interface_Top/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]
create_generated_clock -name ae350_ddr_clk -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 1 -duty_cycle 50 [get_pins {u_Gowin_PLL_AE350/PLL_inst/CLKOUT0}]
create_generated_clock -name ddr3_memory_clk -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 8 -duty_cycle 50 [get_pins {u_Gowin_PLL_DDR3/PLL_inst/CLKOUT2}]
create_generated_clock -name ae350_ahb_clk -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_pins {u_Gowin_PLL_AE350/PLL_inst/CLKOUT2}]
create_generated_clock -name ddr3_clkin -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 1 -duty_cycle 50 [get_pins {u_Gowin_PLL_DDR3/PLL_inst/CLKOUT0}]
create_generated_clock -name ae350_apb_clk -source [get_ports {CLK}] -master_clock clk50m -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_pins {u_Gowin_PLL_AE350/PLL_inst/CLKOUT3}]
set_clock_groups -exclusive -group [get_clocks {flash_sysclk}] -group [get_clocks {ae350_ahb_clk}] -group [get_clocks {ae350_apb_clk}] -group [get_clocks {ae350_ddr_clk}]
set_clock_groups -asynchronous -group [get_clocks {ddr3_clkin}] -group [get_clocks {ddr3_sysclk}]
set_clock_groups -asynchronous -group [get_clocks {ddr3_sysclk}] -group [get_clocks {ddr3_memory_clk}]
set_clock_groups -exclusive -group [get_clocks {ddr3_memory_clk}] -group [get_clocks {ddr3_clkin}]
set_clock_groups -exclusive -group [get_clocks {clk50m}] -group [get_clocks {ddr3_sysclk}]
set_clock_groups -asynchronous -group [get_clocks {flash_spi_clk_iobuf}] -group [get_clocks {flash_sysclk}]
set_operating_conditions -grade c -model slow -speed 2 -setup -hold
