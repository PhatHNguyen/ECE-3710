module tb_stopLight();
reg left,right,harzard,reset,clk;
wire [5:0] status;


stopLight UUT (
	.left(left),
	.right(right),
	.reset(reset),
	.harzard(harzard),
	.clk(clk),
	.status(status)
);


 initial begin
   	clk = 0;
   	forever #5 clk = ~clk;
    end

initial begin 
turnleft;
turnright;
harzardcheck;
turnsignal_interuption;
end 


task turnleft;
   begin   
	reset = 1;
	repeat(10) @(posedge clk);
    left = 1;
    right = 0;
    reset = 0;
    harzard = 0;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask


task turnright;
 begin 
left = 0;
right = 1;
reset = 0;
harzard = 0;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask

task harzardcheck;
 begin
left = 0;
right = 0;
reset = 0;
harzard = 1;
 repeat(35) @(posedge clk);
reset = 1;
end
endtask

task turnsignal_interuption;
 begin  
left = 1;
right = 0;
reset = 0;
harzard = 0;
 repeat(10) @(posedge clk);
right = 1;
 repeat(25) @(posedge clk);
left = 1;
 repeat(10) @(posedge clk);
harzard = 1;
 repeat(10) @(posedge clk);
reset = 1;
end
endtask 

endmodule
