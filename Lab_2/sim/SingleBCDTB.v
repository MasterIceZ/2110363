`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/09/2025 03:29:42 PM
// Design Name: BCD_Counter
// Module Name: SingleBCDTB
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Testbench for the SingleBCD module
//////////////////////////////////////////////////////////////////////////////////


module SingleBCDTB ();
  // reg/wire declaration
  reg        Trigger;
  reg        Reset;
  reg        Clk;
  reg        Cin;
  wire [3:0] DataOut;
  wire       Cout;

  // instantiate the Multiplexer module
  SingleBCD SingleBCDInst (
      .Trigger(Trigger),
      .Clk(Clk),
      .Reset(Reset),
      .Cin(Cin),
      .DataOut(DataOut),
      .Cout(Cout)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [3:0] expected_DataOut;  // Expected output
    input reg expected_Cout;  // Expected output
    begin
      if (DataOut !== expected_DataOut || Cout !== expected_Cout) begin
        $error("ERROR: TestCaseNo %0d | DataOut = %b (Expected: %b) | Cout = %b (Expected: %b)",
               TestCaseNo, $time, DataOut, expected_DataOut, Cout, expected_Cout);
        flag = 1;
      end
    end
  endtask

  localparam CLK_PERIOD = 2;
  always #(CLK_PERIOD / 2.0) Clk = ~Clk;

  // test cases
  initial begin
    // Reset here
    Trigger = 0;
    Reset = 0;
    Clk = 0;
    Cin = 0;
    #(CLK_PERIOD + 0.1);
    Reset = 1;
    check_output(0, 0, 0);
    // Insert test cases here

    #(CLK_PERIOD + 0.1);

    for(i=1; i<10; i=i+1) begin
      Trigger = 1;
      Reset = 0;
      #(CLK_PERIOD + 0.1);
      check_output(i, i, 0);
    end
    
    Trigger = 1;
    Reset = 0;
    check_output(10, 9, 1);
    #(CLK_PERIOD + 0.1);
    check_output(11, 0, 0);

    Trigger = 0;
    Reset = 1;
    #(CLK_PERIOD + 0.1);
    check_output(12, 0, 0);

    // case Trigger and Cin are both 1
    Trigger = 1;
    Reset = 0;
    Cin = 1;
    #(CLK_PERIOD + 0.1);
    check_output(13, 2, 0);

    Trigger = 1;
    Reset = 0;
    Cin = 1;
    #(CLK_PERIOD + 0.1);
    check_output(14, 4, 0);

    Trigger = 1;
    Reset = 0;
    Cin = 1;
    #(CLK_PERIOD + 0.1);
    check_output(15, 6, 0);

    Trigger = 1;
    Reset = 0;
    Cin = 1;
    #(CLK_PERIOD + 0.1);
    check_output(16, 8, 0);

    Trigger = 1;
    Reset = 0;
    Cin = 1;
    check_output(17, 8, 1);
    #(CLK_PERIOD + 0.1);
    check_output(18, 0, 0);




    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end
endmodule
