
// RiscV_AE350_SOC customized demo
// DDR3 Memory Interface IP customized and configured
module ae350_customized_demo
(
    input CLK,
    input RSTN,
    // GPIO
    inout [2:0] LED,     // 2:0
    inout [2:0] KEY,     // 5:3
    // UART2
    output UART2_TXD,
    input  UART2_RXD,
    // SPI Flash Memory
    inout FLASH_SPI_CSN,
    inout FLASH_SPI_MISO,
    inout FLASH_SPI_MOSI,
    inout FLASH_SPI_CLK,
    inout FLASH_SPI_HOLDN,
    inout FLASH_SPI_WPN,
    // DDR3 Memory
    output DDR3_INIT,
    output [2:0] DDR3_BANK,
    output DDR3_CS_N,
    output DDR3_RAS_N,
    output DDR3_CAS_N,
    output DDR3_WE_N,
    output DDR3_CK,
    output DDR3_CK_N,
    output DDR3_CKE,
    output DDR3_RESET_N,
    output DDR3_ODT,
    output [13:0] DDR3_ADDR,
    output [1:0] DDR3_DM,
    inout [15:0] DDR3_DQ,
    inout [1:0] DDR3_DQS,
    inout [1:0] DDR3_DQS_N,
    // JTAG
    input TCK_IN,
    input TMS_IN,
    input TRST_IN,
    input TDI_IN,
    output TDO_OUT
);


wire CORE_CLK;
wire DDR_CLK;
wire AHB_CLK;
wire APB_CLK;
wire RTC_CLK;

wire DDR3_MEMORY_CLK;
wire DDR3_CLK_IN;
wire DDR3_LOCK;
wire DDR3_STOP;


