module SevenHEXSeg(input wire [5:0] hex_input, output reg [15:0] seven_seg);
always @(hex_input)
begin
case (hex_input)
6'b000000 : begin seven_seg = ~16'b0000000000000000; end
6'b001000 : begin seven_seg = ~16'b0010000001000000; end
6'b011000 : begin seven_seg = ~16'b0011000011000000; end
6'b111000 : begin seven_seg = ~16'b0011111111000000; end
6'b000100 : begin seven_seg = ~16'b0100000000100000; end
6'b000110 : begin seven_seg = ~16'b1100000000110000; end
6'b000111 : begin seven_seg = ~16'b1100000000111111; end
6'b111111 : begin seven_seg = ~16'b1111111111111111; end
default : begin seven_seg = ~16'b0000000000000000; end
endcase
end
endmodule

