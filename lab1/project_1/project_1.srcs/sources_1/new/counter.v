`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2017 10:38:22 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input CLK,
    input UP,
    input DOWN,
    input RESET,
    output [3:0] LEDS
    );
    wire newclock1; //The 1Hz clock.
    reg [3:0] counting; //The output counter.
    clockdiv clk1(CLK,RESET,newclock1); //Instantiate the clockdivider fuction.
    assign LEDS[3:0] = counting[3:0]; //The counter assigned to the LEDs.
    always @ (posedge(newclock1) ,posedge(RESET))
    begin
        if(RESET==1) //Reset Condition. Zeros the counters.
        counting<=0;
        else 
        begin
            if(UP==1) //If the UP button is pressed, the counter goes up and 
                       //vice versa. Else the counter remains without change.
            counting<=counting+1;
            else if(DOWN==1)
            counting<=counting-1;
            else
            counting<=counting;
        end
    end
     
endmodule

module clockdiv(
input CLK,
input RESET,
output reg newclock
);
localparam constantNum = 125000000; //125M. divide number
    reg [31:0] Counter;//Counter to count 125M.
        always @ (posedge(CLK))
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