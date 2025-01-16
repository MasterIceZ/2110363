`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 04:13:37 AM
// Design Name: Exercise1
// Module Name: System
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: the top level module
//////////////////////////////////////////////////////////////////////////////////


module System (
    input  wire [7:0] SW,
    input  wire       Reset,
    input  wire       Clk,
    output wire [7:0] Segments,
    output wire [3:0] AN
);

  wire selectorWire;
  wire [3:0] muxOut;

  Controller ControllerInst (
      .Reset(Reset),
      .Clk(Clk),
      .AN(AN),
      .Selector(selectorWire)
  );
  SevenSegmentDecoder SevenSegmentDecoderInst (
      .DataIn  (muxOut),
      .Segments(Segments)
  );
  Multiplexer MultiplexerInst (
      .In0(SW[3:0]),
      .In1(SW[7:4]),
      .Selector(selectorWire),
      .DataOut(muxOut)
  );
  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, System);  // Dump all variables for the top module
  end
`endif
endmodule
