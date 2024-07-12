module tb_bitGenerator1();

reg [9:0] hcount;
reg [9:0] vcount;
reg 	  display_pixel;
reg [2:0] switches;

wire [7:0] red;
wire [7:0] blue;
wire [7:0] green;

bitGenerator1 BitGenUUT (

	.switches(switches),
	.hcount(hcount),
	.vcount(vcount),
	.display_pixel(display_pixel),
	.red(red),
	.blue(blue),
	.green(green)
	
);

initial begin
	Black_WhiteLEDS;
	AllColorLEDS;
	$stop;
end

task Black_WhiteLEDS;
begin   
	hcount = 100;
	display_pixel = 0;
	switches = 3'b000;
	#40;
   hcount = 420;
	display_pixel = 1;
	switches = 3'b111;
	#40;
	hcount = 710;
	display_pixel = 1;
	switches = 3'b110;
	#40;
end
endtask

task AllColorLEDS;
begin   
	hcount = 100;
	display_pixel = 0;
	switches = 3'b000;
	#40;
   hcount = 420;
	display_pixel = 1;
	switches = 3'b000;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b001;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b010;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b100;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b011;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b101;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
	hcount = 420;
	display_pixel = 1;
	switches = 3'b110;
	#40;
	hcount = 785;
	display_pixel = 0;
	switches = 3'b000;
	#40;
end
endtask

endmodule

