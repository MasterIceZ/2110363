`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 01/01/2025 02:14:43 AM
// Design Name: BCD_Counter
// Module Name: FourBCD
// Project Name: BCD_Counter
// Target Devices: Basys3
// Tool Versions: 2023.2
// Description: The Four Digit BCD Counter Module
//////////////////////////////////////////////////////////////////////////////////

module FourBCD (
    input wire [3:0] Trigger,   // 4-bit Trigger signal for each digit
    input wire Clk,              // Clock signal for synchronization
    input wire Reset,            // Reset signal for resetting the counter
    output wire [15:0] DataOut   // 16-bit output for the four BCD digits (4 bits per digit)
);
    // Internal signals for each BCD counter's carry-out and the DataOut for each digit
    wire [3:0] ones, tens, hundreds, thousands;
    wire carry_ones, carry_tens, carry_hundreds, carry_thousands;

    // Instantiate the SingleBCD modules for each of the 4 digits
    SingleBCD u0 (
        .Trigger(Trigger[0]),   // Trigger for ones digit
        .Cin(1'b0),             // No carry-in for the first digit
        .Clk(Clk), 
        .Reset(Reset), 
        .DataOut(ones), 
        .Cout(carry_ones)
    );

    SingleBCD u1 (
        .Trigger(Trigger[1]),   // Trigger for tens digit
        .Cin(carry_ones),       // Carry-out from ones as carry-in for tens
        .Clk(Clk), 
        .Reset(Reset), 
        .DataOut(tens), 
        .Cout(carry_tens)
    );

    SingleBCD u2 (
        .Trigger(Trigger[2]),   // Trigger for hundreds digit
        .Cin(carry_tens),       // Carry-out from tens as carry-in for hundreds
        .Clk(Clk), 
        .Reset(Reset), 
        .DataOut(hundreds), 
        .Cout(carry_hundreds)
    );

    SingleBCD u3 (
        .Trigger(Trigger[3]),   // Trigger for thousands digit
        .Cin(carry_hundreds),   // Carry-out from hundreds as carry-in for thousands
        .Clk(Clk), 
        .Reset(Reset), 
        .DataOut(thousands), 
        .Cout(carry_thousands)
    );

    // Concatenate the 4 BCD digits to form the final 16-bit DataOut (thousands, hundreds, tens, ones)
    assign DataOut = {thousands, hundreds, tens, ones};

endmodule
