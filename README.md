# Custom 8086 Processor Core Development

## Overview

This project implements a custom 8086 processor core and System-on-Chip (SoC) using Verilog HDL. It integrates instruction execution, memory interfaces, cache and TLB control, peripheral IP controllers, and hardware interrupt handling.

The project includes assembly-based firmware designed to initialize the processor, configure interrupt handling, trigger peripheral operations, and verify burst memory transfers.

## Key Features

- Custom 8086 processor core implemented in Verilog HDL.
- Arithmetic Logic Unit (ALU).
- Execution Unit (EU) and Bus Interface Unit (BIU).
- Instruction prefetch queue.
- L1 cache and Instruction Tightly Coupled Memory (ITCM).
- Dual-clock main memory.
- Peripheral IP controllers.
- Programmable interrupt controller (PIC) interface.
- Hardware interrupt handling.
- Clock-gating and clock-domain synchronization logic.
- Assembly firmware and custom instruction encoding.
- System-level simulation using a SystemVerilog testbench.
- FSDB waveform support for debugging with compatible Synopsys tools.

## Project Structure

| File | Description |
|---|---|
| `custom_8086_core.v` | Processor core integration |
| `alu.v` | Arithmetic and logic operations |
| `execution_unit.v` | Instruction execution |
| `bus_interface_unit.v` | Instruction fetching and bus transactions |
| `prefetch_queue.v` | Instruction prefetch buffering |
| `l1_cache.v` | L1 cache logic |
| `itcm.v` | Instruction tightly coupled memory |
| `dual_clock_main_memory.v` | Dual-clock main memory |
| `ip_controller.v` | Peripheral IP controller logic |
| `pointer_sync.v` | Synchronization logic |
| `icg_cell.v` | Clock-gating logic or model |
| `soc_top.v` | Top-level SoC integration, if present |
| `tb_custom_8086_core.sv` | System-level verification testbench |
| `assembler.pl` | Assembly-to-firmware conversion script |
| `firmware1.hex` | Generated firmware image |

*Update this table to match the exact filenames in the repository.*

## Assembly Firmware: Burst and Interrupt Verification

The current assembly test focuses on processor initialization, peripheral interrupt configuration, and a 64-word burst operation initiated by IP1.

### Test Sequence

1. **Processor initialization:** Load `0003` into AX and move it to CR0 to enable the intended cache and TLB configuration.
2. **Interrupt configuration:** Write `0007` to address `7002` to unmask IP1, IP2, and IP3.
3. **Global interrupt enable:** Write `0001` to address `7006` to enable the intended PIC functionality.
4. **Enable CPU interrupts:** Execute `STI` so the processor can accept maskable hardware interrupts.
5. **Start IP1:** Execute `TRIG_IP1` to initiate the intended 64-word burst operation.
6. **Allow background execution:** Execute NOP instructions while the controller performs its memory writes.
7. **Interrupt verification:** Check that the expected hardware interrupt is received and handled correctly during the burst operation.

The intended behavior is for IP1 to write 64 words while the processor continues executing instructions, with an interrupt occurring during the operation. The timing and interrupt behavior must be confirmed through simulation.

### Intended Memory-Mapped Control Registers

| Address | Intended purpose |
|---|---|
| `0x7002` | IP1, IP2, and IP3 interrupt-unmask configuration |
| `0x7006` | Global PIC enable register |

These addresses and their write semantics should be verified against the actual SoC address decoder and peripheral implementation.

## Firmware Generation

The project uses a Perl-based assembler to convert supported assembly instructions into the firmware image `firmware1.hex`.

Generate the firmware using the command supported by your assembler script:

```bash
perl assembler.pl your_assembly_file.asm
```

Ensure that the assembler supports the instructions used by the test, including `MOV`, `MOV CR0, AX`, `STI`, `TRIG_IP1`, and `NOP`.

The custom instruction encodings must match the processor's instruction decoder and execution logic. Confirm the output byte ordering and ROM loading format before simulation.

## Verification Environment

The project includes a SystemVerilog testbench for integrating and verifying the processor and SoC.

The verification environment is intended to test:

- Processor initialization and control-register configuration.
- Cache and TLB configuration.
- Interrupt-mask and PIC-enable writes.
- IP1 burst triggering.
- Main-memory writes and expected data values.
- Hardware interrupt generation and handling.
- Processor execution while the peripheral performs its burst operation.

FSDB waveforms can be used to inspect processor control signals, interrupt requests, controller state transitions, memory write transactions, and completion status when supported by the selected Synopsys simulation environment.

## Simulation Procedure

1. Compile all required Verilog and SystemVerilog source files.
2. Generate `firmware1.hex` using the assembler.
3. Confirm that the testbench loads the firmware from the expected path.
4. Run the system-level simulation.
5. Inspect the simulation log for assertion failures or data mismatches.
6. Examine FSDB waveforms to verify the 64-word burst and interrupt timing.
7. Confirm that the test reports success only when all expected conditions pass.

A successful firmware build does not alone establish functional correctness. Report verification results based on the completed simulation and its checks.

## Tools and Technologies

- Verilog HDL
- SystemVerilog
- Perl
- Synopsys simulation tools
- FSDB waveform debugging
- Git and GitHub

## Development Goals

- Verify the custom instruction set and firmware encoding.
- Validate cache and TLB control behavior.
- Verify interrupt masking and PIC enable logic.
- Confirm correct execution of IP1's 64-word burst operation.
- Verify interrupt timing and handling during peripheral activity.
- Improve testbench assertions and pass/fail reporting.
- Maintain consistency between RTL, firmware, and verification results.

## Author

Custom processor-core and SoC development project using Verilog HDL.