// Gowin_PLL_AE350 instantiation
Gowin_PLL_AE350 u_Gowin_PLL_AE350
(
    .clkout0(DDR_CLK),          // 50MHz
    .clkout1(CORE_CLK),         // 800MHz
    .clkout2(AHB_CLK),          // 100MHz
    .clkout3(APB_CLK),          // 100MHz
    .clkout4(RTC_CLK),          // 10MHz
    .clkin(CLK),
    .enclk0(1'b1),
    .enclk1(1'b1),
    .enclk2(1'b1),
    .enclk3(1'b1),
    .enclk4(1'b1)
);


// Gowin_PLL_DDR3 instantiation
Gowin_PLL_DDR3 u_Gowin_PLL_DDR3
(
    .lock(DDR3_LOCK),
    .clkout0(DDR3_CLK_IN),          // 50MHz
    .clkout2(DDR3_MEMORY_CLK),      // 200MHz
    .clkin(CLK),
    .reset(1'b0),                   // Enforce
    .enclk0(1'b1),
    .enclk2(DDR3_STOP)
);


wire ae350_rstn;                    // AE350 power on and hardware reset in
wire ddr3_rstn;                     // DDR3 memory reset in
wire ddr3_init_completed;           // DDR3 memory initialized completed

assign DDR3_INIT = ~ddr3_init_completed;


// key_debounce instantiation
// DDR3 memory reset in key debounce
key_debounce u_key_debounce_ddr3
(
    .out(ddr3_rstn),
    .in(RSTN),
    .clk(CLK),      // 50MHz
    .rstn(1'b1)
);


// key_debounce instantiation
// AE350 power on and hardware reset in key debounce
key_debounce u_key_debounce_ae350
(
    .out(ae350_rstn),
    .in(ddr3_init_completed),
    .clk(CLK),      // 50MHz
    .rstn(1'b1)
);


// DDR AHB signals
wire [63:0] DDR_HRDATA;
wire DDR_HREADY;
wire DDR_HRESP;
wire [31:0] DDR_HADDR;
wire [2:0] DDR_HBURST;
wire [3:0] DDR_HPROT;
wire [2:0] DDR_HSIZE;
wire [1:0] DDR_HTRANS;
wire [63:0] DDR_HWDATA;
wire DDR_HWRITE;
wire DDR_HCLK;
wire DDR_HRSTN;


// gw_ahb_ddr3_top instantiation
gw_ahb_ddr3_top u_gw_ahb_ddr3_top
(
    // DDR3 I/F
    .DDR3_MEMORY_CLK(DDR3_MEMORY_CLK),  // Memory clock 400MHz
    .DDR3_CLK_IN(DDR3_CLK_IN),          // Clock input 50MHz
    .DDR3_RSTN(ddr3_rstn),              // Reset input
    .DDR3_LOCK(DDR3_LOCK),              // PLL lock
    .DDR3_STOP(DDR3_STOP),              // PLL stop
    .DDR3_INIT(ddr3_init_completed),    // Initialized
    .DDR3_BANK(DDR3_BANK),
    .DDR3_CS_N(DDR3_CS_N),
    .DDR3_RAS_N(DDR3_RAS_N),
    .DDR3_CAS_N(DDR3_CAS_N),
    .DDR3_WE_N(DDR3_WE_N),
    .DDR3_CK(DDR3_CK),
    .DDR3_CK_N(DDR3_CK_N),
    .DDR3_CKE(DDR3_CKE),
    .DDR3_RESET_N(DDR3_RESET_N),
    .DDR3_ODT(DDR3_ODT),
    .DDR3_ADDR(DDR3_ADDR),
    .DDR3_DM(DDR3_DM),
    .DDR3_DQ(DDR3_DQ),
    .DDR3_DQS(DDR3_DQS),
    .DDR3_DQS_N(DDR3_DQS_N),
    // AHB bus I/F
    .HCLK(DDR_HCLK),
    .HRESETN(DDR_HRSTN),
    .HADDR(DDR_HADDR),
    .HSIZE(DDR_HSIZE),
    .HWRITE(DDR_HWRITE),
    .HTRANS(DDR_HTRANS),
    .HBURST(DDR_HBURST),
    .HWDATA(DDR_HWDATA),
    .HREADY_O(DDR_HREADY),
    .HRESP(DDR_HRESP),
    .HRDATA(DDR_HRDATA)
);


// RiscV_AE350_SOC_Top instantiation
RiscV_AE350_SOC_Top u_RiscV_AE350_SOC_Top
(
    .FLASH_SPI_CSN(FLASH_SPI_CSN),
    .FLASH_SPI_MISO(FLASH_SPI_MISO),
    .FLASH_SPI_MOSI(FLASH_SPI_MOSI),
    .FLASH_SPI_CLK(FLASH_SPI_CLK),
    .FLASH_SPI_HOLDN(FLASH_SPI_HOLDN),
    .FLASH_SPI_WPN(FLASH_SPI_WPN),
    .DDR_HRDATA(DDR_HRDATA),
    .DDR_HREADY(DDR_HREADY),
    .DDR_HRESP(DDR_HRESP),
    .DDR_HADDR(DDR_HADDR),
    .DDR_HBURST(DDR_HBURST),
    .DDR_HPROT(DDR_HPROT),
    .DDR_HSIZE(DDR_HSIZE),
    .DDR_HTRANS(DDR_HTRANS),
    .DDR_HWDATA(DDR_HWDATA),
    .DDR_HWRITE(DDR_HWRITE),
    .DDR_HCLK(DDR_HCLK),
    .DDR_HRSTN(DDR_HRSTN),
    .TCK_IN(TCK_IN),
    .TMS_IN(TMS_IN),
    .TRST_IN(TRST_IN),
    .TDI_IN(TDI_IN),
    .TDO_OUT(TDO_OUT),
    .TDO_OE(),
    .UART2_TXD(UART2_TXD),
    .UART2_RTSN(),
    .UART2_RXD(UART2_RXD),
    .UART2_CTSN(),
    .UART2_DCDN(),
    .UART2_DSRN(),
    .UART2_RIN(),
    .UART2_DTRN(),
    .UART2_OUT1N(),
    .UART2_OUT2N(),
    .GPIO({KEY, LED}),
    .CORE_CLK(CORE_CLK),
    .DDR_CLK(DDR_CLK),
    .AHB_CLK(AHB_CLK),
    .APB_CLK(APB_CLK),
    .RTC_CLK(RTC_CLK),
    .POR_RSTN(ae350_rstn),              // AE350 CPU core power on reset, 0 is reset state
    .HW_RSTN(ae350_rstn)                // AE350 hardware reset, 0 is reset state
);

endmodule