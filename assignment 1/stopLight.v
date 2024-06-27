/* File Name:  stopLight.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: Allow user to signal left,right, and hazard sign
* ECE 3710 Stoplight
*/
module stopLight (
    input left, 
    right,
    reset,
    harzard,
    clk,
    output reg [5:0] status
);

parameter Neutral = 6'b000000;
parameter L1 = 6'b001000; 
parameter L2 = 6'b011000; 
parameter L3 = 6'b111000; 
parameter R1 = 6'b000100; 
parameter R2 = 6'b000110; 
parameter R3 = 6'b000111; 
parameter Hazard = 6'b111111; 
reg [5:0] state;
reg [5:0] next_state;


always @(posedge clk) begin
    if(reset) begin
        state <= Neutral;
		  next_state <= Neutral;
    end else if(harzard) begin
        state <= Hazard;
    end else begin 
        state <= next_state;
    end
end 


always @* begin
    case(state)
    Neutral: begin
         if(left) 
            next_state = L1;
        else if(right)
            next_state = R1;
        else
            next_state = Neutral;
        status <=  6'b000000;
    end 
    L1: begin
	 if(left) 
            next_state = L2;
        else if(right)
            next_state = R1;
        else
            next_state = Neutral;
        status <=  6'b001000;
    end
    L2: begin 
	 if(left) 
            next_state = L3;
        else if(right)
            next_state = R1;
        else
            next_state = Neutral;
        status <=  6'b011000;
    end
    L3: begin 
	 if(left) 
            next_state = L1;
        else if(right)
            next_state = R1;
        else
            next_state = Neutral;
        status <=  6'b111000;
    end
    R1: begin 
	if(right) 
            next_state = R2;
        else if(left)
            next_state = L1;
        else
            next_state = Neutral;
        status <=  6'b000100;
    end
    R2: begin 
	if(right) 
            next_state = R3;
        else if(left)
            next_state = L1;
        else
            next_state = Neutral;
        status <=  6'b000110;
    end
    R3: begin 
        if(right) 
            next_state = R1;
        else if(left)
            next_state = L1;
        else
            next_state = Neutral;
        status <=  6'b000111;
    end
    Hazard: begin
		  if(!harzard)
				next_state <= Neutral;
		  else
        next_state <= Hazard;
        status <=  6'b111111;
    end
endcase 
end
endmodule