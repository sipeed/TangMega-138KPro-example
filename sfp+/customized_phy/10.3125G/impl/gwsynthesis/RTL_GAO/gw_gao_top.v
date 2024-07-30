module gw_gao(
    prbs7_lock_ln0,
    \q1_ln0_prbs7_gen_data[7] ,
    \q1_ln0_prbs7_gen_data[6] ,
    \q1_ln0_prbs7_gen_data[5] ,
    \q1_ln0_prbs7_gen_data[4] ,
    \q1_ln0_prbs7_gen_data[3] ,
    \q1_ln0_prbs7_gen_data[2] ,
    \q1_ln0_prbs7_gen_data[1] ,
    \q1_ln0_prbs7_gen_data[0] ,
    \q1_ln0_prbs7_chk_data[7] ,
    \q1_ln0_prbs7_chk_data[6] ,
    \q1_ln0_prbs7_chk_data[5] ,
    \q1_ln0_prbs7_chk_data[4] ,
    \q1_ln0_prbs7_chk_data[3] ,
    \q1_ln0_prbs7_chk_data[2] ,
    \q1_ln0_prbs7_chk_data[1] ,
    \q1_ln0_prbs7_chk_data[0] ,
    Q1L0_K_LOCK,
    Q1L0_WordAlign_Link,
    Customized_PHY_Top_q1_ln0_signal_detect_o,
    Customized_PHY_Top_q1_ln0_rx_cdr_lock_o,
    Customized_PHY_Top_q1_ln0_pll_lock_o,
    q1_ln0_rx_clk,
    prbs7_lock_ln1,
    \q1_ln1_prbs7_gen_data[7] ,
    \q1_ln1_prbs7_gen_data[6] ,
    \q1_ln1_prbs7_gen_data[5] ,
    \q1_ln1_prbs7_gen_data[4] ,
    \q1_ln1_prbs7_gen_data[3] ,
    \q1_ln1_prbs7_gen_data[2] ,
    \q1_ln1_prbs7_gen_data[1] ,
    \q1_ln1_prbs7_gen_data[0] ,
    \q1_ln1_prbs7_chk_data[7] ,
    \q1_ln1_prbs7_chk_data[6] ,
    \q1_ln1_prbs7_chk_data[5] ,
    \q1_ln1_prbs7_chk_data[4] ,
    \q1_ln1_prbs7_chk_data[3] ,
    \q1_ln1_prbs7_chk_data[2] ,
    \q1_ln1_prbs7_chk_data[1] ,
    \q1_ln1_prbs7_chk_data[0] ,
    Q1L1_K_LOCK,
    Q1L1_WordAlign_Link,
    Customized_PHY_Top_q1_ln1_rx_cdr_lock_o,
    Customized_PHY_Top_q1_ln1_pll_lock_o,
    Customized_PHY_Top_q1_ln1_signal_detect_o,
    q1_ln1_rx_clk,
    q1_ln0_tx_clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input prbs7_lock_ln0;
input \q1_ln0_prbs7_gen_data[7] ;
input \q1_ln0_prbs7_gen_data[6] ;
input \q1_ln0_prbs7_gen_data[5] ;
input \q1_ln0_prbs7_gen_data[4] ;
input \q1_ln0_prbs7_gen_data[3] ;
input \q1_ln0_prbs7_gen_data[2] ;
input \q1_ln0_prbs7_gen_data[1] ;
input \q1_ln0_prbs7_gen_data[0] ;
input \q1_ln0_prbs7_chk_data[7] ;
input \q1_ln0_prbs7_chk_data[6] ;
input \q1_ln0_prbs7_chk_data[5] ;
input \q1_ln0_prbs7_chk_data[4] ;
input \q1_ln0_prbs7_chk_data[3] ;
input \q1_ln0_prbs7_chk_data[2] ;
input \q1_ln0_prbs7_chk_data[1] ;
input \q1_ln0_prbs7_chk_data[0] ;
input Q1L0_K_LOCK;
input Q1L0_WordAlign_Link;
input Customized_PHY_Top_q1_ln0_signal_detect_o;
input Customized_PHY_Top_q1_ln0_rx_cdr_lock_o;
input Customized_PHY_Top_q1_ln0_pll_lock_o;
input q1_ln0_rx_clk;
input prbs7_lock_ln1;
input \q1_ln1_prbs7_gen_data[7] ;
input \q1_ln1_prbs7_gen_data[6] ;
input \q1_ln1_prbs7_gen_data[5] ;
input \q1_ln1_prbs7_gen_data[4] ;
input \q1_ln1_prbs7_gen_data[3] ;
input \q1_ln1_prbs7_gen_data[2] ;
input \q1_ln1_prbs7_gen_data[1] ;
input \q1_ln1_prbs7_gen_data[0] ;
input \q1_ln1_prbs7_chk_data[7] ;
input \q1_ln1_prbs7_chk_data[6] ;
input \q1_ln1_prbs7_chk_data[5] ;
input \q1_ln1_prbs7_chk_data[4] ;
input \q1_ln1_prbs7_chk_data[3] ;
input \q1_ln1_prbs7_chk_data[2] ;
input \q1_ln1_prbs7_chk_data[1] ;
input \q1_ln1_prbs7_chk_data[0] ;
input Q1L1_K_LOCK;
input Q1L1_WordAlign_Link;
input Customized_PHY_Top_q1_ln1_rx_cdr_lock_o;
input Customized_PHY_Top_q1_ln1_pll_lock_o;
input Customized_PHY_Top_q1_ln1_signal_detect_o;
input q1_ln1_rx_clk;
input q1_ln0_tx_clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire prbs7_lock_ln0;
wire \q1_ln0_prbs7_gen_data[7] ;
wire \q1_ln0_prbs7_gen_data[6] ;
wire \q1_ln0_prbs7_gen_data[5] ;
wire \q1_ln0_prbs7_gen_data[4] ;
wire \q1_ln0_prbs7_gen_data[3] ;
wire \q1_ln0_prbs7_gen_data[2] ;
wire \q1_ln0_prbs7_gen_data[1] ;
wire \q1_ln0_prbs7_gen_data[0] ;
wire \q1_ln0_prbs7_chk_data[7] ;
wire \q1_ln0_prbs7_chk_data[6] ;
wire \q1_ln0_prbs7_chk_data[5] ;
wire \q1_ln0_prbs7_chk_data[4] ;
wire \q1_ln0_prbs7_chk_data[3] ;
wire \q1_ln0_prbs7_chk_data[2] ;
wire \q1_ln0_prbs7_chk_data[1] ;
wire \q1_ln0_prbs7_chk_data[0] ;
wire Q1L0_K_LOCK;
wire Q1L0_WordAlign_Link;
wire Customized_PHY_Top_q1_ln0_signal_detect_o;
wire Customized_PHY_Top_q1_ln0_rx_cdr_lock_o;
wire Customized_PHY_Top_q1_ln0_pll_lock_o;
wire q1_ln0_rx_clk;
wire prbs7_lock_ln1;
wire \q1_ln1_prbs7_gen_data[7] ;
wire \q1_ln1_prbs7_gen_data[6] ;
wire \q1_ln1_prbs7_gen_data[5] ;
wire \q1_ln1_prbs7_gen_data[4] ;
wire \q1_ln1_prbs7_gen_data[3] ;
wire \q1_ln1_prbs7_gen_data[2] ;
wire \q1_ln1_prbs7_gen_data[1] ;
wire \q1_ln1_prbs7_gen_data[0] ;
wire \q1_ln1_prbs7_chk_data[7] ;
wire \q1_ln1_prbs7_chk_data[6] ;
wire \q1_ln1_prbs7_chk_data[5] ;
wire \q1_ln1_prbs7_chk_data[4] ;
wire \q1_ln1_prbs7_chk_data[3] ;
wire \q1_ln1_prbs7_chk_data[2] ;
wire \q1_ln1_prbs7_chk_data[1] ;
wire \q1_ln1_prbs7_chk_data[0] ;
wire Q1L1_K_LOCK;
wire Q1L1_WordAlign_Link;
wire Customized_PHY_Top_q1_ln1_rx_cdr_lock_o;
wire Customized_PHY_Top_q1_ln1_pll_lock_o;
wire Customized_PHY_Top_q1_ln1_signal_detect_o;
wire q1_ln1_rx_clk;
wire q1_ln0_tx_clk;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i({prbs7_lock_ln1,prbs7_lock_ln0}),
    .data_i({prbs7_lock_ln0,\q1_ln0_prbs7_gen_data[7] ,\q1_ln0_prbs7_gen_data[6] ,\q1_ln0_prbs7_gen_data[5] ,\q1_ln0_prbs7_gen_data[4] ,\q1_ln0_prbs7_gen_data[3] ,\q1_ln0_prbs7_gen_data[2] ,\q1_ln0_prbs7_gen_data[1] ,\q1_ln0_prbs7_gen_data[0] ,\q1_ln0_prbs7_chk_data[7] ,\q1_ln0_prbs7_chk_data[6] ,\q1_ln0_prbs7_chk_data[5] ,\q1_ln0_prbs7_chk_data[4] ,\q1_ln0_prbs7_chk_data[3] ,\q1_ln0_prbs7_chk_data[2] ,\q1_ln0_prbs7_chk_data[1] ,\q1_ln0_prbs7_chk_data[0] ,Q1L0_K_LOCK,Q1L0_WordAlign_Link,Customized_PHY_Top_q1_ln0_signal_detect_o,Customized_PHY_Top_q1_ln0_rx_cdr_lock_o,Customized_PHY_Top_q1_ln0_pll_lock_o,q1_ln0_rx_clk,prbs7_lock_ln1,\q1_ln1_prbs7_gen_data[7] ,\q1_ln1_prbs7_gen_data[6] ,\q1_ln1_prbs7_gen_data[5] ,\q1_ln1_prbs7_gen_data[4] ,\q1_ln1_prbs7_gen_data[3] ,\q1_ln1_prbs7_gen_data[2] ,\q1_ln1_prbs7_gen_data[1] ,\q1_ln1_prbs7_gen_data[0] ,\q1_ln1_prbs7_chk_data[7] ,\q1_ln1_prbs7_chk_data[6] ,\q1_ln1_prbs7_chk_data[5] ,\q1_ln1_prbs7_chk_data[4] ,\q1_ln1_prbs7_chk_data[3] ,\q1_ln1_prbs7_chk_data[2] ,\q1_ln1_prbs7_chk_data[1] ,\q1_ln1_prbs7_chk_data[0] ,Q1L1_K_LOCK,Q1L1_WordAlign_Link,Customized_PHY_Top_q1_ln1_rx_cdr_lock_o,Customized_PHY_Top_q1_ln1_pll_lock_o,Customized_PHY_Top_q1_ln1_signal_detect_o,q1_ln1_rx_clk}),
    .clk_i(q1_ln0_tx_clk)
);

endmodule
