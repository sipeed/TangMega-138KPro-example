
create_clock -name serdes1_tx_clk -period 6.173 -waveform {0 3.087} [get_nets {Xge_2x/xgmii_serdes/u_SerDes_Top/q1_lane0_fabric_tx_clk}]
create_clock -name serdes1_rx_clk -period 6.173 -waveform {0 3.087} [get_nets {Xge_2x/xgmii_serdes/u_SerDes_Top/q1_lane0_fabric_rx_clk}]

create_clock -name serdes2_tx_clk -period 6.173 -waveform {0 3.087} [get_nets {Xge_2x/xgmii_serdes/u_SerDes_Top/q1_lane1_fabric_tx_clk}]
create_clock -name serdes2_rx_clk -period 6.173 -waveform {0 3.087} [get_nets {Xge_2x/xgmii_serdes/u_SerDes_Top/q1_lane1_fabric_rx_clk}]

create_clock -name tck_pad_i -period 50 -waveform {0 25} [get_nets {tck_pad_i}]

create_clock -name xgmii_clk -period 6.4 -waveform {0 3.2} [get_pins {Xge_2x/Xge_pll/PLL_inst/CLKOUT0}]

set_clock_groups -asynchronous  -group [get_clocks {serdes1_rx_clk}] 
                                -group [get_clocks {serdes1_tx_clk}] 
                                -group [get_clocks {serdes2_rx_clk}] 
                                -group [get_clocks {serdes2_tx_clk}] 
                                -group [get_clocks {xgmii_clk}] 
                                -group [get_clocks {tck_pad_i}]

report_timing -setup -from_clock [get_clocks {serdes1_rx_clk}] -to_clock [get_clocks {serdes1_rx_clk}] -max_paths 50 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {serdes1_tx_clk}] -to_clock [get_clocks {serdes1_tx_clk}] -max_paths 50 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {serdes2_rx_clk}] -to_clock [get_clocks {serdes2_rx_clk}] -max_paths 50 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {serdes2_tx_clk}] -to_clock [get_clocks {serdes2_tx_clk}] -max_paths 50 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {xgmii_clk}] -to_clock [get_clocks {xgmii_clk}] -max_paths 50 -max_common_paths 1
