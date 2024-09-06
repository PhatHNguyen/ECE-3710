/* File Name:  ThunderBirdSignal.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: Allow user to signal left,right, and hazard sign
* ECE 3710 ThunderBird Signal
*/
module ThunderBirdSignal (
    input left, 
    right,
    reset,
    hazard,
    clk,
    enable,
    output reg [5:0] status
);

// stages for FSM
parameter Neutral = 6'b000000; // No lights 
parameter L1 = 6'b001000;  // left turn signal stage 1
parameter L2 = 6'b011000;  // left turn signal stage 2
parameter L3 = 6'b111000;  // left turn signal stage 3
parameter R1 = 6'b000100;  // right turn signal stage 1
parameter R2 = 6'b000110;  // right turn signal stage 2
parameter R3 = 6'b000111;  // right turn signal stage 3
parameter Hazard = 6'b111111; // Hazard singal 

reg [5:0] current_state = Neutral;
reg [5:0] next_state;

// update current_state 
always @(posedge clk) begin
    if(~reset) begin
        current_state <= Neutral;
    end else if(enable) begin 
        current_state <= next_state;
    end
end 

// FSM: update the next_state and set the status LED to a specific result depending on the current_state
// Note: is hazard has been pressed, go to the hazard state next clk cycle
always @(*) begin
    case(current_state)

     // NO LEDS is active, waits for an input 
     Neutral: begin
	// presss any of the inputs will go to a specific stage
	if (!hazard)
	   next_state <= Hazard;
	else if (!left) 
            next_state <= L1;
        else if (!right)
            next_state <= R1;
        else
            next_state <= Neutral;
        status <=  6'b000000;
    end 

    // Activate the first left signal (first left light is on)     
    L1: begin
	// presss hazard, go to hazard stage else continue the left stage
	if (~hazard) 
            next_state <= Hazard;
        else
            next_state <= L2;
        status <=  6'b001000;
    end

    // Activate the second left signal (first and second left light is on)   
    L2: begin 
	// presss hazard, go to hazard stage else continue the left stage
	if (!hazard) 
            next_state <= Hazard;
        else
            next_state <= L3;
        status <=  6'b011000;
    end

    // Activate the last left signal  (all 3 left signal )      
    L3: begin 
	// presss any of the inputs will go to a specific stage
	if (!hazard)
	    next_state <= Hazard;	
	else if (!left) 
            next_state <= L1;
        else if (!right)
            next_state <= R1;
        else
            next_state <= Neutral;
        status <=  6'b111000;
    end

    // Activate the first right signal (first right light is on)    
    R1: begin 
	// presss hazard, go to hazard stage else continue the right stage
	if (!hazard) 
            next_state <= Hazard;
        else
            next_state <= R2;
        status <=  6'b000100;
    end

    // Activate the second right signal (first and second right light is on)     
    R2: begin 
	// presss hazard, go to hazard stage else continue the right stage
	if (!hazard) 
            next_state <= Hazard;
        else
            next_state <= R3;
        status <=  6'b000110;
    end

    // Activate the last right signal (all 3 right signal )       
    R3: begin 
	// presss any of the inputs will go to a specific stage
	if (!hazard)
	    next_state <= Hazard;
        else if (!right) 
            next_state <= R1;
        else if (!left)
            next_state <= L1;
        else
            next_state <= Neutral;
        status <=  6'b000111;
    end

    // Activate all LEDS     
    Hazard: begin
	next_state <= Neutral;
        status <=  6'b111111;
    end
   // should never occur
  default: begin
            next_state = Neutral; 
            status = 6'b000000;
        end
endcase 
end

endmodule
