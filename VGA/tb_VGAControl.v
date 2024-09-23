/*
* File Name: tb_VGAControl.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: test VGATimer to determine if it produce the correct outcome for the correct area
* as well as reset the vcount and hcount to 0
* ECE 3710 VGA
*/
module tb_VGAControl();

reg clk;
reg   clear;
	 
wire hsync;
wire vsync;
wire bright;
	  
wire [9:0] hcount;
wire [9:0] vcount;
	  
//Instantiate VGATimer 	  
VGATimer controlUUT(

	.clk(clk),
	.clear(clear),
	.hsync(hsync),
	.vsync(vsync),
	.vcount(vcount),
	.hcount(hcount),
	.bright(bright)
	
	);

// clk generator
 initial begin
   	clk = 0;
   	forever #5 clk = ~clk;
 end

// simulate the following task
 initial begin
	clearActive;
	screenRefresh;
	$stop;
 end

// active clear, to reset hcount and vcount = 0 
 task clearActive;
 begin   
	clear = 0;
	repeat(30) @(posedge clk);
   clear = 1;
	repeat(10) @(posedge clk);
	clear = 0;
end
endtask

// let hcount and vcount increment and reset to 0, in certain area bright should high indicate the specific pixel should display 
task screenRefresh;
begin
	clear =0;
	repeat(100000) @(posedge clk);
end
endtask

endmodule
