# 00d — Digital Circuits

> Once a signal is interpreted as 0 or 1, this is the layer that combines and
> stores it. Logic gates, flip-flops, registers, ALUs, FSMs, and the RTL that
> describes them — the building blocks of every CPU above.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  01  Circuit Board                           │
└───────────────────────┬──────────────────────┘
                        │  Boolean signals on pins and traces
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  00d  Digital Circuits            ◀── here   ┃
┃      gates · flip-flops · clocked logic      ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  voltage / current waveforms
┌───────────────────────┴──────────────────────┐
│  00c  Analog Circuits                        │
└──────────────────────────────────────────────┘
```

**02 CPU is not the rung above.** A CPU is of course built from the gates and
flip-flops described here, and this diagram used to say so by putting 02
directly overhead — which skipped 01 Circuit Board, contradicted both
[LAYERS.md](../LAYERS.md) and the root [README.md](../README.md), and was not
reciprocated by [02's own diagram](../02_CPU/README.md), which draws 01 below
itself. The ladder is 02 → 01 → 00d. The relationship to 02 is real but it is
*composition*, not adjacency: see
[CPU › Topics](../02_CPU/README.md#topics).

## At a glance

| Field | Value |
|-------|-------|
| Description | Discrete two-valued logic and sequential storage |
| Languages | Verilog, SystemVerilog, VHDL, Chisel, Amaranth |
| Medium / Interface | Boolean signals on wires; clocked synchronous design |
| Example | A 32-bit ALU executes ADD via carry-lookahead in 1 clock cycle |
| Adjacent | ↓ [00c_Analog_Circuits](../00c_Analog_Circuits/), ↑ [01_Circuit_Board](../01_Circuit_Board/) |

## What lives here

- **Number systems** — binary, hex, octal, two's complement, BCD, gray code, IEEE 754 float
- **Logic gates** — YES/NO, AND/OR/XOR/NAND/NOR/XNOR (see [Logic Gates Explained](logic_gates.md))
- **Combinational logic** — multiplexers, decoders, encoders, comparators, adders
- **Sequential logic** — latches, flip-flops (D, T, JK, SR), registers, counters, shift registers
- **FSM** — Moore vs Mealy state machines
- **Memory** — SRAM, DRAM cells, register files, FIFOs, CAMs
- **Arithmetic** — ripple-carry / carry-lookahead / Wallace tree / Booth multiplier
- **HDL design** — RTL coding, synthesis, place & route, timing closure
- **Clock domain crossing**, **metastability**, **setup/hold**

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — |  |
| [Lessons](#lessons) | [Interactive labs](digital_labs.md) |  |
| [Languages](#languages) | — |  |
| [Manual Pages](#manual-pages) | — |  |
| [Topics](#topics) | [Logic Gates Explained](logic_gates.md) | including **[Logic Gates Explained](logic_gates.md)** (full truth tables) |
| [Protocols](#protocols) | — |  |

## Cross-references
- Devices used to build gates → [00b_Devices](../00b_Devices/) (CMOS)
- Sampling boundary into the digital domain → [00c_Analog_Circuits](../00c_Analog_Circuits/)
- Microarchitecture built from these blocks → [CPU › Topics](../02_CPU/README.md#topics)
- Bus protocols at the digital wire level → [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols)

---

## References

### Where to start, by how far down you are going

```text
  architecture first, gates later
    Harris & Harris, Digital Design and Computer Architecture (RISC-V)
      └─ Patterson & Hennessy, Computer Organization and Design  ──▶ 02 CPU

  gates first, architecture later
    Wakerly, Digital Design: Principles and Practices

  down to the transistors
    Weste & Harris, CMOS VLSI Design
      └─ Rabaey, Digital Integrated Circuits                     ──▶ 00b

  writing the HDL
    Chu, FPGA Prototyping by SystemVerilog Examples
    Jasinski, Effective Coding with VHDL

  build it rather than read it
    Nand2Tetris — a CPU from NAND up · Ben Eater's 8-bit breadboard series
    HDLBits — Verilog practice · ZipCPU · VSD courses

  The v1 Boolean-logic reference is fully transcribed in
  logic_gates.md, in this folder; the Formal Logic PDF is
  not redistributed here.
