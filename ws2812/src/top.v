module top#(
)(
	input 		clk,  //输入 时钟源  

	output      WS2812
);

ws2812 ws2812_inst(
	.clk(clk),  //输入 时钟源  
	.WS2812(WS2812) //输出到WS2812的接口	
);

endmodule