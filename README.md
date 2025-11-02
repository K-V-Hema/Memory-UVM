# Memory-UVM

**Overview**

This project demonstrates UVM (Universal Verification Methodology)-based verification of a memory design written in SystemVerilog.
The goal is to show how a structured, reusable, and scalable UVM environment can be created to verify memory functionality such as read, write, reset, and boundary behavior.

The project follows standard UVM architecture and can serve as a reference or learning model for students, trainees, and professionals working on digital design verification.


**Main features**:

Parameterized DATA_WIDTH and ADDR_WIDTH.

Synchronous read/write controlled by clk.

Active-low asynchronous reset.

Error handling for underflow and overflow conditions.

Optional support for read-before-write or write-through policies.

**UVM Components Description**

Component	File	Description
sequence_item.sv	-Defines the transaction (addr, data, wr_en, rd_en).	
sequence.sv	-Generates random or directed sequences of transactions.	
driver.sv	-Drives transactions to the DUT via the interface.	
monitor.sv	-Observes DUT signals and captures transactions.	
scoreboard.sv	-Compares DUT output with expected reference model results.	
env.sv	-Instantiates and connects the UVM agent and scoreboard.	
test_basic.sv	-Runs basic read/write test sequences.	
test_random.sv	-Runs constrained random tests to stress all memory conditions.	

**Simulation Flow**

1. Compile and Run

Using ModelSim/QuestaSim or VCS:

vlog -sv rtl/memory.sv rtl/memory_if.sv tb/*.sv +incdir+tb
vsim -c test_basic -do "run -all; quit"

2. Output

Console log showing UVM phases and transaction details.

Waveform file (.wlf or .vcd) for visualizing read/write behavior.


3. Expected Results

Memory correctly stores and retrieves data.

Read-after-write works as expected.

Overflow and underflow conditions generate appropriate errors or flags.

Scoreboard should show zero mismatches.

**Functional Coverage**

To ensure all test scenarios are covered, functional coverage is added in the monitor or environment.

Typical coverage points include:

Read and write enable combinations.

Boundary addresses (first and last address).

Randomized data values.

Transition coverage between read and write operations.
