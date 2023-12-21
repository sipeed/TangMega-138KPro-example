module ddr3_test (
    input clk,
    input rst_n,
    input app_rdy,
    output reg [2:0] app_cmd,
    output reg app_en,
    output reg [29-1:0] app_addr,
    input wr_data_rdy,
    output reg [256-1:0] app_wdf_data,
    output reg app_wdf_wren,
    output reg app_wdf_end,
    output [32-1:0] app_wdf_mask,
    output app_burst,
    input app_rd_data_valid,
    input [256-1:0] app_rd_data,
    input init_calib_complete,
    output wdone,
    output rdone,
    output reg [23:0] num_ok,
    output [2:0] test_state
);

assign app_wdf_mask = 0;
assign app_burst = 0;

reg [2:0] state;

localparam STATE_IDLE = 0;
localparam STATE_WRITE = 1;
localparam STATE_WRITE_WAIT = 2;
localparam STATE_READ_CHECK = 3;
localparam STATE_READ_CMD = 4;
localparam STATE_FINISH = 5;

reg [15:0] cnt;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        state <= STATE_IDLE;
        app_cmd <= 0;
        app_en <= 0;
        app_wdf_data <= 0;
        app_wdf_wren <= 0;
        app_wdf_end <= 0;
        app_addr <= 0;
        num_ok <= 0;
        cnt <= 0;
    end
    else begin
        case(state)
            STATE_IDLE: begin
                if(init_calib_complete) begin
                    if(cnt >= 65535) begin
                        state <= STATE_WRITE;
                        cnt <= 0;
                    end
                    else begin
                        state <= state;
                        cnt <= cnt + 1;
                    end
                end
                else begin
                    state <= state;
                    cnt <= cnt;
                end
                app_cmd <= 0;
                app_en <= 0;
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
                app_addr <= 0;
                num_ok <= 0;
            end
            STATE_WRITE: begin
                if(app_rdy & wr_data_rdy) begin
                    if(app_addr >= 2**27-8) begin
                        app_cmd <= 0;
                        app_en <= 0;
                        app_wdf_data <= 0;
                        app_wdf_wren <= 0;
                        app_wdf_end <= 0;
                        app_addr <= 0;
                        state <= STATE_READ_CMD;
                    end
                    else begin
                        app_cmd <= 0;
                        app_en <= 1;
                        app_wdf_data <= 256'hAAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA;
                        app_wdf_wren <= 1;
                        app_wdf_end <= 1;
                        app_addr <= app_addr + 8;
                        state <= STATE_WRITE_WAIT;
                    end
                end
                else begin
                    app_cmd <= 0;
                    app_en <= 0;
                    app_wdf_data <= 0;
                    app_wdf_wren <= 0;
                    app_wdf_end <= 0;
                    app_addr <= app_addr;
                    state <= state;
                end
                num_ok <= 0;
            end
            STATE_WRITE_WAIT: begin
                if(cnt >= 15) begin
                    state <= STATE_WRITE;
                    cnt <= 0;
                end
                else begin
                    state <= state;
                    cnt <= cnt + 1;
                end
                app_cmd <= 0;
                app_en <= 0;
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
                app_addr <= app_addr;
                num_ok <= 0;
            end
            STATE_READ_CHECK: begin
                if(app_rd_data_valid) begin
                    if(app_rd_data == 256'hAAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA_AAAA) begin
                        num_ok <= num_ok + 1;
                    end
                    else begin
                        num_ok <= num_ok;
                    end
                    state <= STATE_READ_CMD;
                end
                else begin
                    num_ok <= num_ok;
                    state <= state;
                end
                app_cmd <= 0;
                app_en <= 0;
                app_addr <= app_addr;
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
            end
            STATE_READ_CMD: begin
                if(app_rdy) begin
                    if(app_addr >= 2**27-8) begin
                        app_cmd <= 0;
                        app_en <= 0;
                        app_addr <= 0;
                        state <= STATE_FINISH;
                    end
                    else begin
                        app_cmd <= 1;
                        app_en <= 1;
                        app_addr <= app_addr + 8;
                        state <= STATE_READ_CHECK;
                    end
                end
                else begin
                    app_cmd <= 0;
                    app_en <= 0;
                    app_addr <= app_addr;
                    state <= state;
                end
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
                num_ok <= num_ok;
            end
            STATE_FINISH: begin
                state <= state;
                app_cmd <= 0;
                app_en <= 0;
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
                app_addr <= app_addr;
                num_ok <= num_ok;
            end
            default: begin
                state <= state;
                app_cmd <= 0;
                app_en <= 0;
                app_wdf_data <= 0;
                app_wdf_wren <= 0;
                app_wdf_end <= 0;
                app_addr <= app_addr;
                num_ok <= num_ok;
            end
        endcase
    end
end

assign wdone = (state == STATE_READ_CHECK) | (state == STATE_READ_CMD) | (state == STATE_FINISH);
assign rdone = state == STATE_FINISH;

assign test_state = state;

endmodule
