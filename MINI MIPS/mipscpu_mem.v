module mipscpu_mem(
	input clk,
	input reset,
	output memwrite,
        output wire [7:0] adr,
	output wire [7:0] writedata
);
wire [7:0] q;


// instanstiate the mipscpu and exmeme. also connect them like in class
	mipscpu mips(
		.clk(clk),
		.reset(reset),
		.memdata(q),
		.memwrite(memwrite),
		.adr(adr),
		.writedata(writedata)
);

	exmem memory(
		.data(writedata),
		.addr(adr),
		.we(memwrite),
		.clk(~clk),
		.q(q)
);

endmodule
