module top(
    output sfp_tx_disable_ln0,
    output sfp_tx_disable_ln1,
    output led_lck1,
    output led_lck0,
    output led_ln1,
    output led_ln0,
    input sw1
);

assign sfp_tx_disable_ln0 = 1'b0;
assign sfp_tx_disable_ln1 = 1'b0;

wire        Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o   ;   //output Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o
wire [87:0] Customized_PHY_Top_q1_ln1_rx_data_o         ;   //output [87:0] Customized_PHY_Top_q1_ln1_rx_data_o
wire [4:0]  Customized_PHY_Top_q1_ln1_rx_fifo_rdusewd_o ;   //output [4:0] Customized_PHY_Top_q1_ln1_rx_fifo_rdusewd_o
wire        Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o  ;   //output Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o
wire        Customized_PHY_Top_q1_ln1_rx_fifo_empty_o   ;   //output Customized_PHY_Top_q1_ln1_rx_fifo_empty_o
wire        Customized_PHY_Top_q1_ln1_rx_valid_o        ;   //output Customized_PHY_Top_q1_ln1_rx_valid_o
wire        Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o   ;   //output Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o
wire [4:0]  Customized_PHY_Top_q1_ln1_tx_fifo_wrusewd_o ;   //output [4:0] Customized_PHY_Top_q1_ln1_tx_fifo_wrusewd_o
wire        Customized_PHY_Top_q1_ln1_tx_fifo_afull_o   ;   //output Customized_PHY_Top_q1_ln1_tx_fifo_afull_o
wire        Customized_PHY_Top_q1_ln1_tx_fifo_full_o    ;   //output Customized_PHY_Top_q1_ln1_tx_fifo_full_o
wire        Customized_PHY_Top_q1_ln1_refclk_o          ;   //output Customized_PHY_Top_q1_ln1_refclk_o
wire        Customized_PHY_Top_q1_ln1_signal_detect_o   ;   //output Customized_PHY_Top_q1_ln1_signal_detect_o
wire        Customized_PHY_Top_q1_ln1_rx_cdr_lock_o     ;   //output Customized_PHY_Top_q1_ln1_rx_cdr_lock_o
wire        Customized_PHY_Top_q1_ln1_pll_lock_o        ;   //output Customized_PHY_Top_q1_ln1_pll_lock_o
wire        Customized_PHY_Top_q1_ln1_rx_clk_i          ;   //input Customized_PHY_Top_q1_ln1_rx_clk_i
wire        Customized_PHY_Top_q1_ln1_rx_fifo_rden_i    ;   //input Customized_PHY_Top_q1_ln1_rx_fifo_rden_i
wire        Customized_PHY_Top_q1_ln1_tx_clk_i          ;   //input Customized_PHY_Top_q1_ln1_tx_clk_i
wire [79:0] Customized_PHY_Top_q1_ln1_tx_data_i         ;   //input [79:0] Customized_PHY_Top_q1_ln1_tx_data_i
wire        Customized_PHY_Top_q1_ln1_tx_fifo_wren_i    ;   //input Customized_PHY_Top_q1_ln1_tx_fifo_wren_i
wire        Customized_PHY_Top_q1_ln1_pma_rstn_i        ;   //input Customized_PHY_Top_q1_ln1_pma_rstn_i
wire        Customized_PHY_Top_q1_ln1_pcs_rx_rst_i      ;   //input Customized_PHY_Top_q1_ln1_pcs_rx_rst_i
wire        Customized_PHY_Top_q1_ln1_pcs_tx_rst_i      ;   //input Customized_PHY_Top_q1_ln1_pcs_tx_rst_i

assign Customized_PHY_Top_q1_ln1_rx_clk_i = Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o;
assign Customized_PHY_Top_q1_ln1_tx_clk_i = Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o;
assign Customized_PHY_Top_q1_ln1_pma_rstn_i = 1'b1;
assign Customized_PHY_Top_q1_ln1_pcs_rx_rst_i = 1'b0;
assign Customized_PHY_Top_q1_ln1_pcs_tx_rst_i = 1'b0;
assign Customized_PHY_Top_q1_ln1_rx_fifo_rden_i = ~Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o;
assign Customized_PHY_Top_q1_ln1_tx_fifo_wren_i = ~Customized_PHY_Top_q1_ln1_tx_fifo_afull_o;

