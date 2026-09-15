# Digital Circuits — Protocols

Language and exchange-format standards rather than wire protocols — what an
HDL toolchain has to implement.

## Standards, by what they hand to the next tool

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
                                                └─ 1687 iJTAG · 1450 STIL

  moving data on-chip,             AMBA AXI/AHB/APB/ACE/CHI (Arm)
  to RAM, and to storage           Wishbone · TileLink · OCP · Avalon
                                   JESD79-x DDR · JESD209-x LPDDR
                                   JESD235 HBM · ONFI · eMMC ──▶ 01, 02
```

## HDL & exchange formats
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

## Test / debug
| Standard | Scope |
|----------|-------|
| IEEE 1149.1 | JTAG boundary scan |
| IEEE 1149.4 | Mixed-signal boundary scan |
| IEEE 1149.6 | AC-coupled boundary scan |
| IEEE 1149.7 | cJTAG (compact) |
| IEEE 1500 | Embedded core test |
| IEEE 1687 | iJTAG (internal JTAG) |
| IEEE 1450 | STIL (Standard Test Interface Language) |

## On-chip / SoC interconnect
| Spec | Owner | Scope |
|------|-------|-------|
| AMBA AXI / AHB / APB / ACE / CHI | Arm | Bus protocols for SoCs |
| Wishbone | OpenCores | Open SoC bus |
| TileLink | SiFive | Cache-coherent fabric (RISC-V) |
| OCP | Accellera | Open Core Protocol |
| Avalon | Intel/Altera | FPGA interconnect |
| AXI-Stream | Arm | Streaming variant |
| NoC standards | various | Network-on-Chip |

## Memory interfaces (digital-side specs)
| Spec | Scope |
|------|-------|
| JEDEC JESD79-x | DDR / DDR2 / DDR3 / DDR4 / DDR5 |
| JEDEC JESD209-x | LPDDR family |
| JEDEC JESD230 | GDDR5 |
| JEDEC JESD235 | HBM / HBM2 / HBM3 |
| ONFI | Open NAND Flash Interface |
| eMMC (JESD84) | Embedded MultiMediaCard |

## Cross-link
- Wire-level PCB-side bus protocols → [01_Circuit_Board/protocols](../../01_Circuit_Board/protocols/INDEX.md)
- The big "logic analyzer decoder" catalog → [01/protocols/embedded_bus_protocols_lookup.md](../../01_Circuit_Board/protocols/embedded_bus_protocols_lookup.md)
