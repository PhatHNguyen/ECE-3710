module tb_VGAControl();

reg clk,
    clear;
	 
wire hsync;
wire vsync;
wire display_pixel;
	  
wire [9:0] hcount;
wire [9:0] vcount;
	  
	  
VGA_control controlUUT(

	.clk(clk),
	.clear(clear),
	.hsync(hsync),
	.vsync(vsync),
	.vcount(vcount),
	.hcount(hcount),
	.display_pixel(display_pixel)
	
	);
	
 initial begin
   	clk = 0;
   	forever #5 clk = ~clk;
 end
 
 initial begin
	clearActive;
	screenRefresh;
	$stop;
 end
 
 task clearActive;
 begin   
	clear = 0;
	repeat(30) @(posedge clk);
   clear = 1;
	repeat(10) @(posedge clk);
	clear = 0;
end
endtask

task screenRefresh;
begin
	clear =0;
	repeat(100000) @(posedge clk);
end
endtask

endmodule
