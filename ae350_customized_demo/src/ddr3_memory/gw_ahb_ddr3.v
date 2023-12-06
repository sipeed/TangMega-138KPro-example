//********************************************************************
//
//      Copyright ©2014-2023 Gowin Semiconductor Corporation.
//                      All rights reserved.
//
// <File>     : gw_ahb_ddr3.v
// <Author>   : EMB
// <Function> : Gowin AHB interface of DDR3 memory controller
// <Version>  : 1.0
// <Date>     : 2023
//
//********************************************************************

//-------------------------------- gw_ahb_ddr3_top -------------------------------//
module gw_ahb_ddr3_top
(
    // DDR3 I/F
    input   wire            DDR3_MEMORY_CLK,    // Memory clock
    input   wire            DDR3_CLK_IN,        // Clock in
    input   wire            DDR3_RSTN,          // Reset
    input   wire            DDR3_LOCK,          // PLL lock
    output  wire            DDR3_STOP,          // PLL stop
    output 	wire            DDR3_INIT,          // Initialized
    output  wire    [2:0]   DDR3_BANK,
    output  wire            DDR3_CS_N,
    output  wire            DDR3_RAS_N,
    output  wire            DDR3_CAS_N,
    output  wire            DDR3_WE_N,
    output  wire            DDR3_CK,
    output  wire            DDR3_CK_N,
    output  wire            DDR3_CKE,
    output  wire            DDR3_RESET_N,
    output  wire            DDR3_ODT,
    output  wire    [13:0]  DDR3_ADDR,
    output  wire    [1:0]   DDR3_DM,
    inout   wire    [15:0]  DDR3_DQ,
    inout   wire    [1:0]   DDR3_DQS,
    inout   wire    [1:0]   DDR3_DQS_N,
    // AHB bus I/F
    input   wire            HCLK,
    input   wire            HRESETN,
    input   wire    [31:0]  HADDR,
    input   wire    [2:0]   HSIZE,
    input   wire            HWRITE,
    input   wire    [1:0]   HTRANS,
    input   wire    [2:0]   HBURST,
    input   wire    [63:0]  HWDATA,
    output  wire            HREADY_O,
    output  wire    [1:0]   HRESP,
    output  wire    [63:0]  HRDATA
);

// gw_ahb_ddr3 instantiation
gw_ahb_ddr3 u_gw_ahb_ddr3
(
    .memory_clk                (DDR3_MEMORY_CLK),
    .pll_lock                  (DDR3_LOCK),
    .pll_stop                  (DDR3_STOP),
    .rst_n                     (DDR3_RSTN),
    .ddr_clk_in                (DDR3_CLK_IN),
    .init_calib_complete       (DDR3_INIT),
    .ddr_addr                  (DDR3_ADDR),
    .ddr_ba                    (DDR3_BANK),
    .ddr_cs_n                  (DDR3_CS_N),
    .ddr_ras_n                 (DDR3_RAS_N),
    .ddr_cas_n                 (DDR3_CAS_N),
    .ddr_we_n                  (DDR3_WE_N),
    .ddr_ck                    (DDR3_CK),
    .ddr_ck_n                  (DDR3_CK_N),
    .ddr_cke                   (DDR3_CKE),
    .ddr_dm                    (DDR3_DM),
    .ddr_dq                    (DDR3_DQ),
    .ddr_dqs                   (DDR3_DQS),
    .ddr_dqs_n                 (DDR3_DQS_N),
    .ddr_reset_n               (DDR3_RESET_N),
    .ddr_odt                   (DDR3_ODT),
    .HCLK                      (HCLK),
    .HRESETN                   (HRESETN),
    .HSEL                      (1'b1),
    .HREADY                    (HREADY_O),
    .HADDR                     (HADDR),
    .HSIZE                     (HSIZE),
    .HWRITE                    (HWRITE),
    .HTRANS                    (HTRANS),
    .HBURST                    (HBURST),
    .HREADY_O                  (HREADY_O),
    .HWDATA                    (HWDATA),
    .HRESP                     (HRESP),
    .HRDATA                    (HRDATA),
    .HSPLIT                    ()
);

endmodule










//-------------------------------------- gw_ahb_ddr3 --------------------------------//
module gw_ahb_ddr3
#(
    parameter   LANE_NUM         =  3 ,
    parameter   BRUST_MODE       =  16, //32,//64,//16
    parameter   ADDR_WIDTH       =  32,
    parameter   DATA_WIDTH       =  32,
    parameter   BRUST_COUNT      =  20
)
(
    input                       memory_clk,
    input                       pll_lock,
    output                      pll_stop,
    input                       rst_n,
    // AHB bus I/F
    input                       HCLK,
    input                       HRESETN,
    input                       HREADY,
    input                       HSEL,
    input             [31 : 0]  HADDR,
    input              [2 : 0]  HSIZE,
    input                       HWRITE,
    input              [1 : 0]  HTRANS,
    input              [2 : 0]  HBURST,
    input             [63 : 0]  HWDATA,
    output                      HREADY_O,
    output             [1 : 0]  HRESP,
    output            [15 : 0]  HSPLIT,
    output            [63 : 0]  HRDATA,
    // DDR Interface
    input                       ddr_clk_in,
    output                      init_calib_complete,
    output             [2 : 0]  ddr_ba,
    output                      ddr_cs_n,
    output                      ddr_ras_n,
    output                      ddr_cas_n,
    output                      ddr_we_n,
    output                      ddr_ck,
    output                      ddr_ck_n,
    output                      ddr_cke,
    output                      ddr_odt,
    output                      ddr_reset_n,
    output            [13 : 0]  ddr_addr,
    output             [1 : 0]  ddr_dm,
    inout             [15 : 0]  ddr_dq,
    inout              [1 : 0]  ddr_dqs,
    inout              [1 : 0]  ddr_dqs_n 
);


