module tb_miniMips;

  reg clk;
  reg rst;
  reg [7:0] switches;
  wire [7:0] LEDS;
  
 miniMips UUT (.clk(clk),
				  .rst(rst), 
				  .switches(switches),
				  .LEDS(LEDS)
);

always 
begin
clk <= 1; #5; clk <= 0; #5;
end

always #5 begin clk = ~clk; end
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
	
	