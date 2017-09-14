`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2017 10:25:31 PM
// Design Name: 
// Module Name: switch
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

module switch(
    input [3:0] SWITCHES,
    output [3:0] LEDS
    );
    assign LEDS[3:0] = SWITCHES[3:0]; // assign the corresponding LEDS to the switches.
endmodule
