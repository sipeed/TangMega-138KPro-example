module top(
    clk,
    rst_n,
    ddr_addr,
    ddr_bank,
    ddr_cs,
    ddr_ras,
    ddr_cas,
    ddr_we,
    ddr_ck,
    ddr_ck_n,
    ddr_cke,
    ddr_odt,
    ddr_reset_n,
    ddr_dm,
    ddr_dq,
    ddr_dqs,
    ddr_dqs_n,
    test_pt,
    state_led
);    
    input clk;
    output [15-1:0]             ddr_addr;       //ROW_WIDTH=15
    output [3-1:0]              ddr_bank;       //BANK_WIDTH=3
    output                      ddr_cs;
    output                      ddr_ras;
    output                      ddr_cas;
    output                      ddr_we;
    output                      ddr_ck;
    output                      ddr_ck_n;
    output                      ddr_cke;
    output                      ddr_odt;
    output                      ddr_reset_n;
    output [4-1:0]              ddr_dm;         //DM_WIDTH=2
    inout  [32-1:0]             ddr_dq;         //DQ_WIDTH=32
    inout  [4-1:0]              ddr_dqs;        //DQS_WIDTH=2
    inout  [4-1:0]              ddr_dqs_n;      //DQS_WIDTH=2
    input                       rst_n;
    output                      test_pt;

    output [5:0]                state_led;                 

    wire                        app_wdf_wren;
    wire  [32-1:0]              app_wdf_mask;    //APP_MASK_WIDTH=16
    wire                        app_wdf_end; 
    wire [256-1:0]              app_wdf_data;    //APP_DATA_WIDTH=256
    wire                        app_en;
    wire [2:0]                  app_cmd;
    wire [29-1:0]               app_addr;        //ADDR_WIDTH=29
    wire                        app_sre_req;
    wire                        app_ref_req;
    wire                        app_burst;
    wire                        app_sre_act;
    wire                        app_ref_ack;
    wire                        app_wdf_rdy;
    wire                        app_rdy;
    wire                        app_rd_data_valid; 
    wire                        app_rd_data_end;
    wire [256-1:0]              app_rd_data;     //APP_DATA_WIDTH=256
    
    

assign  test_pt = clk_x1;

assign state_led[5] = ~app_wdf_rdy;
assign state_led[4] = ~led;
assign state_led[3] = ~error;
assign state_led[2] = ~pll_stop;
assign state_led[1] = ~pll_lock; 
assign state_led[0] = ~init_calib_complete; //DDR3_init_indicator

wire clk;
wire pll_lock;
wire memory_clk;
wire err;
wire clk_x1;
wire clk50m;
wire init_calib_complete;

wire pll_stop;

reg led;

assign error = ~err;
//assign error1 = err;

reg [31:0] led_cnt;

always@(posedge clk_x1)begin // clk_x1 CLK from DDR IP 
    if(led_cnt >= 50_000_000) begin
            led <= ~led;
            led_cnt <= 'd0;
    end
    else
            led_cnt <= led_cnt + 1'b1;
end


Gowin_PLL Gowin_PLL_inst(
.lock(pll_lock), 
.clkout0(), 
.clkout1(clk50m), 
.clkout2(memory_clk),
.clkin(clk), 
.reset(1'b0),
.enclk0(1'b1), //input enclk0
.enclk1(1'b1), //input enclk1
.enclk2(pll_stop) //input enclk2
);

ddr3_test1  #
    (
     .ADDR_WIDTH(29) ,          //ADDR_WIDTH=29
     .APP_DATA_WIDTH(256) ,     //APP_DATA_WIDTH=256
     .APP_MASK_WIDTH (32),      //APP_MASK_WIDTH=32
     .USER_REFRESH("OFF")
    )u_rd(
    .clk                (clk_x1),
    .rst                (~rst_n),  
    .app_rdy            (app_rdy),
    .app_en             (app_en),
    .app_cmd            (app_cmd),
    .app_addr           (app_addr),
    .app_wdf_data       (app_wdf_data),
    .app_wdf_wren       (app_wdf_wren),
    .app_wdf_end        (app_wdf_end),
    .app_wdf_mask       (app_wdf_mask),
    .app_burst          (app_burst),
    .app_rd_data_valid  (app_rd_data_valid),
    .app_rd_data        (app_rd_data), 
    .init_calib_complete(init_calib_complete),
    .wr_data_rdy        (app_wdf_rdy),
    .sr_req             (sr_req),
    .error              (err),
    .ref_req            (ref_req)
    );

//DDR3_Memory_Interface_Top u_ddr3 (
    D3_400 u_ddr3 (
    .memory_clk      (memory_clk),
    .pll_stop        (pll_stop),
    .clk             (clk),
    .rst_n           (rst_n),   //rst_n
    .cmd_ready       (app_rdy),
    .cmd             (app_cmd),
    .cmd_en          (app_en),
    .addr            (app_addr),
    .wr_data_rdy     (app_wdf_rdy),
    .wr_data         (app_wdf_data),
    .wr_data_en      (app_wdf_wren),
    .wr_data_end     (app_wdf_end),
    .wr_data_mask    (app_wdf_mask),
    .rd_data         (app_rd_data),
    .rd_data_valid   (app_rd_data_valid),
    .rd_data_end     (app_rd_data_end),
    .sr_req          (1'b0),
    .ref_req         (1'b0),
    //.zq_req          (1'b0),
    .sr_ack          (app_sre_act),
    .ref_ack         (app_ref_ack),
    .init_calib_complete(init_calib_complete),
    `ifdef DEBUG_PORT_ENABLE
    .dbg_vector4_out         (),
    .dbg_vector3_out         (),
    .dbg_vector2_out         (), 
    .dbg_vector1_out         (), 
    `endif
    .clk_out         (clk_x1),
    .pll_lock        (pll_lock), 
    //.pll_lock        (1'b1), 
    //`ifdef ECC
    //.ecc_err         (ecc_err),
    //`endif
    .burst           (app_burst),
    // mem interface
    .ddr_rst         (ddr_rst),
    .O_ddr_addr      (ddr_addr),
    .O_ddr_ba        (ddr_bank),
    .O_ddr_cs_n      (ddr_cs),
    .O_ddr_ras_n     (ddr_ras),
    .O_ddr_cas_n     (ddr_cas),
    .O_ddr_we_n      (ddr_we),
    .O_ddr_clk       (ddr_ck),
    .O_ddr_clk_n     (ddr_ck_n),
    .O_ddr_cke       (ddr_cke),
    .O_ddr_odt       (ddr_odt),
    .O_ddr_reset_n   (ddr_reset_n),
    .O_ddr_dqm       (ddr_dm),
    .IO_ddr_dq       (ddr_dq),
    .IO_ddr_dqs      (ddr_dqs),
    .IO_ddr_dqs_n    (ddr_dqs_n)
);
endmodule