wire        Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o   ;   //output Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o
wire [87:0] Customized_PHY_Top_q1_ln0_rx_data_o         ;   //output [87:0] Customized_PHY_Top_q1_ln0_rx_data_o
wire [4:0]  Customized_PHY_Top_q1_ln0_rx_fifo_rdusewd_o ;   //output [4:0] Customized_PHY_Top_q1_ln0_rx_fifo_rdusewd_o
wire        Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o  ;   //output Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o
wire        Customized_PHY_Top_q1_ln0_rx_fifo_empty_o   ;   //output Customized_PHY_Top_q1_ln0_rx_fifo_empty_o
wire        Customized_PHY_Top_q1_ln0_rx_valid_o        ;   //output Customized_PHY_Top_q1_ln0_rx_valid_o
wire        Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o   ;   //output Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o
wire [4:0]  Customized_PHY_Top_q1_ln0_tx_fifo_wrusewd_o ;   //output [4:0] Customized_PHY_Top_q1_ln0_tx_fifo_wrusewd_o
wire        Customized_PHY_Top_q1_ln0_tx_fifo_afull_o   ;   //output Customized_PHY_Top_q1_ln0_tx_fifo_afull_o
wire        Customized_PHY_Top_q1_ln0_tx_fifo_full_o    ;   //output Customized_PHY_Top_q1_ln0_tx_fifo_full_o
wire        Customized_PHY_Top_q1_ln0_refclk_o          ;   //output Customized_PHY_Top_q1_ln0_refclk_o
wire        Customized_PHY_Top_q1_ln0_signal_detect_o   ;   //output Customized_PHY_Top_q1_ln0_signal_detect_o
wire        Customized_PHY_Top_q1_ln0_rx_cdr_lock_o     ;   //output Customized_PHY_Top_q1_ln0_rx_cdr_lock_o
wire        Customized_PHY_Top_q1_ln0_pll_lock_o        ;   //output Customized_PHY_Top_q1_ln0_pll_lock_o
wire        Customized_PHY_Top_q1_ln0_rx_clk_i          ;   //input Customized_PHY_Top_q1_ln0_rx_clk_i
wire        Customized_PHY_Top_q1_ln0_rx_fifo_rden_i    ;   //input Customized_PHY_Top_q1_ln0_rx_fifo_rden_i
wire        Customized_PHY_Top_q1_ln0_tx_clk_i          ;   //input Customized_PHY_Top_q1_ln0_tx_clk_i
wire [79:0] Customized_PHY_Top_q1_ln0_tx_data_i         ;   //input [79:0] Customized_PHY_Top_q1_ln0_tx_data_i
wire        Customized_PHY_Top_q1_ln0_tx_fifo_wren_i    ;   //input Customized_PHY_Top_q1_ln0_tx_fifo_wren_i
wire        Customized_PHY_Top_q1_ln0_pma_rstn_i        ;   //input Customized_PHY_Top_q1_ln0_pma_rstn_i
wire        Customized_PHY_Top_q1_ln0_pcs_rx_rst_i      ;   //input Customized_PHY_Top_q1_ln0_pcs_rx_rst_i
wire        Customized_PHY_Top_q1_ln0_pcs_tx_rst_i      ;   //input Customized_PHY_Top_q1_ln0_pcs_tx_rst_i

