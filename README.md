# Custom 8086 Processor Core Development

## Project Overview

This project focuses on the design and development of a custom 8086 processor core and SoC using Verilog HDL. The design includes processor-related modules and supporting hardware components for instruction execution, memory access, address translation, and system integration.

## Key Features

- Arithmetic Logic Unit (ALU)
- Bus Interface Unit (BIU)
- Instruction and data caches
- Translation Lookaside Buffer (TLB)
- Processor execution unit
- Multiple clock domains for CPU, DMA, and memory
- Three IP/slave controllers with local memories
- Main-memory data transfer verification

## Tools and Technologies

- Verilog HDL
- SystemVerilog testbench
- Synopsys EDA tools
- FSDB waveform dumping
- digital design and processor 

## Verification and Testbench

The design was tested using Synopsys tools with a SystemVerilog testbench.

The testbench includes:
- Clock generation for CPU, DMA, and memory domains
- Initialization of three IP controller local memories with distinct data patterns
- TLB mapping configuration
- Monitoring of IP controller completion status
- Verification of data transfers to main memory
- Self-checking comparisons between source local memories and destination main-memory locations
- FSDB waveform dumping for debugging and analysis

The testbench checks transfers to main-memory offsets 512, 640, and 768 for the three IP controllers.

## Repository Contents

This repository contains the processor-core source files, supporting hardware modules, testbench, and related verification files as they are added and reviewed.

## Future Improvements

- Improve testbench reporting and failure diagnostics
- Document module interfaces and system integration
- Add reproducible simulation instructions
- Expand verification coverage for different data patterns and operating conditions

## Language

Verilog HDL


