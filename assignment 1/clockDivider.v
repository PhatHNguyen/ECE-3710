module ClockDivider (
	input 	   clk, 
	output reg slower_clk	
	);
	
	reg [31:0] counter = 0;
	
always@(posedge clk) begin 
	if(counter >= 12_000_000) begin 
		slower_clk <= ~slower_clk;
		counter <= 0;
	end else begin 
		counter <= counter + 1; 
	end
end 

endmodule 