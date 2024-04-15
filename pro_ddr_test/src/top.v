module top(
    input sys_clk, // 50M
    output uart_tx,
    input rst_n,
    output reg [5:0] led,

    output [15-1:0] ddr_addr,
    output [3-1:0] ddr_bank,
    output ddr_cs,
    output ddr_ras,
    output ddr_cas,
    output ddr_we,
    output ddr_ck,
    output ddr_ck_n,
    output ddr_cke,
    output ddr_odt,
    output ddr_reset_n,
    output [4-1:0] ddr_dm,
    inout  [32-1:0] ddr_dq,
    inout  [4-1:0] ddr_dqs,
    inout  [4-1:0] ddr_dqs_n
);

wire clk100M;

reg uart_wr;
wire tx_done;
reg [7:0] uart_wdata;
wire tx_empty;
wire tx_full;
wire [7:0] tx_data;
wire b_tick;

FIFO #(.DWIDTH(8), .AWIDTH(13)) uFIFO_TX (
    .clk(clk100M),
    .resetn(rst_n),
    .rd(tx_done),
    .wr(uart_wr),
    .w_data(uart_wdata),
    .empty(tx_empty),
    .full(tx_full),
    .r_data(tx_data)
);

BAUDGEN uBAUDGEN(
    .clk(clk100M),
    .resetn(rst_n),
    .baudtick(b_tick)
);

UART_TX uUART_TX (
    .clk(clk100M),
    .resetn(rst_n),
    .tx_start(~tx_empty),
    .b_tick(b_tick),
    .d_in(tx_data),
    .tx_done(tx_done),
    .tx(uart_tx)
);

wire pll_lock;
wire memory_clk;
wire pll_stop;

Gowin_PLL upll(
    .lock(pll_lock),
    .clkout0(),
    .clkout1(clk100M),
    .clkout2(memory_clk),
    .clkin(sys_clk),
    .reset(~rst_n),
    .enclk0(1'b1),
    .enclk1(1'b1),
    .enclk2(pll_stop)
);

wire init_calib_complete;
wire app_rdy;
wire app_wdf_rdy;

wire clk_x1;
wire [2:0] app_cmd;
wire app_en;
wire [29-1:0] app_addr;
wire [256-1:0] app_wdf_data;
wire app_wdf_wren;
wire app_wdf_end;
wire [32-1:0] app_wdf_mask;
wire [256-1:0] app_rd_data;
wire app_rd_data_valid;
wire app_burst;

DDR3_Memory_Interface_Top u_ddr3 (
    .memory_clk      (memory_clk),
    .pll_stop        (pll_stop),
    .clk             (clk100M),
    .rst_n           (rst_n),
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
    .rd_data_end     (),
    .sr_req          (1'b0),
    .ref_req         (1'b0),
    .sr_ack          (),
    .ref_ack         (),
    .init_calib_complete(init_calib_complete),
    .clk_out         (clk_x1),
    .pll_lock        (pll_lock),
    .burst           (app_burst),
    .ddr_rst         (),
    // mem interface
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

wire wdone;
wire rdone;
wire [23:0] num_ok;

wire [2:0] test_state;


///////////////////////////////////////
//2024/04/14
//by:LAKKA
//fix timing

/*
ddr3_test u_ddr_test(
    .clk                (clk_x1),
    .rst_n              (rst_n),  
    .app_rdy            (app_rdy),
    .app_cmd            (app_cmd),
    .app_en             (app_en),
    .app_addr           (app_addr),
    .wr_data_rdy        (app_wdf_rdy),
    .app_wdf_data       (app_wdf_data),
    .app_wdf_wren       (app_wdf_wren),
    .app_wdf_end        (app_wdf_end),
    .app_wdf_mask       (app_wdf_mask),
    .app_burst          (app_burst),
    .app_rd_data_valid  (app_rd_data_valid),
    .app_rd_data        (app_rd_data), 
    .init_calib_complete(init_calib_complete),
    .wdone              (wdone),
    .rdone              (rdone),
    .num_ok             (num_ok),
    .test_state         (test_state)
);*/


reg read_av;
reg [255:0] read_data;

always@(posedge clk_x1)begin
    read_av <= app_rd_data_valid;
    read_data <= app_rd_data;
end

ddr3_test u_ddr_test(
    .clk                (clk_x1),
    .rst_n              (rst_n),  
    .app_rdy            (app_rdy),
    .app_cmd            (app_cmd),
    .app_en             (app_en),
    .app_addr           (app_addr),
    .wr_data_rdy        (app_wdf_rdy),
    .app_wdf_data       (app_wdf_data),
    .app_wdf_wren       (app_wdf_wren),
    .app_wdf_end        (app_wdf_end),
    .app_wdf_mask       (app_wdf_mask),
    .app_burst          (app_burst),
    .app_rd_data_valid  (read_av),
    .app_rd_data        (read_data), 
    .init_calib_complete(init_calib_complete),
    .wdone              (wdone),
    .rdone              (rdone),
    .num_ok             (num_ok),
    .test_state         (test_state)
);
///////////////////////////////////////

always @(*) begin
    case(test_state)
        0: led = 6'b111110;
        1: led = 6'b111101;
        2: led = 6'b111011;
        3: led = 6'b110111;
        4: led = 6'b101111;
        5: led = 6'b011111;
        default: led = 6'b111111;
    endcase
end

reg [2:0] state;
reg [15:0] cnt;

always @(posedge clk100M or negedge rst_n) begin
    if(~rst_n) begin
        state <= 0;
        uart_wr <= 0;
        uart_wdata <= 0;
        cnt <= 0;
    end
    else begin
        case(state)
            0: begin
                if(wdone) begin
                    uart_wr <= 1;
                    uart_wdata <= "W";
                    state <= 1;
                end
                else begin
                    uart_wr <= 0;
                    uart_wdata <= 0;
                    state <= state;
                end
            end
            1: begin
                if(rdone) begin
                    uart_wr <= 1;
                    uart_wdata <= "R";
                    state <= 2;
                end
                else begin
                    uart_wr <= 0;
                    uart_wdata <= 0;
                    state <= state;
                end
            end
            2: begin
                uart_wr <= 0;
                if(cnt >= 65535) begin
                    state <= 3;
                    cnt <= 0;
                end
                else begin
                    state <= state;
                    cnt <= cnt + 1;
                end
            end
            3: begin
                uart_wr <= 1;
                uart_wdata <= num_ok[23:16];
                state <= 4;
            end
            4: begin
                uart_wr <= 1;
                uart_wdata <= num_ok[15:8];
                state <= 5;
            end
            5: begin
                uart_wr <= 1;
                uart_wdata <= num_ok[7:0];
                state <= 6;
            end
            6: begin
                uart_wr <= 0;
                uart_wdata <= 0;
                state <= state;
            end
            default: begin
                uart_wr <= 0;
                uart_wdata <= 0;
                state <= state;
            end
        endcase
    end
end

endmodule
