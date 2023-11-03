module mealy(clk_i,rst_i,valid_i,d_i,pattern_o);
//BCCBC 01101
parameter S_R	 =5'b0_0001;
parameter S_B	 =5'b0_0010;
parameter S_BC   =5'b0_0100;
parameter S_BCC  =5'b0_1000;
parameter S_BCCB =5'b0_0000;

parameter B=1'b0;
parameter C=1'b1;

input clk_i,rst_i,valid_i,d_i;
output reg pattern_o;
reg [4:0]state,n_state;

always@(posedge clk_i)begin
	if(rst_i)begin
		pattern_o=0;
		state=S_R;
		n_state=S_R;
	end
	else begin
		if(valid_i)begin
			case(state)
				S_R:begin
					pattern_o=0;
					n_state = (d_i==B)? S_B:S_R;
				end
				S_B:begin
					pattern_o=0;
					n_state = (d_i==C)? S_BC:S_B;
				end
				S_BC:begin
					pattern_o=0;
					n_state = (d_i==C)? S_BCC:S_B;
				end	
				S_BCC:begin
					pattern_o=0;
					n_state = (d_i==B)? S_BCCB:S_R;
				end
				S_BCCB:begin
					pattern_o=0;
					n_state = (d_i==C)? S_R:S_B;
					if(d_i==C) 
						pattern_o=1;
				end
				

			endcase
		end
	end
end

always@(n_state)
	state=n_state;




endmodule
