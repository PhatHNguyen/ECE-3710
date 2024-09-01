module tb_Clock_Div();

reg clk;
reg reset;
wire slower_clk;

Clock_div UUT(.clk(clk),.reset(reset),.slower_clk(slower_clk));

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	reset = 1;
	repeat (10) @(posedge clk);
	reset = 0;
end

endmodule
