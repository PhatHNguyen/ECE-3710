module ThunderBirdSignal_Toplevel(
input clk,
    reset,
     left,
    right,
    hazard,
    output wire [5:0] status
);

wire enable;
wire [5:0] LEDS;

Clock_div Clock_Divider(.clk(clk),.reset(reset),.slower_clk(enable));
ThunderBirdSignal TurnSignal(.left(left),.right(right),.reset(reset),.hazard(hazard),.clk(clk),.enable(enable),.status(LEDS));

assign status = LEDS;

endmodule