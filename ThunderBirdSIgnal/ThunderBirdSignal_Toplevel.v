/* File Name: ThunderBirdSignal_Toplevel.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: use for instantiate all modules to develop a ThunderBird Signal
* ECE 3710 ThunderBird Signal
*/
module ThunderBirdSignal_Toplevel(
input clk,
    reset,
     left,
    right,
    hazard,
    output wire [15:0] sixteen_seg
);

wire enable;
wire [5:0] status;

// instantiate clock divider, Turn signal, and displayment
Clock_div Clock_Divider(.clk(clk),.reset(reset),.slower_clk(enable));
ThunderBirdSignal TurnSignal(.left(left),.right(right),.reset(reset),.hazard(hazard),.clk(clk),.enable(enable),.status(status));
SixteenHEXSeg Displayment(.hex_input(status),sixteen_seg(sixteen_seg));

endmodule
