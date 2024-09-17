/* File Name: tb_mipscpu_mem.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: test the mipscpu_mem with my fibonacci code to see if it stores all 
* 13 fibonacci numbers between address 128 - 141 
* ECE 3710 MINI MIPS
*/
module tb_mipscpu_mem_NF();

// initialize the inputs and outputs
reg clk;
reg reset;
wire [7:0] adr;
wire [7:0] writedata;

// Instanstiate the module that contains the mips cpu and exmem 
mipscpu_mem UUT(
	.clk(clk),
	.reset(reset),
	.memwrite(memwrite),
	.adr(adr),
	.writedata(writedata)
);

// reset the MIPSCPU and exmem
initial begin
 reset = 0;
 #20;
 reset = 1;
end

// clock generator 
always 
begin
clk <= 1; #5; clk <= 0; #5;
end

// self checking test_bench that checks the addresses 128 - 141 and see if it stores the correct fibonacci numbers
always@(negedge clk) 
  if(UUT.memwrite) begin
    if((UUT.adr == 8'd128) & (UUT.writedata == 8'd0))
      $display("YaY! - 1st Fibonacci sucessefully completed");
    else if((UUT.adr == 8'd129) & (UUT.writedata == 8'd1))
      $display("YaY! - 2nd Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd130) & (UUT.writedata == 8'd1))
		 $display("YaY! - 3rd Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd131) & (UUT.writedata == 8'd2))
		 $display("YaY! - 4th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd132) & (UUT.writedata == 8'd3))
		 $display("YaY! - 5th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd133) & (UUT.writedata == 8'd5))
		 $display("YaY! - 6th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd134) & (UUT.writedata == 8'd8))
		 $display("YaY! - 7th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd135) & (UUT.writedata == 8'd13))
		 $display("YaY! - 8th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd136) & (UUT.writedata == 8'd21))
		 $display("YaY! - 9th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd137) & (UUT.writedata == 8'd34))
		 $display("YaY! - 10th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd138) & (UUT.writedata == 8'd55))
		 $display("YaY! - 11th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd139) & (UUT.writedata == 8'd89))
		 $display("YaY! - 12th Fibonacci sucessefully completed");
	 else if((UUT.adr == 8'd140) & (UUT.writedata == 8'd144))
		 $display("YaY! - 13th Fibonacci sucessefully completed");
	  else if((UUT.adr == 8'd141) & (UUT.writedata == 8'd233))
		 $display("YaY! Fibonacci sucessefully completed");
	 else 
      $display("Opps - wrong value written to addr %d: %d", UUT.adr, UUT.writedata);
   end
endmodule
