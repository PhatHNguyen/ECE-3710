module FSMTS ( 
	input [3:0] buttons,
		        clk,
   output reg [5:0] LED_status
 );
 
parameter left   = 4'b0111;
parameter right  = 4'b1011;
parameter reset  = 4'b1101;
parameter hazard = 4'b1110;

parameter Neutral = 6'b000000;
parameter L1      = 6'b001000; 
parameter L2      = 6'b011000; 
parameter L3      = 6'b111000; 
parameter R1      = 6'b000100; 
parameter R2      = 6'b000110; 
parameter R3      = 6'b000111; 
parameter Hazard  = 6'b111111; 

reg [5:0] current_state;
reg [5:0] next_state;


// Next state prediction 
always @* begin
    case(buttons)
	 
    reset: begin
        next_state <=  Neutral;
    end 
	 
	 hazard: begin 
		 next_state <= (current_state == Neutral) ? Hazard : Neutral;
	 end
	 
	 left: begin 
	   if(current_state == L1)
			next_state <= L2;
		else if(current_state == L2)
			next_state <= L3;
		else if(current_state == L3)
			next_state <= Neutral;
		else 
			next_state <= L1;
	 end
	 
	 right: begin 
	   if(current_state == R1)
			next_state <= R2;
		else if(current_state == R2)
			next_state <= R3;
		else if(current_state == R3)
			next_state <= Neutral;
		else 
			next_state <= R1;
	 end
  
	default: begin
		if(current_state == L1)
			next_state <= L2;
		else if(current_state == L2)
			next_state <= L3;
		else if(current_state == L3)
			next_state <= Neutral;
		else if(current_state == R1)
			next_state <= R2;
		else if(current_state == R2)
			next_state <= R3;
		else if(current_state == R3)
			next_state <= Neutral;
		else 
			next_state <= Neutral;
	end
endcase 
end

//state progression process
always @(posedge clk) begin
    if(buttons == reset) begin
        current_state <= Neutral;
		  next_state <= Neutral;
    end else if(buttons == hazard) begin
        current_state <= Hazard;
    end else begin 
        current_state <= next_state;
    end
end 

//Output Driving Process
always@(current_state) begin 
	case(current_state) 
	
	Neutral: begin
		LED_status <= 6'b000000;
	end 
	L1: begin
		LED_status <= 6'b001000;
	end 
	L2: begin
		LED_status <= 6'b011000;
	end 
	L3: begin
		LED_status <= 6'b111000;
	end 
	R1: begin
		LED_status <= 6'b000100;
	end 
	R2: begin
		LED_status <= 6'b000110;
	end 
	R3: begin
		LED_status <= 6'b000111;
	end 
	Hazard: begin
		LED_status <= 6'b111111;
	end 
	endcase 
end

endmodule