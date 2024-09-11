module VGATimer
	(
		input 		clk,
		input	        clear,
				
		output reg      hsync,
		output reg	vsync,
		output reg [9:0] vcount,
		output reg [9:0] hcount,
	     	output reg  bright
	 );

    always @(posedge clk) begin
        if (clear) begin
            hcount <= 0;
            vcount <= 0;
        end else begin
            // Increment hcount and handle display logic based on hcount and vcount
            if(hcount < 96) begin
		    if(vcount >= 639)
			vcount <= 0;
			hsync <= 0;
			hcount <= hcount + 10'd1;
			bright <= 0;
		end
		//in H back porch
		else if(hcount < 144) begin 
			hcount <= hcount + 10'd1;
			hsync <= 1;
			bright <= 0;
		end 
		else if(hcount < 784) begin 
			hcount <= hcount + 10'd1;
			hsync <= 1;
			bright <= 1;
		end 
		
		//past the active area
		else begin 
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
            vsync <= 1;
        end else begin
            vsync <= 0;
        end
    end

endmodule