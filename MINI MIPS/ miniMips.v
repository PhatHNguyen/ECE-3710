module miniMips(
	input clk,
	input rst,
	input [7:0] switches,
	output [7:0] LEDS
);

wire memwrite;
wire [7:0] adr;
wire [7:0] writedata;
// read data 
wire [7:0] q;

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

