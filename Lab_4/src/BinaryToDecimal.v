`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/15/2025 09:45:18 PM
// Design Name: BinaryToDecimal
// Module Name: BinaryToDecimal
// Project Name: BinaryToDecimal
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Top level module for the Binary to Decimal conversion Module
//////////////////////////////////////////////////////////////////////////////////


module BinaryToDecimal (
    input  wire       Clk,
    input  wire       Reset,
    input  wire [5:0] DataIn,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  // Add your code here

  wire [15:0] romOut;

  ROMUnit rom(
    .Reset(Reset),
    .Clk(Clk),
    .Address(DataIn),
    .DataOut(romOut)
  );
  SevenSegmentDisplay sevenSegmentDisplay(
    .Reset(Reset),
    .Clk(Clk),
    .DataIn(romOut),
    .Segments(Segments),
    .AN(AN)
  );
  // End of your code
endmodule
