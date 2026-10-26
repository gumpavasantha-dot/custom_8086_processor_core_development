## Verification Status

**The 8086 processor core design has been verified using Synopsys tools and works as expected in the tested environment.**

The repository contains Verilog HDL source files for the custom 8086 processor core and its related hardware modules. The source files are organized for review and further development.

## Project Highlights

- Designed using Verilog HDL.
- Includes processor-related modules such as the ALU, Bus Interface Unit (BIU), cache, and other supporting components.
- Verified using Synopsys tools.
- Organized source code for further development and maintenance.

## Future Improvements

1. Continue reviewing and maintaining the Verilog source modules.
2. Improve documentation for module functionality and interconnections.
3. Further develop and optimize the processor core design.
4. Maintain the source files and project documentation in GitHub.

## Included source modules

The `modules/` directory contains the module blocks extracted from the supplied text, including (where present):

- `alu.v` — arithmetic logic unit
- `bus_interface_unit.v` — bus interface and fetch manager
- `l1_cache.v` — L1 cache
- `wishbone_cdc_bridge.v` — Wishbone clock-domain crossing bridge
- `custom_8086_core.v` — processor-core wrapper
- `execution_unit.v` — execution unit
- `icg_cell.v` — integrated clock-gating cell
- `wishbone_interconnect.v` — Wishbone interconnect
- `ip_controller.v` — IP controller
- `itcm.v` — internal instruction memory
- `dual_clock_main_memory.v` — dual-clock main memory
- `programmable_interrupt_controller.v` — programmable interrupt controller
- `prefetch_queue.v` — prefetch queue
- `soc_top.v` — SoC top-level module
- `pointer_sync.v` — pointer synchronizer
- `system_controller.v` — system controller
- `tlb_array.v` — translation lookaside buffer

The exact list depends on which complete module blocks were present in the source file.

## Important status note

**These files have been organized, not verified as a working design.** The supplied text includes a FIFO-related code fragment that starts without its module declaration and earlier declarations. It is saved separately as `INCOMPLETE_FIFO_FRAGMENT.txt` and is intentionally not presented as a compilable `.v` module. Some module dependencies or integration details may also be missing. Review and simulate the design with your Verilog simulator (for example, Icarus Verilog, Verilator, or your FPGA vendor's tools) before relying on it.

## Suggested next steps

1. Review the extracted `.v` files and compare them with the original text.
2. Recover the missing beginning of the FIFO module and any other omitted code.
3. Identify the intended top-level module and confirm all dependencies are included.
4. Add a testbench and simulation instructions once the design is complete.
5. Commit the reviewed source files and this README to GitHub.

## Language

Verilog HDL

## TOOL
Synopsys Verdi, VCS

## Technologies

Verilog HDL

Synopsys EDA tools

Digital design and processor architecture
