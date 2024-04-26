module top#(
    parameter clk_frequency = 50_000_000,
    parameter clk_6m_para   = 6_000_000 ,
    parameter clk_1p5m_para  = clk_6m_para/4
)(
    input        clk    ,
    input        rst    , //S1按键
    
    //audio接口
    output       HP_BCK   , //同clk_1p536m
    output       HP_WS    , //左右声道切换信号，低电平对应左声道
    output       HP_DIN   , //dac串行数据输入信号
    output       PA_EN      //音频功放使能，高电平有效
);

wire rst_n;

assign PA_EN = 1'b1;//PA常开
assign rst_n = !rst ;

wire clk_6m_w;//6MHz,为产生1.5MHz
wire clk_1p5m_w;//1.536MHz近似时钟

// generate clk_6m
parameter clk_6m_cnt_para = clk_frequency/clk_6m_para  ;
reg [$clog2(clk_6m_cnt_para):0] clk_6m_cnt_reg;
reg clk_6m;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        clk_6m_cnt_reg <= 'd0;
        clk_6m <= 'd0;
    end else if(clk_6m_cnt_reg > clk_6m_cnt_para-1) begin
        clk_6m_cnt_reg <= 'd0;
        clk_6m <= ~clk_6m;        
    end else begin
        clk_6m_cnt_reg <= clk_6m_cnt_reg + 'b1;
        clk_6m <= clk_6m;        
    end    
end

assign clk_6m_w = clk_6m;

// generate clk_1p5m
parameter clk_1p5m_cnt_para = clk_frequency/clk_1p5m_para  ;
reg [$clog2(clk_1p5m_cnt_para):0] clk_1p5m_cnt_reg;
reg clk_1p5m;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        clk_1p5m_cnt_reg <= 'd0;
        clk_1p5m <= 'd0;
    end else if(clk_1p5m_cnt_reg > clk_1p5m_cnt_para-1) begin
        clk_1p5m_cnt_reg <= 'd0;
        clk_1p5m <= ~clk_1p5m;        
    end else begin
        clk_1p5m_cnt_reg <= clk_1p5m_cnt_reg + 'b1;
        clk_1p5m <= clk_1p5m;        
    end    
end

assign clk_1p5m_w = clk_1p5m;

// read wave data

wire req_w;//读请求
wire [15:0] q_w;//rom读出的数据

rom_save_sin rom_save_sin_inst(
.clk(clk),
.rst_n(rst_n),
.data(q_w)
);

// audio driver
audio_drive u_audio_drive_0(
    .clk_1p536m(clk_1p5m_w),//bit时钟，每个采样点占32个clk_1p536m(左右声道各16)
    .rst_n     (rst_n),//低电平有效异步复位信号
    //用户数据接口
    .idata     (q_w),
    .req       (req_w),//数据请求信号，可接外部FIFO的读请求(为避免空读，尽量和!fifo_empty相与后作为fifo_rd)
    //audio接口
    .HP_BCK   (HP_BCK),//同clk_1p536m
    .HP_WS    (HP_WS),//左右声道切换信号，低电平对应左声道
    .HP_DIN   (HP_DIN)//dac串行数据输入信号
);

endmodule