`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 04:17:24 AM
// Design Name: Exercise1
// Module Name: SevenSegmentDecoder
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Decoder for 7-segment display
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentDecoder (
    input  wire [3:0] DataIn,
    output wire [7:0] Segments
);
  // Add code here //

  assign Segments = (DataIn == 4'h0) ? 8'b00000011 :
                    (DataIn == 4'h1) ? 8'b10011111 :
                    (DataIn == 4'h2) ? 8'b00100101 :
                    (DataIn == 4'h3) ? 8'b00001101 :
                    (DataIn == 4'h4) ? 8'b10011001 :
                    (DataIn == 4'h5) ? 8'b01001001 :
                    (DataIn == 4'h6) ? 8'b01000001 :
                    (DataIn == 4'h7) ? 8'b00011111 :
                    (DataIn == 4'h8) ? 8'b00000001 :
                    (DataIn == 4'h9) ? 8'b00001001 :
                    (DataIn == 4'ha) ? 8'b00010001 :
                    (DataIn == 4'hb) ? 8'b11000001 :
                    (DataIn == 4'hc) ? 8'b01100011 :
                    (DataIn == 4'hd) ? 8'b10000101 :
                    (DataIn == 4'he) ? 8'b01100001 :
                    (DataIn == 4'hf) ? 8'b01110001 : 8'b11111111;

  // End of code //

  // cocotb dump waveforms
`ifdef COCOTB_SIM
  initial begin
    $dumpfile("waveform.vcd");  // Name of the dump file
    $dumpvars(0, SevenSegmentDecoder);  // Dump all variables for the top module
  end
`endif
endmodule
