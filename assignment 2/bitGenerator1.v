module bitGenerator1
 (
	input [2:0] switches,
			[9:0] hcount,
			[9:0] vcount,
	input display_pixel,
					
	output reg [7:0] red,
		  [7:0] blue,
		  [7:0] green
 );
 
 parameter Red      = 3'b000;
 parameter Green    = 3'b001;
 parameter Blue     = 3'b010;
 parameter BabyBlue = 3'b100;
 parameter Yellow   = 3'b011;
 parameter Pink     = 3'b101;
 parameter White    = 3'b110;
 parameter Black    = 3'b111;
 
always@(*) begin
	
	if(hcount < 144 || hcount >= 784) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end else begin 
		if(~display_pixel) begin
			red   <= 0;
			blue  <= 0;
			green <= 0;
		end
		
		case(switches)
			Red: begin
				red <= 8'b10000000;
				green <= 8'b00000000;
				blue <= 8'b00000000;
			end
			Green: begin
				red <= 8'b00000000;
				green <= 8'b10000000;
				blue <= 8'b00000000;
			end
			Blue: begin
				red <= 8'b00000000;
				green <= 8'b00000000;
				blue <= 8'b10000000;
			end
			BabyBlue: begin
				red <= 8'b10001001;
				green <= 8'b11001111;
				blue <= 8'b11110000;
			end
			Yellow: begin
				red <= 8'b11111111;
				green <= 8'b11111111;
				blue <= 8'b00000000;
			end
			White: begin
				red <= 8'b11111111;
				green <= 8'b11111111;
				blue <= 8'b11111111;
			end
			Black: begin
				red <= 8'b00000000;
				green <= 8'b00000000;
				blue <= 8'b00000000;
			end
		endcase
	end
end		
endmodule			
	