assign Customized_PHY_Top_q1_ln0_rx_clk_i = Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o;
assign Customized_PHY_Top_q1_ln0_tx_clk_i = Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o;
assign Customized_PHY_Top_q1_ln0_pma_rstn_i = 1'b1;
assign Customized_PHY_Top_q1_ln0_pcs_rx_rst_i = 1'b0;
assign Customized_PHY_Top_q1_ln0_pcs_tx_rst_i = 1'b0;
assign Customized_PHY_Top_q1_ln0_rx_fifo_rden_i = ~Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o;
assign Customized_PHY_Top_q1_ln0_tx_fifo_wren_i = ~Customized_PHY_Top_q1_ln0_tx_fifo_afull_o;



  Serdes_Top Serdes_Top(
        .Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o(Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o), //output Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o
        .Customized_PHY_Top_q1_ln1_rx_data_o(Customized_PHY_Top_q1_ln1_rx_data_o), //output [87:0] Customized_PHY_Top_q1_ln1_rx_data_o
        .Customized_PHY_Top_q1_ln1_rx_fifo_rdusewd_o(Customized_PHY_Top_q1_ln1_rx_fifo_rdusewd_o), //output [4:0] Customized_PHY_Top_q1_ln1_rx_fifo_rdusewd_o
        .Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o(Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o), //output Customized_PHY_Top_q1_ln1_rx_fifo_aempty_o
        .Customized_PHY_Top_q1_ln1_rx_fifo_empty_o(Customized_PHY_Top_q1_ln1_rx_fifo_empty_o), //output Customized_PHY_Top_q1_ln1_rx_fifo_empty_o
        .Customized_PHY_Top_q1_ln1_rx_valid_o(Customized_PHY_Top_q1_ln1_rx_valid_o), //output Customized_PHY_Top_q1_ln1_rx_valid_o
        .Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o(Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o), //output Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o
        .Customized_PHY_Top_q1_ln1_tx_fifo_wrusewd_o(Customized_PHY_Top_q1_ln1_tx_fifo_wrusewd_o), //output [4:0] Customized_PHY_Top_q1_ln1_tx_fifo_wrusewd_o
        .Customized_PHY_Top_q1_ln1_tx_fifo_afull_o(Customized_PHY_Top_q1_ln1_tx_fifo_afull_o), //output Customized_PHY_Top_q1_ln1_tx_fifo_afull_o
        .Customized_PHY_Top_q1_ln1_tx_fifo_full_o(Customized_PHY_Top_q1_ln1_tx_fifo_full_o), //output Customized_PHY_Top_q1_ln1_tx_fifo_full_o
        .Customized_PHY_Top_q1_ln1_refclk_o(Customized_PHY_Top_q1_ln1_refclk_o), //output Customized_PHY_Top_q1_ln1_refclk_o
        .Customized_PHY_Top_q1_ln1_signal_detect_o(Customized_PHY_Top_q1_ln1_signal_detect_o), //output Customized_PHY_Top_q1_ln1_signal_detect_o
        .Customized_PHY_Top_q1_ln1_rx_cdr_lock_o(Customized_PHY_Top_q1_ln1_rx_cdr_lock_o), //output Customized_PHY_Top_q1_ln1_rx_cdr_lock_o
        .Customized_PHY_Top_q1_ln1_pll_lock_o(Customized_PHY_Top_q1_ln1_pll_lock_o), //output Customized_PHY_Top_q1_ln1_pll_lock_o
        .Customized_PHY_Top_q1_ln1_rx_clk_i(Customized_PHY_Top_q1_ln1_rx_clk_i), //input Customized_PHY_Top_q1_ln1_rx_clk_i
        .Customized_PHY_Top_q1_ln1_rx_fifo_rden_i(Customized_PHY_Top_q1_ln1_rx_fifo_rden_i), //input Customized_PHY_Top_q1_ln1_rx_fifo_rden_i
        .Customized_PHY_Top_q1_ln1_tx_clk_i(Customized_PHY_Top_q1_ln1_tx_clk_i), //input Customized_PHY_Top_q1_ln1_tx_clk_i
        .Customized_PHY_Top_q1_ln1_tx_data_i(Customized_PHY_Top_q1_ln1_tx_data_i), //input [79:0] Customized_PHY_Top_q1_ln1_tx_data_i
        .Customized_PHY_Top_q1_ln1_tx_fifo_wren_i(Customized_PHY_Top_q1_ln1_tx_fifo_wren_i), //input Customized_PHY_Top_q1_ln1_tx_fifo_wren_i
        .Customized_PHY_Top_q1_ln1_pma_rstn_i(Customized_PHY_Top_q1_ln1_pma_rstn_i), //input Customized_PHY_Top_q1_ln1_pma_rstn_i
        .Customized_PHY_Top_q1_ln1_pcs_rx_rst_i(Customized_PHY_Top_q1_ln1_pcs_rx_rst_i), //input Customized_PHY_Top_q1_ln1_pcs_rx_rst_i
        .Customized_PHY_Top_q1_ln1_pcs_tx_rst_i(Customized_PHY_Top_q1_ln1_pcs_tx_rst_i), //input Customized_PHY_Top_q1_ln1_pcs_tx_rst_i        
        
        .Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o(Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o), //output Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o
        .Customized_PHY_Top_q1_ln0_rx_data_o(Customized_PHY_Top_q1_ln0_rx_data_o), //output [87:0] Customized_PHY_Top_q1_ln0_rx_data_o
        .Customized_PHY_Top_q1_ln0_rx_fifo_rdusewd_o(Customized_PHY_Top_q1_ln0_rx_fifo_rdusewd_o), //output [4:0] Customized_PHY_Top_q1_ln0_rx_fifo_rdusewd_o
        .Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o(Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o), //output Customized_PHY_Top_q1_ln0_rx_fifo_aempty_o
        .Customized_PHY_Top_q1_ln0_rx_fifo_empty_o(Customized_PHY_Top_q1_ln0_rx_fifo_empty_o), //output Customized_PHY_Top_q1_ln0_rx_fifo_empty_o
        .Customized_PHY_Top_q1_ln0_rx_valid_o(Customized_PHY_Top_q1_ln0_rx_valid_o), //output Customized_PHY_Top_q1_ln0_rx_valid_o
        .Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o(Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o), //output Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o
        .Customized_PHY_Top_q1_ln0_tx_fifo_wrusewd_o(Customized_PHY_Top_q1_ln0_tx_fifo_wrusewd_o), //output [4:0] Customized_PHY_Top_q1_ln0_tx_fifo_wrusewd_o
        .Customized_PHY_Top_q1_ln0_tx_fifo_afull_o(Customized_PHY_Top_q1_ln0_tx_fifo_afull_o), //output Customized_PHY_Top_q1_ln0_tx_fifo_afull_o
        .Customized_PHY_Top_q1_ln0_tx_fifo_full_o(Customized_PHY_Top_q1_ln0_tx_fifo_full_o), //output Customized_PHY_Top_q1_ln0_tx_fifo_full_o
        .Customized_PHY_Top_q1_ln0_refclk_o(Customized_PHY_Top_q1_ln0_refclk_o), //output Customized_PHY_Top_q1_ln0_refclk_o
        .Customized_PHY_Top_q1_ln0_signal_detect_o(Customized_PHY_Top_q1_ln0_signal_detect_o), //output Customized_PHY_Top_q1_ln0_signal_detect_o
        .Customized_PHY_Top_q1_ln0_rx_cdr_lock_o(Customized_PHY_Top_q1_ln0_rx_cdr_lock_o), //output Customized_PHY_Top_q1_ln0_rx_cdr_lock_o
        .Customized_PHY_Top_q1_ln0_pll_lock_o(Customized_PHY_Top_q1_ln0_pll_lock_o), //output Customized_PHY_Top_q1_ln0_pll_lock_o
        .Customized_PHY_Top_q1_ln0_rx_clk_i(Customized_PHY_Top_q1_ln0_rx_clk_i), //input Customized_PHY_Top_q1_ln0_rx_clk_i
        .Customized_PHY_Top_q1_ln0_rx_fifo_rden_i(Customized_PHY_Top_q1_ln0_rx_fifo_rden_i), //input Customized_PHY_Top_q1_ln0_rx_fifo_rden_i
        .Customized_PHY_Top_q1_ln0_tx_clk_i(Customized_PHY_Top_q1_ln0_tx_clk_i), //input Customized_PHY_Top_q1_ln0_tx_clk_i
        .Customized_PHY_Top_q1_ln0_tx_data_i(Customized_PHY_Top_q1_ln0_tx_data_i), //input [79:0] Customized_PHY_Top_q1_ln0_tx_data_i
        .Customized_PHY_Top_q1_ln0_tx_fifo_wren_i(Customized_PHY_Top_q1_ln0_tx_fifo_wren_i), //input Customized_PHY_Top_q1_ln0_tx_fifo_wren_i
        .Customized_PHY_Top_q1_ln0_pma_rstn_i(Customized_PHY_Top_q1_ln0_pma_rstn_i), //input Customized_PHY_Top_q1_ln0_pma_rstn_i
        .Customized_PHY_Top_q1_ln0_pcs_rx_rst_i(Customized_PHY_Top_q1_ln0_pcs_rx_rst_i), //input Customized_PHY_Top_q1_ln0_pcs_rx_rst_i
        .Customized_PHY_Top_q1_ln0_pcs_tx_rst_i(Customized_PHY_Top_q1_ln0_pcs_tx_rst_i) //input Customized_PHY_Top_q1_ln0_pcs_tx_rst_i
    ); 

    
