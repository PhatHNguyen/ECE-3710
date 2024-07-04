module SevenHEXSeg(input wire [3:0] hex_input, output reg [6:0] seven_seg);
always @(hex_input)
begin
case (hex_input)
4'h0 : begin seven_seg = ~7'b0111111; end
4'h1 : begin seven_seg = ~7'b0110000; end
4'h2 : begin seven_seg = ~7'b1011011; end
4'h3 : begin seven_seg = ~7'b1001111; end
4'h4 : begin seven_seg = ~7'b1100110; end
4'h5 : begin seven_seg = ~7'b1101101; end
4'h6 : begin seven_seg = ~7'b1111101; end
4'h7 : begin seven_seg = ~7'b0000111; end
4'h8 : begin seven_seg = ~7'b1111111; end
4'h9 : begin seven_seg = ~7'b1100111; end
4'ha : begin seven_seg = ~7'b0110111; end
4'hb : begin seven_seg = ~7'b1111100; end
4'hc : begin seven_seg = ~7'b0111001; end
4'hd : begin seven_seg = ~7'b1011110; end
4'he : begin seven_seg = ~7'b1111001; end
4'hf : begin seven_seg = ~7'b1110001; end
default : begin seven_seg = ~7'b0000000; end
endcase
end
endmodule
/*
output pins:
seven_seg[0] PIN_C14
seven_seg[1] PIN_E15
seven_seg[2] PIN_C15
seven_seg[3] PIN_C16
seven_seg[4] PIN_E16
seven_seg[5] PIN_D17
seven_seg[6] PIN_C17
*/
