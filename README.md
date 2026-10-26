# Custom 8086 Processor Core Development

## Overview

This project focuses on developing a custom 8086 processor core and System-on-Chip (SoC) using Verilog HDL. The system integrates instruction execution, cache and TLB control, memory interfaces, peripheral IP controllers, and hardware interrupt handling.

The project includes custom assembly firmware designed to initialize the processor, configure interrupt handling, execute sequential peripheral operations, and service hardware interrupts through an Interrupt Service Routine (ISR).

## Key Features

- Custom 8086 processor core using Verilog HDL.
- Arithmetic Logic Unit (ALU).
- Execution Unit (EU) and Bus Interface Unit (BIU).
- Instruction prefetch queue.
- L1 cache and Instruction Tightly Coupled Memory (ITCM).
- Dual-clock main memory.
- Peripheral IP controllers.
- Memory-mapped I/O (MMIO) access.
- Cache and TLB control.
- Programmable Interrupt Controller (PIC) interface.
- Hardware interrupt servicing and acknowledgment.
- Clock-gating and clock-domain synchronization logic.
- Custom assembly firmware and instruction encoding.
- System-level verification using SystemVerilog and compatible Synopsys tools.

## Assembly Firmware: Sequential Hardware Burst Test

The firmware initializes the processor and peripheral controllers, configures the PIC, and starts IP1, IP2, and IP3 sequentially.

### 1. System Initialization and Boot Sequence

The firmware performs the following steps:

1. Loads `0003` into AX and writes AX to CR0 to enable the intended cache and TLB configuration.
2. Writes `0008` to the IP1, IP2, and IP3 registers at addresses `0x8080`, `0x9080`, and `0xA080` to clear their boot-reset flags, according to the intended controller register semantics.
3. Writes `0007` to the PIC acknowledgment register at `0x7004` to clear pending interrupt status, according to the PIC implementation.
4. Writes `0007` to `0x7002` to unmask IP1, IP2, and IP3.
5. Writes `0001` to `0x7006` to enable the global PIC function.
6. Executes `STI` to enable maskable hardware interrupts.

### 2. Sequential IP Operation

The main program triggers each peripheral in sequence.

- **IP1:** `TRIG_IP1` starts IP1. The following `HLT` is intended to suspend CPU instruction execution until an interrupt wakes the processor.
- **IP2:** After the IP1 interrupt has been serviced and the interrupted program resumes, `TRIG_IP2` starts IP2. The next `HLT` waits for its interrupt.
- **IP3:** After IP2 completes and its interrupt is serviced, `TRIG_IP3` starts IP3. The following `HLT` waits for the next interrupt.
- **Final halt:** A final `HLT` is intended to stop normal program execution after all three operations.

This test is intended to demonstrate sequential peripheral activation and interrupt-driven processor wake-up rather than relying on a fixed number of NOP instructions for timing.

### 3. Interrupt Service Routine (ISR)

The assembly places the ISR and its handler blocks using `.ORG` directives.

The ISR is intended to:

1. Read the PIC interrupt status from address `0x7000`.
2. Write the status value to `0x7004` to acknowledge the interrupt.
3. Compare the status against `0001`, `0002`, and `0004`, representing the intended IP1, IP2, and IP3 interrupt masks.
4. Jump to the corresponding IP handler.
5. Write `000F` to the appropriate IP register to clear that IP's flag, according to the intended register semantics.
6. Jump to the shared exit block.
7. Execute `STI` and `IRET` to return from the interrupt.

An `IRET` fallback is included for status values that do not match any of the three individual IP masks.

### Intended Memory-Mapped Register Map

| Address | Intended purpose |
|---|---|
| `0x7000` | PIC interrupt status |
| `0x7002` | IP interrupt mask/unmask configuration |
| `0x7004` | PIC interrupt acknowledgment |
| `0x7006` | Global PIC enable |
| `0x8080` | IP1 boot/reset flag register |
| `0x9080` | IP2 boot/reset flag register |
| `0xA080` | IP3 boot/reset flag register |

The register meanings and write-one-to-clear behavior must be confirmed against the actual SoC and IP-controller RTL.

## Firmware Generation

The project uses a Perl-based assembler to generate a hexadecimal firmware image.

Example:

```bash
perl assembler.pl your_assembly_file.asm
```

The generated firmware must use the filename and location expected by the simulation testbench, such as `firmware1.hex`.

The assembler must support the custom instructions used by this firmware, including:

- `MOV`
- `MOV CR0, AX`
- `STI`
- `HLT`
- `TRIG_IP1`
- `TRIG_IP2`
- `TRIG_IP3`
- `CMP`
- `JE`
- `JMP`
- `IRET`
- `.ORG`

The generated instruction encodings, memory byte ordering, interrupt-vector convention, and address calculations must match the processor implementation.

## Verification Strategy

The firmware is intended to verify:

- Processor cache and TLB initialization.
- IP boot/reset flag clearing.
- PIC acknowledgment and interrupt configuration.
- Sequential triggering of IP1, IP2, and IP3.
- CPU halt and interrupt-driven wake-up.
- Interrupt-status decoding in the ISR.
- Per-IP handler selection.
- Controller flag clearing.
- Interrupt return and continuation of the main program.

Simulation logs and FSDB waveforms can be used to inspect CPU execution, interrupt requests, PIC status, controller activity, and memory-mapped register writes.

## Tools and Technologies

- Verilog HDL
- SystemVerilog
- Perl
- Synopsys simulation tools
- FSDB waveform debugging
- Git and GitHub

## Development Goals

- Maintain consistency between firmware encodings and RTL instruction decoding.
- Validate memory-mapped peripheral access.
- Verify PIC interrupt generation and acknowledgment.
- Confirm sequential IP execution.
- Validate ISR dispatch and return behavior.
- Verify correct handling of boot/reset flags.
- Improve testbench assertions and simulation reporting.

## Verification Status

This firmware describes the intended test scenarios. Successful execution, correct interrupt sequencing, and proper controller flag clearing must be confirmed by simulation before marking the tests as passing.

## Author

Custom 8086 processor core and SoC development project using Verilog HDL.
