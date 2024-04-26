module top#(
    parameter clk_frequency = 50_000_000,
    parameter clk_6m_para   = 6_000_000 ,
    parameter clk_1p5m_para  = clk_6m_para/4
)(
    input        clk    ,
    input        rst    , //S1按键

    // SD spi interface
    input        sd_miso  , //SD卡SPI串行输入数据信号
    output       sd_clk   , //SD卡SPI时钟信号
    output       sd_cs    , //SD卡SPI片选信号
    output       sd_mosi  , //SD卡SPI串行输出数据信号
    
    //audio接口
    output       HP_BCK   , //同clk_1p536m
    output       HP_WS    , //左右声道切换信号，低电平对应左声道
    output       HP_DIN   , //dac串行数据输入信号
    output       PA_EN      //音频功放使能，高电平有效
);

wire rst_n;

assign PA_EN = 1'b1;//PA常开
assign rst_n = !rst ;

parameter start_section_parameter = 16640;
parameter file_size               = 69440;
parameter end__section_parameter  = start_section_parameter + file_size ;

wire clk_6m_w;//6MHz,为产生1.5MHz
wire clk_1p5m_w;//1.536MHz近似时钟

// generate clk_6m
parameter clk_6m_cnt_para = 3;
reg [clk_6m_cnt_para-1:0] clk_6m_reg = 'd0;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
        clk_6m_reg <= 'd0;
    else
        clk_6m_reg <= clk_6m_reg +'b1;
end

assign clk_6m_w = clk_6m_reg[clk_6m_cnt_para-1];

// generate clk_1p5m
parameter clk_1p5m_cnt_para = 2;
reg [clk_1p5m_cnt_para-1:0] clk_1p5m_reg = 'd0;
always @(posedge clk_6m_w or negedge rst_n) begin
    if(!rst_n) 
        clk_1p5m_reg <= 'd0;
    else
        clk_1p5m_reg <= clk_1p5m_reg +'b1;
end

assign clk_1p5m_w = clk_1p5m_reg[clk_1p5m_cnt_para-1];

// read wave data

wire req_w;//读请求
wire [15:0] q_w;//rom读出的数据

// audio driver

wire         rd_start_en   ;  //开始读SD卡数据信号
wire [31:0]  rd_sec_addr   ;  //读数据扇区地址
wire         rd_busy       ;  //读数据忙信号
wire         rd_val_en     ;  //读数据有效信号
wire  [15:0] rd_val_data   ;  //读数据    
wire         sd_init_done  ;  //SD卡初始化完成信号

audio_drive u_audio_drive_0(
    .clk_1p536m(clk_1p5m_w),//bit时钟，每个采样点占32个clk_1p536m(左右声道各16)
    .rst_n     (rst_n),//低电平有效异步复位信号
    //用户数据接口
    .idata     (q_w),
    .req       (req_w),//数据请求信号，可接外部FIFO的读请求(为避免空读，尽量和!fifo_empty相与后作为fifo_rd)
    //audio接口
    .HP_BCK   (HP_BCK_oppo),//同clk_1p536m
    .HP_WS    (HP_WS),//左右声道切换信号，低电平对应左声道
    .HP_DIN   (HP_DIN)//dac串行数据输入信号
);

assign HP_BCK = HP_BCK_oppo;

sd_ctrl_top   u_sd_ctrl_top(
    .clk_ref        (clk        ),  //时钟信号
    .clk_ref_180deg (!clk       ),  //时钟信号,与clk_ref相位相差180度
    .rst_n          (rst_n          ),  //复位信号,低电平有效
    //SD卡接口
    .sd_miso        (sd_miso        )       ,  //SD卡SPI串行输入数据信号
    .sd_clk         (sd_clk         )       ,  //SD卡SPI时钟信号    
    .sd_cs          (sd_cs          )       ,  //SD卡SPI片选信号
    .sd_mosi        (sd_mosi        )       ,  //SD卡SPI串行输出数据信号
    //用户写SD卡接口
    .wr_start_en    (1'b0          ),  //开始写SD卡数据信号
    .wr_sec_addr    (0              ),  //写数据扇区地址
    .wr_data        (0              ),//(sd_wr_data     )       ,  //写数据                  
    .wr_busy        (               ),  //写数据忙信号
    .wr_req         (               ),  //写数据请求信号    
    //用户读SD卡接口
   .rd_start_en     (rd_start_en    )   ,  //开始读SD卡数据信号
    .rd_sec_addr    (rd_sec_addr    )   ,  //读数据扇区地址
    .rd_busy        (rd_busy        )   ,  //读数据忙信号
    .rd_val_en      (rd_val_en      )   ,  //读数据有效信号
    .rd_val_data    (rd_val_data    )   ,  //读数据 
   
    .sd_init_done   (sd_init_done   )     //SD卡初始化完成信号
    );

sd_ctrl_read_top u_sd_ctrl_read_top_0(
    .sd_clk        (clk           ), //sd卡的工作时钟
    .rst_n         (rst_n         ),  //异步复位，低有效
    //用户FIFO接口
    .rd_clk        (clk_1p5m_w    ),
    .rd_req        (req_w && !rd_empty ),  //读请求
    .rd_empty      (rd_empty      ),  //FIFO空信号
    .rd_q          (q_w           ),  //读出的数据
    .start_section (start_section_parameter        ),  //起始扇区地址
    .end_section   (end__section_parameter         ),  //结束扇区地址
    //读SD卡接口
    .rd_start_en   (rd_start_en   ),  //开始读SD卡数据信号
    .rd_sec_addr   (rd_sec_addr   ),  //读数据扇区地址
    .rd_busy       (rd_busy       ),  //读数据忙信号
    .rd_val_en     (rd_val_en     ),  //读数据有效信号
    .rd_val_data   (rd_val_data   ),  //读数据    
    .sd_init_done  (sd_init_done  )   //SD卡初始化完成信号
    );

endmodule