`include "mealy_non_over.v"
module tb;
reg clk_i,rst_i,valid_i,d_i;
wire pattern_o;
integer count;
mealy dut(clk_i,rst_i,valid_i,d_i,pattern_o);
initial begin
	clk_i=0;
	forever #5 clk_i=~clk_i;
end
initial begin
	rst_i=1;
	d_i=0;
	valid_i=0;
	count=0;
	@(posedge clk_i);
	rst_i=0;
	repeat(600)begin
		@(posedge clk_i);
		valid_i=1;
		d_i=$random;
	end
	@(posedge clk_i); 
	valid_i=0;
	$display("count=%0d",count);
	#50;
	$finish;
end
always@(posedge pattern_o)
	count=count+1;
endmodule

