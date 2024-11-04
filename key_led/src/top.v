/*
 * SPDX-FileCopyrightText: 2018-2024 Shenzhen Sipeed Technology CO,LTD.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`define INTERNAL_OSC 1 
//Set 0 to use internal oscillator, set 1 to use onboard oscillator, set 2 to use ms5351 CKO2;

module key_led (
    output wire [5:0]  led_o,
    output wire osc_clk,
    input wire sys_clk, // input 50Mhz clock from onboard 50MHz oscillator
    input wire ms5351_clk, // input 25Mhz clock from external ms5351 CKO2
    input wire key1, //function key1
    input wire key0, //function key0
    input wire rst_n //reset key
    );

    wire clk;

    Gowin_OSC internal_osc_inst(
         .oscout(osc_clk)  //output (210/3)=70Mhz clock from internal oscillator
    );

    //clock select
    parameter OSC_SEL = `INTERNAL_OSC;

    if (OSC_SEL == 0) begin
        assign clk = osc_clk;
    end
    else if (OSC_SEL == 1)  begin
        assign clk = sys_clk;
    end
    else if (OSC_SEL == 2)  begin
        assign clk = ms5351_clk;
    end
    else begin
        assign clk = 1'b0;
    end

    reg [23:0] time_cnt;
    reg [5:0] led_reg;
    reg led_dir = 1'b1;
    reg running;                 // Indicates the status of the running LEDs
    reg [23:0] flash_cnt;        // Counter for controlling LED flashing status
    reg flash_state;             // Used to indicate LED flashing status

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            time_cnt <= 24'd0;
            led_reg <= 6'b0;     // Initial value
            led_dir <= 1;        // Reset LEDs running direction
            flash_cnt <= 24'd0;  // Initialize LEDs flash counter
            flash_state <= 0;    // Initialize LEDs flashing state
        end 
        else if (!key0) begin
            led_reg <= {6{1'b1}}; // Press key0 then all LEDs are always on
        end 
        else if (!key1) begin
            if (flash_cnt < 24'd5000000) begin
                flash_cnt <= flash_cnt + 24'b1;
            end 
            else begin
                flash_cnt <= 24'd0;
                flash_state <= ~flash_state;               // Switch LEDs flashing state
            end
            led_reg <= flash_state ? {6{1'b1}} : {6{1'b0}};// Press key1 then all LEDs flash
        end 
        else if (key1 && key0) begin
            if (time_cnt < 24'd10000000) begin
                time_cnt <= time_cnt + 24'b1;
            end 
            else begin
                time_cnt <= 24'd0;
                if (led_dir) begin
                    if (led_reg == {6{1'b1}}) begin
                        led_dir <= 0;                     // All LEDs light turned on and then reverse
                    end 
                    else begin
                        led_reg <= (led_reg << 1) | 6'b1; // LEDs turn up in sequence
                    end
                end 
                else begin
                    if (led_reg == {6{1'b0}}) begin
                        led_dir <= 1;                     // Switch to forward direction after all LEDs turn off
                    end 
                    else begin
                        led_reg <= led_reg >> 1;          // Turn LEDs off in sequence
                    end
                end
            end
        end 
    end

    assign led_o[5:0] = ~led_reg[5:0];                    // All LEDs are connected to the common anode 
                                                          // All LEDs will light up when the IO logic is low. 

endmodule