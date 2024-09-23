/* File Name: VGA_Toplevel.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: instanstiate modules for VGA displayment 
* ECE 3710 VGA
*/
module VGA_Toplevel
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
	// for bitGen1
	wire [7:0] red1;
	wire [7:0] blue1;
	wire [7:0] green1;

	// for ThunderBird Signal (bitGen2)
	wire       FSM_clk; 
	wire [7:0] red2;
	wire [7:0] blue2;
	wire [7:0] green2;
	wire [5:0] LEDS;

	// for VGATimer 
	wire hsync;
	wire vsync;
	wire [9:0] hcount;
	wire [9:0] vcount;
	wire bright; 
	
	// Produce a 25MHZ signal from 50MHZ
	
	always@(posedge clk) begin
		if(~power)
			VGA_clk <= 0;
		else 
			VGA_clk <= ~VGA_clk;
	end
	// end of clock 25 MHZ signal producer 
	
	
	// Produce outputs based on the Bit Gen switches
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
	// end of outputing 
	
	// Instanstiate VGATimer, bitGen1, clock Divider, Thunderbird Signals FSM,
	// and bitGen2 modules
	// to generate/monitor the displaymnet on the screen
		VGATimer control(
			.clk(VGA_clk),
			.clear(power),
			.hsync(hsync),
			.vsync(vsync),
			.vcount(vcount),
			.hcount(hcount),
			.bright(bright)	
		);
		// to display colors on the screen
		bitGen1 bitGenerator1(
			.switches(switches1),
			.hcount(hcount),
			.vcount(vcount),
			.bright(bright),
			.red(red1),
			.blue(blue1),
			.green(green1)
		);
		// to generate an clk enable for the ThunderBirdSignal
		clockDivider clk_Divider(
			.clk(clk),
			.slower_clk(FSM_clk)
		);
		// To generate turn signal based on the inputs left,right, or hazard
		ThunderBirdSignal Turn_Signal(
			.left(buttons2[0]),
			.right(buttons2[1]),
			.reset(buttons2[2]),
			.hazard(buttons2[3]),
			.clk(clk),
			.enable(FSM_clk),
			.status(LEDS)
		);
		// to display the Thunderbird Signal on the screen
		bitGen2 bitGenerator2(
			.hcount(hcount),
			.vcount(vcount),
			.bright(bright),
			.LEDS(LEDS),
			.red(red2),
			.blue(blue2),
			.green(green2)
		);
	// end of instanstiating moduels 
endmodule
	
