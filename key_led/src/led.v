module led (
    input           clk,
    input           rst_n,
    output [5:0]    led
);

// generate 1ms time count.
reg [32:0] time_cnt;
reg [6:0] led_reg;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        time_cnt <= 'd0;
        led_reg <= 'd0;
    end
    else if(time_cnt < 50000000 / 8) begin
        time_cnt <= time_cnt + 'b1;
    end else begin
        time_cnt <= 'd0;
        if(led_reg[6]) begin
            led_reg[6:0] <= 'd1;
        end else begin
            led_reg <= (led_reg << 1) | 'b1 ;            
        end
    end
end

assign led[5:0] = ~led_reg[5:0];

endmodule