/*
The clockDivider module inputs a fast clock and outputs 25 MHZ clk by
using a counter that will invert the input.
*/
module ClockDiff(
	input 	   clk, 
	input reset,
	output reg slower_clk	
	);
	
	reg [31:0] counter = 0;
	
always@(posedge clk) begin
	if(reset) begin
		slower_clk <= 0;
		counter <= 0;
	end else if(slower_clk == 1)begin
		slower_clk <= 0;
		counter <= 0;
	end else if(counter < 32'd12000000) begin 
		counter <= counter + 1; 
	end  else begin 
		slower_clk <= ~slower_clk;
		counter <= 0;
	end
end 

endmodule 
