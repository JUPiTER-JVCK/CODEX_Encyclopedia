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
[02_CPU/topics](../02_CPU/topics/INDEX.md).

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
- **Logic gates** — YES/NO, AND/OR/XOR/NAND/NOR/XNOR (see [topics/logic_gates.md](topics/logic_gates.md))
- **Combinational logic** — multiplexers, decoders, encoders, comparators, adders
- **Sequential logic** — latches, flip-flops (D, T, JK, SR), registers, counters, shift registers
- **FSM** — Moore vs Mealy state machines
- **Memory** — SRAM, DRAM cells, register files, FIFOs, CAMs
- **Arithmetic** — ripple-carry / carry-lookahead / Wallace tree / Booth multiplier
- **HDL design** — RTL coding, synthesis, place & route, timing closure
- **Clock domain crossing**, **metastability**, **setup/hold**

## Sub-sections
- [references/](references/INDEX.md)
- [lessons/](lessons/INDEX.md)
- [languages/](languages/INDEX.md)
- [man_pages/](man_pages/INDEX.md)
- [topics/](topics/INDEX.md) — including **[logic_gates.md](topics/logic_gates.md)** (full truth tables)
- [protocols/](protocols/INDEX.md)

## Cross-references
- Devices used to build gates → [00b_Devices](../00b_Devices/) (CMOS)
- Sampling boundary into the digital domain → [00c_Analog_Circuits](../00c_Analog_Circuits/)
- Microarchitecture built from these blocks → [02_CPU/topics](../02_CPU/topics/INDEX.md)
- Bus protocols at the digital wire level → [01_Circuit_Board/protocols](../01_Circuit_Board/protocols/INDEX.md)