/////////////////////////////////////////////////////
// Parameter definitions
localparam [4: 0]  IDLE               = 4'd0;
localparam [4: 0]  SELECT_LANE        = 4'd1;
localparam [4: 0]  SELECT_LANE_WAIT_1 = 4'd2;
localparam [4: 0]  SELECT_LANE_WAIT_2 = 4'd3;
localparam [4: 0]  SELECT_LANE_CHK    = 4'd4;
localparam [4: 0]  LPDDR_WRITING_1    = 4'd5;
localparam [4: 0]  LPDDR_WRITING_2    = 4'd6;
localparam [4: 0]  LPDDR_READING      = 4'd7;
localparam [4: 0]  LPDDR_WR_END       = 4'd8;
localparam [4: 0]  LPDDR_RD_END       = 4'd9;
localparam [4: 0]  LPDDR_AHB          = 4'd10;


/////////////////////////////////////////////////////
// Register definitions
reg                 [3 : 0] c_status;
reg                 [3 : 0] n_status;

reg                         wr_req;
reg                         rd_req;
reg                         ahb_req;
reg                         wr_data_end;
reg                         rd_data_end;
reg                         ahb_end;

// DDR Signals
reg                [31 : 0] cmd_addr;
reg               [127 : 0] wr_data;
wire              [127 : 0] lpddr_rd_data;
wire                        lpddr_rd_valid;
wire                        lpddr_rd_end;
reg                [15 : 0] lpddr_wdata_mask;

reg                         lpddr_cmd_en;
reg                         lpddr_cmd;
wire                        lpddr_cmd_ready;
wire                        lpddr_data_ready;
reg                         lpddr_wdata_en;
reg                         lpddr_wdata_end;

// DDR work signals
reg                         lpddr_ready;
reg                 [7 : 0] lpddr_ready_cnt;
reg                 [7 : 0] lpddr_data_end_cnt;

// AHB bus signals
wire                        lpddr_ahb_end;
wire                        lpddr_ahb_req;
wire               [31 : 0] lpddr_addr_ahb;
wire                        lpddr_cmd_en_ahb;
wire                        lpddr_cmd_ahb;
wire                        lpddr_wdata_en_ahb;
wire                        lpddr_wdata_end_ahb;
wire              [127 : 0] lpddr_wr_data_ahb;
reg               [127 : 0] rd_data_lpddr_ahb;
reg                         rd_valid_p_ahb;
wire               [15 : 0] lpddr_wdata_mask_ahb;


//////////////////////////////////////////////////////////
//================= Need User Define ===================//
// LANE 0 WRITE Signal
reg                         rst_n_d1;
reg                         rst_n_d2;
reg                         lpddr_rst_n;
wire                        ddr_clk;

always @ (posedge ddr_clk or negedge rst_n) begin
    if(!rst_n) begin
        rst_n_d1    <= 1'b0;
        rst_n_d2    <= 1'b0;
        lpddr_rst_n <= 1'b0;
    end 
    else  begin
        rst_n_d1    <= 1'b1;
        rst_n_d2    <= rst_n_d1;
        lpddr_rst_n <= rst_n_d2;
    end
end

always @ (posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n)
        lpddr_ready <= 1'b0;
    else if(init_calib_complete)
        lpddr_ready <= 1'b1;
    else
        lpddr_ready <= 1'b0;
end

always @ (posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n)
        c_status <= IDLE;
    else
        c_status <= n_status;
end

