`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2017 10:42:43 PM
// Design Name: 
// Module Name: jackpot
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module jackpot(
input CLOCK, 
input RESET,
input [3:0] SWITCHES,
output [3:0] LEDS
);
reg [3:0] lightSwitch;
assign LEDS[3:0]=lightSwitch[3:0];

	
	reg win;
	wire newClock;
	clockdiv divide(CLOCK, RESET, newClock);
always@(SWITCHES or RESET or lightSwitch)
begin
	if(lightSwitch[3:0]==SWITCHES[3:0]) // Condition for the win. Where the win is activated if the switch corresponds to the light.
	win<=1'b1;
	else
	win<=1'b0;

end

always@(posedge newClock, posedge RESET)
begin
	if(RESET == 1) // RESET. 
	begin
	lightSwitch<=4'b1000;
	end
	
	else
	begin
		if(win==1) // if won light up all the lights.
		begin
		lightSwitch<=4'b1111;
		end
		else
		begin
		case(lightSwitch) // switching light in a one hot fashion if not won using case switching. refreshes with every clock cycle.
			4'b1000:lightSwitch<=4'b0100;
			4'b0100:lightSwitch<=4'b0010;
			4'b0010:lightSwitch<=4'b0001;
			4'b0001:lightSwitch<=4'b1000;	
		endcase
		end
	end
end


endmodule

module clockdiv(
input CLOCK,
input RESET,
output reg newclock
);
localparam constantNum = 125000000; //125M. divide number
    reg [31:0] Counter;//Counter to count 125M.
        always @ (posedge(CLOCK))
            begin
            if(RESET == 1'b1)//The new clock if created by counting the Clock  
                             //and see if it is 125M. So the new clock is 1Hz.
                begin 
                Counter <= 32'b0;
                end
            else if (Counter==constantNum)
                begin
                newclock <= 1'b1;
                Counter <= 0;//Counter to count 125M is zeroed.
                end
            else
                begin
                newclock<=1'b0;
                Counter <= Counter +1;//Keep counting until 125M.
                end
            end
        
endmodule

	