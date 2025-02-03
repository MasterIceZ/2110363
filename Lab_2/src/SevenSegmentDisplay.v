`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:16:12 AM
// Design Name: BCD_Counter
// Module Name: SevenSegmentDisplay
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Top module for 7-Segment Display
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentDisplay #(
    parameter ControllerClockCycle   = 1,
    parameter ControllerCounterWidth = 1
) (
    input wire [15:0] DataIn,
    input wire Clk,
    input wire Reset,
    output wire [7:0] Segments,
    output wire [3:0] AN
);
  // Add your code here
    wire [3:0] mux_out;
    wire [3:0] an_out;
    wire [1:0] sel_out;
    wire [7:0] seg_out;
    
    SevenSegmentController #(
        .ControllerClockCycle(ControllerClockCycle),
        .ControllerCounterWidth(ControllerCounterWidth)
      )
     s(
        .Reset(Reset),
        .Clk(Clk),
        .Selector(sel_out),
        .AN(an_out)
    );

    Multiplexer m(
      .DataIn(DataIn),
      .Selector(sel_out),
      .DataOut(mux_out)
    );
    
    SevenSegmentDecoder d(
        .DataIn(mux_out),
        .Segments(seg_out)
    );
    assign Segments = seg_out;
    assign AN = an_out;
  // End of your code
endmodule
