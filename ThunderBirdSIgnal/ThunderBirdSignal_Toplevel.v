module ThunderBirdSignal_Toplevel(
input clk,
    reset,
     left,
    right,
    hazard,
    output wire [15:0] seven_seg
);

wire enable;
wire [5:0] status;

Clock_div Clock_Divider(.clk(clk),.reset(reset),.slower_clk(enable));
ThunderBirdSignal TurnSignal(.left(left),.right(right),.reset(reset),.hazard(hazard),.clk(clk),.enable(enable),.status(status));
SevenHEXSeg(.hex_input(status),seven_seg(seven_seg));

endmodule
