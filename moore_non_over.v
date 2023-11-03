module moore(clk_i,rst_i,valid_i,d_i,pattern_o);
parameter S_R	 =6'b00_0001;
parameter S_B	 =6'b00_0010;
parameter S_BC   =6'b00_0100;
parameter S_BCC  =6'b00_1000;
parameter S_BCCB =6'b01_0000;
parameter S_BCCBC=6'b10_0000;
parameter B=1'b0;
parameter C=1'b1;

input clk_i,rst_i,valid_i,d_i;
output reg pattern_o;
reg [5:0]state,n_state;

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
					n_state = (d_i==C)? S_BCCBC:S_B;
				end
				S_BCCBC:begin
					pattern_o=1;
					n_state = (d_i==B)? S_B:S_R;
				end

			endcase
		end
	end
end

always@(n_state)
	state=n_state;




endmodule