always @ (*) begin
    case (c_status)
        IDLE: begin
            if ( lpddr_ready == 1'b1 )
                n_status = SELECT_LANE;
            else n_status = IDLE;
        end

        SELECT_LANE: begin
            n_status = SELECT_LANE_CHK;
        end

        SELECT_LANE_CHK: begin
            if( lpddr_cmd_ready && lpddr_data_ready && ahb_req )
                n_status = LPDDR_AHB;
            else if(ahb_req == 1'b0)
                n_status = IDLE;
            else 
                n_status = SELECT_LANE;
        end

        LPDDR_AHB: begin
            if (ahb_end)
                n_status = SELECT_LANE;
            else 
                n_status = LPDDR_AHB;
        end

        default: begin
            n_status = IDLE;
        end

    endcase
end

// Calculate Lane Number & ADDR & Burst Count
always @(posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n) begin
        ahb_end               <= 1'b0;
        ahb_req               <= 1'b0;
    end
    else begin
        ahb_end               <= lpddr_ahb_end;
        ahb_req               <= lpddr_ahb_req;
    end
end


// DDR ADDR & Write Data
always @ (posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n) begin
        cmd_addr               <= {32{1'b0}};
        wr_data                <= 'h0000_0000_0000_0000;
        lpddr_cmd_en           <= 1'b0;
        lpddr_cmd              <= 1'b0;
        lpddr_wdata_en         <= 1'b0;
        lpddr_wdata_end        <= 1'b0;
    end
    else begin
        cmd_addr               <= lpddr_addr_ahb;
        wr_data                <= lpddr_wr_data_ahb;
        lpddr_cmd_en           <= lpddr_cmd_en_ahb;
        lpddr_cmd              <= lpddr_cmd_ahb;
        lpddr_wdata_en         <= lpddr_wdata_en_ahb;
        lpddr_wdata_end        <= lpddr_wdata_end_ahb;
    end
end

always @ (posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n)
        lpddr_wdata_mask        <= 8'h00;
    else 
        lpddr_wdata_mask        <= lpddr_wdata_mask_ahb;
end

// Read Valid & Read Data from DDR
always @ (posedge ddr_clk or negedge lpddr_rst_n) begin
    if(!lpddr_rst_n) begin
        rd_valid_p_ahb         <= 1'b0;
    end
    else begin
        rd_valid_p_ahb          <= lpddr_rd_valid;
    end
end


// DDR3_Memeory_Interface_Top instantiation
DDR3_Memory_Interface_Top u_DDR3_Memory_Interface_Top
(
    .clk                     (ddr_clk_in),
    .pll_stop                (pll_stop),
    .memory_clk              (memory_clk),
    .pll_lock                (pll_lock),
    .rst_n                   (rst_n),
    .cmd_ready               (lpddr_cmd_ready),
    .cmd                     ({2'b00,lpddr_cmd}),
    .cmd_en                  (lpddr_cmd_en),
    .addr                    ({3'b000,cmd_addr[25:1]}),
    .wr_data_rdy             (lpddr_data_ready),
    .wr_data                 (wr_data),
    .wr_data_en              (lpddr_wdata_en),
    .wr_data_end             (lpddr_wdata_en),
    .wr_data_mask            (lpddr_wdata_mask),
    .rd_data                 (lpddr_rd_data),
    .rd_data_valid           (lpddr_rd_valid),
    .rd_data_end             (lpddr_rd_end),
    .sr_req                  (1'b0),
    .ref_req                 (1'b0),
    .sr_ack                  (),
    .ref_ack                 (),
    .init_calib_complete     (init_calib_complete),
    .clk_out                 (ddr_clk),
    .ddr_rst                 (),
    .burst                   (1'b1),
    .O_ddr_addr              (ddr_addr),
    .O_ddr_ba                (ddr_ba),
    .O_ddr_cs_n              (ddr_cs_n),
    .O_ddr_ras_n             (ddr_ras_n),
    .O_ddr_cas_n             (ddr_cas_n),
    .O_ddr_we_n              (ddr_we_n),
    .O_ddr_clk               (ddr_ck),
    .O_ddr_clk_n             (ddr_ck_n),
    .O_ddr_cke               (ddr_cke),
    .O_ddr_odt               (ddr_odt),
    .O_ddr_reset_n           (ddr_reset_n),
    .O_ddr_dqm               (ddr_dm),
    .IO_ddr_dq               (ddr_dq),
    .IO_ddr_dqs              (ddr_dqs),
    .IO_ddr_dqs_n            (ddr_dqs_n)
);


// ddr3_memory_and_ahb_bus instantiation
ddr3_memory_and_ahb_bus u_ddr3_memory_and_ahb_bus
(
    .lpddr_clk         (ddr_clk),
    .rst_n             (rst_n&init_calib_complete & HRESETN),
    .c_status          (c_status),
    .n_status          (n_status),
    .lpddr_rdata       (lpddr_rd_data),
    .rd_valid_p        (rd_valid_p_ahb),
    .lpddr_wr_data     (lpddr_wr_data_ahb),
    .lpddr_addr        (lpddr_addr_ahb),
    .lpddr_cmd         (lpddr_cmd_ahb),
    .lpddr_cmd_en      (lpddr_cmd_en_ahb),
    .lpddr_cmd_ready   (lpddr_cmd_ready),
    .lpddr_data_ready  (lpddr_data_ready),
    .lpddr_wdata_en    (lpddr_wdata_en_ahb),
    .lpddr_wdata_end   (lpddr_wdata_end_ahb),
    .lpddr_wdata_mask  (lpddr_wdata_mask_ahb),
    .ahb_end           (lpddr_ahb_end),
    .ahb_req           (lpddr_ahb_req),
    .HCLK              (HCLK),
    .HRESETN           (HRESETN),
    .HSEL              (HSEL),
    .HREADY            (HREADY),
    .HADDR             (HADDR),
    .HSIZE             (HSIZE),
    .HWRITE            (HWRITE),
    .HTRANS            (HTRANS),
    .HBURST            (HBURST),
    .HWDATA            (HWDATA),
    .HREADY_O          (HREADY_O),
    .HRESP             (HRESP),
    .HRDATA            (HRDATA),
    .HSPLIT            (HSPLIT)
);

endmodule










//--------------------------------------- ddr3_memory_and_ahb_bus -----------------------------------//
module ddr3_memory_and_ahb_bus
(
    lpddr_clk,
    rst_n,
    c_status,
    n_status,
    lpddr_wr_data,
    lpddr_addr, 
    lpddr_cmd,
    lpddr_cmd_en,
    lpddr_cmd_ready,
    lpddr_data_ready,
    lpddr_wdata_en,
    lpddr_wdata_end,
    lpddr_wdata_mask,
    lpddr_rdata,
    rd_valid_p,
    ahb_end,
    ahb_req,
    HCLK,
    HRESETN,
    HSEL,
    HREADY,
    HADDR,
    HSIZE,
    HWRITE,
    HTRANS,
    HBURST,
    HWDATA,
    HREADY_O,
    HRESP,
    HRDATA,
    HSPLIT
);


input                              lpddr_clk;
input                              rst_n;
input                      [3 : 0] c_status;
input                      [3 : 0] n_status;
input                    [127 : 0] lpddr_rdata;
output                   [127 : 0] lpddr_wr_data;
output                    [31 : 0] lpddr_addr;
input                              rd_valid_p;
output                             lpddr_cmd;
output                             lpddr_cmd_en;
input                              lpddr_cmd_ready;
input                              lpddr_data_ready;
output  reg                        lpddr_wdata_en;
output  reg                        lpddr_wdata_end;
output                    [15 : 0] lpddr_wdata_mask;
output  reg                        ahb_end;
output  reg                        ahb_req;
input                              HCLK;
input                              HRESETN;
input                              HREADY;
input                              HSEL;
input                     [31 : 0] HADDR;
input                      [2 : 0] HSIZE;
input                              HWRITE;
input                      [1 : 0] HTRANS;
input                      [2 : 0] HBURST;
input                     [63 : 0] HWDATA;
output                             HREADY_O;
output                     [1 : 0] HRESP;
output                    [15 : 0] HSPLIT;
output                    [63 : 0] HRDATA;
 

localparam [4 : 0]  IDLE               = 4'd0;
localparam [4 : 0]  SELECT_LANE        = 4'd1;
localparam [4 : 0]  SELECT_LANE_WAIT_1 = 4'd2;
localparam [4 : 0]  SELECT_LANE_WAIT_2 = 4'd3;
localparam [4 : 0]  SELECT_LANE_CHK    = 4'd4;
localparam [4 : 0]  LPDDR_WRITING_1    = 4'd5;
localparam [4 : 0]  LPDDR_WRITING_2    = 4'd6;
localparam [4 : 0]  LPDDR_READING      = 4'd7;
localparam [4 : 0]  LPDDR_WR_END       = 4'd8;
localparam [4 : 0]  LPDDR_RD_END       = 4'd9;
localparam [4 : 0]  LPDDR_AHB          = 4'd10;

// AHB ops
// HBURST
localparam [2 : 0]  SINGLE = 0; 
localparam [2 : 0]  INCR   = 1;
localparam [2 : 0]  WRAP4  = 2;
localparam [2 : 0]  INCR4  = 3;
localparam [2 : 0]  WRAP8  = 4;
localparam [2 : 0]  INCR8  = 5;
localparam [2 : 0]  WRAP16 = 6;
localparam [2 : 0]  INCR16 = 7;
// HTRANS
localparam [1 : 0]  BUSY   = 1;
localparam [1 : 0]  NONSEQ = 2;
localparam [1 : 0]  SEQ    = 3;
localparam [3 : 0]  S_VLD_CNT = 1;
localparam [3 : 0]	WR_DLY = 4;

// Registers
reg              hready;
wire             hsel;
reg              hsel_r;

reg      [1 : 0] hwrite_d;
reg              hwrite_r;
reg     [31 : 0] haddr_r;
reg     [31 : 0] haddr_wr;
reg      [2 : 0] hsize_r /*syntheis preserve=1*/;
reg      [1 : 0] htrans_r;
reg      [2 : 0] hburst_r;

reg              fifo_wr;
wire             Almost_Full;

reg    [167 : 0] fifo_wdata;

reg              fifo_rd;
wire   [167 : 0] Q;

reg     [31 : 0] app_addr;
reg              app_cmd;
reg              app_cmd_en;
reg    [127 : 0] app_wdata;
reg      [7 : 0] app_mask;
reg              app_wdf_en;
reg              app_wdf_end;
wire   [127 : 0] ddr_rd_data;

reg      [4 : 0] ddr_pstate;
reg      [4 : 0] ddr_nstate;


wire             ddr_rst;
wire             lpddr_clk;
wire             rdfifo_empty;
wire    [63 : 0] ahb_rd_o;
reg    [127 : 0] hrdata_reg;
wire             cmd_ready;
wire             wr_data_rdy;

reg              ahbr_flag,ahbw_flag;
reg              ahbr_start,ahbw_start;
reg              ahbr_end_flag;
wire             ahbw_end_flag;
reg              ahbr_cmd_flag;

reg              ahbw_single;
reg              ahbw_incr16;
reg      [6 : 0] ahbw_incr16_cnt;
reg              ahbr_single;
reg              ahbr_incr16;
reg      [6 : 0] ahbr_cnt;
reg              ahbr_op;
reg              data_valid_dly;
reg              data_valid;
wire     [4 : 0] addr_wrap;
wire    [15 : 0] ahb_mask_d0;
wire    [15 : 0] ahb_mask_d1;

reg      [1 : 0] ahb_mask_2word;
reg      [7 : 0] ahb_mask_word;
reg      [7 : 0] ahb_mask_byte;
reg      [7 : 0] ahb_mask_halfword;

reg      [2 : 0] valid_cnd;
reg     [63 : 0] adata_datal0;
reg      [4 : 0] ddr_burstrd_cnt;

reg              wr_end;
reg              rd_end;
reg     [63 : 0] lpddr_rdata_d;
wire   [127 : 0] lpddr_rdata_buf;

reg	     [3 : 0] beat_cnt;
reg              hwr_en;
reg              hrd_en;

// wr fifo
reg      [3 : 0] wr_cnt;
wire             fifo_ahb_wr_wren;
wire             fifo_ahb_wr_rden;
wire   [127 : 0] fifo_ahb_wr_data;
wire   [127 : 0] fifo_ahb_rd_data;
wire             fifo_wr_empty;
wire             fifo_wr_full;
wire    [63 : 0] ahb_wr_data_q;
wire    [31 : 0] ahb_wr_addr_q;
wire    [15 : 0] ahb_wr_mask_q;

wire             hwrite_buf_wren;
reg	             hwrite_buf_rden;
wire             hwrite_buf_afull;
wire             hwrite_buf_empty;
wire             hwrite_buf_full;
wire   [127 : 0] hwrite_buf_data_in;
wire   [127 : 0] hwrite_buf_data_out;
wire    [31 : 0] haddr_q;
wire    [63 : 0] hwdata_q;
wire    [ 2 : 0] hsize_q /*syntheis preserve=1*/;

// rd fifo
wire             fifo_rd_empty;
wire             fifo_rd_full;
reg              fifo_ahb_rd_rden;
reg      [3 : 0] fifo_ahb_rd_cnt;

// AHB logics
wire             hwrite_s,hread_s;
wire             hwrite_neg;
  
assign hsel       = HREADY & HSEL & HTRANS[1];
assign hwrite_s   =  HWRITE & hsel;
assign hread_s    = !HWRITE & hsel;
assign hwrite_neg = !hwrite_d[0] & hwrite_d[1];

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        hwrite_d <= 'b0;
    else 
        hwrite_d <= {hwrite_d[0],hwrite_s};
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        haddr_r  <= 'b0;
    else if(hread_s && !ahbr_start && !ahbr_flag)
        haddr_r  <= HADDR ;
    else
        haddr_r  <= haddr_r;
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        haddr_wr  <= 'b0;
    else if(hwrite_s)
        haddr_wr  <= HADDR ;
    else
        haddr_wr  <= haddr_wr;
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        ahbr_flag <= 1'b0;
    else if(ahb_req && !ahbw_single)
        ahbr_flag <= 1'b0;
    else if(HREADY & HSEL & !HWRITE & (HTRANS[1] == 1'b1))
        ahbr_flag <= 1'b1;
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        ahbr_start <= 1'b0;
    else if(ahbr_cmd_flag)
        ahbr_start <= 1'b0;
    else if(ahbr_single & ahbr_flag)
        ahbr_start <= 1'b1;
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        hsize_r <= 1'b0;
    else if(hsel) 
        hsize_r <= HSIZE ;
    else  
        hsize_r <= hsize_r;
end
  
always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        ahbw_single <= 1'b0;
    else if(ahb_end)
        ahbw_single <= 1'b0;
    else if(!ahbw_single & !fifo_wr_empty & !ahbr_flag & !ahbr_single)  //only 1 op allowed
        ahbw_single <= 1'b1;
end

always @(posedge HCLK or negedge HRESETN) begin
    if(!HRESETN)
        ahbr_single <= 1'b0;
    else if(ahbr_single & data_valid & (fifo_ahb_rd_cnt > S_VLD_CNT))
        ahbr_single <= 1'b0;
    else if(!ahbw_single  & !ahbr_single & ahbr_flag)
        ahbr_single <= 1'b1;
end

always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN)
        hready <= 1'b1;
    else if(HREADY & HSEL & !HWRITE & (HTRANS[1] == 1'b1))  // single read
        hready <= 1'b0;//!Almost_Full;
    else if(ahbr_flag)
        hready <= 1'b0;
    else if(ahbr_single && data_valid)
        hready <= (fifo_ahb_rd_cnt==S_VLD_CNT+1);
    else if(ahb_end & ahbw_single)
        hready <= !Almost_Full && !hwrite_buf_afull;
    else if(HREADY & HSEL & HWRITE & (HTRANS[1] == 1'b1))   // single write
        hready <= 1'b0;
end


// to ddr ui
reg        app_cmd_a;
reg        app_cmd_c;
reg [2:0]  app_cmd_d;
wire       lpddr_cmd_en_c;
wire       lpddr_cmd_en_d;

// DDR CMD 
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        app_cmd  <= 1'b0;
    else if(ahb_end)
        app_cmd <= 1'b0;
    else if(ahbw_single)
        app_cmd <= 1'b0;
    else if(ahbr_single)
        app_cmd <= 1'b1;
end

assign lpddr_cmd = app_cmd;

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        ahb_req <= 1'b0;
    else if(ahb_end && !ahbr_single && !ahbw_single)
        ahb_req <= 1'b0;
    else if(!ahb_end &&  !fifo_wr_empty)
        ahb_req <= 1'b1;
    else if(ahbr_single && !ahb_end)
        ahb_req <= 1'b1;
end

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        app_cmd_a <= 1'b0;
    else if(ahb_end)
        app_cmd_a <= 1'b0 ;
    else if(ahb_req && (c_status == LPDDR_AHB))
        app_cmd_a <= 1'b1;
end

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
       app_cmd_c  <= 1'b0;
    else if(app_cmd_a && lpddr_cmd_ready && lpddr_data_ready && c_status == LPDDR_AHB)
       app_cmd_c  <= 1'b1 ;
    else
       app_cmd_c  <= 1'b0;
end

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
       app_cmd_d  <= 2'b0;
    else 
       app_cmd_d[2:0]  <= {app_cmd_d[1:0] ,app_cmd_c};
end

assign lpddr_cmd_en_c = app_cmd_c & (~app_cmd_d[0]);
assign lpddr_cmd_en_d = app_cmd_d[0] & (~app_cmd_d[1]);
assign lpddr_cmd_en   = app_cmd_d[1] & (~app_cmd_d[2]);

// DDR ADDR
wire [31:0] ahb_cmd_addr0;  //0010_0000[ROM] 2010_0000[RAM] 8000_0000[USER RAM]
wire [31:0] ahb_cmd_addr1;  //0010_0000[ROM] 2010_0000[RAM] 8000_0000[USER RAM]
assign ahb_cmd_addr0 = haddr_r;
assign ahb_cmd_addr1 = ahb_wr_addr_q;

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        app_addr <= 'b0;
    else if(ahbw_single & lpddr_cmd_en_d)
        app_addr <= {ahb_cmd_addr1[31:4],4'h0} ;
    else if(ahbr_single & lpddr_cmd_en_d)	
        app_addr <= {ahb_cmd_addr0[31:4],ahb_cmd_addr0[3],3'b0};// ddr x1
    else 
        app_addr <= app_addr;
end
assign lpddr_addr = app_addr;

// DDR Write DATA
always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN)
        adata_datal0  <= 'b0;
    else if(hwrite_d[0])
        adata_datal0  <= HWDATA;
end  
  
always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN)
        hwrite_buf_rden  <= 'b0;
    else if(!hwrite_buf_empty && !ahbw_flag && !Almost_Full)
        hwrite_buf_rden  <= 1'b1;
    else
        hwrite_buf_rden  <= 'b0;
end

always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN) 
        ahbw_flag <= 1'b0;
    else if(hwrite_buf_rden)
        ahbw_flag <= 1'b1;
    else if(ahbw_start)
        ahbw_flag <= 1'b0;
end

always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN)
        ahbw_start <= 1'b0;
    else if(wr_cnt == WR_DLY)
        ahbw_start <= 1'b1;
    else
        ahbw_start <= 1'b0;
end

assign hwrite_buf_data_in         = {29'h0,hsize_r,haddr_wr,adata_datal0};//3 32 64
assign hwrite_buf_wren            = hwrite_d[1];
assign {hsize_q,haddr_q,hwdata_q} = hwrite_buf_data_out[3+32+64-1:0];

ddr3_memory_wrfifo u_hwrite_buf
(
    .RdClk        (HCLK),
    .WrClk        (HCLK),
    .WrEn         (hwrite_buf_wren),
    .RdEn         (hwrite_buf_rden),
    .Reset        (!HRESETN),
    .Data         (hwrite_buf_data_in),
    .Empty        (hwrite_buf_empty),
    .Full         (hwrite_buf_full),
    .Almost_Full  (hwrite_buf_afull),
    .Almost_Empty (),
    .Q            (hwrite_buf_data_out)
);

always @(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN)
        wr_cnt  <= 'b0;
    else if(ahbw_start)
        wr_cnt  <= 0;
    else if(ahbw_flag)
        wr_cnt  <= (wr_cnt == WR_DLY) ? wr_cnt : wr_cnt+1;
end

assign fifo_ahb_wr_wren = (wr_cnt == WR_DLY-1);
assign fifo_ahb_wr_data = (wr_cnt == WR_DLY-1) ? {16'h0,ahb_mask_d0,haddr_q,hwdata_q}:128'h0;

assign fifo_ahb_wr_rden = (lpddr_cmd_en_c);
assign lpddr_wr_data    = {2{ahb_wr_data_q}};
assign ahb_wr_data_q    = fifo_ahb_rd_data[63:0];
assign ahb_wr_addr_q    = fifo_ahb_rd_data[95:64];
assign ahb_wr_mask_q    = fifo_ahb_rd_data[111:96];
assign lpddr_wdata_mask =  ahb_wr_mask_q;

ddr3_memory_wrfifo u_fifo_wr
(
    .RdClk        (lpddr_clk),
    .WrClk        (HCLK),
    .WrEn         (fifo_ahb_wr_wren),
    .RdEn         (fifo_ahb_wr_rden),
    .Reset        (!HRESETN),
    .Data         (fifo_ahb_wr_data),
    .Empty        (fifo_wr_empty),
    .Full         (fifo_wr_full),
    .Almost_Full  (Almost_Full),
    .Almost_Empty (),
    .Q            (fifo_ahb_rd_data)
);

always@(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN) begin
        ahb_mask_2word <= 'b0;
        ahb_mask_word <= 'b0;
        ahb_mask_byte <= 'b0;
        ahb_mask_halfword <= 'b0;
    end
    else begin
        ahb_mask_2word <= (haddr_q[3] == 1'b0) ? 2'b10 :
                          (haddr_q[3] == 1'b1) ? 2'b01 :2'b0;

        ahb_mask_byte <= (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b000) ? 8'b1111_1110 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b001) ? 8'b1111_1101 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b010) ? 8'b1111_1011 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b011) ? 8'b1111_0111 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b100) ? 8'b1110_1111 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b101) ? 8'b1101_1111 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b110) ? 8'b1011_1111 :
                         (hsize_q[2:0] == 3'b000 &&haddr_q [2:0] == 3'b111) ? 8'b0111_1111 : 8'b0;

        ahb_mask_halfword <= (hsize_q[2:0] == 3'b001 && haddr_q[2:1] == 2'b00) ? 8'b1111_1100 :
                        (hsize_q[2:0] == 3'b001 && haddr_q[2:1] == 2'b01) ? 8'b1111_0011 :
                        (hsize_q[2:0] == 3'b001 && haddr_q[2:1] == 2'b10) ? 8'b1100_1111 :
                        (hsize_q[2:0] == 3'b001 && haddr_q[2:1] == 2'b11) ? 8'b0011_1111 :8'b0;

        ahb_mask_word <= (hsize_q[2:0] == 3'b010 && haddr_q[2] == 1'b0) ? 8'b1111_0000 :
                        (hsize_q[2:0] == 3'b010 && haddr_q[2] == 1'b1) ? 8'b0000_1111 :8'b0;
    end
end

assign ahb_mask_d0 = (hsize_q[2:0] == 3'b000 && !ahb_mask_2word[0])	?	{8'hFF,ahb_mask_byte}       :
                     (hsize_q[2:0] == 3'b000 && !ahb_mask_2word[1])	?	{ahb_mask_byte,8'hFF}       :
                     (hsize_q[2:0] == 3'b001 && !ahb_mask_2word[0])	?	{8'hFF,ahb_mask_halfword}   :
                     (hsize_q[2:0] == 3'b001 && !ahb_mask_2word[1])	?	{ahb_mask_halfword,8'hFF}   :
                     (hsize_q[2:0] == 3'b010 && !ahb_mask_2word[0])	?	{8'hFF,ahb_mask_word}       :
                     (hsize_q[2:0] == 3'b010 && !ahb_mask_2word[1])	?	{ahb_mask_word,8'hFF}       :
                     {{8{ahb_mask_2word[1]}},{8{ahb_mask_2word[0]}}};

// DDR DATA EN
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
       lpddr_wdata_en <= 1'b0;
    else if((lpddr_cmd_en_d) && ahbw_single)
       lpddr_wdata_en <= 1'b1;
    else
       lpddr_wdata_en <= 1'b0;
end

always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        lpddr_wdata_end <= 1'b0;
    else if(lpddr_cmd_en_d  && ahbw_single)
        lpddr_wdata_end <= 1'b1;
    else
        lpddr_wdata_end <= 1'b0;
end

// Current Lane start LPDDR write end (One time of whole LPDDR write)
// Change to next Lane
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        ahb_end <= 1'b0;
    else if(ahbw_single && lpddr_cmd_en && c_status == LPDDR_AHB)
        ahb_end <= 1'b1;
    else if(ahbr_single && data_valid && c_status == LPDDR_AHB)
        ahb_end <= 1'b1;
    else if(ahb_end && !ahbr_single && !ahbw_single && !ahb_req)
        ahb_end <= 1'b0 ;
end

reg [2:0]lpddr_cmd_en_flag;
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        lpddr_cmd_en_flag <= 1'b0;
    else 
        lpddr_cmd_en_flag <= {lpddr_cmd_en_flag[1:0],lpddr_cmd_en};
end
 
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
        ahbr_cmd_flag <= 1'b0;
    else if(ahbr_single && (|lpddr_cmd_en_flag))
        ahbr_cmd_flag <= 1'b1;
    else if(ahbr_cmd_flag && !ahbr_start)
        ahbr_cmd_flag <= 1'b0;
end

always@(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN) 
        fifo_ahb_rd_rden <= 1'b0;
    else
        fifo_ahb_rd_rden <= !fifo_rd_empty;
end
  
always@(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN) 
        fifo_ahb_rd_cnt <= 'b0;
    else if(fifo_ahb_rd_rden)
        fifo_ahb_rd_cnt <= fifo_ahb_rd_cnt+1;
    else
        fifo_ahb_rd_cnt <= 'b0;
end

always@(posedge HCLK or negedge HRESETN) begin
    if (!HRESETN) 
        data_valid <= 1'b0;
    else
        data_valid <= fifo_ahb_rd_rden;
end

assign HRESP    =  2'b0;
assign HSPLIT   = 16'b0;
assign HREADY_O = hready;
assign HRDATA   = hrdata_reg[63:0];

always@(posedge HCLK or negedge HRESETN) begin
if (!HRESETN) 
    hrdata_reg <= 128'h0000;
else if ((fifo_ahb_rd_cnt == S_VLD_CNT) && data_valid)
    hrdata_reg <= lpddr_rdata_buf;
end

reg [127:0]  rd_data_lpddr_d;
always @ (posedge lpddr_clk or negedge rst_n) begin
    if(!rst_n)
       rd_data_lpddr_d <= 128'b0;
    else 
       rd_data_lpddr_d <= lpddr_rdata;
end

// Read data fifo
ddr3_memory_rdfifo u_fifo_rd
(
    .RdClk        (HCLK),
    .WrClk        (lpddr_clk),
    .WrEn         (rd_valid_p),
    .RdEn         (fifo_ahb_rd_rden),
    .Reset        (!HRESETN),
    .Data         (rd_data_lpddr_d),
    .Empty        (fifo_rd_empty),
    .Full         (fifo_rd_full),
    .Almost_Empty (),
    .Almost_Full  (),
    .Q            (lpddr_rdata_buf)
);

endmodule