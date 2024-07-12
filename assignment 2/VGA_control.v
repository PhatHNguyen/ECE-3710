 module VGA_control
	(
		input 		clk,
			        clear,
				
		output reg      hsync,
				vsync,
		         [9:0] vcount,
			 [9:0] hcount,

	     	output reg  display_pixel
	 );

    always @(posedge clk) begin
        if (clear) begin
            hcount <= 0;
            vcount <= 0;
        end else begin
            // Increment hcount and handle display logic based on hcount and vcount
            if(hcount < 96) begin
			if(vcount >= 496)
				vcount <= 0;
				
			hsync <= 1;
			hcount <= hcount + 1;
			display_pixel <= 0;
		end
		//in H back porch
		else if(hcount < 144) begin 
			hcount <= hcount + 1;
			
			hsync <= 0;
			display_pixel <= 0;
		end 
		else if(hcount < 784) begin 
			hcount <= hcount + 1;
			
			hsync <= 0;
			display_pixel <= 1;
		end 
		
		//past the active area
		else begin 
			if(hcount == 799) begin 
				hcount <= 0;
				vcount <= vcount + 1;
			end else begin
				hcount <= hcount + 1; 
			end
			display_pixel <= 0;
		end 
        end
        
        // Generate vsync signal based on vcount
        if (vcount < 1) begin
            vsync <= 1;
        end else begin
            vsync <= 0;
        end
    end

endmodule