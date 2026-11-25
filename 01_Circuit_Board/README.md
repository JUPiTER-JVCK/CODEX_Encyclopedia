# 01 — Circuit Board

> The physical substrate. Copper, silicon, solder, and signals — everything
> above this layer ultimately rides on electrons moving across these traces.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  02  CPU                                     │
└───────────────────────┬──────────────────────┘
                        │  electrical signals, serial & parallel buses
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓     ┌────────────────────────┐
┃  01  Circuit Board                ◀── here   ┃─────┤  09  Network Physical  │
┃      PCB · buses · connectors · power rails  ┃     └────────────────────────┘
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  Boolean signals on pins and traces
┌───────────────────────┴──────────────────────┐
│  00d  Digital Circuits                       │
└──────────────────────────────────────────────┘
```

09 Network Physical is a network layer, but its silicon — the NIC's PHY, the
magnetics, the SFP cage — is on this board, which is why it hangs off the side
rather than sitting above or below.

## At a glance

| Field | Value |
|-------|-------|
| Description | Physical hardware connecting CPU, RAM, I/O |
| Languages | N/A (Hardware Description Languages: Verilog, VHDL, SystemVerilog) |
| Medium / Interface | Electrical signals, parallel & serial buses |
| Example | CPU fetches data from RAM via the memory bus |
| Adjacent layers | ↑ [02_CPU](../02_CPU/), ↓ [00d_Digital_Circuits](../00d_Digital_Circuits/), ↔ [09_Network_Physical](../09_Network_Physical/) (NIC PHY) |

## What lives here

- Motherboard, daughterboards, riser cards, backplanes
- Chipsets (PCH, Southbridge equivalents)
- Buses: PCIe, DDR, SPI, I²C, USB, SATA, NVMe (M.2), JTAG, UART
- Power delivery (VRMs), clock distribution, signal integrity, EMI/EMC
- Single Board Computers (Raspberry Pi, BeagleBone, Jetson)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | books, datasheets, vendor docs |
| [Lessons](#lessons) | [Interactive labs](pcb_labs.md) | electronics, PCB design, FPGA labs |
| [Languages](#languages) | — | HDLs and EDA tools |
| [Manual Pages](#manual-pages) | — | `lspci`, `lshw`, `dmidecode`, `lsusb` |
| [Topics](#topics) | — | buses, chipsets, RAM, NIC PHYs |
| [Protocols](#protocols) | [Embedded Bus Protocols](embedded_bus_protocols_lookup.md) | PCIe, USB, SPI, I²C, JTAG, DDR |

## Cross-references

- Voltage / ISA-level concerns → [02_CPU](../02_CPU/)
- Driver enumeration of devices → [04_Device_Drivers](../04_Device_Drivers/)
- RF and antenna front-ends → [16_RF_Wireless](../16_RF_Wireless/)
- Hardware attacks (fault injection, side channels) → [Security › Topics](../14_Security/README.md#topics)

---

## References

### Where to start, by what you are doing

```text
  designing the circuit     Horowitz & Hill, The Art of Electronics
                            └─ shared with 00b and 00c — one book, three
                               layers, which is the point of it

  getting from HDL to CPU   Harris & Harris, Digital Design and Computer
                            Architecture                    ──▶ 00d, 02

  making it work at speed   Johnson & Graham, High-Speed Digital Design
                            (the "black magic" handbook — signal integrity)

  having it manufactured    Coombs, Printed Circuits Handbook

  Below the books, the specs — which at this layer are the real reference
  and are all primary sources:

    JEDEC JESD79 family      DDR electrical and timing
    PCI-SIG Base Spec        PCIe electrical and protocol layers
    USB-IF 2.0 / 3.x / 4     physical and link layer
    Intel chipset datasheets what a given PCH actually exposes

  And the community boards that publish their own schematics: Raspberry Pi,
  Arduino, BeagleBoard.
