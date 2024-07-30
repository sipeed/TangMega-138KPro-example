//
//Written by GowinSynthesis
//Tool Version "V1.9.10 (64-bit)"
//Tue Jul 30 00:49:18 2024

//Source file index table:
//file0 "\C:/Gowin/Gowin_V1.9.10_x64/IDE/ipcore/SERDES_IP/IPlib/CUSTOMIZED/data/customized_phy_wrapper.v"
//file1 "\C:/Gowin/Gowin_V1.9.10_x64/IDE/ipcore/SERDES_IP/IPlib/CUSTOMIZED/data/customized_phy.v"
`timescale 100 ps/100 ps
module Customized_PHY_Top (
  Q1_LANE0_PCS_RX_O_FABRIC_CLK,
  Q1_LANE0_FABRIC_RX_CLK,
  Q1_FABRIC_LN0_RXDATA_O,
  Q1_LANE0_RX_IF_FIFO_RDEN,
  Q1_LANE0_RX_IF_FIFO_RDUSEWD,
  Q1_LANE0_RX_IF_FIFO_AEMPTY,
  Q1_LANE0_RX_IF_FIFO_EMPTY,
  Q1_FABRIC_LN0_RX_VLD_OUT,
  Q1_LANE0_PCS_TX_O_FABRIC_CLK,
  Q1_LANE0_FABRIC_TX_CLK,
  Q1_FABRIC_LN0_TXDATA_I,
  Q1_FABRIC_LN0_TX_VLD_IN,
  Q1_LANE0_TX_IF_FIFO_WRUSEWD,
  Q1_LANE0_TX_IF_FIFO_AFULL,
  Q1_LANE0_TX_IF_FIFO_FULL,
  Q1_FABRIC_LN0_STAT_O,
  Q1_LANE0_FABRIC_C2I_CLK,
  Q1_LANE0_CHBOND_START,
  Q1_FABRIC_LN0_RSTN_I,
  Q1_LANE0_PCS_RX_RST,
  Q1_LANE0_PCS_TX_RST,
  Q1_FABRIC_LANE0_CMU_CK_REF_O,
  Q1_FABRIC_LN0_ASTAT_O,
  Q1_FABRIC_LN0_PMA_RX_LOCK_O,
  Q1_LANE0_ALIGN_LINK,
  Q1_LANE0_K_LOCK,
  Q1_FABRIC_LANE0_CMU_OK_O,
  q1_ln0_rx_pcs_clkout_o,
  q1_ln0_rx_clk_i,
  q1_ln0_rx_data_o,
  q1_ln0_rx_fifo_rden_i,
  q1_ln0_rx_fifo_rdusewd_o,
  q1_ln0_rx_fifo_aempty_o,
  q1_ln0_rx_fifo_empty_o,
  q1_ln0_rx_valid_o,
  q1_ln0_tx_pcs_clkout_o,
  q1_ln0_tx_clk_i,
  q1_ln0_tx_data_i,
  q1_ln0_tx_fifo_wren_i,
  q1_ln0_tx_fifo_wrusewd_o,
  q1_ln0_tx_fifo_afull_o,
  q1_ln0_tx_fifo_full_o,
  q1_ln0_ready_o,
  q1_ln0_pma_rstn_i,
  q1_ln0_pcs_rx_rst_i,
  q1_ln0_pcs_tx_rst_i,
  q1_ln0_refclk_o,
  q1_ln0_signal_detect_o,
  q1_ln0_rx_cdr_lock_o,
  q1_ln0_k_lock_o,
  q1_ln0_word_align_link_o,
  q1_ln0_pll_lock_o,
  Q1_LANE1_PCS_RX_O_FABRIC_CLK,
  Q1_LANE1_FABRIC_RX_CLK,
  Q1_FABRIC_LN1_RXDATA_O,
  Q1_LANE1_RX_IF_FIFO_RDEN,
  Q1_LANE1_RX_IF_FIFO_RDUSEWD,
  Q1_LANE1_RX_IF_FIFO_AEMPTY,
  Q1_LANE1_RX_IF_FIFO_EMPTY,
  Q1_FABRIC_LN1_RX_VLD_OUT,
  Q1_LANE1_PCS_TX_O_FABRIC_CLK,
  Q1_LANE1_FABRIC_TX_CLK,
  Q1_FABRIC_LN1_TXDATA_I,
  Q1_FABRIC_LN1_TX_VLD_IN,
  Q1_LANE1_TX_IF_FIFO_WRUSEWD,
  Q1_LANE1_TX_IF_FIFO_AFULL,
  Q1_LANE1_TX_IF_FIFO_FULL,
  Q1_FABRIC_LN1_STAT_O,
  Q1_LANE1_FABRIC_C2I_CLK,
  Q1_LANE1_CHBOND_START,
  Q1_FABRIC_LN1_RSTN_I,
  Q1_LANE1_PCS_RX_RST,
  Q1_LANE1_PCS_TX_RST,
  Q1_FABRIC_LANE1_CMU_CK_REF_O,
  Q1_FABRIC_LN1_ASTAT_O,
  Q1_FABRIC_LN1_PMA_RX_LOCK_O,
  Q1_LANE1_ALIGN_LINK,
  Q1_LANE1_K_LOCK,
  Q1_FABRIC_LANE1_CMU_OK_O,
  q1_ln1_rx_pcs_clkout_o,
  q1_ln1_rx_clk_i,
  q1_ln1_rx_data_o,
  q1_ln1_rx_fifo_rden_i,
  q1_ln1_rx_fifo_rdusewd_o,
  q1_ln1_rx_fifo_aempty_o,
  q1_ln1_rx_fifo_empty_o,
  q1_ln1_rx_valid_o,
  q1_ln1_tx_pcs_clkout_o,
  q1_ln1_tx_clk_i,
  q1_ln1_tx_data_i,
  q1_ln1_tx_fifo_wren_i,
  q1_ln1_tx_fifo_wrusewd_o,
  q1_ln1_tx_fifo_afull_o,
  q1_ln1_tx_fifo_full_o,
  q1_ln1_ready_o,
  q1_ln1_pma_rstn_i,
  q1_ln1_pcs_rx_rst_i,
  q1_ln1_pcs_tx_rst_i,
  q1_ln1_refclk_o,
  q1_ln1_signal_detect_o,
  q1_ln1_rx_cdr_lock_o,
  q1_ln1_k_lock_o,
  q1_ln1_word_align_link_o,
  q1_ln1_pll_lock_o,
  Q0_FABRIC_CMU_CK_REF_O,
  Q0_FABRIC_CMU1_CK_REF_O,
  Q0_FABRIC_CMU1_OK_O,
  Q0_FABRIC_CMU_OK_O,
  Q1_FABRIC_CMU_CK_REF_O,
  Q1_FABRIC_CMU1_CK_REF_O,
  Q1_FABRIC_CMU1_OK_O,
  Q1_FABRIC_CMU_OK_O
)
;
input Q1_LANE0_PCS_RX_O_FABRIC_CLK;
output Q1_LANE0_FABRIC_RX_CLK;
input [87:0] Q1_FABRIC_LN0_RXDATA_O;
output Q1_LANE0_RX_IF_FIFO_RDEN;
input [4:0] Q1_LANE0_RX_IF_FIFO_RDUSEWD;
input Q1_LANE0_RX_IF_FIFO_AEMPTY;
input Q1_LANE0_RX_IF_FIFO_EMPTY;
input Q1_FABRIC_LN0_RX_VLD_OUT;
input Q1_LANE0_PCS_TX_O_FABRIC_CLK;
output Q1_LANE0_FABRIC_TX_CLK;
output [79:0] Q1_FABRIC_LN0_TXDATA_I;
output Q1_FABRIC_LN0_TX_VLD_IN;
input [4:0] Q1_LANE0_TX_IF_FIFO_WRUSEWD;
input Q1_LANE0_TX_IF_FIFO_AFULL;
input Q1_LANE0_TX_IF_FIFO_FULL;
input [12:0] Q1_FABRIC_LN0_STAT_O;
output Q1_LANE0_FABRIC_C2I_CLK;
output Q1_LANE0_CHBOND_START;
output Q1_FABRIC_LN0_RSTN_I;
output Q1_LANE0_PCS_RX_RST;
output Q1_LANE0_PCS_TX_RST;
input Q1_FABRIC_LANE0_CMU_CK_REF_O;
input [5:0] Q1_FABRIC_LN0_ASTAT_O;
input Q1_FABRIC_LN0_PMA_RX_LOCK_O;
input Q1_LANE0_ALIGN_LINK;
input Q1_LANE0_K_LOCK;
input Q1_FABRIC_LANE0_CMU_OK_O;
output q1_ln0_rx_pcs_clkout_o;
input q1_ln0_rx_clk_i;
output [87:0] q1_ln0_rx_data_o;
input q1_ln0_rx_fifo_rden_i;
output [4:0] q1_ln0_rx_fifo_rdusewd_o;
output q1_ln0_rx_fifo_aempty_o;
output q1_ln0_rx_fifo_empty_o;
output q1_ln0_rx_valid_o;
output q1_ln0_tx_pcs_clkout_o;
input q1_ln0_tx_clk_i;
input [79:0] q1_ln0_tx_data_i;
input q1_ln0_tx_fifo_wren_i;
output [4:0] q1_ln0_tx_fifo_wrusewd_o;
output q1_ln0_tx_fifo_afull_o;
output q1_ln0_tx_fifo_full_o;
output q1_ln0_ready_o;
input q1_ln0_pma_rstn_i;
input q1_ln0_pcs_rx_rst_i;
input q1_ln0_pcs_tx_rst_i;
output q1_ln0_refclk_o;
output q1_ln0_signal_detect_o;
output q1_ln0_rx_cdr_lock_o;
output q1_ln0_k_lock_o;
output q1_ln0_word_align_link_o;
output q1_ln0_pll_lock_o;
input Q1_LANE1_PCS_RX_O_FABRIC_CLK;
output Q1_LANE1_FABRIC_RX_CLK;
input [87:0] Q1_FABRIC_LN1_RXDATA_O;
output Q1_LANE1_RX_IF_FIFO_RDEN;
input [4:0] Q1_LANE1_RX_IF_FIFO_RDUSEWD;
input Q1_LANE1_RX_IF_FIFO_AEMPTY;
input Q1_LANE1_RX_IF_FIFO_EMPTY;
input Q1_FABRIC_LN1_RX_VLD_OUT;
input Q1_LANE1_PCS_TX_O_FABRIC_CLK;
output Q1_LANE1_FABRIC_TX_CLK;
output [79:0] Q1_FABRIC_LN1_TXDATA_I;
output Q1_FABRIC_LN1_TX_VLD_IN;
input [4:0] Q1_LANE1_TX_IF_FIFO_WRUSEWD;
input Q1_LANE1_TX_IF_FIFO_AFULL;
input Q1_LANE1_TX_IF_FIFO_FULL;
input [12:0] Q1_FABRIC_LN1_STAT_O;
output Q1_LANE1_FABRIC_C2I_CLK;
output Q1_LANE1_CHBOND_START;
output Q1_FABRIC_LN1_RSTN_I;
output Q1_LANE1_PCS_RX_RST;
output Q1_LANE1_PCS_TX_RST;
input Q1_FABRIC_LANE1_CMU_CK_REF_O;
input [5:0] Q1_FABRIC_LN1_ASTAT_O;
input Q1_FABRIC_LN1_PMA_RX_LOCK_O;
input Q1_LANE1_ALIGN_LINK;
input Q1_LANE1_K_LOCK;
input Q1_FABRIC_LANE1_CMU_OK_O;
output q1_ln1_rx_pcs_clkout_o;
input q1_ln1_rx_clk_i;
output [87:0] q1_ln1_rx_data_o;
input q1_ln1_rx_fifo_rden_i;
output [4:0] q1_ln1_rx_fifo_rdusewd_o;
output q1_ln1_rx_fifo_aempty_o;
output q1_ln1_rx_fifo_empty_o;
output q1_ln1_rx_valid_o;
output q1_ln1_tx_pcs_clkout_o;
input q1_ln1_tx_clk_i;
input [79:0] q1_ln1_tx_data_i;
input q1_ln1_tx_fifo_wren_i;
output [4:0] q1_ln1_tx_fifo_wrusewd_o;
output q1_ln1_tx_fifo_afull_o;
output q1_ln1_tx_fifo_full_o;
output q1_ln1_ready_o;
input q1_ln1_pma_rstn_i;
input q1_ln1_pcs_rx_rst_i;
input q1_ln1_pcs_tx_rst_i;
output q1_ln1_refclk_o;
output q1_ln1_signal_detect_o;
output q1_ln1_rx_cdr_lock_o;
output q1_ln1_k_lock_o;
output q1_ln1_word_align_link_o;
output q1_ln1_pll_lock_o;
input Q0_FABRIC_CMU_CK_REF_O;
input Q0_FABRIC_CMU1_CK_REF_O;
input Q0_FABRIC_CMU1_OK_O;
input Q0_FABRIC_CMU_OK_O;
input Q1_FABRIC_CMU_CK_REF_O;
input Q1_FABRIC_CMU1_CK_REF_O;
input Q1_FABRIC_CMU1_OK_O;
input Q1_FABRIC_CMU_OK_O;
wire VCC;
wire GND;
  VCC VCC_cZ (
    .V(VCC)
);
  GND GND_cZ (
    .G(GND)
);
  GSR GSR (
    .GSRI(VCC) 
);
assign Q1_LANE0_FABRIC_RX_CLK = q1_ln0_rx_clk_i;
assign Q1_LANE0_RX_IF_FIFO_RDEN = q1_ln0_rx_fifo_rden_i;
assign Q1_LANE0_FABRIC_TX_CLK = q1_ln0_tx_clk_i;
assign Q1_FABRIC_LN0_TXDATA_I[0] = q1_ln0_tx_data_i[0];
assign Q1_FABRIC_LN0_TXDATA_I[1] = q1_ln0_tx_data_i[1];
assign Q1_FABRIC_LN0_TXDATA_I[2] = q1_ln0_tx_data_i[2];
assign Q1_FABRIC_LN0_TXDATA_I[3] = q1_ln0_tx_data_i[3];
assign Q1_FABRIC_LN0_TXDATA_I[4] = q1_ln0_tx_data_i[4];
assign Q1_FABRIC_LN0_TXDATA_I[5] = q1_ln0_tx_data_i[5];
assign Q1_FABRIC_LN0_TXDATA_I[6] = q1_ln0_tx_data_i[6];
assign Q1_FABRIC_LN0_TXDATA_I[7] = q1_ln0_tx_data_i[7];
assign Q1_FABRIC_LN0_TXDATA_I[8] = q1_ln0_tx_data_i[8];
assign Q1_FABRIC_LN0_TXDATA_I[9] = q1_ln0_tx_data_i[9];
assign Q1_FABRIC_LN0_TXDATA_I[10] = q1_ln0_tx_data_i[10];
assign Q1_FABRIC_LN0_TXDATA_I[11] = q1_ln0_tx_data_i[11];
assign Q1_FABRIC_LN0_TXDATA_I[12] = q1_ln0_tx_data_i[12];
assign Q1_FABRIC_LN0_TXDATA_I[13] = q1_ln0_tx_data_i[13];
assign Q1_FABRIC_LN0_TXDATA_I[14] = q1_ln0_tx_data_i[14];
assign Q1_FABRIC_LN0_TXDATA_I[15] = q1_ln0_tx_data_i[15];
assign Q1_FABRIC_LN0_TXDATA_I[16] = q1_ln0_tx_data_i[16];
assign Q1_FABRIC_LN0_TXDATA_I[17] = q1_ln0_tx_data_i[17];
assign Q1_FABRIC_LN0_TXDATA_I[18] = q1_ln0_tx_data_i[18];
assign Q1_FABRIC_LN0_TXDATA_I[19] = q1_ln0_tx_data_i[19];
assign Q1_FABRIC_LN0_TXDATA_I[20] = q1_ln0_tx_data_i[20];
assign Q1_FABRIC_LN0_TXDATA_I[21] = q1_ln0_tx_data_i[21];
assign Q1_FABRIC_LN0_TXDATA_I[22] = q1_ln0_tx_data_i[22];
assign Q1_FABRIC_LN0_TXDATA_I[23] = q1_ln0_tx_data_i[23];
assign Q1_FABRIC_LN0_TXDATA_I[24] = q1_ln0_tx_data_i[24];
assign Q1_FABRIC_LN0_TXDATA_I[25] = q1_ln0_tx_data_i[25];
assign Q1_FABRIC_LN0_TXDATA_I[26] = q1_ln0_tx_data_i[26];
assign Q1_FABRIC_LN0_TXDATA_I[27] = q1_ln0_tx_data_i[27];
assign Q1_FABRIC_LN0_TXDATA_I[28] = q1_ln0_tx_data_i[28];
assign Q1_FABRIC_LN0_TXDATA_I[29] = q1_ln0_tx_data_i[29];
assign Q1_FABRIC_LN0_TXDATA_I[30] = q1_ln0_tx_data_i[30];
assign Q1_FABRIC_LN0_TXDATA_I[31] = q1_ln0_tx_data_i[31];
assign Q1_FABRIC_LN0_TXDATA_I[32] = q1_ln0_tx_data_i[32];
assign Q1_FABRIC_LN0_TXDATA_I[33] = q1_ln0_tx_data_i[33];
assign Q1_FABRIC_LN0_TXDATA_I[34] = q1_ln0_tx_data_i[34];
assign Q1_FABRIC_LN0_TXDATA_I[35] = q1_ln0_tx_data_i[35];
assign Q1_FABRIC_LN0_TXDATA_I[36] = q1_ln0_tx_data_i[36];
assign Q1_FABRIC_LN0_TXDATA_I[37] = q1_ln0_tx_data_i[37];
assign Q1_FABRIC_LN0_TXDATA_I[38] = q1_ln0_tx_data_i[38];
assign Q1_FABRIC_LN0_TXDATA_I[39] = q1_ln0_tx_data_i[39];
assign Q1_FABRIC_LN0_TXDATA_I[40] = q1_ln0_tx_data_i[40];
assign Q1_FABRIC_LN0_TXDATA_I[41] = q1_ln0_tx_data_i[41];
assign Q1_FABRIC_LN0_TXDATA_I[42] = q1_ln0_tx_data_i[42];
assign Q1_FABRIC_LN0_TXDATA_I[43] = q1_ln0_tx_data_i[43];
assign Q1_FABRIC_LN0_TXDATA_I[44] = q1_ln0_tx_data_i[44];
assign Q1_FABRIC_LN0_TXDATA_I[45] = q1_ln0_tx_data_i[45];
assign Q1_FABRIC_LN0_TXDATA_I[46] = q1_ln0_tx_data_i[46];
assign Q1_FABRIC_LN0_TXDATA_I[47] = q1_ln0_tx_data_i[47];
assign Q1_FABRIC_LN0_TXDATA_I[48] = q1_ln0_tx_data_i[48];
assign Q1_FABRIC_LN0_TXDATA_I[49] = q1_ln0_tx_data_i[49];
assign Q1_FABRIC_LN0_TXDATA_I[50] = q1_ln0_tx_data_i[50];
assign Q1_FABRIC_LN0_TXDATA_I[51] = q1_ln0_tx_data_i[51];
assign Q1_FABRIC_LN0_TXDATA_I[52] = q1_ln0_tx_data_i[52];
assign Q1_FABRIC_LN0_TXDATA_I[53] = q1_ln0_tx_data_i[53];
assign Q1_FABRIC_LN0_TXDATA_I[54] = q1_ln0_tx_data_i[54];
assign Q1_FABRIC_LN0_TXDATA_I[55] = q1_ln0_tx_data_i[55];
assign Q1_FABRIC_LN0_TXDATA_I[56] = q1_ln0_tx_data_i[56];
assign Q1_FABRIC_LN0_TXDATA_I[57] = q1_ln0_tx_data_i[57];
assign Q1_FABRIC_LN0_TXDATA_I[58] = q1_ln0_tx_data_i[58];
assign Q1_FABRIC_LN0_TXDATA_I[59] = q1_ln0_tx_data_i[59];
assign Q1_FABRIC_LN0_TXDATA_I[60] = q1_ln0_tx_data_i[60];
assign Q1_FABRIC_LN0_TXDATA_I[61] = q1_ln0_tx_data_i[61];
assign Q1_FABRIC_LN0_TXDATA_I[62] = q1_ln0_tx_data_i[62];
assign Q1_FABRIC_LN0_TXDATA_I[63] = q1_ln0_tx_data_i[63];
assign Q1_FABRIC_LN0_TXDATA_I[64] = q1_ln0_tx_data_i[64];
assign Q1_FABRIC_LN0_TXDATA_I[65] = q1_ln0_tx_data_i[65];
assign Q1_FABRIC_LN0_TXDATA_I[66] = q1_ln0_tx_data_i[66];
assign Q1_FABRIC_LN0_TXDATA_I[67] = q1_ln0_tx_data_i[67];
assign Q1_FABRIC_LN0_TXDATA_I[68] = q1_ln0_tx_data_i[68];
assign Q1_FABRIC_LN0_TXDATA_I[69] = q1_ln0_tx_data_i[69];
assign Q1_FABRIC_LN0_TXDATA_I[70] = q1_ln0_tx_data_i[70];
assign Q1_FABRIC_LN0_TXDATA_I[71] = q1_ln0_tx_data_i[71];
assign Q1_FABRIC_LN0_TXDATA_I[72] = q1_ln0_tx_data_i[72];
assign Q1_FABRIC_LN0_TXDATA_I[73] = q1_ln0_tx_data_i[73];
assign Q1_FABRIC_LN0_TXDATA_I[74] = q1_ln0_tx_data_i[74];
assign Q1_FABRIC_LN0_TXDATA_I[75] = q1_ln0_tx_data_i[75];
assign Q1_FABRIC_LN0_TXDATA_I[76] = q1_ln0_tx_data_i[76];
assign Q1_FABRIC_LN0_TXDATA_I[77] = q1_ln0_tx_data_i[77];
assign Q1_FABRIC_LN0_TXDATA_I[78] = q1_ln0_tx_data_i[78];
assign Q1_FABRIC_LN0_TXDATA_I[79] = q1_ln0_tx_data_i[79];
assign Q1_FABRIC_LN0_TX_VLD_IN = q1_ln0_tx_fifo_wren_i;
assign Q1_LANE0_FABRIC_C2I_CLK = GND;
assign Q1_LANE0_CHBOND_START = GND;
assign Q1_FABRIC_LN0_RSTN_I = q1_ln0_pma_rstn_i;
assign Q1_LANE0_PCS_RX_RST = q1_ln0_pcs_rx_rst_i;
assign Q1_LANE0_PCS_TX_RST = q1_ln0_pcs_tx_rst_i;
assign q1_ln0_rx_pcs_clkout_o = Q1_LANE0_PCS_RX_O_FABRIC_CLK;
assign q1_ln0_rx_data_o[0] = Q1_FABRIC_LN0_RXDATA_O[0];
assign q1_ln0_rx_data_o[1] = Q1_FABRIC_LN0_RXDATA_O[1];
assign q1_ln0_rx_data_o[2] = Q1_FABRIC_LN0_RXDATA_O[2];
assign q1_ln0_rx_data_o[3] = Q1_FABRIC_LN0_RXDATA_O[3];
assign q1_ln0_rx_data_o[4] = Q1_FABRIC_LN0_RXDATA_O[4];
assign q1_ln0_rx_data_o[5] = Q1_FABRIC_LN0_RXDATA_O[5];
assign q1_ln0_rx_data_o[6] = Q1_FABRIC_LN0_RXDATA_O[6];
assign q1_ln0_rx_data_o[7] = Q1_FABRIC_LN0_RXDATA_O[7];
assign q1_ln0_rx_data_o[8] = Q1_FABRIC_LN0_RXDATA_O[8];
assign q1_ln0_rx_data_o[9] = Q1_FABRIC_LN0_RXDATA_O[9];
assign q1_ln0_rx_data_o[10] = Q1_FABRIC_LN0_RXDATA_O[10];
assign q1_ln0_rx_data_o[11] = Q1_FABRIC_LN0_RXDATA_O[11];
assign q1_ln0_rx_data_o[12] = Q1_FABRIC_LN0_RXDATA_O[12];
assign q1_ln0_rx_data_o[13] = Q1_FABRIC_LN0_RXDATA_O[13];
assign q1_ln0_rx_data_o[14] = Q1_FABRIC_LN0_RXDATA_O[14];
assign q1_ln0_rx_data_o[15] = Q1_FABRIC_LN0_RXDATA_O[15];
assign q1_ln0_rx_data_o[16] = Q1_FABRIC_LN0_RXDATA_O[16];
assign q1_ln0_rx_data_o[17] = Q1_FABRIC_LN0_RXDATA_O[17];
assign q1_ln0_rx_data_o[18] = Q1_FABRIC_LN0_RXDATA_O[18];
assign q1_ln0_rx_data_o[19] = Q1_FABRIC_LN0_RXDATA_O[19];
assign q1_ln0_rx_data_o[20] = Q1_FABRIC_LN0_RXDATA_O[20];
assign q1_ln0_rx_data_o[21] = Q1_FABRIC_LN0_RXDATA_O[21];
assign q1_ln0_rx_data_o[22] = Q1_FABRIC_LN0_RXDATA_O[22];
assign q1_ln0_rx_data_o[23] = Q1_FABRIC_LN0_RXDATA_O[23];
assign q1_ln0_rx_data_o[24] = Q1_FABRIC_LN0_RXDATA_O[24];
assign q1_ln0_rx_data_o[25] = Q1_FABRIC_LN0_RXDATA_O[25];
assign q1_ln0_rx_data_o[26] = Q1_FABRIC_LN0_RXDATA_O[26];
assign q1_ln0_rx_data_o[27] = Q1_FABRIC_LN0_RXDATA_O[27];
assign q1_ln0_rx_data_o[28] = Q1_FABRIC_LN0_RXDATA_O[28];
assign q1_ln0_rx_data_o[29] = Q1_FABRIC_LN0_RXDATA_O[29];
assign q1_ln0_rx_data_o[30] = Q1_FABRIC_LN0_RXDATA_O[30];
assign q1_ln0_rx_data_o[31] = Q1_FABRIC_LN0_RXDATA_O[31];
assign q1_ln0_rx_data_o[32] = Q1_FABRIC_LN0_RXDATA_O[32];
assign q1_ln0_rx_data_o[33] = Q1_FABRIC_LN0_RXDATA_O[33];
assign q1_ln0_rx_data_o[34] = Q1_FABRIC_LN0_RXDATA_O[34];
assign q1_ln0_rx_data_o[35] = Q1_FABRIC_LN0_RXDATA_O[35];
assign q1_ln0_rx_data_o[36] = Q1_FABRIC_LN0_RXDATA_O[36];
assign q1_ln0_rx_data_o[37] = Q1_FABRIC_LN0_RXDATA_O[37];
assign q1_ln0_rx_data_o[38] = Q1_FABRIC_LN0_RXDATA_O[38];
assign q1_ln0_rx_data_o[39] = Q1_FABRIC_LN0_RXDATA_O[39];
assign q1_ln0_rx_data_o[40] = Q1_FABRIC_LN0_RXDATA_O[40];
assign q1_ln0_rx_data_o[41] = Q1_FABRIC_LN0_RXDATA_O[41];
assign q1_ln0_rx_data_o[42] = Q1_FABRIC_LN0_RXDATA_O[42];
assign q1_ln0_rx_data_o[43] = Q1_FABRIC_LN0_RXDATA_O[43];
assign q1_ln0_rx_data_o[44] = Q1_FABRIC_LN0_RXDATA_O[44];
assign q1_ln0_rx_data_o[45] = Q1_FABRIC_LN0_RXDATA_O[45];
assign q1_ln0_rx_data_o[46] = Q1_FABRIC_LN0_RXDATA_O[46];
assign q1_ln0_rx_data_o[47] = Q1_FABRIC_LN0_RXDATA_O[47];
assign q1_ln0_rx_data_o[48] = Q1_FABRIC_LN0_RXDATA_O[48];
assign q1_ln0_rx_data_o[49] = Q1_FABRIC_LN0_RXDATA_O[49];
assign q1_ln0_rx_data_o[50] = Q1_FABRIC_LN0_RXDATA_O[50];
assign q1_ln0_rx_data_o[51] = Q1_FABRIC_LN0_RXDATA_O[51];
assign q1_ln0_rx_data_o[52] = Q1_FABRIC_LN0_RXDATA_O[52];
assign q1_ln0_rx_data_o[53] = Q1_FABRIC_LN0_RXDATA_O[53];
assign q1_ln0_rx_data_o[54] = Q1_FABRIC_LN0_RXDATA_O[54];
assign q1_ln0_rx_data_o[55] = Q1_FABRIC_LN0_RXDATA_O[55];
assign q1_ln0_rx_data_o[56] = Q1_FABRIC_LN0_RXDATA_O[56];
assign q1_ln0_rx_data_o[57] = Q1_FABRIC_LN0_RXDATA_O[57];
assign q1_ln0_rx_data_o[58] = Q1_FABRIC_LN0_RXDATA_O[58];
assign q1_ln0_rx_data_o[59] = Q1_FABRIC_LN0_RXDATA_O[59];
assign q1_ln0_rx_data_o[60] = Q1_FABRIC_LN0_RXDATA_O[60];
assign q1_ln0_rx_data_o[61] = Q1_FABRIC_LN0_RXDATA_O[61];
assign q1_ln0_rx_data_o[62] = Q1_FABRIC_LN0_RXDATA_O[62];
assign q1_ln0_rx_data_o[63] = Q1_FABRIC_LN0_RXDATA_O[63];
assign q1_ln0_rx_data_o[64] = Q1_FABRIC_LN0_RXDATA_O[64];
assign q1_ln0_rx_data_o[65] = Q1_FABRIC_LN0_RXDATA_O[65];
assign q1_ln0_rx_data_o[66] = Q1_FABRIC_LN0_RXDATA_O[66];
assign q1_ln0_rx_data_o[67] = Q1_FABRIC_LN0_RXDATA_O[67];
assign q1_ln0_rx_data_o[68] = Q1_FABRIC_LN0_RXDATA_O[68];
assign q1_ln0_rx_data_o[69] = Q1_FABRIC_LN0_RXDATA_O[69];
assign q1_ln0_rx_data_o[70] = Q1_FABRIC_LN0_RXDATA_O[70];
assign q1_ln0_rx_data_o[71] = Q1_FABRIC_LN0_RXDATA_O[71];
assign q1_ln0_rx_data_o[72] = Q1_FABRIC_LN0_RXDATA_O[72];
assign q1_ln0_rx_data_o[73] = Q1_FABRIC_LN0_RXDATA_O[73];
assign q1_ln0_rx_data_o[74] = Q1_FABRIC_LN0_RXDATA_O[74];
assign q1_ln0_rx_data_o[75] = Q1_FABRIC_LN0_RXDATA_O[75];
assign q1_ln0_rx_data_o[76] = Q1_FABRIC_LN0_RXDATA_O[76];
assign q1_ln0_rx_data_o[77] = Q1_FABRIC_LN0_RXDATA_O[77];
assign q1_ln0_rx_data_o[78] = Q1_FABRIC_LN0_RXDATA_O[78];
assign q1_ln0_rx_data_o[79] = Q1_FABRIC_LN0_RXDATA_O[79];
assign q1_ln0_rx_data_o[80] = Q1_FABRIC_LN0_RXDATA_O[80];
assign q1_ln0_rx_data_o[81] = Q1_FABRIC_LN0_RXDATA_O[81];
assign q1_ln0_rx_data_o[82] = Q1_FABRIC_LN0_RXDATA_O[82];
assign q1_ln0_rx_data_o[83] = Q1_FABRIC_LN0_RXDATA_O[83];
assign q1_ln0_rx_data_o[84] = Q1_FABRIC_LN0_RXDATA_O[84];
assign q1_ln0_rx_data_o[85] = Q1_FABRIC_LN0_RXDATA_O[85];
assign q1_ln0_rx_data_o[86] = Q1_FABRIC_LN0_RXDATA_O[86];
assign q1_ln0_rx_data_o[87] = Q1_FABRIC_LN0_RXDATA_O[87];
assign q1_ln0_rx_fifo_rdusewd_o[0] = Q1_LANE0_RX_IF_FIFO_RDUSEWD[0];
assign q1_ln0_rx_fifo_rdusewd_o[1] = Q1_LANE0_RX_IF_FIFO_RDUSEWD[1];
assign q1_ln0_rx_fifo_rdusewd_o[2] = Q1_LANE0_RX_IF_FIFO_RDUSEWD[2];
assign q1_ln0_rx_fifo_rdusewd_o[3] = Q1_LANE0_RX_IF_FIFO_RDUSEWD[3];
assign q1_ln0_rx_fifo_rdusewd_o[4] = Q1_LANE0_RX_IF_FIFO_RDUSEWD[4];
assign q1_ln0_rx_fifo_aempty_o = Q1_LANE0_RX_IF_FIFO_AEMPTY;
assign q1_ln0_rx_fifo_empty_o = Q1_LANE0_RX_IF_FIFO_EMPTY;
assign q1_ln0_rx_valid_o = Q1_FABRIC_LN0_RX_VLD_OUT;
assign q1_ln0_tx_pcs_clkout_o = Q1_LANE0_PCS_TX_O_FABRIC_CLK;
assign q1_ln0_tx_fifo_wrusewd_o[0] = Q1_LANE0_TX_IF_FIFO_WRUSEWD[0];
assign q1_ln0_tx_fifo_wrusewd_o[1] = Q1_LANE0_TX_IF_FIFO_WRUSEWD[1];
assign q1_ln0_tx_fifo_wrusewd_o[2] = Q1_LANE0_TX_IF_FIFO_WRUSEWD[2];
assign q1_ln0_tx_fifo_wrusewd_o[3] = Q1_LANE0_TX_IF_FIFO_WRUSEWD[3];
assign q1_ln0_tx_fifo_wrusewd_o[4] = Q1_LANE0_TX_IF_FIFO_WRUSEWD[4];
assign q1_ln0_tx_fifo_afull_o = Q1_LANE0_TX_IF_FIFO_AFULL;
assign q1_ln0_tx_fifo_full_o = Q1_LANE0_TX_IF_FIFO_FULL;
assign q1_ln0_ready_o = Q1_FABRIC_LN0_STAT_O[12];
assign q1_ln0_refclk_o = Q1_FABRIC_CMU_CK_REF_O;
assign q1_ln0_signal_detect_o = Q1_FABRIC_LN0_ASTAT_O[5];
assign q1_ln0_rx_cdr_lock_o = Q1_FABRIC_LN0_PMA_RX_LOCK_O;
assign q1_ln0_k_lock_o = Q1_LANE0_K_LOCK;
assign q1_ln0_word_align_link_o = Q1_LANE0_ALIGN_LINK;
assign q1_ln0_pll_lock_o = Q1_FABRIC_CMU_OK_O;
assign Q1_LANE1_FABRIC_RX_CLK = q1_ln1_rx_clk_i;
assign Q1_LANE1_RX_IF_FIFO_RDEN = q1_ln1_rx_fifo_rden_i;
assign Q1_LANE1_FABRIC_TX_CLK = q1_ln1_tx_clk_i;
assign Q1_FABRIC_LN1_TXDATA_I[0] = q1_ln1_tx_data_i[0];
assign Q1_FABRIC_LN1_TXDATA_I[1] = q1_ln1_tx_data_i[1];
assign Q1_FABRIC_LN1_TXDATA_I[2] = q1_ln1_tx_data_i[2];
assign Q1_FABRIC_LN1_TXDATA_I[3] = q1_ln1_tx_data_i[3];
assign Q1_FABRIC_LN1_TXDATA_I[4] = q1_ln1_tx_data_i[4];
assign Q1_FABRIC_LN1_TXDATA_I[5] = q1_ln1_tx_data_i[5];
assign Q1_FABRIC_LN1_TXDATA_I[6] = q1_ln1_tx_data_i[6];
assign Q1_FABRIC_LN1_TXDATA_I[7] = q1_ln1_tx_data_i[7];
assign Q1_FABRIC_LN1_TXDATA_I[8] = q1_ln1_tx_data_i[8];
assign Q1_FABRIC_LN1_TXDATA_I[9] = q1_ln1_tx_data_i[9];
assign Q1_FABRIC_LN1_TXDATA_I[10] = q1_ln1_tx_data_i[10];
assign Q1_FABRIC_LN1_TXDATA_I[11] = q1_ln1_tx_data_i[11];
assign Q1_FABRIC_LN1_TXDATA_I[12] = q1_ln1_tx_data_i[12];
assign Q1_FABRIC_LN1_TXDATA_I[13] = q1_ln1_tx_data_i[13];
assign Q1_FABRIC_LN1_TXDATA_I[14] = q1_ln1_tx_data_i[14];
assign Q1_FABRIC_LN1_TXDATA_I[15] = q1_ln1_tx_data_i[15];
assign Q1_FABRIC_LN1_TXDATA_I[16] = q1_ln1_tx_data_i[16];
assign Q1_FABRIC_LN1_TXDATA_I[17] = q1_ln1_tx_data_i[17];
assign Q1_FABRIC_LN1_TXDATA_I[18] = q1_ln1_tx_data_i[18];
assign Q1_FABRIC_LN1_TXDATA_I[19] = q1_ln1_tx_data_i[19];
assign Q1_FABRIC_LN1_TXDATA_I[20] = q1_ln1_tx_data_i[20];
assign Q1_FABRIC_LN1_TXDATA_I[21] = q1_ln1_tx_data_i[21];
assign Q1_FABRIC_LN1_TXDATA_I[22] = q1_ln1_tx_data_i[22];
assign Q1_FABRIC_LN1_TXDATA_I[23] = q1_ln1_tx_data_i[23];
assign Q1_FABRIC_LN1_TXDATA_I[24] = q1_ln1_tx_data_i[24];
assign Q1_FABRIC_LN1_TXDATA_I[25] = q1_ln1_tx_data_i[25];
assign Q1_FABRIC_LN1_TXDATA_I[26] = q1_ln1_tx_data_i[26];
assign Q1_FABRIC_LN1_TXDATA_I[27] = q1_ln1_tx_data_i[27];
assign Q1_FABRIC_LN1_TXDATA_I[28] = q1_ln1_tx_data_i[28];
assign Q1_FABRIC_LN1_TXDATA_I[29] = q1_ln1_tx_data_i[29];
assign Q1_FABRIC_LN1_TXDATA_I[30] = q1_ln1_tx_data_i[30];
assign Q1_FABRIC_LN1_TXDATA_I[31] = q1_ln1_tx_data_i[31];
assign Q1_FABRIC_LN1_TXDATA_I[32] = q1_ln1_tx_data_i[32];
assign Q1_FABRIC_LN1_TXDATA_I[33] = q1_ln1_tx_data_i[33];
assign Q1_FABRIC_LN1_TXDATA_I[34] = q1_ln1_tx_data_i[34];
assign Q1_FABRIC_LN1_TXDATA_I[35] = q1_ln1_tx_data_i[35];
assign Q1_FABRIC_LN1_TXDATA_I[36] = q1_ln1_tx_data_i[36];
assign Q1_FABRIC_LN1_TXDATA_I[37] = q1_ln1_tx_data_i[37];
assign Q1_FABRIC_LN1_TXDATA_I[38] = q1_ln1_tx_data_i[38];
assign Q1_FABRIC_LN1_TXDATA_I[39] = q1_ln1_tx_data_i[39];
assign Q1_FABRIC_LN1_TXDATA_I[40] = q1_ln1_tx_data_i[40];
assign Q1_FABRIC_LN1_TXDATA_I[41] = q1_ln1_tx_data_i[41];
assign Q1_FABRIC_LN1_TXDATA_I[42] = q1_ln1_tx_data_i[42];
assign Q1_FABRIC_LN1_TXDATA_I[43] = q1_ln1_tx_data_i[43];
assign Q1_FABRIC_LN1_TXDATA_I[44] = q1_ln1_tx_data_i[44];
assign Q1_FABRIC_LN1_TXDATA_I[45] = q1_ln1_tx_data_i[45];
assign Q1_FABRIC_LN1_TXDATA_I[46] = q1_ln1_tx_data_i[46];
assign Q1_FABRIC_LN1_TXDATA_I[47] = q1_ln1_tx_data_i[47];
assign Q1_FABRIC_LN1_TXDATA_I[48] = q1_ln1_tx_data_i[48];
assign Q1_FABRIC_LN1_TXDATA_I[49] = q1_ln1_tx_data_i[49];
assign Q1_FABRIC_LN1_TXDATA_I[50] = q1_ln1_tx_data_i[50];
assign Q1_FABRIC_LN1_TXDATA_I[51] = q1_ln1_tx_data_i[51];
assign Q1_FABRIC_LN1_TXDATA_I[52] = q1_ln1_tx_data_i[52];
assign Q1_FABRIC_LN1_TXDATA_I[53] = q1_ln1_tx_data_i[53];
assign Q1_FABRIC_LN1_TXDATA_I[54] = q1_ln1_tx_data_i[54];
assign Q1_FABRIC_LN1_TXDATA_I[55] = q1_ln1_tx_data_i[55];
assign Q1_FABRIC_LN1_TXDATA_I[56] = q1_ln1_tx_data_i[56];
assign Q1_FABRIC_LN1_TXDATA_I[57] = q1_ln1_tx_data_i[57];
assign Q1_FABRIC_LN1_TXDATA_I[58] = q1_ln1_tx_data_i[58];
assign Q1_FABRIC_LN1_TXDATA_I[59] = q1_ln1_tx_data_i[59];
assign Q1_FABRIC_LN1_TXDATA_I[60] = q1_ln1_tx_data_i[60];
assign Q1_FABRIC_LN1_TXDATA_I[61] = q1_ln1_tx_data_i[61];
assign Q1_FABRIC_LN1_TXDATA_I[62] = q1_ln1_tx_data_i[62];
assign Q1_FABRIC_LN1_TXDATA_I[63] = q1_ln1_tx_data_i[63];
assign Q1_FABRIC_LN1_TXDATA_I[64] = q1_ln1_tx_data_i[64];
assign Q1_FABRIC_LN1_TXDATA_I[65] = q1_ln1_tx_data_i[65];
assign Q1_FABRIC_LN1_TXDATA_I[66] = q1_ln1_tx_data_i[66];
assign Q1_FABRIC_LN1_TXDATA_I[67] = q1_ln1_tx_data_i[67];
assign Q1_FABRIC_LN1_TXDATA_I[68] = q1_ln1_tx_data_i[68];
assign Q1_FABRIC_LN1_TXDATA_I[69] = q1_ln1_tx_data_i[69];
assign Q1_FABRIC_LN1_TXDATA_I[70] = q1_ln1_tx_data_i[70];
assign Q1_FABRIC_LN1_TXDATA_I[71] = q1_ln1_tx_data_i[71];
assign Q1_FABRIC_LN1_TXDATA_I[72] = q1_ln1_tx_data_i[72];
assign Q1_FABRIC_LN1_TXDATA_I[73] = q1_ln1_tx_data_i[73];
assign Q1_FABRIC_LN1_TXDATA_I[74] = q1_ln1_tx_data_i[74];
assign Q1_FABRIC_LN1_TXDATA_I[75] = q1_ln1_tx_data_i[75];
assign Q1_FABRIC_LN1_TXDATA_I[76] = q1_ln1_tx_data_i[76];
assign Q1_FABRIC_LN1_TXDATA_I[77] = q1_ln1_tx_data_i[77];
assign Q1_FABRIC_LN1_TXDATA_I[78] = q1_ln1_tx_data_i[78];
assign Q1_FABRIC_LN1_TXDATA_I[79] = q1_ln1_tx_data_i[79];
assign Q1_FABRIC_LN1_TX_VLD_IN = q1_ln1_tx_fifo_wren_i;
assign Q1_LANE1_FABRIC_C2I_CLK = GND;
assign Q1_LANE1_CHBOND_START = GND;
assign Q1_FABRIC_LN1_RSTN_I = q1_ln1_pma_rstn_i;
assign Q1_LANE1_PCS_RX_RST = q1_ln1_pcs_rx_rst_i;
assign Q1_LANE1_PCS_TX_RST = q1_ln1_pcs_tx_rst_i;
assign q1_ln1_rx_pcs_clkout_o = Q1_LANE1_PCS_RX_O_FABRIC_CLK;
assign q1_ln1_rx_data_o[0] = Q1_FABRIC_LN1_RXDATA_O[0];
assign q1_ln1_rx_data_o[1] = Q1_FABRIC_LN1_RXDATA_O[1];
assign q1_ln1_rx_data_o[2] = Q1_FABRIC_LN1_RXDATA_O[2];
assign q1_ln1_rx_data_o[3] = Q1_FABRIC_LN1_RXDATA_O[3];
assign q1_ln1_rx_data_o[4] = Q1_FABRIC_LN1_RXDATA_O[4];
assign q1_ln1_rx_data_o[5] = Q1_FABRIC_LN1_RXDATA_O[5];
assign q1_ln1_rx_data_o[6] = Q1_FABRIC_LN1_RXDATA_O[6];
assign q1_ln1_rx_data_o[7] = Q1_FABRIC_LN1_RXDATA_O[7];
assign q1_ln1_rx_data_o[8] = Q1_FABRIC_LN1_RXDATA_O[8];
assign q1_ln1_rx_data_o[9] = Q1_FABRIC_LN1_RXDATA_O[9];
assign q1_ln1_rx_data_o[10] = Q1_FABRIC_LN1_RXDATA_O[10];
assign q1_ln1_rx_data_o[11] = Q1_FABRIC_LN1_RXDATA_O[11];
assign q1_ln1_rx_data_o[12] = Q1_FABRIC_LN1_RXDATA_O[12];
assign q1_ln1_rx_data_o[13] = Q1_FABRIC_LN1_RXDATA_O[13];
assign q1_ln1_rx_data_o[14] = Q1_FABRIC_LN1_RXDATA_O[14];
assign q1_ln1_rx_data_o[15] = Q1_FABRIC_LN1_RXDATA_O[15];
assign q1_ln1_rx_data_o[16] = Q1_FABRIC_LN1_RXDATA_O[16];
assign q1_ln1_rx_data_o[17] = Q1_FABRIC_LN1_RXDATA_O[17];
assign q1_ln1_rx_data_o[18] = Q1_FABRIC_LN1_RXDATA_O[18];
assign q1_ln1_rx_data_o[19] = Q1_FABRIC_LN1_RXDATA_O[19];
assign q1_ln1_rx_data_o[20] = Q1_FABRIC_LN1_RXDATA_O[20];
assign q1_ln1_rx_data_o[21] = Q1_FABRIC_LN1_RXDATA_O[21];
assign q1_ln1_rx_data_o[22] = Q1_FABRIC_LN1_RXDATA_O[22];
assign q1_ln1_rx_data_o[23] = Q1_FABRIC_LN1_RXDATA_O[23];
assign q1_ln1_rx_data_o[24] = Q1_FABRIC_LN1_RXDATA_O[24];
assign q1_ln1_rx_data_o[25] = Q1_FABRIC_LN1_RXDATA_O[25];
assign q1_ln1_rx_data_o[26] = Q1_FABRIC_LN1_RXDATA_O[26];
assign q1_ln1_rx_data_o[27] = Q1_FABRIC_LN1_RXDATA_O[27];
assign q1_ln1_rx_data_o[28] = Q1_FABRIC_LN1_RXDATA_O[28];
assign q1_ln1_rx_data_o[29] = Q1_FABRIC_LN1_RXDATA_O[29];
assign q1_ln1_rx_data_o[30] = Q1_FABRIC_LN1_RXDATA_O[30];
assign q1_ln1_rx_data_o[31] = Q1_FABRIC_LN1_RXDATA_O[31];
assign q1_ln1_rx_data_o[32] = Q1_FABRIC_LN1_RXDATA_O[32];
assign q1_ln1_rx_data_o[33] = Q1_FABRIC_LN1_RXDATA_O[33];
assign q1_ln1_rx_data_o[34] = Q1_FABRIC_LN1_RXDATA_O[34];
assign q1_ln1_rx_data_o[35] = Q1_FABRIC_LN1_RXDATA_O[35];
assign q1_ln1_rx_data_o[36] = Q1_FABRIC_LN1_RXDATA_O[36];
assign q1_ln1_rx_data_o[37] = Q1_FABRIC_LN1_RXDATA_O[37];
assign q1_ln1_rx_data_o[38] = Q1_FABRIC_LN1_RXDATA_O[38];
assign q1_ln1_rx_data_o[39] = Q1_FABRIC_LN1_RXDATA_O[39];
assign q1_ln1_rx_data_o[40] = Q1_FABRIC_LN1_RXDATA_O[40];
assign q1_ln1_rx_data_o[41] = Q1_FABRIC_LN1_RXDATA_O[41];
assign q1_ln1_rx_data_o[42] = Q1_FABRIC_LN1_RXDATA_O[42];
assign q1_ln1_rx_data_o[43] = Q1_FABRIC_LN1_RXDATA_O[43];
assign q1_ln1_rx_data_o[44] = Q1_FABRIC_LN1_RXDATA_O[44];
assign q1_ln1_rx_data_o[45] = Q1_FABRIC_LN1_RXDATA_O[45];
assign q1_ln1_rx_data_o[46] = Q1_FABRIC_LN1_RXDATA_O[46];
assign q1_ln1_rx_data_o[47] = Q1_FABRIC_LN1_RXDATA_O[47];
assign q1_ln1_rx_data_o[48] = Q1_FABRIC_LN1_RXDATA_O[48];
assign q1_ln1_rx_data_o[49] = Q1_FABRIC_LN1_RXDATA_O[49];
assign q1_ln1_rx_data_o[50] = Q1_FABRIC_LN1_RXDATA_O[50];
assign q1_ln1_rx_data_o[51] = Q1_FABRIC_LN1_RXDATA_O[51];
assign q1_ln1_rx_data_o[52] = Q1_FABRIC_LN1_RXDATA_O[52];
assign q1_ln1_rx_data_o[53] = Q1_FABRIC_LN1_RXDATA_O[53];
assign q1_ln1_rx_data_o[54] = Q1_FABRIC_LN1_RXDATA_O[54];
assign q1_ln1_rx_data_o[55] = Q1_FABRIC_LN1_RXDATA_O[55];
assign q1_ln1_rx_data_o[56] = Q1_FABRIC_LN1_RXDATA_O[56];
assign q1_ln1_rx_data_o[57] = Q1_FABRIC_LN1_RXDATA_O[57];
assign q1_ln1_rx_data_o[58] = Q1_FABRIC_LN1_RXDATA_O[58];
assign q1_ln1_rx_data_o[59] = Q1_FABRIC_LN1_RXDATA_O[59];
assign q1_ln1_rx_data_o[60] = Q1_FABRIC_LN1_RXDATA_O[60];
assign q1_ln1_rx_data_o[61] = Q1_FABRIC_LN1_RXDATA_O[61];
assign q1_ln1_rx_data_o[62] = Q1_FABRIC_LN1_RXDATA_O[62];
assign q1_ln1_rx_data_o[63] = Q1_FABRIC_LN1_RXDATA_O[63];
assign q1_ln1_rx_data_o[64] = Q1_FABRIC_LN1_RXDATA_O[64];
assign q1_ln1_rx_data_o[65] = Q1_FABRIC_LN1_RXDATA_O[65];
assign q1_ln1_rx_data_o[66] = Q1_FABRIC_LN1_RXDATA_O[66];
assign q1_ln1_rx_data_o[67] = Q1_FABRIC_LN1_RXDATA_O[67];
assign q1_ln1_rx_data_o[68] = Q1_FABRIC_LN1_RXDATA_O[68];
assign q1_ln1_rx_data_o[69] = Q1_FABRIC_LN1_RXDATA_O[69];
assign q1_ln1_rx_data_o[70] = Q1_FABRIC_LN1_RXDATA_O[70];
assign q1_ln1_rx_data_o[71] = Q1_FABRIC_LN1_RXDATA_O[71];
assign q1_ln1_rx_data_o[72] = Q1_FABRIC_LN1_RXDATA_O[72];
assign q1_ln1_rx_data_o[73] = Q1_FABRIC_LN1_RXDATA_O[73];
assign q1_ln1_rx_data_o[74] = Q1_FABRIC_LN1_RXDATA_O[74];
assign q1_ln1_rx_data_o[75] = Q1_FABRIC_LN1_RXDATA_O[75];
assign q1_ln1_rx_data_o[76] = Q1_FABRIC_LN1_RXDATA_O[76];
assign q1_ln1_rx_data_o[77] = Q1_FABRIC_LN1_RXDATA_O[77];
assign q1_ln1_rx_data_o[78] = Q1_FABRIC_LN1_RXDATA_O[78];
assign q1_ln1_rx_data_o[79] = Q1_FABRIC_LN1_RXDATA_O[79];
assign q1_ln1_rx_data_o[80] = Q1_FABRIC_LN1_RXDATA_O[80];
assign q1_ln1_rx_data_o[81] = Q1_FABRIC_LN1_RXDATA_O[81];
assign q1_ln1_rx_data_o[82] = Q1_FABRIC_LN1_RXDATA_O[82];
assign q1_ln1_rx_data_o[83] = Q1_FABRIC_LN1_RXDATA_O[83];
assign q1_ln1_rx_data_o[84] = Q1_FABRIC_LN1_RXDATA_O[84];
assign q1_ln1_rx_data_o[85] = Q1_FABRIC_LN1_RXDATA_O[85];
assign q1_ln1_rx_data_o[86] = Q1_FABRIC_LN1_RXDATA_O[86];
assign q1_ln1_rx_data_o[87] = Q1_FABRIC_LN1_RXDATA_O[87];
assign q1_ln1_rx_fifo_rdusewd_o[0] = Q1_LANE1_RX_IF_FIFO_RDUSEWD[0];
assign q1_ln1_rx_fifo_rdusewd_o[1] = Q1_LANE1_RX_IF_FIFO_RDUSEWD[1];
assign q1_ln1_rx_fifo_rdusewd_o[2] = Q1_LANE1_RX_IF_FIFO_RDUSEWD[2];
assign q1_ln1_rx_fifo_rdusewd_o[3] = Q1_LANE1_RX_IF_FIFO_RDUSEWD[3];
assign q1_ln1_rx_fifo_rdusewd_o[4] = Q1_LANE1_RX_IF_FIFO_RDUSEWD[4];
assign q1_ln1_rx_fifo_aempty_o = Q1_LANE1_RX_IF_FIFO_AEMPTY;
assign q1_ln1_rx_fifo_empty_o = Q1_LANE1_RX_IF_FIFO_EMPTY;
assign q1_ln1_rx_valid_o = Q1_FABRIC_LN1_RX_VLD_OUT;
assign q1_ln1_tx_pcs_clkout_o = Q1_LANE1_PCS_TX_O_FABRIC_CLK;
assign q1_ln1_tx_fifo_wrusewd_o[0] = Q1_LANE1_TX_IF_FIFO_WRUSEWD[0];
assign q1_ln1_tx_fifo_wrusewd_o[1] = Q1_LANE1_TX_IF_FIFO_WRUSEWD[1];
assign q1_ln1_tx_fifo_wrusewd_o[2] = Q1_LANE1_TX_IF_FIFO_WRUSEWD[2];
assign q1_ln1_tx_fifo_wrusewd_o[3] = Q1_LANE1_TX_IF_FIFO_WRUSEWD[3];
assign q1_ln1_tx_fifo_wrusewd_o[4] = Q1_LANE1_TX_IF_FIFO_WRUSEWD[4];
assign q1_ln1_tx_fifo_afull_o = Q1_LANE1_TX_IF_FIFO_AFULL;
assign q1_ln1_tx_fifo_full_o = Q1_LANE1_TX_IF_FIFO_FULL;
assign q1_ln1_ready_o = Q1_FABRIC_LN1_STAT_O[12];
assign q1_ln1_refclk_o = Q1_FABRIC_CMU_CK_REF_O;
assign q1_ln1_signal_detect_o = Q1_FABRIC_LN1_ASTAT_O[5];
assign q1_ln1_rx_cdr_lock_o = Q1_FABRIC_LN1_PMA_RX_LOCK_O;
assign q1_ln1_k_lock_o = Q1_LANE1_K_LOCK;
assign q1_ln1_word_align_link_o = Q1_LANE1_ALIGN_LINK;
assign q1_ln1_pll_lock_o = Q1_FABRIC_CMU_OK_O;
endmodule /* Customized_PHY_Top */
