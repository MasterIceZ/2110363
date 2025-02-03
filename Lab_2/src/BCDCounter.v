`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:10:33 AM
// Design Name: BCD_Counter
// Module Name: BCDCounter
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Top module for BCD Counter
//////////////////////////////////////////////////////////////////////////////////

module BCDCounter #(
    // Modify the parameter to match the requirements
    parameter CounterWidth = 20,
    parameter DebounceTime = 10000,
    parameter ControllerClockCycle = 1,
    parameter ControllerCounterWidth = 30
) (
    input  wire       Clk,
    input  wire       Reset,
    input  wire [3:0] Trigger,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  // Add your code here
  wire [3:0] toFourBCD;
  wire [15:0] toSeven;
  InputSanitizer #(
    .CounterWidth(CounterWidth),
    .DebounceTime(DebounceTime)
  ) inputSanitizer (
    .DataIn(Trigger),
    .Clk(Clk),
    .Reset(Reset),
    .DataOut(toFourBCD)
  );
  FourBCD fourBCD (
    .Trigger(toFourBCD),
    .Clk(Clk),
    .Reset(Reset),
    .DataOut(toSeven)
  );
  SevenSegmentDisplay #(
    .ControllerClockCycle(ControllerClockCycle),
    .ControllerCounterWidth(ControllerCounterWidth)
  ) sevenSegmentDisplay (
    .DataIn(toSeven),
    .Clk(Clk),
    .Reset(Reset),
    .AN(AN),
    .Segments(Segments)
  );
  // End of your code
endmodule