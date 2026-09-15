# Digital Circuits — Languages

## From text to a bitstream

```text
  An HDL is not compiled, it is *synthesised* — turned into gates, then into
  a placement on real silicon. Every tool below sits at one of four stages.

  describe      Verilog · SystemVerilog · VHDL        the industry three
                Chisel · SpinalHDL (Scala)            embedded in a host
                Amaranth · Migen · MyHDL (Python)     language, so the
                Bluespec (rules) · Clash (Haskell)    elaborator is a program
                   │
                   ▼
  simulate      Icarus (iverilog) · GHDL              event-driven, free
                Verilator                             compiles to C++, fast
                VCS · Xcelium · ModelSim              commercial
                   │                    └──▶ GTKWave · Surfer · Verdi
                   ▼
  synthesise    Yosys                                 open, RTL ─▶ netlist
                Vivado · Quartus · Design Compiler    vendor / ASIC
                   │
                   ▼
  place & route nextpnr  ──▶ IceStorm · Trellis · Apicula   ──▶ bitstream
                          iCE40        ECP5       Gowin

  Verification runs alongside all four rather than after them:
  SystemVerilog/UVM · e · PSL · cocotb (Python) · SymbiYosys · JasperGold
```

## HDLs (Hardware Description Languages)
| Language | Notes |
|----------|-------|
| Verilog | The dominant industry HDL |
| SystemVerilog | Verilog + verification (assertions, classes, constraints) |
| VHDL | Strongly typed, common in defense/aerospace |
| Chisel | Scala-embedded HDL (used for RISC-V Rocket, BOOM) |
| Amaranth (was nMigen) | Python-embedded HDL |
| Migen | Older Python HDL (LiteX uses it) |
| SpinalHDL | Scala-embedded, modern alt to Chisel |
| Bluespec | Rule-based, atomic transactions |
| MyHDL | Python-embedded, sim-friendly |
| Clash | Haskell-based HDL |

## Synthesis / sim toolchains
| Tool | Open | Use |
|------|------|-----|
| Icarus Verilog | Yes | Free sim |
| Verilator | Yes | High-perf C++ converter / sim |
| GHDL | Yes | VHDL sim |
| Yosys | Yes | Synthesis (RTL → gate netlist) |
| nextpnr | Yes | Place & route for iCE40, ECP5, Gowin |
| Project IceStorm / Trellis / Apicula | Yes | Bitstream backends |
| Vivado | No (Xilinx) | Full AMD/Xilinx flow |
| Quartus Prime | No (Intel) | Altera/Intel FPGA flow |
| Synopsys VCS, Cadence Xcelium | No | Big-iron sim |
| Synopsys Design Compiler | No | ASIC synthesis |

## Waveform viewers
- GTKWave (open)
- Surfer (modern open, written in Rust)
- ModelSim (commercial-ish, free editions exist)
- Verdi (Synopsys)

## Verification languages
- SystemVerilog (UVM)
- e (Specman)
- PSL (Property Specification Language)
- cocotb — Python testbench framework for Verilog/VHDL
- formal: SymbiYosys, JasperGold

## V1 cross-reference
- Number-systems notes (v1 collection) — binary/hex/octal lookup
- Logic foundations (v1 collection)
