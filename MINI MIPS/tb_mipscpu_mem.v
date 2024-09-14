/* File Name: tb_mipscpu_mem.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: test the mipscpu_mem with the given fibonacci code to see if it stores the 8th number into 255
* ECE 3710 ThunderBird Signal
*/
module tb_mipscpu_mem();

reg clk;
reg reset;
wire [7:0] adr;
wire [7:0] writedata;

// Instanstiate the module 
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

always 
begin
clk <= 1; #5; clk <= 0; #5;
end


always@(negedge clk) 
  if(UUT.memwrite)
    if(UUT.adr == 8'd255 & UUT.writedata == 8'h0d)
      $display("YaY! - Fibonacci sucessefully completed");
    else 
      $display("Opps - wrong value written to addr 255: %h", UUT.writedata);


endmodule
