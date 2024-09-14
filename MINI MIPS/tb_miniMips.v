/* File Name: tb_miniMips.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: test the mipscpu_mem with the given fibonacci code to see if it stores the 8th number into 255
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

  // Generate the inputs, and check the outputs. 		
  initial begin
  switches = 8'b00000000;
  rst = 0; 

  #40
  rst = 1;
  
  #1000
  switches = 8'b00001000;
  #6000
  switches = 8'b00001001;
  #350
  switches = 8'b00001010;
  end
	
endmodule
	
	