```

### Books
- *The Art of Electronics* — Horowitz & Hill. The canonical analog/digital electronics text.
- *Digital Design and Computer Architecture* — Harris & Harris. Bridges HDL to CPU.
- *High-Speed Digital Design: A Handbook of Black Magic* — Johnson & Graham. Signal integrity.
- *Printed Circuits Handbook* — Coombs. PCB fabrication and design practice.

### Datasheets & specs
- Intel chipset datasheets — `https://www.intel.com/content/www/us/en/products/docs/`
- JEDEC standards for DDR (JESD79 family) — memory module electrical specs
- PCI-SIG specs (PCIe Base Spec) — bus electrical and protocol layers
- USB-IF specs (USB 2.0 / 3.x / 4) — physical and link layer

### Online
- All About Circuits — `https://www.allaboutcircuits.com/`
- EEVblog forum + YouTube — practical electronics
- OSHW community boards: Raspberry Pi, Arduino, BeagleBoard

### Migration from v1
- General hardware datasheets (v1 collection) → drop them in this folder
- SBC-specific documentation (v1 collection)
- `DL_020_datasheet.pdf` — product datasheet, not yet migrated

---

## Lessons

### The ladder

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

### Dedicated lesson modules

| Topic | File |
|-------|------|
| PCB interactive labs | [Circuit Board interactive labs](pcb_labs.md) — KiCad schematic/layout, soldering, signal integrity |

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

### Suggested external courses
- MIT 6.002 *Circuits and Electronics* (OCW)
- Nand2Tetris — build a computer from NAND gates up
- Ben Eater's 8-bit breadboard CPU series (YouTube)

---

## Languages

No "programming" languages in the conventional sense at this layer — you describe
hardware behavior with HDLs and design tools.

### Three things a board is described in

```text
  Nothing at this layer is a programming language. Each box below is a
  different description of the same board. The first two are run — one on
  hardware, one in a simulator — and the third is manufactured.

  ┌─ behaviour of the logic ──────────────────────────────────────────┐
  │  Verilog · SystemVerilog · VHDL      the industry three           │
  │  Chisel (Scala) · Amaranth (Python)  generator-based              │
  │     ├──▶ Icarus · Verilator · GHDL   simulate it                 │
  │     └──▶ Vivado · Quartus · yosys    synthesise it                │
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

### Related
- HDL ↔ CPU instructions → [CPU › Languages](../02_CPU/README.md#languages)
- Embedded C for SBCs → [Firmware / BIOS › Languages](../03_Firmware_BIOS/README.md#languages)

---

## Manual Pages

Hardware enumeration & inspection tools — mostly Linux, with macOS equivalents.

### Asking the machine what it is made of

```text
  Every command here answers the same question at a different level of the
  board. Most read back what firmware and the kernel already discovered; the
  last two go and ask the hardware themselves.

  the whole board        lshw · hwinfo          system_profiler   (macOS)
  │                      dmidecode ── SMBIOS/DMI: board, BIOS, memory
  │
  ├─ the buses           lspci   PCIe tree, and which driver claimed what
  │                      lsusb   USB topology
  │                      ioreg   the IORegistry tree          (macOS)
  │
  ├─ the parts on them   lscpu · lsmem · lsblk
  │
  ├─ what happened at boot
  │                      dmesg   the kernel's own account of the above
  │
  └─ and two that transact rather than report:
                         i2cdetect   drives the bus, addressing every slot
                         spi-tools   talks to /dev/spidev* directly
                         both can wedge a live device — read their warnings

  On an SBC the same job needs board-specific tools — not because the
  header lacks standard buses (it multiplexes I²C, SPI and UART onto those
  pins) but because deciding *which* function a pin carries, and reading the
  SoC's own firmware, is vendor territory: pinctrl (RPi GPIO and pin-mux,
  the supported replacement for raspi-gpio — WiringPi's gpio was a separate
  third-party tool) and vcgencmd (VideoCore temperature, voltage, clocks).

  Who is driving each of these devices is 04 Device Drivers.
