/* File Name: miniMips.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: refresh and display one color on the entire screen 
* ECE 3710 VGA
*/
module bitGen1
 (
	 input [2:0] switches, // allow user to decide what color is begin display
	 input [9:0] hcount, // x position on the screen
	 input [9:0] vcount, // y position on the screen
	input bright,     // at the specified psoition, turn on/off the that spot
					
        output reg [7:0] red, 
	output reg [7:0] blue,
	output reg [7:0] green
 );

// Option of colors that can be picked via switches
 parameter Red      = 3'b000;
 parameter Green    = 3'b001;
 parameter Blue     = 3'b010;
 parameter BabyBlue = 3'b100;
 parameter Yellow   = 3'b011;
 parameter Pink     = 3'b101;
 parameter White    = 3'b110;
 parameter Black    = 3'b111;
 
always@(*) begin
	// if hcount is not in active state of screen set red,blue, and green to 0 (no color display)
	if(hcount < 144 || hcount >= 784) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	// user dont want it to screen to display color. set red,blue, and green to 0 (no color display)
	end else begin 
		if(~bright) begin
			red   <= 0;
			blue  <= 0;
			green <= 0;
		end
		// depending on the status of the switches, set the entire screen to specific color by setting the outputs red,blue, and green to specifiy value
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
			// This should never happen
			default: begin
				red <= 8'b10000000;
				green <= 8'b00000000;
				blue <= 8'b00000000;
			end
		endcase
	end
end		
endmodule			
	
