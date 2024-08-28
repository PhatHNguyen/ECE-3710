/*
The clockDivider module inputs a fast clock and outputs 25 MHZ clk by
using a counter that will invert the input.
*/
module Clock_div(
	input 	   clk, 
	input reset,
	output reg slower_clk	
	);
	
	reg [31:0] counter = 0;
	
always@(posedge clk) begin
	if(reset) begin
		slower_clk <= 0;
		counter <= 0;
	end else if(counter < 32'd1200000) begin 
		counter <= counter + 1; 
	end else begin 
		slower_clk <= ~slower_clk;
		counter <= 0;
	end
end 

always@(posedge clk) begin
	if(slower_clk) begin
		slower_clk <= ~slower_clk;
		counter <= 0;
	end
end

endmodule 