```

### Books
- *Digital Design and Computer Architecture (RISC-V Edition)* — Harris & Harris.
- *Digital Design: Principles and Practices* — John Wakerly.
- *Computer Organization and Design (RISC-V)* — Patterson & Hennessy.
- *CMOS VLSI Design: A Circuits and Systems Perspective* — Weste & Harris.
- *Digital Integrated Circuits* — Jan Rabaey.
- *Effective Coding with VHDL* — Ricardo Jasinski.
- *FPGA Prototyping by SystemVerilog Examples* — Pong P. Chu.

### V1 cross-references
- *Boolean logic gates* HTML reference — migrated from the v1 collection;
  content preserved in [Logic Gates Explained](logic_gates.md)
- *Formal Logic* (PDF) — v1 collection, not redistributed here
- Number-systems notes — v1 collection; see
  [Topics](#topics) for the migrated material

### Online
- Nand2Tetris — build a CPU from NAND
- Ben Eater's 8-bit breadboard CPU series (YouTube)
- ZipCPU blog (FPGA + Verilog deep dives)
- VLSI System Design / VSD courses
- HDLBits — Verilog practice (`https://hdlbits.01xz.net/`)

---

## Lessons

### The ladder

```text
  Fifteen exercises that end in a working CPU. The file states no
  prerequisites, so the grouping below is editorial — the first ten are
  gates and a breadboard, the last five an HDL and an FPGA.

  combinational, on a breadboard
     1  Truth tables ─▶ K-maps ─▶ minimal SOP/POS
     2  Gates on a breadboard      74HC00 · 74HC02 · 74HC04
     3  Any gate from NAND         functional completeness, measured
     4  Mux · demux · decoder      4:1 mux from gates
     5  Ripple-carry adder         1-bit full ─▶ 4-bit; watch the carry delay
     6  Carry-lookahead            the same sum, faster, for more area

  sequential — once there is a clock
     7  Latches vs flip-flops      level- vs edge-triggered
     8  Counters & shifters        synchronous 4-bit, serial-to-parallel
     9  FSM design                 sequence detector, Moore and Mealy
     10  Memory cells              SRAM 6T · DRAM 1T1C

  in an HDL, on an FPGA
     11  Verilog hello             counter in Icarus + GTKWave
     12  FPGA blink                iCE40 / Tang Nano via yosys + nextpnr
     13  Pipelined datapath        3 stages for one ALU op
     14  Clock domain crossing     2-FF synchroniser, async FIFO

  15  Mini-CPU    single-cycle ─▶ pipelined ─▶ hazards and forwarding
                  ──▶ 02 CPU starts here

  Lab: digital_labs.md covers 1, 7, 8 and 12.
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Digital interactive labs | [Digital Circuits interactive labs](digital_labs.md) — Truth tables, flip-flop timing, counter, FPGA hello |

---

1. **Truth tables → Karnaugh maps → minimal SOP/POS** — minimize a 3- and 4-var function.
2. **Logic gates on a breadboard** — 74HC00 (NAND), 74HC02 (NOR), 74HC04 (NOT) wiring.
3. **Build any gate from NAND** — prove functional completeness experimentally.
4. **Multiplexer / demultiplexer / decoder** — 4:1 mux from gates, 2-to-4 decoder.
5. **Ripple-carry adder** — 1-bit full adder → 4-bit; observe carry delay.
6. **Carry-lookahead adder** — speed up vs ripple; tradeoffs.
7. **Latches vs flip-flops** — SR, D, JK, T; level- vs edge-triggered.
8. **Counters & shift registers** — 4-bit synchronous counter, serial-to-parallel shifter.
9. **FSM design** — sequence detector (Moore + Mealy); state diagram → table → logic.
10. **Memory cells** — SRAM 6T, DRAM 1T1C concept walkthrough.
11. **Verilog hello** — write & sim a counter in Icarus + GTKWave.
12. **FPGA blink** — Tang Nano / Lattice iCE40: blink LED via yosys/nextpnr open flow.
13. **Pipelined data path** — 3-stage pipeline for a simple ALU op.
14. **Clock domain crossing** — 2-FF synchronizer, async FIFO concept.
15. **Mini-CPU project** — single-cycle 8- or 16-bit; then pipelined; then add hazards/forwarding.

### Suggested external
- Nand2Tetris Part 1 (free)
- HDLBits Verilog problems
- Ben Eater's 6502 / 8-bit CPU series

---

## Languages

### From text to a bitstream

```text
  An HDL takes two different routes. Simulation *compiles* it — iverilog is
  a compiler, Verilator emits C++. Hardware *synthesises* it, into gates and
  then a placement on real silicon. Below, those two routes branch from one
  description and never rejoin.

  describe      Verilog · SystemVerilog · VHDL        the industry three
                Chisel · SpinalHDL (Scala)            embedded in a host
                Amaranth · Migen · MyHDL (Python)     language, so the
                Clash (Haskell)                       elaborator is a program

                Bluespec SystemVerilog                its own .bsv language
                                                      and compiler, not a DSL
                   │
     ┌─────────────┴─────────────┐   two consumers of the same source,
     ▼                           ▼   not one after the other
  simulate                    synthesise
  Icarus (iverilog) · GHDL    Yosys              open, RTL ─▶ netlist
  Verilator (to C++)          Vivado · Quartus   vendor
  VCS · Xcelium · ModelSim    Design Compiler    ASIC
     │                           │
     ▼                           ▼
  GTKWave · Surfer · Verdi    place & route
  waveforms                   nextpnr ──▶ IceStorm · Trellis · Apicula
                                          iCE40     ECP5      Gowin
                                      ──▶ bitstream

  Verification is not a stage here — it runs against whichever branch you
  are on: SystemVerilog/UVM · e · PSL · cocotb · SymbiYosys · JasperGold
