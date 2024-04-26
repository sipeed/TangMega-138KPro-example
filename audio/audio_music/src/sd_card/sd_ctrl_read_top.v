//功能：FIFO接口的SD卡控制器读出模块
//使用说明： 
//不读数据时，将rst_n拉低，需要读出时拉高rst_n，rst_n为高时，只要FIFO没有满，
//就会一直循环读出start_section~end_section这些扇区的数据.
module sd_ctrl_read_top(
    input             sd_clk, //sd卡的工作时钟
    input             rst_n,  //异步复位，低有效
    //用户FIFO接口
    input             rd_clk,
    input             rd_req,       //读请求
    output            rd_empty,     //FIFO空信号
    output [15:0]     rd_q,         //读出的数据
    input  [31:0]     start_section,//起始扇区地址
    input  [31:0]     end_section,  //结束扇区地址
    //读SD卡接口
    output            rd_start_en   ,  //开始读SD卡数据信号
    output     [31:0] rd_sec_addr   ,  //读数据扇区地址
    input             rd_busy       ,  //读数据忙信号
    input             rd_val_en     ,  //读数据有效信号
    input [15:0]      rd_val_data   ,  //读数据    
    input             sd_init_done     //SD卡初始化完成信号
    );
wire fifo_almost_full;//当FIFO usedw达到512时，该信号拉高
wire [9:0]  wrusedw_w;//FIFO深度为1024
assign fifo_almost_full = (wrusedw_w >= 10'd512);//预留足够的空间，防止写满
sd_ctrl_read u_sd_ctrl_read_0(
    .sd_clk           (sd_clk),  //sd卡的工作时钟
    .rst_n            (rst_n),  //异步复位，低有效
    //用户接口
    .start_section    (start_section ),  //起始扇区地址
    .end_section      (end_section   ),  //结束扇区地址
    //FIFO将满信号
    .fifo_almost_full (fifo_almost_full),
    //读SD卡接口
    .rd_start_en      (rd_start_en   ),  //开始读SD卡数据信号
    .rd_sec_addr      (rd_sec_addr   ),  //读数据扇区地址
    .rd_busy          (rd_busy       ),  //读数据忙信号
    .sd_init_done     (sd_init_done  )   //SD卡初始化完成信号
    ); 
sd_ctrl_dcfifo u_sd_ctrl_dcfifo_0(
    .Data(rd_val_data), //input [15:0] Data
    .Reset(!rst_n), //input Reset
    .WrClk(sd_clk), //input WrClk
    .RdClk(rd_clk), //input RdClk
    .WrEn(rd_val_en), //input WrEn
    .RdEn(rd_req), //input RdEn
    .Wnum(wrusedw_w), //output [10:0] Wnum
    //.Almost_Empty(Almost_Empty_o), //output Almost_Empty
    .Q(rd_q) ,//output [15:0] Q
    .Empty(rd_empty) //output Empty
    //.Full(Full_o) //output Full
);
endmodule