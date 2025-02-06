`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:44:47 AM
// Design Name: StackCircuit
// Module Name: StackCircuit
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Top level module for the Stack Circuit
//////////////////////////////////////////////////////////////////////////////////


module StackCircuit (
    input  wire       Clk,
    input  wire       Reset,
    input  wire       Push,
    input  wire       Pop,
    input  wire [7:0] DataIn,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  // Add your code here

  wire pushWire;
  wire popWire;
  wire [7:0] stackValueWire;
  wire [7:0] stackCounterWire;

  InputSanitizer inputSanitizer(
    .Clk(Clk),
    .Reset(Reset),
    .DataIn({Push, Pop}),
    .DataOut({pushWire, popWire})
  );

  StackUnit stackUnit(
    .Clk(Clk),
    .Reset(Reset),
    .DataIn(DataIn),
    .Push(pushWire),
    .Pop(popWire),
    .StackValue(stackValueWire),
    .StackCounter(stackCounterWire)
  );

  SevenSegmentDisplay sevenSegment(
    .Clk(Clk),
    .Reset(Reset),
    .DataIn({stackValueWire, stackCounterWire}),
    .Segments(Segments),
    .AN(AN)
  );
  
  // End of your code
endmodule
