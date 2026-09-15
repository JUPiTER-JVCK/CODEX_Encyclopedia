# Circuit Board — Lessons

## The ladder

```text
  Ten tracks. The file states three prerequisites — #1→#2, #2→#6, #4→#5 —
  and those are the only edges drawn as such below. Everything else is listed
  in its own order, not claimed to depend on what precedes it.

  1  Basic electronics        Ohm · Kirchhoff · RC · op-amps    → 00c
  │
  └─ 2  Digital logic         gates · flip-flops · FSMs         → 00d
        │
        └─ 6  FPGA on Verilog/VHDL    blink ─▶ UART echo ─▶ a CPU

  3  Soldering & rework       through-hole ─▶ SMD ─▶ hot air ─▶ BGA
  │
  4  Reading schematics & PCBs   symbols · nets · layers · gerbers · BOM
  │
  └─ 5  KiCad project         design ─▶ export gerbers ─▶ send to a fab

  7  Signal integrity & EMC     transmission lines · termination
                                crosstalk · ground planes
  8  Bus bring-up debug         logic analyzer + scope on I²C/SPI/UART
  9  JTAG & boundary scan       chain detection · fault isolation
  10  SBC project               boot Linux on a Pi or BeagleBone, attach a
                                sensor, write the driver    ──▶ 04, 05

  Lab: pcb_labs.md — a KiCad schematic and layout (#5), soldering (#3).
```

## Dedicated lesson modules

| Topic | File |
|-------|------|
| PCB interactive labs | [pcb_labs.md](pcb_labs.md) — KiCad schematic/layout, soldering, signal integrity |

---

Ordered beginner → advanced. Each entry is a learning track, not a single page.

1. **Basic electronics** — Ohm's law, Kirchhoff, RC circuits, op-amps. *Prereq:* algebra.
2. **Digital logic** — gates, flip-flops, FSMs, combinational vs sequential. *Prereq:* #1.
3. **Soldering & rework** — through-hole, SMD, hot-air rework, BGA awareness.
4. **Reading schematics & PCBs** — symbols, nets, layers, gerbers, BOMs.
5. **KiCad project** — design a small PCB, export gerbers, send to fab. *Prereq:* #4.
6. **FPGA intro on Verilog/VHDL** — blink an LED → UART echo → simple CPU. *Prereq:* #2.
7. **Signal integrity & EMC** — transmission lines, termination, crosstalk, ground planes.
8. **Bus bring-up debug** — using a logic analyzer & scope on I²C / SPI / UART.
9. **JTAG & boundary scan** — chain detection, board test, fault isolation.
10. **SBC project** — Raspberry Pi or BeagleBone: boot Linux, attach a sensor, write a driver.

## Suggested external courses
- MIT 6.002 *Circuits and Electronics* (OCW)
- Nand2Tetris — build a computer from NAND gates up
- Ben Eater's 8-bit breadboard CPU series (YouTube)