//Test case

parameter q1_ln1_WIDTH = 8;

wire q1_ln1_tx_clk;
wire q1_ln1_prbs7_gen_rstn;
wire q1_ln1_prbs7_gen_en;
wire [q1_ln1_WIDTH-1:0] q1_ln1_prbs7_gen_data;

wire q1_ln1_rx_clk;
wire q1_ln1_prbs7_chk_rstn;
wire q1_ln1_prbs7_chk_en;
wire [q1_ln1_WIDTH-1:0] q1_ln1_prbs7_chk_data;
wire q1_ln1_lock;

assign q1_ln1_tx_clk = Customized_PHY_Top_q1_ln1_tx_pcs_clkout_o;
assign q1_ln1_prbs7_gen_rstn = sw1;
assign q1_ln1_prbs7_gen_en = 1'b1;
assign Customized_PHY_Top_q1_ln1_tx_data_i = {10'b0,10'b0,10'b0,10'b0,10'b0,10'b0,10'b0,{2'b0,q1_ln1_prbs7_gen_data}};

assign q1_ln1_rx_clk = Customized_PHY_Top_q1_ln1_rx_pcs_clkout_o;
assign q1_ln1_prbs7_chk_rstn = Customized_PHY_Top_q1_ln1_rx_cdr_lock_o;
assign q1_ln1_prbs7_chk_en = 1'b1;
assign q1_ln1_prbs7_chk_data = Customized_PHY_Top_q1_ln1_rx_data_o[7:0];

