// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module exmem #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
        (
	input [5:0]              switches,
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input                    we, clk,
	output [(DATA_WIDTH-1):0] q,
	output reg [(DATA_WIDTH-1):0] LEDS
        );

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the read address
	reg [ADDR_WIDTH-1:0] addr_reg;
	
	// memory location space Indicator
	//wire IO;
	
	//assign IO = (addr[7 -: 1] == 2'b11);

        // The $readmemb function allows you to load the
        // RAM with data on initialization to the FPGA
        // you'll need to update the path to this file
        // for your own location. 
	initial begin
	$display("Loading memory");
	$readmemb("/home/u1278438/fib-b.dat", ram);
	$display("done loading");
	end

	always @ (posedge clk)
	begin
		// Write
		if (we)
			//if(IO) begin
			//	LEDS <= data;
			// end else begin
				ram[addr] <= data;
			//end
                // register to hold the read address
		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode. 
   assign q = ram[addr_reg];	
	//assign q = IO ? switches :ram[addr_reg];

endmodule // exmem