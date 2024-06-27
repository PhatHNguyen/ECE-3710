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
    output reg [5:0] status
);

paremeter Neutral = 6'b000000;
paremeter L1 = 6'b001000; 
paremeter L2 = 6'b011000; 
paremeter L3 = 6'b111000; 
paremeter R1 = 6'b000001; 
paremeter R2 = 6'b000011; 
paremeter R3 = 6'b000111; 
paremeter Hazard = 6'b111111; 
reg [5:0] state;
reg [5:0] next_state;


always @(posedge clk) begin
    if(reset) begin
        left <= 0;
        right <= 0;
        state <= Neutral;
    end else if(harzard) begin
        left <= 0;
        right <= 0;
        state <= Hazard;
    end else begin 
        state <= next_state;
    end
end 

always @(posedge left, posedge right) begin
 if(left) begin 
        right <= 0;
        state <= L1;
    end else if(right) begin
        left <= 0;
        state <= R1;
    end 
end

always @(state) begin
    case(state)
    Neutral: begin
        next_state <= Neutral;
        status <=  6'b000000;
    end 
    L1: begin
        next_state <= L2;
        status <=  6'b001000;
    end
    L2: begin 
        next_state <= L3;
        status <=  6'b011000;
    end
    L3: begin 
        next_state <= L1;
        status <=  6'b111000;
    end
    R1: begin 
        next_state <= R2;
        status <=  6'b000001;
    end
    R2: begin 
        next_state <= R3;
        status <=  6'b000011;
    end
    R3: begin 
        next_state <= R1;
        status <=  6'b000111;
    end
    Hazard: begin
        next_state <= Hazard;
        status <=  6'b111111;
    end
end 

endmodule