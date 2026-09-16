# Digital Circuits — Topics

## What is built from what

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

## Number systems
- **Binary, octal, decimal, hexadecimal** — base conversions; migrated from
  the v1 number-systems notes
- **Signed representations** — sign-magnitude, 1's complement, **two's complement** (standard), excess/biased
- **BCD**, **gray code** (rotary encoders, low-glitch counters)
- **Fixed-point**, **block floating-point**
- **IEEE 754** — single/double/half precision, bfloat16
- **Posit numbers** (modern alt)

## Combinational logic
- **Gates** — see [logic_gates.md](logic_gates.md) for full truth tables
- **Adders** — half, full, ripple-carry, carry-lookahead, carry-skip, carry-select, Kogge-Stone, Brent-Kung
- **Subtractors** — via two's complement + adder
- **Multipliers** — array, Wallace tree, Dadda, Booth-encoded
- **Comparators**, **encoders**, **decoders** (binary, priority), **multiplexers** / **demultiplexers**
- **Shifters / barrel shifters**
- **ALU** — composition of adder + logic + shifter + control

## Sequential logic
- **Latches vs flip-flops** — level- vs edge-triggered
- **Flip-flop flavors** — D, T, JK, SR
- **Registers, register files**
- **Counters** — async (ripple), sync; up/down; modulo-N
- **Shift registers** — SISO, SIPO, PISO, PIPO; LFSRs for pseudo-random / CRC

## Memory cells
- **SRAM (6T cell)** — fast, expensive
- **DRAM (1T1C)** — dense, needs refresh
- **NVM** — ROM, EPROM, EEPROM, NOR/NAND flash, MRAM, ReRAM, FeRAM, PCM
- **CAM / TCAM** — content-addressable (routing TCAMs)
- **FIFO** — sync / async (with Gray-coded pointers for CDC)

## State machines
- **Moore vs Mealy**
- **One-hot vs binary encoding**
- **State minimization**
- **Statecharts / hierarchical FSMs**

## RTL & synthesis
- **RTL coding style** — flip-flop inference, blocking vs non-blocking
- **Always blocks** — combinational, sequential, latch (usually unintended)
- **Synthesis** — RTL → gate netlist mapped to standard-cell library
- **Place & route** — floorplan, placement, clock tree, routing, timing closure
- **Static Timing Analysis (STA)** — setup, hold, recovery, removal
- **Clock skew, jitter, uncertainty**
- **Clock gating, power gating, multi-Vt, multi-voltage**

## Clock domain crossing & metastability
- **Metastability** — what it is, MTBF formulas
- **2-FF synchronizer** — for single bit signals
- **Async FIFO** — with Gray-code pointers
- **Handshake-based CDC**

## Test & debug
- **Functional sim** vs **gate-level sim** vs **formal verification**
- **JTAG boundary scan (IEEE 1149.1)** — cross-link [01](../../01_Circuit_Board/protocols/INDEX.md)
- **Scan chains, ATPG, BIST**
- **Coverage** — line, branch, FSM, toggle, functional, assertion

## FPGA vs ASIC vs CPLD
- **CPLD** — small, instant-on, EEPROM-based
- **FPGA** — LUT + flip-flop + DSP block + BRAM + SerDes
- **ASIC** — full-custom or standard-cell; NRE vs unit cost tradeoff
- **Structured ASIC** / **eFPGA** — middle ground

## Cross-link
- Built from devices → [00b_Devices](../../00b_Devices/) (CMOS)
- Microarch above → [02_CPU/topics](../../02_CPU/topics/INDEX.md)
- Embedded firmware on FPGA soft cores → [03_Firmware_BIOS](../../03_Firmware_BIOS/)
