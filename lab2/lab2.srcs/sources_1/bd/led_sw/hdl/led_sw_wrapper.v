//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Tue Sep 12 21:30:53 2017
//Host        : apollo.ece.tamu.edu running 64-bit unknown
//Command     : generate_target led_sw_wrapper.bd
//Design      : led_sw_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module led_sw_wrapper
   (clock_rtl,
    led_tri_o);
  input clock_rtl;
  output [3:0]led_tri_o;

  wire clock_rtl;
  wire [3:0]led_tri_o;

  led_sw led_sw_i
       (.clock_rtl(clock_rtl),
        .led_tri_o(led_tri_o));
endmodule