```

### HDLs (Hardware Description Languages)
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

### Synthesis / sim toolchains
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

### Waveform viewers
- GTKWave (open)
- Surfer (modern open, written in Rust)
- ModelSim (commercial-ish, free editions exist)
- Verdi (Synopsys)

### Verification languages
- SystemVerilog (UVM)
- e (Specman)
- PSL (Property Specification Language)
- cocotb — Python testbench framework for Verilog/VHDL
- formal: SymbiYosys, JasperGold

### V1 cross-reference
- Number-systems notes (v1 collection) — binary/hex/octal lookup
- Logic foundations (v1 collection)

---

## Manual Pages

HDL toolchain commands — simulators, synthesis and place-and-route — rather
than system utilities.

### The open flow, end to end

```text
  These commands chain. Running them in order is the whole FPGA toolchain,
  and every one of them is free:

  design.v ──▶ iverilog ──▶ vvp ──▶ dump.vcd ──▶ gtkwave · surfer
     │           simulate first: a bug found here costs seconds
     │
     ├──▶ verilator ──▶ C++ model        when the testbench is large
     ├──▶ ghdl                           if the design is VHDL
     ├──▶ cocotb, via one of the simulators above — cocotb-config only
     │    reports its install paths and flags, it runs nothing
     ├──▶ sby (SymbiYosys)               if you want a proof, not a test
     │
     └──▶ yosys ──▶ netlist ──▶ nextpnr-ice40 ──▶ icepack     ──▶ .bin
                                nextpnr-ecp5  ──▶ ecppack     ──▶ .bit
                                nextpnr-gowin ──▶ gowin_pack  ──▶ .fs
                                                  (Apicula)

     icetime reads an iCE40 placement and reports its timing; the other two
     families have their own equivalents rather than sharing this one.

  The proprietary tools cover the same stages and are bought separately:
  vcs · xrun · vsim simulate, dc_shell and genus synthesise, innovus
  implements, and vivado and quartus_sh bundle a whole FPGA flow each.

  On the bench, a logic analyzer closes the loop — Saleae, DSLogic or any
  sigrok device, driven by sigrok-cli or PulseView. The decoder catalog is
  in 01 Circuit Board's protocols section.
