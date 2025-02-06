`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:55 AM
// Design Name: StackCircuit
// Module Name: StackUnit
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Module that implement the Stack
//////////////////////////////////////////////////////////////////////////////////

module StackUnit (
    input wire Clk,
    input wire Reset,
    input wire [7:0] DataIn,
    input wire Push,
    input wire Pop,
    output wire [7:0] StackValue,
    output wire [7:0] StackCounter
);
  // Add your code here

  wire RAMWriteEnable;
  wire RAMEnable;
  wire [7:0] RAMAddress;
  wire [7:0] RAMDataIn;
  wire [7:0] RAMDataOut;

  StackController stackController(
    .Push(Push),
    .Pop(Pop),
    .Clk(Clk),
    .Reset(Reset),
    .DataIn(DataIn),
    .StackCounter(StackCounter),
    .StackValue(StackValue),
    .RAMWriteEnable(RAMWriteEnable),
    .RAMEnable(RAMEnable),
    .RAMAddress(RAMAddress),
    .RAMDataIn(RAMDataIn),
    .RAMDataOut(RAMDataOut)
  );

  RAMUnit ramUnit(
    .Clk(Clk),
    .Reset(Reset),
    .WriteEnable(RAMWriteEnable),
    .RamEnable(RAMEnable),
    .Address(RAMAddress),
    .DataIn(RAMDataIn),
    .DataOut(RAMDataOut)
  );
  
  // End of your code
endmodule
