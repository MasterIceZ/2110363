`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 12/23/2024 05:07:14 AM
// Design Name: Exercise1
// Module Name: SevenSegmentDecoderTB
// Project Name: Exercise1
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: Testbench for the SevenSegmentDecoder module
//////////////////////////////////////////////////////////////////////////////////


module SevenSegmentDecoderTB ();
  // declare the reg/wire
  reg  [3:0] DataIn;
  wire [7:0] Segments;

  // instantiate the SevenSegmentDecoder module
  SevenSegmentDecoder SevenSegmentDecoderInst (
      .DataIn  (DataIn),
      .Segments(Segments)
  );

  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  
  integer i;

  reg [7:0] answers [15:0];

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [7:0] expected_Segments;  // Expected output
    begin
      if (Segments !== expected_Segments) begin
        $error("ERROR: TestCaseNo %0d | Time = %0t | DataIn = %b | Segments = %b (Expected: %b)",
               TestCaseNo, $time, DataIn, Segments, expected_Segments);
        flag = 1;
      end
    end
  endtask

  // test cases
  initial begin
    // your task : complete this testcase
    
    answers[0]  = 8'b00000011;
    answers[1]  = 8'b10011111;
    answers[2]  = 8'b00100101;
    answers[3]  = 8'b00001101;
    answers[4]  = 8'b10011001;
    answers[5]  = 8'b01001001;
    answers[6]  = 8'b01000001;
    answers[7]  = 8'b00011111;
    answers[8]  = 8'b00000001;
    answers[9]  = 8'b00001001;
    answers[10] = 8'b00010001;
    answers[11] = 8'b11000001;
    answers[12] = 8'b01100011;
    answers[13] = 8'b10000101;
    answers[14] = 8'b01100001;
    answers[15] = 8'b01110001;

    for(i=0; i<16; i=i+1) begin
      DataIn = i;
      #1
      check_output(TestCaseNo, answers[i]);
      TestCaseNo = TestCaseNo + 1;
    end

    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