```

| Command | Section | Purpose |
|---------|---------|---------|
| `lspci` | 8 | List PCI/PCIe devices and their drivers |
| `lsusb` | 8 | List USB devices and topology |
| `lshw` | 1 | Comprehensive hardware listing (CPU, memory, buses) |
| `dmidecode` | 8 | Dump SMBIOS/DMI tables: motherboard, memory modules, BIOS info (firmware-reported, not read from the DIMM's SPD) |
| `hwinfo` | 8 | openSUSE-style hardware probe |
| `dmesg` | 1 | Kernel ring buffer — boot-time hardware messages |
| `lsblk` | 8 | List block devices and partitions |
| `lscpu` | 1 | CPU architecture details (cores, cache, flags) |
| `lsmem` | 1 | Memory range information |
| `i2cdetect` | 8 | Scan for devices on I²C bus (i2c-tools) |
| `spi-tools` | 1 | Userspace SPI access via `/dev/spidev*` |
| `system_profiler` | 8 | macOS — equivalent to `lshw` (`SPHardwareDataType`) |
| `ioreg` | 8 | macOS — IORegistry tree of attached devices |

### SBC / embedded
| Command | Purpose |
|---------|---------|
| `gpio` (WiringPi) | Raspberry Pi GPIO control — third-party, deprecated |
| `pinctrl` | RPi GPIO and pin-mux — the supported tool, replacing `raspi-gpio` |
| `vcgencmd` | Raspberry Pi VideoCore GPU/temp/voltage queries |

---

## Topics

Concept notes. One file per topic as the codex grows; this index gives the map.

### The board, outside in

```text
  Four groups. The first is the object, the second is how its parts talk,
  the third is what keeps them alive, and the fourth is how it got built.

  the object          motherboard layout — sockets, slots, headers, planes
  │                   chipsets — Intel PCH · AMD · ARM SoC controllers
  │                   form factors — ATX ─ microATX ─ ITX ─ NUC ─ SBC
  │                   SBCs — Raspberry Pi · BeagleBone · Jetson · Pine64
  ▼
  how it talks        parallel — DDR, legacy PCI
  │                   serial — PCIe · USB · SATA · SPI · I²C · CAN
  │                   topology — point-to-point · multi-drop · fabric
  │                   clocking — synchronous · source-sync · embedded clock
  │                   NVMe is a command set carried over PCIe, not a bus
  ▼                                          detail: Protocols, below
  what keeps it up    memory — DIMMs · ECC · channels · ranks · SPD · XMP
  │                   power — multi-phase VRM · PMIC · sequencing   → 00c
  │                   clocks — PLLs · crystals · jitter             → 00c
  │                   thermal — sinks · pipes · vapour chambers · TIM
  ▼
  how it was made     stackup — layer count · dielectric · impedance
                      soldering — reflow · wave · hand · SMD vs THT
                      inspection — AOI · X-ray for BGA · in-circuit test

  Attacking any of the above — chip-off, JTAG abuse, glitching, implants,
  supply chain — is 14 Security's topics section.
