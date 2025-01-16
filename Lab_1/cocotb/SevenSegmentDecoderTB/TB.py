import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def SevenSegmentDecoderTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")
    # create a testbench here

    real_answer = [
        0b00000011,
        0b10011111,
        0b00100101,
        0b00001101,
        0b10011001,
        0b01001001,
        0b01000001,
        0b00011111,
        0b00000001,
        0b00001001,
        0b00010001,
        0b11000001,
        0b01100011,
        0b10000101,
        0b01100001,
        0b01110001
    ]

    for i in range(0, 16):
        dut.DataIn.value = i
        await Timer(1, units='ns')

        assert dut.Segments.value == real_answer[i]

    dut._log.info("Test Complete")