```

### Open-source HDL flow
| Command | Purpose |
|---------|---------|
| `iverilog` | Icarus Verilog compiler |
| `vvp` | Icarus Verilog runtime |
| `verilator` | Verilog → C++ converter |
| `ghdl` | VHDL sim |
| `yosys` | Synthesis |
| `nextpnr-ice40` / `-ecp5` / `-gowin` | Place & route |
| `icepack` / `icetime` | iCE40 bitstream / timing |
| `ecppack` | ECP5 bitstream |
| `gtkwave` | Waveform viewer |
| `surfer` | Modern Rust waveform viewer |
| `cocotb-config` | cocotb framework |
| `sby` (SymbiYosys) | Formal verification driver |

### Commercial / vendor
| Tool | Vendor |
|------|--------|
| `vivado` | AMD/Xilinx |
| `quartus_sh` | Intel/Altera |
| `vcs`, `simv` | Synopsys VCS |
| `xrun` (Xcelium) | Cadence |
| `vsim` (ModelSim/QuestaSim) | Siemens EDA |
| `dc_shell` | Synopsys Design Compiler |
| `genus`, `innovus` | Cadence digital implementation |

### Number / bit utilities
| Command | Purpose |
|---------|---------|
| `printf '%b' 255` | Decimal → binary |
| `printf '%x' 255` | Decimal → hex |
| `printf '%d' 0xFF` | Hex → decimal |
| `bc <<< "obase=2; ibase=10; 255"` | Arbitrary base in `bc` |
| `python3 -c "print(bin(255))"` | Python one-liner |

### Lab
- Logic analyzer (Saleae, DSLogic, sigrok-supported devices)
- `sigrok-cli`, PulseView GUI — open-source LA software (see [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols) for the decoder list)
- FPGA dev boards — TinyFPGA, iCEBreaker, Tang Nano, ULX3S (open-toolchain friendly)

---

## Topics

### What is built from what

```text
  Read downward, but only two of these edges are composition. Number systems
  are a *convention* — what a bit pattern is taken to mean — and gates, not
  that convention, are what combinational blocks are built from.
  Combinational logic plus state is what makes a sequential circuit, and
  that is the one real assembly here. The datapath an ALU and a register
  file make is where 02 CPU picks up; RTL and below are how any of it is
  described and made real, not further layers of parts.

  number systems      binary · hex · two's complement · BCD · gray
  │                   IEEE 754 · fixed-point · posits
  │                   — the meaning assigned to a bit pattern
  ▼
  combinational       gates ──▶ adders (ripple ─▶ lookahead ─▶ Kogge-Stone)
  │                   multipliers (array ─▶ Wallace ─▶ Booth)
  │                   mux · decoder · comparator · barrel shifter
  │                   └──▶ ALU = adder + logic + shifter + control
  ▼  add a clock
  sequential          latches ─▶ flip-flops (D, T, JK, SR)
  │                   registers · counters · shift registers · LFSR
  │                   ├──▶ memory cells   SRAM 6T · DRAM 1T1C · NVM · CAM
  │                   └──▶ state machines Moore vs Mealy · one-hot encoding
  ▼
  RTL & synthesis     coding style ─▶ netlist ─▶ place & route ─▶ STA
  │                   clock trees, skew, gating, multi-Vt
  ▼
  and two that run alongside all of the above rather than after it:

    clock domains     metastability · 2-FF synchroniser · async FIFO
                      a problem from the first asynchronous clock in RTL
    test & debug      sim vs gate-level vs formal · scan · ATPG · BIST
                      formal and simulation run before any silicon exists;
                      scan and JTAG 1149.1 are what remain once it does

  and the three things you can build all of it on:
    CPLD ── instant-on, small   FPGA ── LUT + FF + DSP + BRAM   ASIC ── NRE
