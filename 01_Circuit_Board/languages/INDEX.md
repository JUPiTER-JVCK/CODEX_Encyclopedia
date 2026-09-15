# Circuit Board — Languages

No "programming" languages in the conventional sense at this layer — you describe
hardware behavior with HDLs and design tools.

## Three things a board is described in

```text
  Nothing at this layer is a programming language. Each box below is a
  different description of the same board. The first two are run — one on
  hardware, one in a simulator — and the third is manufactured.

  ┌─ behaviour of the logic ──────────────────────────────────────────┐
  │  Verilog · SystemVerilog · VHDL      the industry three           │
  │  Chisel (Scala) · Amaranth (Python)  generator-based              │
  │     └──▶ Icarus · Verilator · GHDL ──▶ Vivado · Quartus · yosys   │
  └───────────────────────────────────────────────────────────────────┘
                              ──▶ runs on the FPGA, → 00d Digital Circuits

  ┌─ behaviour of the analog ─────────────────────────────────────────┐
  │  SPICE netlists ──▶ ngspice · LTspice        → 00c Analog         │
  └───────────────────────────────────────────────────────────────────┘

  ┌─ the board as an object ──────────────────────────────────────────┐
  │  KiCad S-expressions   schematic and layout, rarely hand-written  │
  │     └──▶ Gerber RS-274X   what the fab actually receives          │
  └───────────────────────────────────────────────────────────────────┘

  The instruction set that runs on the chip this board carries is one
  layer up, in 02 CPU; the C that boots it is in 03 Firmware.
```

| Language | Type | Use at this layer | Toolchain |
|----------|------|-------------------|-----------|
| Verilog | HDL | RTL design for FPGAs/ASICs | Icarus, Verilator, Vivado, Quartus |
| SystemVerilog | HDL + verification | RTL + testbenches, assertions | VCS, Questa, Verilator |
| VHDL | HDL | RTL design, common in defense/aerospace | GHDL, Vivado, Quartus |
| Chisel | HDL DSL (Scala) | Generator-based RTL (RISC-V chips) | sbt, FIRRTL |
| Migen / nMigen / Amaranth | HDL DSL (Python) | Higher-level FPGA design | yosys, nextpnr |
| SPICE | Analog sim | Transistor-level circuit simulation | ngspice, LTspice |
| KiCad S-expressions | Schematic/PCB | File format, rarely hand-written | KiCad GUI |
| Gerber (RS-274X) | PCB output | Fabrication interchange format | KiCad/Altium export |

## Related
- HDL ↔ CPU instructions → [02_CPU/languages](../../02_CPU/languages/INDEX.md)
- Embedded C for SBCs → [03_Firmware_BIOS/languages](../../03_Firmware_BIOS/languages/INDEX.md)
