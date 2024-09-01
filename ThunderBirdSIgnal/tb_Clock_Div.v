/*
* File Name: tb_Clock_Div.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: test ThunderBiedSignal.v for correctness
* ECE 3710
*/
module tb_Clock_Div();

reg clk;
reg reset;
wire slower_clk;

// instansitate module 
Clock_div UUT(.clk(clk),.reset(reset),.slower_clk(slower_clk));

// Toggle clk every 5 ns 
initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

// test if the output, slower_clk, go high for only one cycle
// Note: since the counter is 20 million, you will need to set the simulation 
// to 100 ms 
initial begin
	reset = 1;
	repeat (10) @(posedge clk);
	reset = 0;
end

endmodule
