//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.9 Beta-2
//Created Time: 2023-07-07 09:23:50
create_clock -name tck_pad_i -period 50 -waveform {0 25} [get_ports {tck_pad_i}]
create_clock -name q1_ln1_rx_clk -period 10 -waveform {0 5} [get_nets {Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o}]
create_clock -name q1_ln1_tx_clk -period 10 -waveform {0 5} [get_nets {Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o}]
set_clock_groups -asynchronous -group [get_clocks {tck_pad_i}] -group [get_clocks {q1_ln1_rx_clk}]
set_clock_groups -asynchronous -group [get_clocks {q1_ln1_rx_clk}] -group [get_clocks {q1_ln1_tx_clk}]
