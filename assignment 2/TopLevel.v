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
	wire bright; 
	
	
	
	
	// ***Produce a 25MHZ signal from 50MHZ****
	
	always@(posedge clk) begin
		if(~power)
			VGA_clk <= 0;
		else 
			VGA_clk <= ~VGA_clk;
	end
	// ****************************************
	
	
	// *********Produce outputs****************
	always@(*) begin 
		VGA_Hsync <= hsync;
		VGA_Vsync <= vsync;
		
		// Select BitGen 1 or BitGen 2 
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
		
		// if dislaying pixel, signify VGA displayment 
		if(bright) begin
			VGA_Display <= 1;
		end else begin 
			VGA_Display <= 0;
		end
	end
	// ****************************************
	
	// ***********Instanstiate modules*********
		VGA_control control(
			.clk(VGA_clk),
			.clear(power),
			.hsync(hsync),
			.vsync(vsync),
			.hCount(hCount),
			.vCount(vCount),
			.bright(bright)	
		);
		
		bitGenerator1 bitGen1(
			.switches(swithces),
			.hcount(hcount),
			.vcount(vcount),
			.bright(bright),
			.red(red1),
			.blue(blue1),
			.green(green1)
		);
		
		clockDivider clk_Divider(
			.clk(clk),
			.slower_clk(FSM_clk)
		);
		
		FSMTS Turn_Signal(
			.left(buttons2[0]),
			.right(buttons2[1]),
			.reset(buttons2[2]),
			.hazard(buttons2[3]),
			.clk(clk),
			.en(FSM_clk),
			.status(LEDS)
		);
		
		bitGenerator2 bitGen2(
			.hcount(hcount),
			.vcount(vcount),
			.bright(bright),
			.LEDS(LEDS),
			.red(red2),
			.blue(blue2),
			.green(green2)
		);
	// ****************************************	
endmodule
	
