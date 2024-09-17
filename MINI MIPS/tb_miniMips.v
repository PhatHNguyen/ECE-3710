/* File Name: tb_miniMips.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: test the mipscpu_mem with my fibonacci code to see if it stores the 
* first 13th numbers in address 128 - 141, afterwards see if outputs the correct fibonacci number
* when given a specifc input switches
* ECE 3710 MINI MIPS
*/
module tb_miniMips;

//instanstiate inputs and outputs 
  reg clk;
  reg rst;
  reg [7:0] switches;
  wire [7:0] LEDS;

//instanstiate module that has mipscpu and exmem
 miniMips UUT (.clk(clk),
		.rst(rst), 
		.switches(switches),
		.LEDS(LEDS)
);

// clk generator 
always 
begin
  clk <= 1; #5; clk <= 0; #5;
end
	
  initial begin
  // reset the MIPSCPU and exmem
  switches = 8'b00000000;
  rst = 0; 
  #40
  rst = 1;	
  //generate a varitety of input switches to check for LEDS outputs 
 #6000
  switches = 8'b00000111; 
  #1000
  switches = 8'b00000000;
  #350
  switches = 8'b00001000;
  #350
  switches = 8'b00000010;
  #500
  switches = 8'b00001010;
  end

	
endmodule
	
