/* File Name: miniMips.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: instanstiate the mipscpu and exmem to and connect them (This time with the switches and LEDS as input and output)
* ECE 3710 MINI MIPS
*/
module miniMips(
	input clk,
	input rst,
	input [7:0] switches,
	output [7:0] LEDS
);

// initalize wires to connect the mipscpi and exmem 
wire memwrite;
wire [7:0] adr;
wire [7:0] writedata;
// read data 
wire [7:0] q;

// instantiate the mipscpu and exmem 
	mipscpu mips(
		.clk(clk),
		.reset(rst),
		.memdata(q),
		.memwrite(memwrite),
		.adr(adr),
		.writedata(writedata)
);

	exmem memory(
	   .switches(switches),
		.data(writedata),
		.addr(adr),
		.we(memwrite),
		.clk(~clk),
		.q(q),
		.LEDS(LEDS)
);

endmodule

