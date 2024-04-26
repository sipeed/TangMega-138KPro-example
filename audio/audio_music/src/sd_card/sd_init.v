//****************************************Copyright (c)***********************************//
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取FPGA & STM32资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved                               
//----------------------------------------------------------------------------------------
// File name:           sd_init
// Last modified Date:  2018/3/18 8:41:06
// Last Version:        V1.0
// Descriptions:        SD卡初始化
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2018/3/18 8:41:06
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module sd_init(
    input          clk_ref       ,  //时钟信号
    input          clk_ref_180deg,  //时钟信号,与clk_ref相位相差180度
    input          rst_n         ,  //复位信号,低电平有效
    
    input          sd_miso       ,  //SD卡SPI串行输入数据信号
    output  reg    sd_cs         ,  //SD卡SPI片选信号
    output  reg    sd_mosi       ,  //SD卡SPI串行输出数据信号
    output  reg    sd_init_done     //SD卡初始化完成信号
    );

//parameter define
//SD卡软件复位命令,由于命令号及参数为固定值,CRC也为固定值,CRC = 8'h95
parameter  CMD0  = {8'h40,8'h00,8'h00,8'h00,8'h00,8'h95};
//接口状态命令,发送主设备的电压范围,用于区分SD卡版本,只有2.0及以后的卡才支持CMD8命令
//MMC卡及V1.x的卡,不支持此命令,由于命令号及参数为固定值,CRC也为固定值,CRC = 8'h87
parameter  CMD8  = {8'h48,8'h00,8'h00,8'h01,8'haa,8'h87};
//告诉SD卡接下来的命令是应用相关命令，而非标准命令, 不需要CRC
parameter  CMD55 = {8'h77,8'h00,8'h00,8'h00,8'h00,8'hff};  
//发送操作寄存器(OCR)内容, 不需要CRC
parameter  ACMD41= {8'h69,8'h40,8'h00,8'h00,8'h00,8'hff};
//上电至少等待74个同步时钟周期,在等待上电稳定期间,sd_cs = 1,sd_mosi = 1
parameter  POWER_ON_NUM = 74;
//发送软件复位命令时等待SD卡返回的最大时间,T = 500ms
//当超时计数器等于此值时,认为SD卡响应超时,重新发送软件复位命令
parameter  OVER_TIME_NUM = 25'd25_000_000; 
                                           
parameter  st_idle        = 7'b000_0001;  //默认状态,上电等待SD卡稳定
parameter  st_send_cmd0   = 7'b000_0010;  //发送软件复位命令
parameter  st_wait_cmd0   = 7'b000_0100;  //等待SD卡响应
parameter  st_send_cmd8   = 7'b000_1000;  //发送主设备的电压范围，检测SD卡是否满足
parameter  st_send_cmd55  = 7'b001_0000;  //告诉SD卡接下来的命令是应用相关命令
parameter  st_send_acmd41 = 7'b010_0000;  //发送操作寄存器(OCR)内容
parameter  st_init_done   = 7'b100_0000;  //SD卡初始化完成

//reg define
reg    [7:0]   cur_state    ;
reg    [7:0]   next_state   ; 
                            
reg    [7:0]   poweron_cnt  ;  //上电等待稳定计数器
reg            res_en       ;  //接收SD卡返回数据有效信号
reg    [47:0]  res_data     ;  //接收SD卡返回数据
reg            res_flag     ;  //开始接收返回数据的标志
reg    [5:0]   res_bit_cnt  ;  //接收位数据计数器

reg    [5:0]   cmd_bit_cnt  ;  //发送指令位计数器
reg   [24:0]   over_time_cnt;  //超时计数器  
reg            over_time_en ;  //超时使能信号 

//*****************************************************
//**                    main code
//*****************************************************

