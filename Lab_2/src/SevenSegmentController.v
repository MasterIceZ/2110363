`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: BCD_Counter
// Module Name: SevenSegmentController
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Controller module for 7-Segment Display
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentController #(
    parameter ControllerClockCycle   = 1,
    parameter ControllerCounterWidth = 1
) (
    input  wire       Reset,
    input  wire       Clk,
    output wire [3:0] AN,
    output wire [1:0] Selector
);
  reg [ControllerCounterWidth-1:0] Counter = 0;
  // Add your code here

  reg [3:0] ANReg = 4'b1111;
  assign AN = ANReg;
  reg [1:0] SelectorReg = 0;
  assign Selector = SelectorReg;

  // 1111 -> 0000
  // 1110 -> 0001
  // 1101 -> 0010
  // 1011 -> 0100
  // 0111 -> 1000

  always @(posedge Clk) begin
    if(Reset) begin
      Counter = 0;
      ANReg = 4'b1111;
      SelectorReg = 0;
    end else begin
      if (ANReg == 4'b1111) begin
        Counter = 0;
        ANReg = 4'b1110;
        SelectorReg = 0;
      end else begin
        if(Counter == ControllerClockCycle - 1) begin
          Counter <= 0;
          case(SelectorReg)
            0 : begin ANReg <= 4'b1101; SelectorReg <= 1; end
            1: begin ANReg <= 4'b1011; SelectorReg <= 2; end
            2: begin ANReg <= 4'b0111; SelectorReg <= 3; end
            3: begin ANReg <= 4'b1110; SelectorReg <= 0; end
          endcase
        end else begin
          Counter <= Counter + 1;
        end
      end
    end
  end

  // End of your code
endmodule
