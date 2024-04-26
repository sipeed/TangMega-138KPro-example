//功能：FIFO接口的SD卡读控制模块，支持多扇区循环读出
module sd_ctrl_read(
    input             sd_clk, //sd卡的工作时钟
    input             rst_n,  //异步复位，低有效
    //用户接口
    input  [31:0]     start_section,//起始扇区地址
    input  [31:0]     end_section,  //结束扇区地址
    //FIFO将满信号
    input             fifo_almost_full,
    //读SD卡接口
    output reg        rd_start_en   ,  //开始读SD卡数据信号
    output reg [31:0] rd_sec_addr   ,  //读数据扇区地址
    input             rd_busy       ,  //读数据忙信号
    input             sd_init_done     //SD卡初始化完成信号
    );

//reg define
reg    [1:0]          rd_flow_cnt      ;    //读数据流程控制计数器
reg                   rd_busy_d0       ;    //读忙信号打拍，用来采下降沿
reg                   rd_busy_d1       ;  
//wire define
wire neg_rd_busy;
wire read_able_w;//可读标志信号
assign read_able_w = (sd_init_done && !rd_busy && !fifo_almost_full);//FIFO将满信号为高时不可读出SD卡数据，否则数据无处存放
//对rd_busy信号进行延时打拍,用于采rd_busy信号的下降沿
assign  neg_rd_busy = rd_busy_d1 & (~rd_busy_d0);
always @(posedge sd_clk or negedge rst_n) begin
    if(rst_n == 1'b0) begin
        rd_busy_d0 <= 1'b0;
        rd_busy_d1 <= 1'b0;
    end
    else begin
        rd_busy_d0 <= rd_busy;
        rd_busy_d1 <= rd_busy_d0;
    end
end
//读取SD卡中的数据
always @(posedge sd_clk or negedge rst_n) 
begin
if(!rst_n) begin
    rd_flow_cnt <= 2'd0;
    rd_start_en <= 1'b0;
    rd_sec_addr <= 32'd0;
end
else begin
	case(rd_flow_cnt)
	2'd0 : begin//等待SD卡初始化完成,完成后进入读出数据状态	 
		rd_sec_addr <= start_section;//输出的读扇区地址寄存器，初始化赋值为起始扇区地址
		rd_flow_cnt <= read_able_w?2'd1 : rd_flow_cnt;
		rd_start_en <= read_able_w;
	end
	2'd1 : begin//检测一个扇区是否读完，neg_rd_busy为高即读完
	    rd_start_en <= 1'b0;
		rd_flow_cnt <= neg_rd_busy?2'd2:2'd1;//检测到neg_rd_busy下降沿，则准备开启下一扇区读操作
	    rd_sec_addr <= neg_rd_busy?rd_sec_addr+1:rd_sec_addr;    //通过neg_rd_busy增加扇区地址                 
	end
   2'd2:begin
	    rd_start_en <= (rd_sec_addr <= end_section) && !fifo_almost_full;//读出缓冲fifo有足够空间才开启一个扇区的读操作
		 if(rd_sec_addr > end_section)//将要读的扇区数超过end_section，则返回2'd0状态
		     rd_flow_cnt <= 2'd0;
		 else if(!fifo_almost_full)   //将要读的扇区数不超过end_section，并且读出缓冲fifo有足够空间，则开启一次扇区读
		     rd_flow_cnt <= 2'd1;
		 else                         //否则一直等待!fifo_almost_full
		     rd_flow_cnt <= 2'd2;
	end
	default : ;
	endcase    
    end
end
endmodule