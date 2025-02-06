`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/16/2025 01:45:42 AM
// Design Name: StackCircuit
// Module Name: StackController
// Project Name: StackCircuit
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: This module is used to implement the stack from RAMUnit
//////////////////////////////////////////////////////////////////////////////////


module StackController (
    input  wire       Push,
    input  wire       Pop,
    input  wire       Clk,
    input  wire       Reset,
    input  wire [7:0] DataIn,
    output reg [7:0] StackCounter,
    output reg [7:0] StackValue,
    output reg       RAMWriteEnable,
    output reg       RAMEnable,
    output reg [7:0] RAMAddress,
    output reg [7:0] RAMDataIn,
    input  wire [7:0] RAMDataOut
);
  // add your code here

  always @(posedge Clk) begin
    if (Reset) begin
      StackCounter <= 8'h00;
      RAMAddress <= 0;
      StackValue <= 8'h00;
    end else begin
      if (Push) begin
        if (StackCounter != 8'b11111111) begin
          RAMEnable <= 1;
          RAMWriteEnable <= 1;
          RAMAddress <= StackCounter + 1;
          RAMDataIn <= DataIn;
          StackCounter <= StackCounter + 1;
        end
      end else if (Pop) begin
        if (StackCounter != 8'b00000000) begin
          RAMEnable <= 1;
          RAMWriteEnable <= 0;
          RAMAddress <= StackCounter - 1;
          StackValue <= RAMDataOut;
          StackCounter <= StackCounter - 1;
        end
      end else begin
        RAMEnable <= 1;
        RAMWriteEnable <= 0;
      end
    end
  end

  // End of your code
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, StackController);  // Dump all variables for the top module
  end
`endif
endmodule
