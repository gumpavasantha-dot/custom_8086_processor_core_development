# Custom 8086 Processor Core Development

## Overview

This project focuses on the design and development of a custom 8086 processor core and System-on-Chip (SoC) using Verilog HDL. The design integrates processor execution, memory access, instruction prefetching, cache functionality, and peripheral-controller interfaces.

The project also includes a testbench for functional verification of the processor and SoC components.

## Key Features

- Custom 8086 processor core implementation using Verilog HDL.
- Arithmetic Logic Unit (ALU) for arithmetic and logical operations.
- Execution Unit (EU) and Bus Interface Unit (BIU).
- Instruction prefetch queue.
- L1 cache and instruction Tightly Coupled Memory (ITCM).
- Dual-clock main memory.
- Interrupt and peripheral-controller integration.
- Clock-gating support.
- Synchronization logic for clock-domain crossing.
- Assembly-based firmware generation.
- System-level simulation and verification.

## Project Structure

| File | Description |
|---|---|
| `custom_8086_core.v` | Top-level custom processor core |
| `alu.v` | Arithmetic and Logic Unit |
| `execution_unit.v` | Instruction execution logic |
| `bus_interface_unit.v` | Instruction fetching and bus interface logic |
| `prefetch_queue.v` | Instruction prefetch queue |
| `l1_cache.v` | L1 cache implementation |
| `itcm.v` | Instruction Tightly Coupled Memory |
| `dual_clock_main_memory.v` | Dual-clock main memory |
| `ip_controller.v` | Peripheral or IP controller logic |
| `pointer_sync.v` | Pointer synchronization logic |
| `icg_cell.v` | Integrated clock-gating cell model or logic |
| `soc_top.v` | Top-level SoC integration, if present |
| `tb_custom_8086_core.sv` | System-level testbench |
| `assembler.pl` | Perl-based assembly-to-firmware conversion script |
| `firmware1.hex` | Generated firmware image |
| `EXTRACTED_MODULES.txt` | Supporting module or extraction notes, if applicable |

*Descriptions should be adjusted to match the final contents of each file.*

## System Architecture

The processor core is organized around the Execution Unit (EU) and Bus Interface Unit (BIU).

- **Execution Unit:** Executes supported instructions and performs arithmetic and logical operations.
- **Bus Interface Unit:** Handles instruction fetching and memory/bus transactions.
- **Prefetch Queue:** Buffers instructions for execution.
- **Memory Subsystem:** Includes main memory and supporting cache or tightly coupled memory components.
- **Peripheral Controllers:** Provide interfaces for IP operations, control registers, and interrupt-related functionality.
- **SoC Integration:** Connects the processor, memory subsystem, and peripheral controllers.

## Firmware and Assembler

The project includes a Perl-based assembler script, `assembler.pl`, which converts the supported assembly instructions into a hexadecimal firmware image named `firmware1.hex`.

The firmware format and instruction encodings are specific to the custom processor implementation. The generated instruction encodings must match the instruction decoder and execution logic in the RTL.

### Generate Firmware

Run the assembler from the directory containing the assembly source and script:

```bash
perl assembler.pl syscon_soft_reset.asm
```

Confirm that the script writes `firmware1.hex` to the expected location before running the simulation.

## SYSCON Soft-Reset Test

The SYSCON soft-reset firmware is intended to exercise the system-control register and peripheral wakeup/reset behavior.

The test sequence includes:

1. Disable interrupts.
2. Initialize the processor control register.
3. Clear the intended power-on/wakeup flags for IP1, IP2, and IP3.
4. Trigger the three IP controllers.
5. Issue a soft reset to IP1 through the SYSCON register.
6. Issue a global soft reset for all three IPs.
7. Clear the wakeup flags again, if required by the controller's reset behavior.
8. Trigger IP1 after the reset sequence.
9. Halt the processor.

### Intended Register Map

| Address | Intended purpose |
|---|---|
| `0x5000` | SYSCON soft-reset register |
| `0x8080` | IP1 wakeup flag register |
| `0x9080` | IP2 wakeup flag register |
| `0xA080` | IP3 wakeup flag register |

These addresses must be verified against the actual SoC address decoder and memory map. The assembly comments alone do not establish whether they are virtual addresses, physical addresses, or peripheral offsets.

## Verification and Simulation

The project includes `tb_custom_8086_core.sv`, which instantiates the SoC and provides clock generation, memory initialization, firmware loading, and completion/data checks.

The testbench is intended to verify:

- Processor and SoC operation.
- Peripheral-controller activity.
- Memory data transfers.
- Expected data at designated main-memory locations.
- Behavior during and after the soft-reset sequence.

The testbench uses Synopsys-compatible FSDB dumping tasks for waveform inspection where supported by the simulation environment.

### Simulation Notes

Before running the simulation:

1. Compile all required RTL source files.
2. Ensure `firmware1.hex` is available at the path expected by the testbench.
3. Configure the required Synopsys simulation libraries and FSDB support.
4. Run the testbench.
5. Inspect simulation logs and waveforms.
6. Confirm that every expected-data comparison passes.

A successful firmware assembly does not, by itself, prove that the firmware executes correctly on the processor. Verification results should be reported only after the simulation has completed successfully.

## Tools and Technologies

- Verilog HDL
- SystemVerilog
- Perl
- Synopsys simulation tools
- FSDB waveform debugging
- Git and GitHub

## Current Development Goals

- Maintain consistency between custom instruction encodings and RTL decoding.
- Verify memory-mapped peripheral addresses.
- Validate IP reset, wakeup-flag, and trigger behavior.
- Improve testbench pass/fail reporting.
- Verify firmware execution through simulation and waveform analysis.

## Disclaimer

This repository represents an ongoing hardware-design and verification project. Features and verification status should be considered according to the RTL implementation and simulation results available in the repository.

## Author

Developed as a custom processor-core and SoC design project using Verilog HDL.
