//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.03 (64-bit) 
//Created Time: 2024-11-04 17:32:26
create_clock -name sys_clk -period 20 -waveform {0 10} [get_ports {sys_clk}]
create_clock -name ms5351_clk -period 40 -waveform {0 20} [get_ports {ms5351_clk}]
create_clock -name osc_clk -period 14.286 -waveform {0 9.804} [get_ports {osc_clk}]
