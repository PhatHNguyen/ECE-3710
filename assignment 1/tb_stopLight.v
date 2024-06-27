module tb_stopLight();
reg left,right,harzard,reset,clk;
wire [6:0] status;

intial begin 
    forever #5 begin
        clk = ~clk
    end
end

intital begin 
turnleft;
turnright;
harzardcheck;
turnsignal_interuption;
end 


task turnleft 
left = 1;
right = 0;
reset = 0;
harzard = 0;
wait for 35 seconds 
reset = 1;
endtask

task turnright 
left = 0;
right = 1;
reset = 0;
harzard = 0;
wait for 35 seconds 
reset = 1;
endtask

task harzardcheck 
left = 0;
right = 0;
reset = 0;
harzard = 1;
wait for 35 seconds 
reset = 1;
endtask

task turnsignal_interuption  
left = 1;
right = 0;
reset = 0;
harzard = 0;
wait for 10 seconds 
right = 1;
wait for 25 seconds 
left = 1;
wait for 10 seconds
harzard = 1;
wait for 10 seconds
reset = 1;
endtask 

endmodule



