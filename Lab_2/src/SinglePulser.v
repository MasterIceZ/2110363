`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:12:30 AM
// Design Name: BCD_Counter
// Module Name: SinglePulser
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Single Pulser Module
//////////////////////////////////////////////////////////////////////////////////


module SinglePulser (
    input  wire DataIn,
    input  wire Clk,
    input  wire Reset,
    output wire DataOut
);
  // Add your code here

  reg DataOutReg = 1'b0;
  reg DataPrevReg = 1'b0;

  always @(posedge Clk) begin
    if (Reset) begin
      DataOutReg <= 1'b0;
      DataPrevReg <= 1'b0;
    end else begin
      if (DataIn && !DataPrevReg) begin
        DataOutReg <= 1'b1;
      end else begin
        DataOutReg <= 1'b0;
      end
      DataPrevReg <= DataIn;
    end
  end

  assign DataOut = DataOutReg;

  // End of your code
endmodule