//上电等待稳定计数器
always @(posedge clk_ref or negedge rst_n) begin
    if(!rst_n) 
        poweron_cnt <= 8'd0;
    else if(poweron_cnt < POWER_ON_NUM + 3'd6) 
        poweron_cnt <= poweron_cnt + 1'b1;
end    

//接收sd卡返回的响应数据
//在clk_ref_180deg(sd_clk)的上升沿锁存数据
always @(posedge clk_ref_180deg or negedge rst_n) begin
    if(!rst_n) begin
        res_en <= 1'b0;
        res_data <= 48'd0;
        res_flag <= 1'b0;
        res_bit_cnt <= 6'd0;
    end    
    else begin
        //sd_miso = 0 开始接收响应数据
        if(sd_miso == 1'b0 && res_flag == 1'b0) begin 
            res_flag <= 1'b1;
            res_data <= {res_data[46:0],sd_miso};
            res_bit_cnt <= res_bit_cnt + 6'd1;
            res_en <= 1'b0;
        end    
        else if(res_flag) begin
            //R1返回1个字节,R3 R7返回5个字节
            //在这里统一按照6个字节来接收,多出的1个字节为NOP(8个时钟周期的延时)
            res_data <= {res_data[46:0],sd_miso};     
            res_bit_cnt <= res_bit_cnt + 6'd1;
            if(res_bit_cnt == 6'd47) begin
                res_flag <= 1'b0;
                res_bit_cnt <= 6'd0;
                res_en <= 1'b1; 
            end                
        end  
        else
            res_en <= 1'b0;         
    end
end                    

always @(posedge clk_ref or negedge rst_n) begin
    if(!rst_n)
        cur_state <= st_idle;
    else
        cur_state <= next_state;
end

always @(*) begin
    next_state = st_idle;
    case(cur_state)
        st_idle : begin
            //上电至少等待74个同步时钟周期,为了安全起见,多增加几个时钟周期
            if(poweron_cnt == POWER_ON_NUM + 3'd6)   //默认状态,上电等待SD卡稳定
                next_state = st_send_cmd0;
            else
                next_state = st_idle;
        end 
        st_send_cmd0 : begin                         //发送软件复位命令
            if(cmd_bit_cnt == 6'd47)
                next_state = st_wait_cmd0;
            else
                next_state = st_send_cmd0;    
        end               
        st_wait_cmd0 : begin                         //等待SD卡响应
            if(res_en) begin                         //SD卡返回响应信号
                if(res_data[47:40] == 8'h01)         //SD卡返回复位成功
                    next_state = st_send_cmd8;
                else
                    next_state = st_send_cmd0;
            end
            else if(over_time_en)                    //SD卡响应超时
                next_state = st_send_cmd0;
            else
                next_state = st_wait_cmd0;                                    
        end    
        //发送主设备的电压范围,检测SD卡是否满足
        st_send_cmd8 : begin 
            if(res_en) begin                         //SD卡返回响应信号  
                //返回SD卡的操作电压,[19:16] = 4'b0001(2.7V~3.6V)
                if(res_data[19:16] == 4'b0001)       
                    next_state = st_send_cmd55;
                else
                    next_state = st_send_cmd8;
            end
            else
                next_state = st_send_cmd8;            
        end
        //告诉SD卡接下来的命令是应用相关命令
        st_send_cmd55 : begin     
            if(res_en) begin                         //SD卡返回响应信号  
                if(res_data[47:40] == 8'h01)         //SD卡返回空闲状态
                    next_state = st_send_acmd41;
                else
                    next_state = st_send_cmd55;    
            end        
            else
                next_state = st_send_cmd55;     
        end  
        st_send_acmd41 : begin                       //发送操作寄存器(OCR)内容
            if(res_en) begin                         //SD卡返回响应信号  
                if(res_data[47:40] == 8'h00)         //初始化完成信号
                    next_state = st_init_done;
                else
                    next_state = st_send_cmd55;      //初始化未完成,重新发起 
            end
            else
                next_state = st_send_acmd41;     
        end                
        st_init_done : next_state = st_init_done;    //初始化完成 
        default : next_state = st_idle;
    endcase
end

//SD卡在clk_ref_180deg(sd_clk)的上升沿锁存数据,因此在clk_ref_180deg的下降沿输出数据
//为了统一在alway块中使用上升沿触发,此处使用和clk_ref_180deg相位相差180度的时钟
always @(posedge clk_ref or negedge rst_n) begin
    if(!rst_n) begin
        sd_cs <= 1'b1;
        sd_mosi <= 1'b1;
        sd_init_done <= 1'b0;
        cmd_bit_cnt <= 6'd0;
        over_time_cnt <= 25'd0;
        over_time_en <= 1'b0;
    end
    else begin
        over_time_en <= 1'b0;
        case(cur_state)
            st_idle : begin                               //默认状态,上电等待SD卡稳定
                sd_cs <= 1'b1;                            //在等待上电稳定期间,sd_cs=1
                sd_mosi <= 1'b1;                          //sd_mosi=1
            end     
            st_send_cmd0 : begin                          //发送CMD0软件复位命令
                cmd_bit_cnt <= cmd_bit_cnt + 6'd1;        
                sd_cs <= 1'b0;                            
                sd_mosi <= CMD0[6'd47 - cmd_bit_cnt];     //先发送CMD0命令高位
                if(cmd_bit_cnt == 6'd47)                  
                    cmd_bit_cnt <= 6'd0;                  
            end      
            //在接收CMD0响应返回期间,片选CS拉低,进入SPI模式                                     
            st_wait_cmd0 : begin                          
                sd_mosi <= 1'b1;             
                if(res_en)                                //SD卡返回响应信号
                    //接收完成之后再拉高,进入SPI模式                     
                    sd_cs <= 1'b1;                                      
                over_time_cnt <= over_time_cnt + 1'b1;    //超时计数器开始计数
                //SD卡响应超时,重新发送软件复位命令
                if(over_time_cnt == OVER_TIME_NUM - 1'b1)
                    over_time_en <= 1'b1;
                if(over_time_en)
                    over_time_cnt <= 25'd0;                                        
            end                                           
            st_send_cmd8 : begin                          //发送CMD8
                if(cmd_bit_cnt<=6'd47) begin
                    cmd_bit_cnt <= cmd_bit_cnt + 6'd1;
                    sd_cs <= 1'b0;
                    sd_mosi <= CMD8[6'd47 - cmd_bit_cnt]; //先发送CMD8命令高位       
                end
                else begin
                    sd_mosi <= 1'b1;
                    if(res_en) begin                      //SD卡返回响应信号
                        sd_cs <= 1'b1;
                        cmd_bit_cnt <= 6'd0; 
                    end   
                end                                                                   
            end 
            st_send_cmd55 : begin                         //发送CMD55
                if(cmd_bit_cnt<=6'd47) begin
                    cmd_bit_cnt <= cmd_bit_cnt + 6'd1;
                    sd_cs <= 1'b0;
                    sd_mosi <= CMD55[6'd47 - cmd_bit_cnt];       
                end
                else begin
                    sd_mosi <= 1'b1;
                    if(res_en) begin                      //SD卡返回响应信号
                        sd_cs <= 1'b1;
                        cmd_bit_cnt <= 6'd0;     
                    end        
                end                                                                                    
            end
            st_send_acmd41 : begin                        //发送ACMD41
                if(cmd_bit_cnt <= 6'd47) begin
                    cmd_bit_cnt <= cmd_bit_cnt + 6'd1;
                    sd_cs <= 1'b0;
                    sd_mosi <= ACMD41[6'd47 - cmd_bit_cnt];      
                end
                else begin
                    sd_mosi <= 1'b1;
                    if(res_en) begin                      //SD卡返回响应信号
                        sd_cs <= 1'b1;
                        cmd_bit_cnt <= 6'd0;  
                    end        
                end     
            end
            st_init_done : begin                          //初始化完成
                sd_init_done <= 1'b1;
                sd_cs <= 1'b1;
                sd_mosi <= 1'b1;
            end
            default : begin
                sd_cs <= 1'b1;
                sd_mosi <= 1'b1;                
            end    
        endcase
    end
end

endmodule