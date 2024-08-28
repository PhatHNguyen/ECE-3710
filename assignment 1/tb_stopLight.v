/*
* File Name: tb_ThunderBirdSignal.v
* Author:  Phat Nguyen
* Create Date:    8/20/2024
* Purpose: test ThunderBiedSignal.v for correctness
* ECE 3710
*/
module tb_ThunderBirdSignal();

reg left,right,hazard,reset,clk,enable;
wire [5:0] status;

//instanstiate ThunderBirdSingal
ThunderBirdSignal UUT (
	.left(left),
	.right(right),
	.reset(reset),
	.hazard(hazard),
	.clk(clk),
	.enable(enable),
	.status(status)
);

// Toggle clk every 5 ns 
 initial begin
   	clk = 0;
   	forever #5 clk = ~clk;
    end

// Simulate the following tasks for functionality 
initial begin 

turnleft;
turnright;
harzardcheck;
turnsignal_interuption;
end 


// simulate left turn signal (checking for complete sequence)
task turnleft;
   begin   
	reset = 1;
	left = 0;
	right = 0;
	hazard = 0;
	enable = 0;
	repeat(10) @(posedge clk);
    enable = 1;
    left = 1;
    right = 0;
    reset = 0;
    hazard = 0;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask

// simulate right turn signal (checking for complete sequence)
task turnright;
 begin 
left = 0;
right = 1;
reset = 0;
hazard = 0;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask

// simulate hazard signal (checking for alternation between [000000] and [111111])
task harzardcheck;
 begin
left = 0;
right = 0;
reset = 0;
hazard = 1;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask

// simulate hazard assertion during a left/right turn signal sequence 
task turnsignal_interuption;
 begin  
left = 1;
right = 0;
reset = 0;
hazard = 0;
 repeat(10) @(posedge clk);
right = 1;
 repeat(25) @(posedge clk);
left = 1;
 repeat(10) @(posedge clk);
hazard = 1;
 repeat(10) @(posedge clk);
reset = 1;
end
endtask 

endmodule
