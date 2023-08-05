`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:50:15 08/05/2023 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
input wire clk,
input [7:0] switch,
input [3:0] button,
output wire [3:0] anode,
output wire [7:0] cathode
    );
	 
wire refresh_clk;
wire [1:0] refreshcounter;
wire [3:0] ONE_DIGIT;

// wrapper for clock divider
clock_divider refreshclock_generator (
.clk(clk),
.divided_clk(refresh_clk) // 10khz
);

refreshcounter refreshcounter_uut (
.refresh_clk(refresh_clk),
.refreshcounter(refreshcounter)
);

anode_control anode_control_uut (
.refreshcounter(refreshcounter),
.anode(anode)
);

BCD_control BCD_control_uut (
.digit1(switch[3:0]),
.digit2(switch[7:4]),
.digit3(button[3:0]),
.digit4(button[3:0]),
.refreshcounter(refreshcounter),
.ONE_DIGIT(ONE_DIGIT)
);

BCD_to_cathodes BCD_to_cathode_uut (
.digit(ONE_DIGIT),
.cathode(cathode)
);

endmodule
