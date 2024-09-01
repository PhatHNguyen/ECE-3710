/*
The clockDivider module inputs a fast clock and outputs an enable signal by
using a counter that will invert the input.
*/
module Clock_div(
	input 	   clk, 
	input reset,
	output reg slower_clk = 0
	);
	
	reg [31:0] counter = 0;

/* reset - set the counter and output to 0
   slower_clk - if slower_clk is high, set it to low next cycle so that it creates a blimp
   counter - if reaches to 20 million then invert the output "clk" (enable)
*/
always@(posedge clk) begin
	if(!reset) begin
		slower_clk <= 0;
		counter <= 0;
	end else if(slower_clk) begin 
		slower_clk <= 0;
		counter <= 0;
	end else if(counter < 32'd20000000)begin
		counter <= counter + 1; 
	end else begin 
		slower_clk <= ~slower_clk;
		counter <= 0;
	end
end 

endmodule 
