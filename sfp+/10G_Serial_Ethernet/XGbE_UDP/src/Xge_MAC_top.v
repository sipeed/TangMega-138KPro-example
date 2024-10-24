
module Xge_MAC_top#(
    // UDP Param
    parameter SRC_MAC 	    = 48'h03_08_35_01_AE_C2,        //Source MAC Address
	parameter SRC_IP 		= {8'd192,8'd168,8'd3,8'd2},    //Source IP Address
	parameter SRC_PORT	    = 16'h8000,                     //Source UDP Port
	parameter DES_MAC 		= 48'hff_ff_ff_ff_ff_ff,        //Destination MAC address
	parameter DES_IP 		= {8'd192,8'd168,8'd3,8'd3},    //Destination IP address
	parameter DES_PORT		= 16'h8000,                     //Destination PORT
	parameter DATA_SIZE		= 16'd1024                      //Data Length
)(
    //Clock & Rst
    input xgmii_rx_clk,
    input xgmii_tx_clk,
    input xge_block_lock,

    output [7:0]  xgmii_txc,
    output [63:0] xgmii_txd,
    input  [7:0]  xgmii_rxc,
    input  [63:0] xgmii_rxd
);

//-------Instantiate 10G Ethernet MAC IP----------
    wire          rx_mac_clk;
    wire          rx_mac_valid;
    wire [63:0]   rx_mac_data;
    wire [7:0]    rx_mac_byte;
    wire          rx_mac_last;
    wire          rx_mac_error;
    wire          rx_statistics_valid;
    wire [19:0]   rx_statistics_vector;

    wire          tx_mac_clk;
    wire          tx_mac_valid;
    wire [63:0]   tx_mac_data;
    wire [7:0]    tx_mac_byte;
    wire          tx_mac_last;
    wire          tx_mac_error;
    wire          tx_mac_ready;
    wire          tx_statistics_valid;
    wire [18:0]   tx_statistics_vector;

    wire          local_fault;
    wire          remote_fault;

    Ten_Giga_Ethernet_MAC_Top u_Ten_Giga_Ethernet_MAC_Top (
        //rstn
        .rx_rstn_i(xge_block_lock),
        .tx_rstn_i(xge_block_lock),
        //XGMII
        .xgmii_rx_clk_i(xgmii_rx_clk),
        .xgtx_clk_i(xgmii_tx_clk),
        
        .xgmii_rxc_i(xgmii_rxc),
        .xgmii_rxd_i(xgmii_rxd),
        .xgmii_txc_o(xgmii_txc),
        .xgmii_txd_o(xgmii_txd),
     
        //Config IF
        .rx_fcs_fwd_ena_i(1'b0),
        .rx_jumbo_ena_i(1'b1),
        .tx_fcs_fwd_ena_i(1'b0),
        .tx_fault_ena_i(1'b0),
        .tx_ifg_delay_ena_i(1'b0),
        .tx_ifg_delay_i(8'd3),
        //User IF
        .rx_mac_clk_o(rx_mac_clk),
        .rx_mac_valid_o(rx_mac_valid),
        .rx_mac_data_o(rx_mac_data),
        .rx_mac_byte_o(rx_mac_byte),
        .rx_mac_last_o(rx_mac_last),
        .rx_mac_error_o(rx_mac_error),
        .rx_statistics_valid_o(rx_statistics_valid),
        .rx_statistics_vector_o(rx_statistics_vector),
        
        .tx_mac_clk_o(tx_mac_clk),
        .tx_mac_valid_i(tx_mac_valid),
        .tx_mac_data_i(tx_mac_data),
        .tx_mac_byte_i(tx_mac_byte),
        .tx_mac_last_i(tx_mac_last),
        .tx_mac_error_i(tx_mac_error),
        .tx_mac_ready_o(tx_mac_ready),
        .tx_statistics_valid_o(tx_statistics_valid),
        .tx_statistics_vector_o(tx_statistics_vector),

        .local_fault_o(local_fault),
        .remote_fault_o(remote_fault)
    );
    

    //------tx user if--------
    XGbE_Send_UDP#(
	    .SRC_MAC(SRC_MAC),    //Source MAC Address
	    .SRC_IP(SRC_IP),      //Source IP Address
	    .SRC_PORT(SRC_PORT),  //Source UDP Port
	    .DES_MAC(DES_MAC),    //Destination MAC address
	    .DES_IP(DES_IP),      //Destination IP address
	    .DES_PORT(DES_PORT),  //Destination PORT
	    .DATA_SIZE(DATA_SIZE) //Data Length
    ) XGbE_udp_inst (
        .tx_mac_clk(tx_mac_clk),
	    .rst_n(xge_block_lock),
	    .tx_mac_data(tx_mac_data),
        .tx_mac_byte(tx_mac_byte),
        .tx_mac_ready(tx_mac_ready),
        .tx_mac_valid(tx_mac_valid),
        .tx_mac_last(tx_mac_last),
        .tx_mac_error(tx_mac_error)
    );
        
endmodule

