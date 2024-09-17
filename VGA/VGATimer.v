/* File Name: VGATimer.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: This module generate/monitors the pixels on the screen (whether they should be bright or not) 
* by using hcount and vcount to iterate through each pixel in a 640x800 pixel display. 
* It generates the horizontal and vertical sync signals (hsync, vsync) and tracks when 
* to update the display by notifying the user when it's entering 
* a new row or column, helping to manage pixel data during the display's active and 
* blanking periods.
* ECE 3710 VGA
*/
module VGATimer
	(
		input 		clk,
		input	        clear,
				
		output reg      hsync,  // horizontal sync 
		output reg	vsync,  // vertical sync 
		output reg [9:0] vcount, // counter for vertical position for the screen
		output reg [9:0] hcount, // counter for horizontal position for the screen
	     	output reg  bright // at the specified position, turn on/off the that pixel
	 );

    always @(posedge clk) begin
	// reset both the horizontal and vertical counter 
        if (clear) begin
            hcount <= 0;
            vcount <= 0;
        end else begin
            // Increment hcount and handle display logic based on hcount and vcount
	    // in the front porch of the screen 
            if(hcount < 96) begin
		    // if vcount is at the end of current column, reset it to 0 (new column)
		    if(vcount >= 639)
			vcount <= 0;
			hsync <= 0; // indicate a new row 
		        hcount <= hcount + 10'd1; // increment hcount ( x position of the screen)
		        bright <= 0; // set brightness off 
		end
		// in back porch of the screen, increment the hcount and set hsync high to indicate that it's not a new row
		else if(hcount < 144) begin 
			hcount <= hcount + 10'd1;
			hsync <= 1;
			bright <= 0;
		end 
		// in active area of the screen, increment the hcount and display the pixels that are within the active area
		else if(hcount < 784) begin 
			hcount <= hcount + 10'd1;
			hsync <= 1;
			bright <= 1;
		end 
		
		//past the active area, stop display the pixels and continue to increment hcount until 799
		else if (hcount < 800) begin 
			// if hcount = 799, reset the hcount and increment the vcount by 1
			if(hcount == 799) begin 
				hcount <= 0;
				vcount <= vcount + 10'd1;
			end else begin
				hcount <= hcount + 10'd1; 
				hsync <= 1;
			end
			bright <= 0;
		end 
        end
        
        // Generate vsync signal based on vcount
        if (vcount < 1) begin
            vsync <= 0; // indicate a new column
        end else begin
            vsync <= 1; 
        end
    end

endmodule
