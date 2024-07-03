module TopLevel
	(
		input power
	      	clk,
		[2:0] switches1,
		[3:0] buttons2,
      		bitGenSelector,
				
		output reg VGA_Hsync,
					  VGA_Vsync,
					  VGA_clk,
					  VGA_Display,
			  [5:0]VGA_LED,
		
			  [7:0] VGA_Red,
			  [7:0] VGA_Blue,
			  [7:0] VGA_Green
	);
	
	reg slower_clk = 0;
	
	wire [7:0] red1;
	wire [7:0] blue1;
	wire [7:0] green1;
	
	wire 		  FSM_clk; 
	wire [7:0] red2;
	wire [7:0] blue2;
	wire [7:0] green2;
	wire [5:0] LEDs
	
	wire Hsync;
	wire Vsync;
	wire [9:0] hCount;
	wire [9:0] vCount;
	wire display_pixels; 
	
	
	
	
	// ***Produce a 25MHZ signal from 50MHZ****
	
	always@(posedge clk) begin
		if(~power)
			slower_clk <= 0;
		else 
			slower_clk <= ~slower_clk;
	
	// ****************************************
	
	
	// *********Produce outputs****************
	always@(*) begin 
		VGA_Hsync <= Hsync;
		VGA_Vsync <= Vsync;
		VGA_clk <= slower_clk;
		
		if(bitGenSelector) begin 
			VGA_Red <= red2;
			VGA_Blue <= blue2;
			VGA_Green <= green2;
			VGA_LED <= LEDS;
		end else begin 
			VGA_Red <= red1;
			VGA_Blue <= blue1;
			VGA_Green <= green1;
			VGA_LED <= 6'b000000;
		end
		
		if(display_pixel) begin
			VGA_Display <= 1;
		end else begin 
			VGA_Display <= 0;
		end
	end
	// ****************************************
	
	// ***********Sub modules******************
		VGA_control control(
			.clk(slower_clk),
			.clear(power),
			.hsync(Hsync),
			.vsync(Vsync),
			.hCount(hCount),
			.vCount(vCount),
			.display_pixel(display_pixel)	
		);
		
		bitGenerator1 bitGen1(
			.switches(swithces),
			.hcount(hcount),
			.vcount(vcount),
			.display_pixel(display_pixel),
			.red(red1),
			.blue(blue1),
			.green(green1)
		);
			
	
	
	