module tb_bitGenerator2();

reg [9:0] hcount;
reg [9:0] vcount;
reg 	  display_pixel;
reg [5:0] LEDS;

wire [7:0] red;
wire [7:0] blue;
wire [7:0] green;

bitGenerator2 BitGenUUT (

	.hcount(hcount),
	.vcount(vcount),
	.display_pixel(display_pixel),
	.LEDS(LEDS),
	.red(red),
	.blue(blue),
	.green(green)
	
	);

initial begin
	InactiveLEDS;
	ActiveLEDS;
end
 	

task InactiveLEDS;
begin   
	hcount = 100;
	vcount = 200;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
        hcount = 420;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b001000;
	#40;
	hcount = 710;
	vcount = 200;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
end
endtask

task ActiveLEDS;
begin   
	hcount = 420;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b001000;
	#40;
   	hcount = 380;
	vcount = 221;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
	hcount = 360;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b011000;
	#40;
	hcount = 310;
	vcount = 221;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
	hcount = 280;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b111000;
	#40;
	hcount = 470;
	vcount = 221;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
	hcount = 500;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b000100;
	#40;
	hcount = 530;
	vcount = 221;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
	hcount = 560;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b000110;
	#40;
	hcount = 600;
	vcount = 221;
	display_pixel = 0;
	LEDS = 6'b000000;
	#40;
	hcount = 630;
	vcount = 221;
	display_pixel = 1;
	LEDS = 6'b000111;
	#40;
end
endtask
endmodule
