module bitGenerator1
 (
	input [2:0] switches,
			[9:0] hcount,
			[9:0] vcount,
					display_pixel,
					
	output reg [7:0] red,
				  [7:0] blue,
				  [7:0] green
 );
 
 parameter red      = 3'b000;
 parameter green    = 3'b001;
 parameter blue     = 3'b010;
 parameter babyBlue = 3'b100;
 parameter yellow   = 3'b011;
 parameter pink     = 3'b101;
 parameter white    = 3'b110;
 parameter black    = 3'b000;
 
 always@(*) begin
	
	if(hcount < 144 || hcount >= 784) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end else begin 
		if(!display_pixel) begin
			red   <= 0;
			blue  <= 0;
			green <= 0;
		end
		
		case(switches)
			red: begin
				red <= 8'b10000000;
				green <= 8'b00000000;
				blue <= 8'b00000000;
			end
			green: begin
				red <= 8'b00000000;
				green <= 8'b10000000;
				blue <= 8'b00000000;
			end
			blue: begin
				red <= 8'b00000000;
				green <= 8'b00000000;
				blue <= 8'b10000000;
			end
			babyBlue: begin
				red <= 8'b10001001;
				green <= 8'b11001111;
				blue <= 8'b11110000;
			end
			yellow: begin
				red <= 8'b11111111;
				green <= 8'b11111111;
				blue <= 8'b00000000;
			end
			white: begin
				red <= 8'b11111111;
				VGA_G <= 8'b11111111;
				blue <= 8'b11111111;
			end
			black: begin
				red <= 8'b00000000;
				green <= 8'b00000000;
				blue <= 8'b00000000;
			end
		endcase
	end			
endmodule			
	