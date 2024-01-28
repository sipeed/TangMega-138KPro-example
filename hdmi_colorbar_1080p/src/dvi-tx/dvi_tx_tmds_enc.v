module dvi_tx_tmds_enc(
	
	input					clock,
	input					reset,
	
	input					den,
	input		[7 : 0]		data,
	input		[1 : 0]		ctrl,
	output reg	[9 : 0]		tmds
);
	reg			[7 : 0]		data_reg;
	reg						den_reg;
	reg			[1 : 0]		ctrl_reg;
	wire		[9 : 0]		tmds_int;
	
	reg 		[8 : 0]		cnt_q;
	reg 		[8 : 0]		cnt_d;
	reg			[8 : 0]		q_m;
	
	reg			[9 : 0]		q_out;
	wire		[8 : 0]		q_m_temp;
	
	
	/////////////////////////////////////////////////////////////
	function [3 : 0] count_ones;
		input [7 : 0] data_in;
		integer loop;
	begin
	
		count_ones = 0;
		
		for(loop = 0; loop < 8; loop = loop + 1)begin : cnt_o
			count_ones = count_ones + data_in[loop];
		end
	end
	endfunction
	/////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////////
	always@(posedge clock)begin
		
		if(reset)begin
			data_reg <= 0;
			ctrl_reg <= 0;
			den_reg <= 0;
			tmds <= 0;
			cnt_q <= 0;
		end else begin
			data_reg <= data;
			den_reg <= den;
			ctrl_reg <= ctrl;
			tmds <= tmds_int;
			cnt_q <= cnt_d;
		end
	end
	/////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////////
	wire qm_flip;
	
	assign qm_flip = (count_ones(data_reg) > 4) | ((count_ones(data_reg) == 4) & (!data_reg[0])) ? 1'b1 : 1'b0;
	
	assign q_m_temp[0] = data_reg[0];
	assign q_m_temp[1] = (qm_flip) ? ~(q_m_temp[0] ^ data_reg[1]) : (q_m_temp[0] ^ data_reg[1]);
	assign q_m_temp[2] = (qm_flip) ? ~(q_m_temp[1] ^ data_reg[2]) : (q_m_temp[1] ^ data_reg[2]);
	assign q_m_temp[3] = (qm_flip) ? ~(q_m_temp[2] ^ data_reg[3]) : (q_m_temp[2] ^ data_reg[3]);
	assign q_m_temp[4] = (qm_flip) ? ~(q_m_temp[3] ^ data_reg[4]) : (q_m_temp[3] ^ data_reg[4]);
	assign q_m_temp[5] = (qm_flip) ? ~(q_m_temp[4] ^ data_reg[5]) : (q_m_temp[4] ^ data_reg[5]);
	assign q_m_temp[6] = (qm_flip) ? ~(q_m_temp[5] ^ data_reg[6]) : (q_m_temp[5] ^ data_reg[6]);
	assign q_m_temp[7] = (qm_flip) ? ~(q_m_temp[6] ^ data_reg[7]) : (q_m_temp[6] ^ data_reg[7]);
	assign q_m_temp[8] = (qm_flip) ? 1'b0 : 1'b1;
	
	always@(*)begin
		q_m <= q_m_temp;
	end
	/////////////////////////////////////////////////////////////
	
	wire ones_equ_f;
	wire ones_larg_f;
	wire ones_sml_f;
	
	assign ones_equ_f = (count_ones(q_m[7 : 0]) == 4) ? 1'b1 : 1'b0;
	assign ones_larg_f = (count_ones(q_m[7 : 0]) > 4) ? 1'b1 : 1'b0;
	assign ones_sml_f = (count_ones(q_m[7 : 0]) < 4) ? 1'b1 : 1'b0;
	
	/////////////////////////////////////////////////////////////
	always@(*)begin
		
		if(!den_reg)begin
			
			case(ctrl_reg)
				2'b00:   q_out = 10'b1101010100;
				2'b01:   q_out = 10'b0010101011;
				2'b10:   q_out = 10'b0101010100;
				2'b11:   q_out = 10'b1010101011;
			endcase
			
		end else if( ($signed(cnt_q) == 0) | ones_equ_f)begin
			
			q_out[9] = ~q_m[8];
			q_out[8] = q_m[8];
			
			if(q_m[8])begin
				q_out[7 : 0] = q_m[7 : 0];
			end else begin
				q_out[7 : 0] = ~q_m[7 : 0];
			end
			
		end else if(
			( ($signed(cnt_q) > 0) & ones_larg_f ) | 
			( ($signed(cnt_q) < 0) & ones_sml_f )
		)begin
			q_out[9] = 1'b1;
			q_out[8] = q_m[8];
			q_out[7 : 0] = ~q_m[7 : 0];
		end else begin
			q_out[9] = 1'b0;
			q_out[8] = q_m[8];
			q_out[7 : 0] = q_m[7 : 0];
		end
	end
	
	assign tmds_int = q_out;
	/////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////////
	always@(*)begin
		
		if(!den_reg)begin
			
			cnt_d = 0;
			
		end else if( ($signed(cnt_q) == 0) | ones_equ_f )begin
			
			if(q_m[8])begin
				cnt_d = $signed(cnt_q) + 2 * (count_ones(q_m[7 : 0]) - 4);
			end else begin
				cnt_d = $signed(cnt_q) + 2 * (4 - count_ones(q_m[7 : 0]));
			end
			
		end else if(
			( ($signed(cnt_q) > 0) & ones_larg_f ) | 
			( ($signed(cnt_q) < 0) & ones_sml_f )
		)begin
			
			if(q_m[8])begin
				cnt_d = $signed(cnt_q) + 2 + 2 * (4 - count_ones(q_m[7 : 0]));
			end else begin
				cnt_d = $signed(cnt_q) + 2 * (4 - count_ones(q_m[7 : 0]));
			end
			
		end else begin
			
			if(!q_m[8])begin
				cnt_d = ($signed(cnt_q) - 2) + 2 * (count_ones(q_m[7 : 0]) - 4);
			end else begin
				cnt_d = $signed(cnt_q) + 2 * (count_ones(q_m[7 : 0]) - 4);
			end
		end
	end
	/////////////////////////////////////////////////////////////
	
endmodule
