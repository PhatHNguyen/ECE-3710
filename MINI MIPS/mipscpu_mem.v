/* File Name: mipscpu_mem.v
* Author:  Phat Nguyen
* Create Date:    09/08/2024
* Purpose: instansitate the mipscpu and exmem to and connect them 
* ECE 3710 MINI MIPS
*/
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
