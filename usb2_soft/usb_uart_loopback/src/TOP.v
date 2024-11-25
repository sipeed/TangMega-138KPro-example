
module Top(
    input      CLK_IN,
    output [5:0] LED,
    inout      usb_dxp_io     ,
    inout      usb_dxn_io     ,
    input      usb_rxdp_i     ,
    input      usb_rxdn_i     ,
    output     usb_pullup_en_o,
    inout      usb_term_dp_io ,
    inout      usb_term_dn_io,

    output uart_tx
);

assign uart_tx = uart_txd;


localparam ENDPT_UART_CONFIG = 4'd0;

wire [1:0]  PHY_XCVRSELECT      ;
wire        PHY_TERMSELECT      ;
wire [1:0]  PHY_OPMODE          ;
wire [1:0]  PHY_LINESTATE       ;
wire        PHY_TXVALID         ;
wire        PHY_TXREADY         ;
wire        PHY_RXVALID         ;
wire        PHY_RXACTIVE        ;
wire        PHY_RXERROR         ;
wire [7:0]  PHY_DATAIN          ;
wire [7:0]  PHY_DATAOUT         ;
wire        PHY_CLKOUT          ;
wire [15:0] DESCROM_RADDR       ;
wire [ 7:0] DESC_INDEX          ;
wire [ 7:0] DESC_TYPE           ;
wire [ 7:0] DESCROM_RDAT        ;
wire [15:0] DESC_DEV_ADDR       ;
wire [15:0] DESC_DEV_LEN        ;
wire [15:0] DESC_QUAL_ADDR      ;
wire [15:0] DESC_QUAL_LEN       ;
wire [15:0] DESC_FSCFG_ADDR     ;
wire [15:0] DESC_FSCFG_LEN      ;
wire [15:0] DESC_HSCFG_ADDR     ;
wire [15:0] DESC_HSCFG_LEN      ;
wire [15:0] DESC_OSCFG_ADDR     ;
wire [15:0] DESC_HIDRPT_ADDR    ;
wire [15:0] DESC_HIDRPT_LEN     ;
wire [15:0] DESC_BOS_ADDR       ;
wire [15:0] DESC_BOS_LEN        ;
wire [15:0] DESC_STRLANG_ADDR   ;
wire [15:0] DESC_STRVENDOR_ADDR ;
wire [15:0] DESC_STRVENDOR_LEN  ;
wire [15:0] DESC_STRPRODUCT_ADDR;
wire [15:0] DESC_STRPRODUCT_LEN ;
wire [15:0] DESC_STRSERIAL_ADDR ;
wire [15:0] DESC_STRSERIAL_LEN  ;
wire        DESCROM_HAVE_STRINGS;
wire        RESET;
reg  [7:0]  rst_cnt;
wire [7:0]  usb_txdat;
wire [11:0] usb_txdat_len;
wire        usb_txcork;
wire        usb_txpop;
wire        usb_txact;
wire [7:0]  usb_rxdat;
wire        usb_rxval;
wire        usb_rxpktval;
wire        usb_rxact;
wire        usb_rxrdy;
wire [3:0]  endpt_sel;
wire        rx_fifo_wren;
wire        rx_fifo_empty;
reg         rx_fifo_rden;
wire [7:0]  rx_fifo_data;
wire        rx_fifo_dval;
reg         rx_fifo_dval_d0;
wire        rx_fifo_dval_rise;
wire [9:0]  tx_fifo_wnum;
wire        tx_fifo_empty;
wire [7:0]  tx_fifo_rdat;
wire        tx_fifo_rd;
wire        setup_active;
wire        setup_val;
wire [7:0]  setup_data;
wire        endpt0_send;
wire [7:0]  endpt0_dat;
wire        pll_locked;
wire        uart_en;
wire [31:0] uart_dte_rate;
wire [7:0]  uart_char_format;
wire [7:0]  uart_parity_type;
wire [7:0]  uart_data_bits;
wire [11:0] uart_config_txdat_len;
wire [15:0] uart_tx_data    ;
wire        uart_tx_data_val;
wire        uart_tx_busy    ;
wire [15:0] uart_rx_data    ;
wire        uart_rx_data_val;
reg  [31:0] led_cnt;
wire        uart_rts;
wire        uart_cts;
wire        uart_txd;
wire        uart_rxd;
wire        ep_usb_rxrdy;
wire        ep_usb_txcork;
wire [11:0] ep_usb_txlen;
wire [7:0]  ep_usb_txdat;
wire        ep2_rx_dval;
wire [7:0]  ep2_rx_data;
wire [7:0]  inf_alter_i;
wire [7:0]  inf_alter_o;
wire [7:0]  inf_sel_o;
wire        inf_set_o;
reg  [7:0]  interface0_alter;
reg  [7:0]  interface1_alter;

