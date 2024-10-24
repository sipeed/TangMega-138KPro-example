module XGbE_Send_UDP#(
	parameter SRC_MAC 	    = 48'h03_08_35_01_AE_C2,        //Source MAC Address
	parameter SRC_IP 		= {8'd192,8'd168,8'd3,8'd2},    //Source IP Address
	parameter SRC_PORT	    = 16'h8000,                     //Source UDP Port
	parameter DES_MAC 		= 48'hff_ff_ff_ff_ff_ff,        //Destination MAC address
	parameter DES_IP 		= {8'd192,8'd168,8'd3,8'd3},    //Destination IP address
	parameter DES_PORT		= 16'h8000,                     //Destination PORT
	parameter DATA_SIZE		= 16'd1024                      //Data Length
)(
    input 				tx_mac_clk,
	input  				rst_n, 	

	output reg  [63:0]  tx_mac_data, 		
    output reg  [7:0]   tx_mac_byte,   //Data Mask
    input               tx_mac_ready,
    output reg          tx_mac_valid,
    output reg          tx_mac_last,
    output reg          tx_mac_error
);

/**************** Function: Used to Reverse Byte Order ****************/
    function [63:0] reverse_64_Byte;
        input [63:0] input_64B;
    begin
        reverse_64_Byte[7:0]   = input_64B[63:56];
        reverse_64_Byte[15:8]  = input_64B[55:48];
        reverse_64_Byte[23:16] = input_64B[47:40];
        reverse_64_Byte[31:24] = input_64B[39:32];
        reverse_64_Byte[39:32] = input_64B[31:24];
        reverse_64_Byte[47:40] = input_64B[23:16];
        reverse_64_Byte[55:48] = input_64B[15:8];
        reverse_64_Byte[63:56] = input_64B[7:0];
    end
    endfunction