```

### Number systems
- **Binary, octal, decimal, hexadecimal** — base conversions; migrated from
  the v1 number-systems notes
- **Signed representations** — sign-magnitude, 1's complement, **two's complement** (standard), excess/biased
- **BCD**, **gray code** (rotary encoders, low-glitch counters)
- **Fixed-point**, **block floating-point**
- **IEEE 754** — single/double/half precision, bfloat16
- **Posit numbers** (modern alt)

### Combinational logic
- **Gates** — see [Logic Gates Explained](logic_gates.md) for full truth tables
- **Adders** — half, full, ripple-carry, carry-lookahead, carry-skip, carry-select, Kogge-Stone, Brent-Kung
- **Subtractors** — via two's complement + adder
- **Multipliers** — array, Wallace tree, Dadda, Booth-encoded
- **Comparators**, **encoders**, **decoders** (binary, priority), **multiplexers** / **demultiplexers**
- **Shifters / barrel shifters**
- **ALU** — composition of adder + logic + shifter + control

### Sequential logic
- **Latches vs flip-flops** — level- vs edge-triggered
- **Flip-flop flavors** — D, T, JK, SR
- **Registers, register files**
- **Counters** — async (ripple), sync; up/down; modulo-N
- **Shift registers** — SISO, SIPO, PISO, PIPO; LFSRs for pseudo-random / CRC

### Memory cells
- **SRAM (6T cell)** — fast, expensive
- **DRAM (1T1C)** — dense, needs refresh
- **NVM** — ROM, EPROM, EEPROM, NOR/NAND flash, MRAM, ReRAM, FeRAM, PCM
- **CAM / TCAM** — content-addressable (routing TCAMs)
- **FIFO** — sync / async (with Gray-coded pointers for CDC)

### State machines
- **Moore vs Mealy**
- **One-hot vs binary encoding**
- **State minimization**
- **Statecharts / hierarchical FSMs**

### RTL & synthesis
- **RTL coding style** — flip-flop inference, blocking vs non-blocking
- **Always blocks** — combinational, sequential, latch (usually unintended)
- **Synthesis** — RTL → gate netlist mapped to standard-cell library
- **Place & route** — floorplan, placement, clock tree, routing, timing closure
- **Static Timing Analysis (STA)** — setup, hold, recovery, removal
- **Clock skew, jitter, uncertainty**
- **Clock gating, power gating, multi-Vt, multi-voltage**

### Clock domain crossing & metastability
- **Metastability** — what it is, MTBF formulas
- **2-FF synchronizer** — for single bit signals
- **Async FIFO** — with Gray-code pointers
- **Handshake-based CDC**

### Test & debug
- **Functional sim** vs **gate-level sim** vs **formal verification**
- **JTAG boundary scan (IEEE 1149.1)** — cross-link [01](../01_Circuit_Board/README.md#protocols)
- **Scan chains, ATPG, BIST**
- **Coverage** — line, branch, FSM, toggle, functional, assertion

### FPGA vs ASIC vs CPLD
- **CPLD** — small, instant-on, EEPROM-based
- **FPGA** — LUT + flip-flop + DSP block + BRAM + SerDes
- **ASIC** — full-custom or standard-cell; NRE vs unit cost tradeoff
- **Structured ASIC** / **eFPGA** — middle ground

### Cross-link
- Built from devices → [00b_Devices](../00b_Devices/) (CMOS)
- Microarch above → [CPU › Topics](../02_CPU/README.md#topics)
- Embedded firmware on FPGA soft cores → [03_Firmware_BIOS](../03_Firmware_BIOS/)

---

## Protocols

Language and exchange-format standards rather than wire protocols — what an
HDL toolchain has to implement.

### Standards, by what they hand to the next tool

```text
  The chain below is not wire protocols at all — it is the file formats and
  language definitions that let one vendor's tool read another's output. The
  two families after it are, which is why they are kept separate.

  RTL   IEEE 1364 Verilog · 1800 SystemVerilog · 1076 VHDL · 1666 SystemC
  │     and three that travel with it without being it:
  │       1850 PSL      assertions about the design
  │       1801 UPF      power intent
  │       1685 IP-XACT  how an IP block declares itself
  ▼
  synthesis  ◀── Liberty .lib     timing and power, per standard cell
  │
  ▼
  gate netlist
  │
  ▼
  place & route  ◀── LEF          abstract cell geometry
  │
  ▼
  DEF ──▶ GDSII  or  OASIS        what actually goes to the fab —
                                  two alternative stream-out formats,
                                  OASIS the newer and more compact

  Liberty and LEF enter from the side because they are *inputs* to those two
  stages, not output by the stage above — each tool reads both the design
  and the library it is mapping onto.

  Two families of real wire protocol sit beside that chain rather than in it:

  getting inside a finished chip   1149.1 JTAG ─┬─ .4 mixed-signal
                                                ├─ .6 AC-coupled
                                                ├─ .7 cJTAG
                                                ├─ 1500 core test
                                                └─ 1687 iJTAG

                                   1450 STIL is not one of these — it is a
                                   file format for the patterns they carry

  moving data on-chip,             AMBA AXI/AHB/APB/ACE/CHI (Arm)
  to RAM, and to storage           Wishbone · TileLink · OCP · Avalon
                                   JESD79-x DDR · JESD209-x LPDDR
                                   JESD235 HBM · ONFI · eMMC ──▶ 01, 02
