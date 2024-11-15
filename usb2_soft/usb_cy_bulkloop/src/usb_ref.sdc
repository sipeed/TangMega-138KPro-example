create_clock -name clk_50M -period 20 -waveform {0 10} [get_ports {CLK_IN}]
create_clock -name sclk -period 8 -waveform {0 4} [get_nets {u_USB_SoftPHY_Top/usb2_0_softphy/u_usb_20_phy_utmi/u_usb2_0_softphy/u_usb_phy_hs/sclk}] -add

create_generated_clock -name clk_48M -source [get_ports {CLK_IN}] -master_clock clk_50M -divide_by 50 -multiply_by 48 [get_pins {u_pll_F/PLL_inst/CLKOUT0}]
create_generated_clock -name PHY_CLKOUT -source [get_pins {u_pll_F/PLL_inst/CLKOUT0}] -master_clock clk_48M -divide_by 4 -multiply_by 5 [get_pins {u_pll_B/PLL_inst/CLKOUT1}]
create_generated_clock -name fclk_960M  -source [get_pins {u_pll_F/PLL_inst/CLKOUT0}] -master_clock clk_48M -divide_by 1 -multiply_by 20 [get_pins {u_pll_B/PLL_inst/CLKOUT0}]

set_clock_groups -asynchronous -group [get_clocks {PHY_CLKOUT}] -group [get_clocks {sclk}] -group [get_clocks {fclk_960M}]