prbs7_single_channel
#(.WIDTH(q1_ln1_WIDTH)
) q1ln1_prbs7_single_channel
(
//tx
.tx_clk_i(q1_ln1_tx_clk),
.tx_rstn_i(q1_ln1_prbs7_gen_rstn),
.tx_en_i(q1_ln1_prbs7_gen_en),
.tx_data_o(q1_ln1_prbs7_gen_data),

//rx
.rx_clk_i(q1_ln1_rx_clk), 
.rx_rstn_i(q1_ln1_prbs7_chk_rstn),
.rx_en_i(q1_ln1_prbs7_chk_en),
.rx_data_i(q1_ln1_prbs7_chk_data),
.lock_o(prbs7_lock_ln1)

);

parameter q1_ln0_WIDTH = 8;

wire q1_ln0_tx_clk;
wire q1_ln0_prbs7_gen_rstn;
wire q1_ln0_prbs7_gen_en;
wire [q1_ln0_WIDTH-1:0] q1_ln0_prbs7_gen_data;

wire q1_ln0_rx_clk;
wire q1_ln0_prbs7_chk_rstn;
wire q1_ln0_prbs7_chk_en;
wire [q1_ln0_WIDTH-1:0] q1_ln0_prbs7_chk_data;
wire q1_ln0_lock;

assign q1_ln0_tx_clk = Customized_PHY_Top_q1_ln0_tx_pcs_clkout_o;
assign q1_ln0_prbs7_gen_rstn = sw1;
assign q1_ln0_prbs7_gen_en = 1'b1;
assign Customized_PHY_Top_q1_ln0_tx_data_i = {10'b0,10'b0,10'b0,10'b0,10'b0,10'b0,10'b0,{2'b0,q1_ln0_prbs7_gen_data}};

assign q1_ln0_rx_clk = Customized_PHY_Top_q1_ln0_rx_pcs_clkout_o;
assign q1_ln0_prbs7_chk_rstn = Customized_PHY_Top_q1_ln0_rx_cdr_lock_o;
assign q1_ln0_prbs7_chk_en = 1'b1;
assign q1_ln0_prbs7_chk_data = Customized_PHY_Top_q1_ln0_rx_data_o[7:0];

prbs7_single_channel
#(.WIDTH(q1_ln0_WIDTH)
) q1ln0_prbs7_single_channel
(
//tx
.tx_clk_i(q1_ln0_tx_clk),
.tx_rstn_i(q1_ln0_prbs7_gen_rstn),
.tx_en_i(q1_ln0_prbs7_gen_en),
.tx_data_o(q1_ln0_prbs7_gen_data),

//rx
.rx_clk_i(q1_ln0_rx_clk), 
.rx_rstn_i(q1_ln0_prbs7_chk_rstn),
.rx_en_i(q1_ln0_prbs7_chk_en),
.rx_data_i(q1_ln0_prbs7_chk_data),
.lock_o(prbs7_lock_ln0)

);

reg [26:0] led_cnt_ln1 = 27'b0;;
always@(posedge q1_ln1_tx_clk) led_cnt_ln1 <= led_cnt_ln1 + 1;

assign led_ln1 = led_cnt_ln1[26];

reg [26:0] led_cnt_ln0 = 27'b0;;
always@(posedge q1_ln0_tx_clk) led_cnt_ln0 <= led_cnt_ln0 + 1;

assign led_ln0 = led_cnt_ln0[26];

assign led_lck0 = ~prbs7_lock_ln0;
assign led_lck1 = ~prbs7_lock_ln1;
endmodule