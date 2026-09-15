# 18 — Embedded Systems (Cross-cutting)

> The discipline of building **constrained, deterministic, hardware-bound
> compute**. Spans layers 00 (physics) through 08 (apps) — embedded systems
> engineers wear every hat in the codex. Mirrors the *Embedded Systems
> Engineering Roadmap v1.2.3* by Meysam Parvizi (CC BY-SA 4.0), transcribed
> in full below.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  16  RF / Wireless        ─┐
  14  Security             ─┤
  13  Network Application  ─┤
  09  Network Physical     ─┤      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  05  OS Kernel / RTOS     ─┼──────┃  18  Embedded Systems                 ◀── here   ┃
  03  Firmware             ─┤      ┃      co-design under tight constraints           ┃
  02  CPU / MCU            ─┤      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  00  Physics              ─┘

one engineer owns the whole column, from silicon to cloud
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | All of 00–13, plus all of 14 (security) and 16 (RF) for IoT |
| Description | Hardware-software co-design for deterministic, often resource-limited devices |
| Languages | **C, C++, Python, Rust, Assembly** (user emphasized Python & Rust) |
| Industries | Automotive, aerospace, consumer electronics, telecom, healthcare, robotics, agriculture |

## The roadmap, in four columns

Parvizi's roadmap is a single large poster. The sections below transcribe it
in full; this is its shape.

```text
  ┌───────────────────────┐ ┌───────────────────────┐ ┌───────────────────────┐
  │ SOFTWARE              │ │ INTERFACES            │ │ HARDWARE              │
  ├───────────────────────┤ ├───────────────────────┤ ├───────────────────────┤
  │ C · C++ · Assembly    │ │ UART · I²C · SPI      │ │ electronics · math    │
  │ Python · Rust         │ │ Ethernet · USB · PCIe │ │ digital design        │
  │ algorithms · patterns │ │ BT · Wi-Fi · LoRa     │ │ test equipment        │
  │ Embedded Linux        │ │ Modbus · Profinet     │ │ breadboard · solder   │
  │ RTOS · MCU periph.    │ │ CAN · LIN · FlexRay   │ │ PCB design · EMC      │
  │ build · debug · test  │ │ TCP/IP · cellular     │ │ FPGA development      │
  └───────────────────────┘ └───────────────────────┘ └───────────────────────┘

  ┌───────────────────────────────────────────────────────────────────────────┐
  │ SOFT SKILLS — the fourth column, and the one that                         │
  │ decides whether the other three ship                                      │
  │ communication · problem solving · teamwork ·                              │
  │ organization · self-driven · adaptable · patient                          │
  └───────────────────────────────────────────────────────────────────────────┘
```

The original is at
[github.com/m3y54m/Embedded-Engineering-Roadmap](https://github.com/m3y54m/Embedded-Engineering-Roadmap).
Earlier revisions of this file located its sections by pointing at a
numbered picture that was never in the repository, which told a reader here
nothing. The column names above are what they meant.

## What lives here

### Hardware
- **Electronics** — math/calc, circuits, electronics fundamentals, digital design, computer architecture
- **Test equipment** — multimeter, logic / protocol analyzer, oscilloscope
- **Prototyping skills** — breadboarding, hardware design, PCB design + EMC, soldering / rework
- **FPGA development**

### Software
- **Programming languages** — **C** (required), **C++**, **Assembly** (required), **Python**, **Rust** *(user-circled)*
- **Programming fundamentals** — algorithms & DS, design patterns, state machines, memory management
- **Operating systems**:
  - **Embedded Linux** — Linux kernel, device drivers, U-Boot, Buildroot/Yocto, threading, IPC, Qt
  - **RTOS** — basics, FreeRTOS, Zephyr, QNX, µC/OS, RT-Thread
- **Microcontrollers** — GPIO, ADC/DAC, timers/counters, PWM, watchdog, interrupts, DMA, clock mgmt, power mgmt, bootloader/DFU
- **Build system** — Compilers/GCC, Make/CMake, Bash, Docker
- **Debugging** — JTAG/SWD, GDB, OpenOCD
- **Version control** — Git (SVN legacy)
- **SDLC** — Agile/SCRUM, V-Model
- **Testing** — TDD/unit, CI/CD, SIL/HIL, standards/certs
- **Embedded security**, **Embedded GUI**, **IoT**, **Edge AI**, **AUTOSAR**

### Interfaces & protocols
- **Basic** — UART (req), I2C (req), SPI (req)
- **High-speed** — Ethernet (req), USB, PCIe
- **Wireless** — Bluetooth (req), Wi-Fi (req), LoRa, Zigbee, Thread, Matter, UWB
- **Industrial** — Modbus (req), Profinet, EtherCAT, MQTT, CoAP → see [19_Industrial_Protocols](../19_Industrial_Protocols/)
- **Automotive** — CAN (req), LIN, MOST, FlexRay → see [19_Industrial_Protocols](../19_Industrial_Protocols/)
- **Network** — TCP/IP, UDP → cross-link [11](../Network/11_Network_Internet/) + [12](../Network/12_Network_Transport/)
- **Cellular** — GSM/LTE, LTE-M / 5G, NB-IoT → cross-link [16](../16_RF_Wireless/)

### Cross-cutting topics
- **Memory technologies & file systems**, **hardware simulation/emulation**
- **Sensors & actuators**, **DSP**, **control theory**

### Soft skills
- Communication, problem solving & critical thinking, teamwork, organization, self-driven, adaptable & patient

## Sub-sections

- [references/](references/INDEX.md) — including `embedded_systems_full_roadmap_book.pdf` (v1)
- [lessons/](lessons/INDEX.md) — ordered roadmap-style study path
- [languages/](languages/INDEX.md) — emphasis on C / Python / Rust
- [man_pages/](man_pages/INDEX.md) — toolchain, debug, build, RTOS CLIs
- [topics/](topics/INDEX.md) — exhaustive index of the roadmap topics
- [protocols/](protocols/INDEX.md) — protocols index pointing into layer 19 + 13 + 09–13

## Cross-references
- Physics & devices substrate → [00_Physics](../00_Physics/), [00b_Devices](../00b_Devices/)
- Bare-metal / RTOS firmware → [03_Firmware_BIOS](../03_Firmware_BIOS/)
- Drivers → [04_Device_Drivers](../04_Device_Drivers/)
- Industrial bus protocols → [19_Industrial_Protocols](../19_Industrial_Protocols/)
- RF & wireless → [16_RF_Wireless](../16_RF_Wireless/)
- Algorithmic foundations → [17_Algorithms_DSA](../17_Algorithms_DSA/)
- Embedded security → [14_Security/topics](../14_Security/topics/INDEX.md)
- Edge AI → [15_AI_ML/topics](../15_AI_ML/topics/INDEX.md)

## Anchor reference
- `references/embedded_systems_full_roadmap_book.pdf` — placeholder for the
  Embedded Systems Roadmap book. Original by Meysam Parvizi (CC BY-SA 4.0)
  at [github.com/m3y54m/Embedded-Engineering-Roadmap](https://github.com/m3y54m/Embedded-Engineering-Roadmap)
- The roadmap poster itself is not vendored here. It is CC BY-SA 4.0 and
  freely available upstream, and the four-column transcription above plus the
  sections that follow carry its content.