```

### HDL & exchange formats
| Standard | Body | Scope |
|----------|------|-------|
| IEEE 1364 | IEEE | Verilog HDL |
| IEEE 1800 | IEEE | SystemVerilog |
| IEEE 1076 | IEEE | VHDL |
| IEEE 1666 | IEEE | SystemC |
| IEEE 1850 | IEEE | PSL (Property Spec Language) |
| IEEE 1685 | IEEE | IP-XACT (IP packaging) |
| IEEE 1801 | IEEE | UPF (low-power intent) |
| Liberty (.lib) | Synopsys | Standard-cell timing/power |
| LEF / DEF | Cadence | Library / design exchange |
| GDSII | Calma | Layout interchange (fab format) |
| OASIS | SEMI | GDSII successor |

### Test / debug
| Standard | Scope |
|----------|-------|
| IEEE 1149.1 | JTAG boundary scan |
| IEEE 1149.4 | Mixed-signal boundary scan |
| IEEE 1149.6 | AC-coupled boundary scan |
| IEEE 1149.7 | cJTAG (compact) |
| IEEE 1500 | Embedded core test |
| IEEE 1687 | iJTAG (internal JTAG) |
| IEEE 1450 | STIL (Standard Test Interface Language) |

### On-chip / SoC interconnect
| Spec | Owner | Scope |
|------|-------|-------|
| AMBA AXI / AHB / APB / ACE / CHI | Arm | Bus protocols for SoCs |
| Wishbone | OpenCores | Open SoC bus |
| TileLink | SiFive | Cache-coherent fabric (RISC-V) |
| OCP | Accellera | Open Core Protocol |
| Avalon | Intel/Altera | FPGA interconnect |
| AXI-Stream | Arm | Streaming variant |
| NoC standards | various | Network-on-Chip |

### Memory interfaces (digital-side specs)
| Spec | Scope |
|------|-------|
| JEDEC JESD79-x | DDR / DDR2 / DDR3 / DDR4 / DDR5 |
| JEDEC JESD209-x | LPDDR family |
| JEDEC JESD230 | GDDR5 |
| JEDEC JESD235 | HBM / HBM2 / HBM3 |
| ONFI | Open NAND Flash Interface |
| eMMC (JESD84) | Embedded MultiMediaCard |

### Cross-link
- Wire-level PCB-side bus protocols → [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols)
- The big "logic analyzer decoder" catalog → [Embedded Bus Protocols](../01_Circuit_Board/embedded_bus_protocols_lookup.md)
