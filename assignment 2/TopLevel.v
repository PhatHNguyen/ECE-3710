module TopLevel
	(
		input power,
	      	input  clk,
		input [2:0] switches1,
		input [3:0] buttons2,
      		input bitGenSelector,
				
		output reg VGA_Hsync,
		output reg VGA_Vsync,
		output reg VGA_clk,
		output reg  VGA_Display,
		output reg [5:0] VGA_LED,
		output reg [7:0] VGA_Red,
		output reg [7:0] VGA_Blue,
		output reg [7:0] VGA_Green
	);
	
	reg slower_clk = 0;
	
	wire [7:0] red1;
	wire [7:0] blue1;
	wire [7:0] green1;
	
	wire       FSM_clk; 
	wire [7:0] red2;
	wire [7:0] blue2;
	wire [7:0] green2;
	wire [5:0] LEDS;
	
	wire hsync;
	wire vsync;
	wire [9:0] hCount;
	wire [9:0] vCount;
	wire display_pixels; 
	
	
	
	
	// ***Produce a 25MHZ signal from 50MHZ****
	
	always@(posedge clk) begin
		if(~power)
			slower_clk <= 0;
		else 
			slower_clk <= ~slower_clk;
	end
	// ****************************************
	
	
	// *********Produce outputs****************
	always@(*) begin 
		VGA_Hsync <= hsync;
		VGA_Vsync <= vsync;
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
		
		if(display_pixels) begin
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
			.hsync(hsync),
			.vsync(vsync),
			.hCount(hCount),
			.vCount(vCount),
			.display_pixel(display_pixel)	
		);
		
		bitGenerator1 bitGen1(
			.switches(swithces),
			.hcount(hcount),
			.vcount(vcount),
			.display_pixel(display_pixels),
			.red(red1),
			.blue(blue1),
			.green(green1)
		);
		
		clockDivider clk_Divider(
			.clk(clk),
			.slower_clk(FSM_clk)
		);
		
		FSMTS Turn_Signal(
			.buttons(buttons2),
			.clk(FSM_clk),
			.LED_status(LEDS)
		);
		
		bitGenerator2 bitGen2(
			.hcount(hcount),
			.vcount(vcount),
			.display_pixel(display_pixel),
			.LEDS(LEDS),
			.red(red2),
			.blue(blue2),
			.green(green2)
		);
	// ****************************************	
endmodule
	
