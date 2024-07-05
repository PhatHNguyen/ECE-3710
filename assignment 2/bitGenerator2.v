module bitGenerator2
 (
	input [9:0] hcount,
			[9:0] vcount,
					display_pixel,
			[5:0] LEDS,		
					
	output reg [7:0] red,
				  [7:0] blue,
				  [7:0] green
 );
 
 reg L1;
 reg L2;
 reg L3;
 reg R1;
 reg R2;
 reg R3;
 reg displayWidth;
 reg displayHeight;
 
 always@(*) begin 
	L1 <= (400 <= hcount && 440 > hcount);
	L2 <= (330 <= hcount && 370 > hcount);
	L3 <= (260 <= hcount && 300 > hcount);
	R1 <= (480 <= hcount && 520 > hcount);
	R2 <= (550 <= hcount && 590 > hcount);
	R3 <= (620 <= hcount && 660 > hcount);
	displayWidth <= (220 < vcount && 260 > vcount);
	displayHeight <= (L1 | L2 | L3| R1| R2 | R3);
 end 
 
 
 
 
 
 always@(*) begin	
	if(hcount < 144 || hcount >= 784) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end else if(~display_pixel) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end
	
	if(displayWidth && displayHeight) begin
		if(L1 && LEDS[3]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;
		end else if(L2 && LEDS[4]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(L3 && LEDS[5]) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(R1 && LEDS[2]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(R2 && LEDS[1]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end else if(R3 && LEDS[0]) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		end
	end else begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end
end	
