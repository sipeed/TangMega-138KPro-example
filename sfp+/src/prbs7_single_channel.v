module prbs7_single_channel
#(parameter WIDTH = 8,
  parameter INIT = {WIDTH{1'b1}} 
)
(
//tx
input tx_clk_i,
input tx_rstn_i,
input tx_en_i,
output [WIDTH-1:0] tx_data_o,

//rx
input rx_clk_i, 
input rx_rstn_i,
input rx_en_i,
input [WIDTH-1:0] rx_data_i,
output lock_o


);



prbs7_gen
#(.WIDTH(WIDTH),
  .INIT(INIT)
)prbs7_gen
(
.clk_i(tx_clk_i),
.rstn_i(tx_rstn_i),
.ena_i(tx_en_i),
.prbs7_o(tx_data_o)
);


prbs7_chk
#(.WIDTH(WIDTH),
  .INIT(INIT)
)prbs7_chk
(
.clk_i(rx_clk_i),
.rstn_i(rx_rstn_i),
.ena_i(rx_en_i),
.prbs7_i(rx_data_i),
.lock_o(lock_o),
.error_stat_o()

);

endmodule