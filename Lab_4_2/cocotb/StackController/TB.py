import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def StackControllerTB(dut):
    """Try accessing the design."""

    dut._log.info("Running test!")
    # create the clock
    cocotb.start_soon(Clock(dut.Clk, 1, units="ns").start())

    # reset
    dut.Reset.value = 1
    dut.Push.value = 0
    dut.Pop.value = 0
    dut.DataIn.value = 0
    dut.RAMDataOut.value = 0
    await Timer(1, units="ns")
    dut.Reset.value = 0
    # insert your test here

    dut.Push.value = 1
    dut.DataIn.value = 5
    await Timer(1, units="ns")
    dut.Pop.value = 1
    await Timer(1, units="ns")
    print("VALUE =", dut.StackValue.value, "COUNTER =", dut.StackCounter.value)
    print("RAMDATAOUT =", dut.RAMDataOut.value)
    await Timer(1, units="ns")
    dut.Push.value = 0
    dut.Pop.value = 1
    await Timer(1, units="ns")
    print("VALUE =", dut.StackValue.value, "COUNTER =", dut.StackCounter.value)
    print("RAMDATAOUT =", dut.RAMDataOut.value)
    assert dut.StackValue.value == 5

    dut._log.info("Test Complete")