```

### Board-level
- **Motherboard layout** — sockets, slots, headers, power planes.
- **Chipsets** — Intel PCH, AMD chipsets, ARM SoC platform controllers.
- **Form factors** — ATX, microATX, ITX, NUC, server boards, SBCs.
- **Single Board Computers** — Raspberry Pi family, BeagleBone, Jetson, Pine64.

### Buses & interconnect
- **Parallel buses** — DDR memory, legacy PCI.
- **Serial buses** — PCIe, USB, SATA, Thunderbolt, SPI, I²C, UART, CAN, JTAG.
  (NVMe rides on PCIe as a command set rather than being a bus of its own.)
- **Bus topologies** — point-to-point, multi-drop, bussed, fabric.
- **Bus arbitration & clocking** — synchronous vs source-synchronous vs embedded clock.

### Subsystems
- **Memory subsystem** — DIMMs, ECC, channels, ranks, SPD/JEDEC profile, XMP/EXPO.
- **Power delivery (VRM)** — multi-phase regulators, PMIC, sequencing.
- **Clock generation** — PLLs, crystal oscillators, jitter.
- **Cooling & thermal** — heat sinks, heat pipes, vapor chambers, thermal interface material.

### Manufacturing & assembly
- **PCB stackup** — layer count, dielectric, impedance control.
- **Soldering** — reflow, wave, hand soldering, SMD vs through-hole.
- **Inspection** — AOI, X-ray (for BGA), in-circuit test.

### Hardware security (cross-link)
- See [Security › Topics](../14_Security/README.md#topics) for: chip-off attacks, JTAG debug abuse, glitching/fault injection, hardware implants, supply-chain.

---

## Protocols

Physical/electrical bus protocols that live on the board.

### The buses, by shape

```text
  What distinguishes these is topology and clocking, not speed — and the
  slow ones at the bottom differ from each other as much as from the rest.

  point-to-point, serial, lanes        the fast ones. A link is two devices
    PCIe 1.0–6.0 ──▶ NVMe (a command set, not a bus)
    SATA · Thunderbolt 3/4/5 (tunnels PCIe + DisplayPort over USB-C;
      1 and 2 did the same over Mini DisplayPort)
    HDMI (TMDS/FRL) · DisplayPort (Main Link)
    SGMII ── MAC ◀──▶ PHY, serialised          ──▶ 09 Network Physical

  parallel, clocked, wide              memory, and the MAC-to-PHY link
    DDR4 · DDR5 (JESD79-4/5) · LPDDR4/5 (JESD209-4/5)
    MII · RGMII — four or eight data lines plus a clock, not lanes

  a tree with one host                 enumeration, addresses handed out
    USB 2.0 / 3.x / 4

  the slow ones, everywhere on the board — and no two share a topology:
    I²C ──▶ SMBus     truly multi-drop: two wires, addresses on the bus
    CAN (ISO 11898)   multi-drop and multi-master, with arbitration
    SPI               a shared clock and data, one chip-select per device
    UART / RS-232     point-to-point, and no clock at all
    JTAG (1149.1)     a daisy chain — out of one device, into the next

  The decoder catalog for all of these, as a logic analyzer sees them, is
  in embedded_bus_protocols_lookup.md in this folder.
```

| Protocol | Spec | Type | Status |
|----------|------|------|--------|
| PCIe (1.0 – 6.0) | PCI-SIG Base Spec | Serial, point-to-point, lanes | Active |
| DDR4 / DDR5 | JEDEC JESD79-4 / JESD79-5 | Parallel memory bus | Active |
| LPDDR4/5 | JEDEC JESD209-4/5 | Low-power memory | Active |
| USB 2.0 / 3.x / 4 | USB-IF | Serial, host-centric tree | Active |
| Thunderbolt 3 / 4 / 5 | Intel + USB-IF | Tunnels PCIe + DisplayPort over USB-C | Active |
| SATA (I/II/III) | SATA-IO | Serial storage | Legacy/active |
| NVMe (over PCIe) | NVM Express | Storage command protocol | Active |
| SPI | de facto (Motorola) | 4-wire serial, master-slave | Active |
| I²C | NXP/Philips | 2-wire, multi-drop | Active |
| UART / RS-232 | ANSI/TIA-232-F | Asynchronous serial | Legacy/active |
| CAN bus | ISO 11898 | Multi-master, automotive | Active |
| JTAG / Boundary scan | IEEE 1149.1 | Test & debug access | Active |
| SMBus | SBS-IF | I²C-derived, system management | Active |
| HDMI | HDMI Forum | Video + audio (TMDS / FRL) | Active |
| DisplayPort | VESA | Video + audio (Main Link) | Active |
| Ethernet PHY (MII/RGMII/SGMII) | IEEE 802.3 | MAC ↔ PHY interface | Active |

### Cross-links
- Wire-level Ethernet → [Network Physical › Protocols](../09_Network_Physical/README.md#protocols)
- RF interconnects → [RF / Wireless › Protocols](../16_RF_Wireless/README.md#protocols)