//==============================================================
//======PLL 

wire CLK48;
Gowin_PLL_F u_pll_F(
    .lock   (pll0_locked), //output lock
    .clkout0(CLK48      ), //output clkout0
    .clkin  (CLK_IN     ), //input clkin
    .reset  (1'b0       )  //input reset
);

Gowin_PLL_B u_pll_B(
    .lock   (pll1_locked),  //output lock
    .clkout0(fclk_960M  ),  //output clkout0
    .clkout1(PHY_CLKOUT ),  //output clkout1
    .clkin  (CLK48      ),  //input clkin
    .reset  (1'b0       )   //input reset
);

assign pll_locked = pll1_locked;
assign RESET = ~pll_locked;

wire usb_highspeed;
wire reset_led = ~RESET;
wire phy_speed_ls= ~PHY_XCVRSELECT[0];
wire phy_speed_fs= ~PHY_XCVRSELECT[1];

assign LED[0] = ~running;           //LED[0]: Running indicator
assign LED[1] = ~pll1_locked;       //LED[1]: ON = Main PLL Locked
assign LED[2] = ~reset_led;         //LED[2]: ON = System reset disabled 
assign LED[3] = ~phy_speed_ls;      //LED[3]: ON = USB PHY in LS mode
assign LED[4] = ~phy_speed_fs;      //LED[4]: ON = FS, LED[3:4]ALL ON: HS
assign LED[5] = ~usb_highspeed;     //LED[5]: ON = USB Device Controller HS Mode
//==============================================================
//======

assign running = (led_cnt >= 30_000_000); 

always@(posedge PHY_CLKOUT or posedge RESET) begin
    if (RESET) begin
        led_cnt <= 31'd0;
    end
    else if (led_cnt >= 32'd60_000_000) begin
        led_cnt <= 31'd0;
    end
    else begin
        led_cnt <= led_cnt + 1'd1;
    end
end

//==============================================================
//======UART
assign uart_rxd = uart_txd;
assign uart_cts = 1'b0;
assign uart_tx_data     = {8'd0,ep2_rx_data};
assign uart_tx_data_val = ep2_rx_dval;
UART  #(
    .CLK_FREQ     (30'd60000000)  // set system clock frequency in Hz
)u_UART
(
     .CLK        (PHY_CLKOUT          ),// clock
     .RST        (RESET               ),// reset
     .UART_TXD   (uart_txd            ),
     .UART_RXD   (uart_rxd            ),//
     .UART_RTS   (uart_rts            ),// when UART_RTS = 0, UART This Device Ready to receive.
     .UART_CTS   (uart_cts            ),// when UART_CTS = 0, UART Opposite Device Ready to receive.
     .BAUD_RATE  (uart_dte_rate       ),
     .PARITY_BIT (uart_parity_type    ),
     .STOP_BIT   (uart_char_format    ),
     .DATA_BITS  (uart_data_bits      ),
     .TX_DATA    (uart_tx_data        ), //
     .TX_DATA_VAL(uart_tx_data_val    ), // when TX_DATA_VAL = 1, data on TX_DATA will be transmit, DATA_SEND can set to 1 only when BUSY = 0
     .TX_BUSY    (uart_tx_busy        ), // when BUSY = 1 transiever is busy, you must not set DATA_SEND to 1
     .RX_DATA    (uart_rx_data        ), //
     .RX_DATA_VAL(uart_rx_data_val    ) //
);

//==============================================================
//======FIFO
assign usb_rxrdy     = ep_usb_rxrdy;
assign usb_txcork    = (endpt_sel ==ENDPT_UART_CONFIG) ? 1'b0 : ep_usb_txcork;
assign usb_txdat     = (endpt_sel==ENDPT_UART_CONFIG) ? endpt0_dat : ep_usb_txdat;
assign usb_txdat_len = (endpt_sel ==ENDPT_UART_CONFIG) ? uart_config_txdat_len : ep_usb_txlen;

//wire ep2_data_valid;
//wire [7:0] ep2_data;
//reg ep2_data_valid_d1, ep2_data_valid_d2, ep2_data_valid_d3, ep2_data_valid_d4;
//reg [7:0] ep2_data_d1, ep2_data_d2, ep2_data_d3, ep2_data_d4;

//always@(posedge PHY_CLKOUT)
//begin
//    ep2_data_valid_d1 <= ep2_data_valid;
//    ep2_data_valid_d2 <= ep2_data_valid_d1;
//    ep2_data_valid_d3 <= ep2_data_valid_d2;
//    ep2_data_valid_d4 <= ep2_data_valid_d3;

//    ep2_data_d1 <= ep2_data;
//    ep2_data_d2 <= ep2_data_d1;
//    ep2_data_d3 <= ep2_data_d2;
//    ep2_data_d4 <= ep2_data_d3;
//end


usb_fifo usb_fifo
(
     .i_clk         (PHY_CLKOUT   ),//clock
     .i_reset       (usb_busreset ),//reset
     .i_usb_endpt   (endpt_sel    ),
     .i_usb_rxact   (usb_rxact    ),
     .i_usb_rxval   (usb_rxval    ),
     .i_usb_rxpktval(usb_rxpktval ),
     .i_usb_rxdat   (usb_rxdat    ),
     .o_usb_rxrdy   (ep_usb_rxrdy ),
     .i_usb_txact   (usb_txact    ),
     .i_usb_txpop   (usb_txpop    ),
     .i_usb_txpktfin(usb_txpktfin ),
     .o_usb_txcork  (ep_usb_txcork),
     .o_usb_txlen   (ep_usb_txlen ),
     .o_usb_txdat   (ep_usb_txdat ),
    //Endpoint 2
     .i_ep2_tx_clk  (PHY_CLKOUT       ),
     .i_ep2_tx_max  (12'd64           ),
     .i_ep2_tx_dval (uart_rx_data_val ),
     .i_ep2_tx_data (uart_rx_data[7:0]),
     .i_ep2_rx_clk  (PHY_CLKOUT       ),
     .i_ep2_rx_rdy  (!uart_tx_busy    ),
     .o_ep2_rx_dval (ep2_rx_dval      ),
     .o_ep2_rx_data (ep2_rx_data      )
    //Loopback Endpoint 2
    /*
     .i_ep2_tx_clk  (PHY_CLKOUT       ),
     .i_ep2_tx_max  (12'd64           ),
     .i_ep2_tx_dval (ep2_data_valid_d4),
     .i_ep2_tx_data (ep2_data_d4      ),
     .i_ep2_rx_clk  (PHY_CLKOUT       ),
     .i_ep2_rx_rdy  (1'b1             ),
     .o_ep2_rx_dval (ep2_data_valid   ),
     .o_ep2_rx_data (ep2_data         )
     */
);
//==============================================================
//======Interface Setting
assign inf_alter_i = (inf_sel_o == 0) ? interface0_alter :
                     (inf_sel_o == 1) ? interface1_alter : 8'd0;
always@(posedge PHY_CLKOUT , posedge RESET   ) begin
    if (RESET) begin
        interface0_alter <= 'd0;
        interface1_alter <= 'd0;
    end
    else begin
        if (inf_set_o) begin
            if (inf_sel_o == 0) begin
                interface0_alter <= inf_alter_o;
            end
            else if (inf_sel_o == 1) begin
                interface1_alter <= inf_alter_o;
            end
        end
    end
end


//==============================================================
//======USB Device descriptor Demo
usb_desc#(
     .SERIALSTR       ("11252024"       ),
     .SERIALSTR_LEN   (8                ),
     .VENDORSTR       ("Sipeed"         ),
     .VENDORSTR_LEN   (6                ),
     .PRODUCTSTR      ("Tang USB2Serial"),
     .PRODUCTSTR_LEN  (15               ),
     .VENDORID        (16'h359F         ),
     .PRODUCTID       (16'h2010         ),
     .VERSIONBCD      (16'h0112         ),
     .HSSUPPORT       (1                ),
     .SELFPOWERED     (0                )
) u_usb_desc (
     .CLK                    (PHY_CLKOUT          ),
     .RESET                  (RESET               ),
     .i_pid                  (16'd0               ),
     .i_vid                  (16'd0               ),
     .i_descrom_raddr        (DESCROM_RADDR       ),
     .o_descrom_rdat         (DESCROM_RDAT        ),
     .o_desc_dev_addr        (DESC_DEV_ADDR       ),
     .o_desc_dev_len         (DESC_DEV_LEN        ),
     .o_desc_qual_addr       (DESC_QUAL_ADDR      ),
     .o_desc_qual_len        (DESC_QUAL_LEN       ),
     .o_desc_fscfg_addr      (DESC_FSCFG_ADDR     ),
     .o_desc_fscfg_len       (DESC_FSCFG_LEN      ),
     .o_desc_hscfg_addr      (DESC_HSCFG_ADDR     ),
     .o_desc_hscfg_len       (DESC_HSCFG_LEN      ),
     .o_desc_oscfg_addr      (DESC_OSCFG_ADDR     ),
     .o_desc_strlang_addr    (DESC_STRLANG_ADDR   ),
     .o_desc_strvendor_addr  (DESC_STRVENDOR_ADDR ),
     .o_desc_strvendor_len   (DESC_STRVENDOR_LEN  ),
     .o_desc_strproduct_addr (DESC_STRPRODUCT_ADDR),
     .o_desc_strproduct_len  (DESC_STRPRODUCT_LEN ),
     .o_desc_strserial_addr  (DESC_STRSERIAL_ADDR ),
     .o_desc_strserial_len   (DESC_STRSERIAL_LEN  ),
     .o_descrom_have_strings (DESCROM_HAVE_STRINGS)
);

//==============================================================
//======Device Controller
USB_Device_Controller_Top u_usb_device_controller_top (
     .clk_i                 (PHY_CLKOUT          ),
     .reset_i               (RESET               ),
     .usbrst_o              (usb_busreset        ),
     .highspeed_o           (usb_highspeed       ),
     .suspend_o             (usb_suspend         ),
     .online_o              (usb_online          ),
     .txdat_i               (usb_txdat           ),
     .txval_i               (endpt0_send&(endpt_sel==ENDPT_UART_CONFIG)),
     .txdat_len_i           (usb_txdat_len       ),
     .txcork_i              (usb_txcork          ),
     .txiso_pid_i           (4'b0011             ),
     .txpop_o               (usb_txpop           ),
     .txact_o               (usb_txact           ),
     .txpktfin_o            (usb_txpktfin        ),
     .rxdat_o               (usb_rxdat           ),
     .rxval_o               (usb_rxval           ),
     .rxact_o               (usb_rxact           ),
     .rxrdy_i               (usb_rxrdy           ),
     .rxpktval_o            (usb_rxpktval        ),
     .setup_o               (setup_active        ),
     .endpt_o               (endpt_sel           ),
     .sof_o                 (usb_sof             ),
     .inf_alter_i           (inf_alter_i         ),
     .inf_alter_o           (inf_alter_o         ),
     .inf_sel_o             (inf_sel_o           ),
     .inf_set_o             (inf_set_o           ),
     .descrom_rdata_i       (DESCROM_RDAT        ),
     .descrom_raddr_o       (DESCROM_RADDR       ),
     .desc_index_o          (DESC_INDEX          ),
     .desc_type_o           (DESC_TYPE           ),
     .desc_dev_addr_i       (DESC_DEV_ADDR       ),
     .desc_dev_len_i        (DESC_DEV_LEN        ),
     .desc_qual_addr_i      (DESC_QUAL_ADDR      ),
     .desc_qual_len_i       (DESC_QUAL_LEN       ),
     .desc_fscfg_addr_i     (DESC_FSCFG_ADDR     ),
     .desc_fscfg_len_i      (DESC_FSCFG_LEN      ),
     .desc_hscfg_addr_i     (DESC_HSCFG_ADDR     ),
     .desc_hscfg_len_i      (DESC_HSCFG_LEN      ),
     .desc_oscfg_addr_i     (DESC_OSCFG_ADDR     ),
     .desc_hidrpt_addr_i    (16'd0               ),//DESC_HIDRPT_ADDR
     .desc_hidrpt_len_i     (16'd0               ),//DESC_HIDRPT_LEN
     .desc_bos_addr_i       (16'd0               ),//DESC_BOS_ADDR
     .desc_bos_len_i        (16'd0               ),//DESC_BOS_LEN
     .desc_strlang_addr_i   (DESC_STRLANG_ADDR   ),
     .desc_strvendor_addr_i (DESC_STRVENDOR_ADDR ),
     .desc_strvendor_len_i  (DESC_STRVENDOR_LEN  ),
     .desc_strproduct_addr_i(DESC_STRPRODUCT_ADDR),
     .desc_strproduct_len_i (DESC_STRPRODUCT_LEN ),
     .desc_strserial_addr_i (DESC_STRSERIAL_ADDR ),
     .desc_strserial_len_i  (DESC_STRSERIAL_LEN  ),
     .desc_have_strings_i   (DESCROM_HAVE_STRINGS),
    
     .utmi_dataout_o        (PHY_DATAOUT       ),
     .utmi_txvalid_o        (PHY_TXVALID       ),
     .utmi_txready_i        (PHY_TXREADY       ),
     .utmi_datain_i         (PHY_DATAIN        ),
     .utmi_rxactive_i       (PHY_RXACTIVE      ),
     .utmi_rxvalid_i        (PHY_RXVALID       ),
     .utmi_rxerror_i        (PHY_RXERROR       ),
     .utmi_linestate_i      (PHY_LINESTATE     ),
     .utmi_opmode_o         (PHY_OPMODE        ),
     .utmi_xcvrselect_o     (PHY_XCVRSELECT    ),
     .utmi_termselect_o     (PHY_TERMSELECT    ),
     .utmi_reset_o          (PHY_RESET         )
);



//==============================================================
//======USB SoftPHY

USB2_0_SoftPHY_Top u_USB_SoftPHY_Top
(
     .clk_i            (PHY_CLKOUT     ),
     .rst_i            (PHY_RESET      ),
     .fclk_i           (fclk_960M      ),
     .pll_locked_i     (pll_locked     ),
     .utmi_data_out_i  (PHY_DATAOUT    ),
     .utmi_txvalid_i   (PHY_TXVALID    ),
     .utmi_op_mode_i   (PHY_OPMODE     ),
     .utmi_xcvrselect_i(PHY_XCVRSELECT ),
     .utmi_termselect_i(PHY_TERMSELECT ),
     .utmi_data_in_o   (PHY_DATAIN     ),
     .utmi_txready_o   (PHY_TXREADY    ),
     .utmi_rxvalid_o   (PHY_RXVALID    ),
     .utmi_rxactive_o  (PHY_RXACTIVE   ),
     .utmi_rxerror_o   (PHY_RXERROR    ),
     .utmi_linestate_o (PHY_LINESTATE  ),
     .usb_dxp_io       (usb_dxp_io     ),
     .usb_dxn_io       (usb_dxn_io     ),
     .usb_rxdp_i       (usb_rxdp_i     ),
     .usb_rxdn_i       (usb_rxdn_i     ),
     .usb_pullup_en_o  (usb_pullup_en_o),
     .usb_term_dp_io   (usb_term_dp_io ),
     .usb_term_dn_io   (usb_term_dn_io )
);

//==============================================================
//======USB_SoftPHY_full_speed_config
/*
    USB_SoftPHY_Top u_USBFS_SoftPHY_Top
    (
		.clk_i(PHY_CLKOUT),
		.rst_i(PHY_RESET),
		.utmi_data_out_i(PHY_DATAOUT),
		.utmi_txvalid_i(PHY_TXVALID),
		.utmi_op_mode_i(PHY_OPMODE),
		.utmi_xcvrselect_i(PHY_XCVRSELECT),
		.utmi_termselect_i(PHY_TERMSELECT),
		.utmi_data_in_o(PHY_DATAIN),
		.utmi_txready_o(PHY_TXREADY),
		.utmi_rxvalid_o(PHY_RXVALID),
		.utmi_rxactive_o(PHY_RXACTIVE),
		.utmi_rxerror_o(PHY_RXERROR),
		.utmi_linestate_o(PHY_LINESTATE),
		.usb_dp_io(usb_term_dp_io),
		.usb_dn_io(usb_term_dn_io)
	);
    assign usb_pullup_en_o = 1;
*/

//==============================================================
//======UART_config
usb_uart_config u_usb_uart_config
(
     .PHY_CLKOUT         (PHY_CLKOUT           ),
     .RESET_IN           (usb_busreset         ),
     .setup_active       (setup_active         ),
     .endpt_sel          (endpt_sel            ),
     .usb_rxval          (usb_rxval            ),
     .usb_rxact          (usb_rxact            ),
     .usb_rxdat          (usb_rxdat            ),
     .usb_txact          (usb_txact            ),
     .usb_txpop          (usb_txpop            ),
     .usb_txdat_len_o    (uart_config_txdat_len),
     .endpt0_dat_o       (endpt0_dat           ),
     .endpt0_send_o      (endpt0_send          ),
     .uart1_en_o         (uart_en              ),
     .uart1_BAUD_RATE_o  (uart_dte_rate        ),
     .uart1_PARITY_BIT_o (uart_parity_type     ),
     .uart1_STOP_BIT_o   (uart_char_format     ),
     .uart1_DATA_BITS_o  (uart_data_bits       )

);
defparam u_usb_uart_config.ENDPT_UART_CONFIG = ENDPT_UART_CONFIG;



endmodule
