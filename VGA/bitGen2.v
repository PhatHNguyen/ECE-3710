module bitGen2
 (
	input [9:0] hcount,
	input [9:0] vcount,
	input	    bright,
	input	[5:0] LEDS,						
	output reg [7:0] red,
	output reg [7:0] blue,
	output reg [7:0] green
 );
 
 
 always@(*) begin	
	if(hcount < 144 || hcount >= 784) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end else if(~bright) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end
	
	if((220 < vcount) & (260 > vcount)) begin
		if(((400 <= hcount) && (440 > hcount)) && LEDS[3]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;
		end else if(((330 <= hcount) && (370 > hcount)) && LEDS[4]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(((260 <= hcount) && (300 > hcount)) && LEDS[5]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(((480 <= hcount) && (520 > hcount)) && LEDS[2]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(((550 <= hcount) && (590 > hcount)) && LEDS[1]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(((620 <= hcount) && (660 > hcount)) && LEDS[0]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else begin
			red   <= 8'b00000000;
			blue  <= 8'b00000000;
			green <= 8'b00000000;
		end 
	end else begin
		red   <= 8'b00000000;
		blue  <= 8'b00000000;
		green <= 8'b00000000;
	end
end	
endmodule