/********************* Signals Define **********************************/
    localparam MAC_DATA = {DES_MAC, SRC_MAC, 16'h0800}; //MAC Part(DST MAC + SRC MAC + Protocol)

    reg [31:0] packet_header[6:0];
    //crc reg
    reg [31:0] check_buffer;
    reg [31:0] check_buffer1;
    reg [31:0] check_buffer2;
    reg [31:0] check_buffer3;
    reg [31:0] check_buffer4;

    //FSM State Define
    localparam IDLE             = 4'b0000;
    localparam GEN_HDR_CHECKSUM = 4'b0001;
    localparam SEND_MAC         = 4'b0011;
    localparam SEND_IP_HEADER   = 4'b0111;
    localparam SEND_DATA        = 4'b0101;
    localparam DELAY            = 4'b0100;

    // FSM Varaible
    reg [ 3:0] state;
    reg [10:0] step;
    reg [11:0] remain_byte;

    always@(posedge tx_mac_clk or negedge rst_n)begin
    	if(!rst_n)
        begin
    		step <= 11'd0;
            remain_byte <= 0;
            state <= IDLE;

            //MAC Interface
            tx_mac_data <= 64'd0;
            tx_mac_byte <= 8'd0;
            tx_mac_valid <= 1'b0;
            tx_mac_last <= 1'b0;
            tx_mac_error <= 1'b0;
        end else begin
            case(state)
    		IDLE:
            begin
    			step <= 11'd0;
                //MAC Interface Reset
                tx_mac_data <= 64'd0;
                tx_mac_byte <= 8'd0;
                tx_mac_valid <= 1'b0;
                tx_mac_last <= 1'b0;
                tx_mac_error <= 1'b0;
    			// Construct IP header
    			packet_header[0] <= {16'h4_5_00, DATA_SIZE+16'd28 };    //Version:4, Header Length:20, Total Length(Data len+20B Header)
    			packet_header[1] <= {{5'b00000,11'd0},16'h4000};        //Identification
    			packet_header[2] <= {8'h80,8'h11,16'h0000};             //alive time & Protocol UDP & IP header Checksum
    			packet_header[3] <= SRC_IP;                   	        //Source IP Address
    			packet_header[4] <= DES_IP;                   		    //Destnation IP address
    			packet_header[5] <= {SRC_PORT, DES_PORT};               //Port
    			packet_header[6] <= {DATA_SIZE+16'd8,16'h0000};         //Data_length & UDP Checksum

    			state <= GEN_HDR_CHECKSUM;
    		end
    
    		GEN_HDR_CHECKSUM:
            begin  
                //Generate IP Header Checksum
    			step <= (step == 4) ? 0 : step + 1;
    
    			case(step)
    				11'd0: 
                    begin
                        check_buffer  <= packet_header[0][15:0] + packet_header[0][31:16];
                        check_buffer1 <= packet_header[1][15:0] + packet_header[1][31:16];
                        check_buffer2 <= packet_header[2][15:0] + packet_header[2][31:16];
                        check_buffer3 <= packet_header[3][15:0] + packet_header[3][31:16];
                        check_buffer4 <= packet_header[4][15:0] + packet_header[4][31:16];
                        state <= state;
                    end
    				11'd1:
                    begin
                        check_buffer <= check_buffer + check_buffer1;
                        check_buffer2 <= check_buffer2 + check_buffer3;
                        check_buffer4 <= check_buffer4;
                        check_buffer1 <= check_buffer1;
                        check_buffer3 <= check_buffer3;
                        state <= state;
                    end 
    				11'd2:
                    begin
                        check_buffer <= check_buffer + check_buffer2;
                        check_buffer1 <= check_buffer1;
                        check_buffer2 <= check_buffer2;
                        check_buffer3 <= check_buffer3;
                        check_buffer4 <= check_buffer4;
                        state <= state;
                    end 
                    11'd3:
                    begin
                        check_buffer <= check_buffer + check_buffer4;
                        check_buffer1 <= check_buffer1;
                        check_buffer2 <= check_buffer2;
                        check_buffer3 <= check_buffer3;
                        check_buffer4 <= check_buffer4;
                        state <= state;
                    end
                    11'd4:
                    begin
                        packet_header[2][15:0] <= ~check_buffer[15:0];   //header checksum
                        check_buffer <= check_buffer;
                        check_buffer1 <= check_buffer1;
                        check_buffer2 <= check_buffer2;
                        check_buffer3 <= check_buffer3;
                        check_buffer4 <= check_buffer4;
                        state <= SEND_MAC;
                    end
                    default:
                    begin
                        check_buffer <= check_buffer;
                        check_buffer1 <= check_buffer1;
                        check_buffer2 <= check_buffer2;
                        check_buffer3 <= check_buffer3;
                        check_buffer4 <= check_buffer4;
                        state <= IDLE;
                    end
    			endcase

                //MAC Interface Reset
                tx_mac_data <= 64'd0;
                tx_mac_byte <= 8'd0;
                tx_mac_valid <= 1'b0;
                tx_mac_last <= 1'b0;
                tx_mac_error <= 1'b0;
    		end

    		SEND_MAC:
            begin 
                //Send MAC Header
                tx_mac_data <= reverse_64_Byte(MAC_DATA[111:48]);
                tx_mac_byte <= 8'hff;
                tx_mac_valid <= 1'b1;
                tx_mac_last <= 1'b0;
                tx_mac_error <= 1'b0;

                step <= 0;

    			state <= SEND_IP_HEADER;
    		end

    		SEND_IP_HEADER:
            begin
                // Send IP Header
                if(tx_mac_ready & tx_mac_valid)
                begin
                    case(step)
                    0:begin
                        tx_mac_data <= reverse_64_Byte({MAC_DATA[47:0], packet_header[0][31:16]});
                        step <= step + 1;
                        state <= state;
                    end
                    1:begin
                        tx_mac_data <= reverse_64_Byte({packet_header[0][15:0], packet_header[1], packet_header[2][31:16]});
                        step <= step + 1;
                        state <= state;
                    end
                    2:begin
                        tx_mac_data <= reverse_64_Byte({packet_header[2][15:0], packet_header[3], packet_header[4][31:16]});
                        step <= step + 1;
                        state <= state;
                    end
                    3:begin
                        tx_mac_data <= reverse_64_Byte({packet_header[4][15:0], packet_header[5], packet_header[6][31:16]});
                        step <= 0;
                        state <= SEND_DATA;
                    end
                    default:begin
                        tx_mac_data <= tx_mac_data;
                        step <= 0;
                        state <= IDLE;
                    end
                    endcase
                end else begin
                    tx_mac_data <= tx_mac_data;
                    step <= step;
                    state <= state;
                end

                tx_mac_byte <= 8'hff;
                tx_mac_valid <= 1'b1;
                tx_mac_last <= 1'b0;
                tx_mac_error <= 1'b0;
    		end

    		SEND_DATA:
            begin 
                //Send Data Part
                    // Wait for tx_mac_ready assert
                if(tx_mac_ready & tx_mac_valid)
                begin
                    if(step == 0)
                    begin
                        //remain IP Header
                        tx_mac_data[7:0]  <= packet_header[6][15:7];
                        tx_mac_data[15:8] <= packet_header[6][7:0];
                        // Fill Initial Data
                        tx_mac_data[23:16] <= 8'd0;
                        tx_mac_data[31:24] <= 8'd1;
                        tx_mac_data[39:32] <= 8'd2;
                        tx_mac_data[47:40] <= 8'd3;
                        tx_mac_data[55:48] <= 8'd4;
                        tx_mac_data[63:56] <= 8'd5;

                        tx_mac_byte <= 8'hff;
                        tx_mac_valid <= 1'b1;
                        tx_mac_last <= 1'b0;
                        tx_mac_error <= 1'b0;
                    
                        step <= 1;
                        remain_byte <= DATA_SIZE - 7;
                        state <= state;
                    end else begin
                        if(remain_byte < 9)  //last transfer
                        begin
                            tx_mac_valid <= 1'b1;
                            tx_mac_last <= 1'b1;
                            tx_mac_error <= 1'b0;

                            case(remain_byte)
                            11'd0: tx_mac_byte <= 8'b0000_0001;
                            11'd1: tx_mac_byte <= 8'b0000_0011;
                            11'd2: tx_mac_byte <= 8'b0000_0111;
                            11'd3: tx_mac_byte <= 8'b0000_1111;
                            11'd4: tx_mac_byte <= 8'b0001_1111;
                            11'd5: tx_mac_byte <= 8'b0011_1111;
                            11'd6: tx_mac_byte <= 8'b0111_1111;
                            11'd7: tx_mac_byte <= 8'b1111_1111;
                            default: tx_mac_byte <= 8'b1111_1111;
                            endcase

                            tx_mac_data[7:0]   <= tx_mac_data[7:0]   + 8'd8;
                            tx_mac_data[15:8]  <= tx_mac_data[15:8]  + 8'd8;
                            tx_mac_data[23:16] <= tx_mac_data[23:16] + 8'd8;
                            tx_mac_data[31:24] <= tx_mac_data[31:24] + 8'd8;
                            tx_mac_data[39:32] <= tx_mac_data[39:32] + 8'd8;
                            tx_mac_data[47:40] <= tx_mac_data[47:40] + 8'd8;
                            tx_mac_data[55:48] <= tx_mac_data[55:48] + 8'd8;
                            tx_mac_data[63:56] <= tx_mac_data[63:56] + 8'd8;

                            step <= 0;
                            state <= DELAY;

                            remain_byte <= 0;
                        end else begin
                            tx_mac_byte <= 8'hff;
                            tx_mac_valid <= 1'b1;
                            tx_mac_last <= 1'b0;
                            tx_mac_error <= 1'b0;

                            if(step == 1)
                            begin
                                tx_mac_data[7:0]   <= 8'd6;
                                tx_mac_data[15:8]  <= 8'd7;
                            end else begin
                                tx_mac_data[7:0]   <= tx_mac_data[7:0]   + 8'd8;
                                tx_mac_data[15:8]  <= tx_mac_data[15:8]  + 8'd8;
                            end
                            tx_mac_data[23:16] <= tx_mac_data[23:16] + 8'd8;
                            tx_mac_data[31:24] <= tx_mac_data[31:24] + 8'd8;
                            tx_mac_data[39:32] <= tx_mac_data[39:32] + 8'd8;
                            tx_mac_data[47:40] <= tx_mac_data[47:40] + 8'd8;
                            tx_mac_data[55:48] <= tx_mac_data[55:48] + 8'd8;
                            tx_mac_data[63:56] <= tx_mac_data[63:56] + 8'd8;
                            remain_byte <= remain_byte - 8;

                            step <= 2;
                            state <= state;
                        end
                    end
                end else begin
                    tx_mac_data  <= tx_mac_data;
                    tx_mac_byte <= tx_mac_byte;
                    tx_mac_valid <= tx_mac_valid;
                    tx_mac_last <= tx_mac_last;
                    tx_mac_error <= tx_mac_error;
                    step <= step;
                    remain_byte <= remain_byte;
                    state <= state;
                end
    		end

    		DELAY:
            begin
                // wait for next frame start
    			step <= step [3] ? 0 : step + 1;
    
    			tx_mac_data <= 64'd0;
                tx_mac_byte <= 8'd0;
                tx_mac_valid <= 1'b0;
                tx_mac_last <= 1'b0;
                tx_mac_error <= 1'b0;

    			state <= step [3] ? IDLE : state;
    		end

    		default:    
                state <= IDLE;
    		endcase
        end
    end


endmodule 