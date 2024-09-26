/* File Name: bitGen2.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: refresh and display ThunderbirdSignal on the screen
* ECE 3710 VGA
*/
module bitGen2
 (
	 input [9:0] hcount,  // x position on the screen
	 input [9:0] vcount,  // y position on the screen
	input	    bright,  // at the specified psoition, turn on/off the that spot
	 input	[5:0] LEDS,  // Status of the ThunderBirdSignal					
	output reg [7:0] red,
	output reg [7:0] blue,
	output reg [7:0] green
 );
 
 
 always@(*) begin
	 // if hcount is not in active state of screen set red,blue, and green to 0 (no color display) - black background
	if(hcount < 144 || hcount > 783) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	// if user dont want the screen to display. set red,blue, and green to 0 (no color display) - black background
	end else if(!bright) begin
		red   <= 0;
		blue  <= 0;
		green <= 0;
	end

	 // if the vcount is with in the correct position on the grid, check for hcount and LEDS from ThunderBirdSignal 
	if((220 < vcount) && (260 > vcount)) begin
		// if h count within the area and the first left signal is on, set the pixel to be BabyBlue
		if((399 < hcount) && (440 > hcount) && (LEDS[3])) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;
		// if h count within the area and the second left signal is on, set the pixel to be BabyBlue
		end else if((329 < hcount) && (370 > hcount) && (LEDS[4])) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		// if h count within the area and the third left signal is on, set the pixel to be BabyBlue
		end else if((259 < hcount) && (300 > hcount) && (LEDS[5])) begin
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		// if h count within the area and the first right signal is on, set the pixel to be BabyBlue
		end else if((479 < hcount) && (520 > hcount) && (LEDS[2])) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		// if h count within the area and the second right signal is on, set the pixel to be BabyBlue
		end else if((549 < hcount) && (590 > hcount) && (LEDS[1])) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		// if h count within the area and the third right signal is on, set the pixel to be BabyBlue
		end else if((629 < hcount) && (670 > hcount) && (LEDS[0])) begin 
			red <= 8'b10001001;
			green <= 8'b11001111;
			blue <= 8'b11110000;	
		// if hcount is not in the specified area or LEDS are not on then set the specific pixel to RED
		end else begin
			red <= 8'b10000000;
			green <= 8'b00000000;
			blue <= 8'b00000000;
		end 
		// if vcount is not in the specified area then set the specific pixel to RED
	end else begin
		red <= 8'b10000000;
		green <= 8'b00000000;
		blue <= 8'b00000000;
	end
end	
endmodule
