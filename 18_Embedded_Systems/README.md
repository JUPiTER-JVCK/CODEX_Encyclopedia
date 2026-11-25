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
- **Network** — TCP/IP, UDP → cross-link [11](../11_Network_Internet/) + [12](../12_Network_Transport/)
- **Cellular** — GSM/LTE, LTE-M / 5G, NB-IoT → cross-link [16](../16_RF_Wireless/)

### Cross-cutting topics
- **Memory technologies & file systems**, **hardware simulation/emulation**
- **Sensors & actuators**, **DSP**, **control theory**

### Soft skills
- Communication, problem solving & critical thinking, teamwork, organization, self-driven, adaptable & patient

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | [Roadmap book (PDF placeholder)](embedded_systems_full_roadmap_book.pdf) | including `embedded_systems_full_roadmap_book.pdf` (v1) |
| [Lessons](#lessons) | [Interactive labs](embedded_labs.md) | ordered roadmap-style study path |
| [Languages](#languages) | [Embedded C](embedded_c.md) · [Embedded Python (MicroPython / CircuitPython)](embedded_python.md) · [Embedded Rust](embedded_rust.md) | emphasis on C / Python / Rust |
| [Manual Pages](#manual-pages) | [Embedded Systems Tools Reference](embedded_tools.md) | toolchain, debug, build, RTOS CLIs |
| [Topics](#topics) | — | exhaustive index of the roadmap topics |
| [Protocols](#protocols) | [I2C and SPI](i2c_spi.md) · [UART](uart.md) | protocols index pointing into layer 19 + 13 + 09–13 |

## Cross-references
- Physics & devices substrate → [00_Physics](../00_Physics/), [00b_Devices](../00b_Devices/)
- Bare-metal / RTOS firmware → [03_Firmware_BIOS](../03_Firmware_BIOS/)
- Drivers → [04_Device_Drivers](../04_Device_Drivers/)
- Industrial bus protocols → [19_Industrial_Protocols](../19_Industrial_Protocols/)
- RF & wireless → [16_RF_Wireless](../16_RF_Wireless/)
- Algorithmic foundations → [17_Algorithms_DSA](../17_Algorithms_DSA/)
- Embedded security → [Security › Topics](../14_Security/README.md#topics)
- Edge AI → [AI / ML › Topics](../15_AI_ML/README.md#topics)

## Anchor reference
- [`embedded_systems_full_roadmap_book.pdf`](embedded_systems_full_roadmap_book.pdf) — placeholder for the
  Embedded Systems Roadmap book. Original by Meysam Parvizi (CC BY-SA 4.0)
  at [github.com/m3y54m/Embedded-Engineering-Roadmap](https://github.com/m3y54m/Embedded-Engineering-Roadmap)
- The roadmap poster itself is not vendored here. It is CC BY-SA 4.0 and
  freely available upstream, and the four-column transcription above plus the
  sections that follow carry its content.

---

## References

### What is in this section

```text
  Books and online resources for embedded systems study.

  ┌─── foundational books ────────────────────────────────────────────────┐
  │  Making Embedded Systems (White) · Embedded Software: The Works      │
  │  Art of Designing Embedded Systems (Ganssle) · Barr (C/C++)          │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── language & OS books ───────────────────────────────────────────────┐
  │  Rust Embedded Book (free) · FreeRTOS Mastering (free)               │
  │  Zephyr docs · Mastering Embedded Linux (Simmonds)                   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  Memfault / Interrupt blog · Beningo Embedded · Embedded Artistry     │
  │  Phil's Lab (YouTube) · Embedded.fm podcast · vendor app notes       │
  └──────────────────────────────────────────────────────────────────────┘
```

### Anchor (user-supplied)
- **`embedded_systems_full_roadmap_book.pdf`** — currently a generated
  placeholder, not the real book. Obtain the original from the authorized
  source below.
- **Roadmap image** — Meysam Parvizi, *Embedded Systems Engineering Roadmap* v1.2.3 (2023-12-23)
  - GitHub: `https://github.com/m3y54m/Embedded-Engineering-Roadmap`
  - License: CC BY-SA 4.0
  - Transcribed in full in [the layer README](README.md); the poster
    itself is not vendored here.

### Books — foundations
- *Making Embedded Systems* — Elecia White. The starting point.
- *Embedded Software: The Works* — Colin Walls.
- *The Art of Designing Embedded Systems* — Jack Ganssle.
- *Programming Embedded Systems in C and C++* — Michael Barr.
- *Embedded Systems Architecture* — Daniele Lacamera (modern Rust + C).
- *Real-Time Concepts for Embedded Systems* — Qing Li & Caroline Yao.

### Books — language-specific
- *Modern C for Absolute Beginners* — Slobodan Dmitrović
- *Embedded Rust: The Discovery Book* (free, official) — `https://docs.rust-embedded.org/discovery/`
- *The Rust Embedded Book* — `https://docs.rust-embedded.org/book/`
- *Programming Arduino Next Steps* — Simon Monk
- *MicroPython for the Internet of Things* — Charles Bell

### Books — OS / RTOS
- *FreeRTOS Reference Manual* + *Mastering the FreeRTOS Real-Time Kernel* (free, Richard Barry)
- *Zephyr Project Documentation* — `https://docs.zephyrproject.org/`
- *QNX Neutrino System Architecture*
- *Linux Device Drivers, 3rd ed.* — Corbet/Rubini/Kroah-Hartman (cross-link [04](../04_Device_Drivers/))
- *Mastering Embedded Linux Programming* — Chris Simmonds
- *Embedded Linux Primer* — Christopher Hallinan

### Books — hardware design
- *Practical Electronics for Inventors* — Scherz & Monk
- *High-Speed Digital Design* — Howard Johnson
- *Printed Circuits Handbook* — Coombs

### Application notes / vendor docs
- ST AppNotes (`AN-####` series) for STM32
- NXP / Infineon / Renesas application notes
- TI Tiva / MSP430 / C2000 user guides
- Espressif ESP-IDF docs
- Raspberry Pi RP2040 datasheet & C SDK

### Online
- Beningo Embedded Group blog
- Memfault blog (firmware engineering deep dives)
- Interrupt blog (Memfault) — embedded debugging
- Embedded.fm podcast
- The Amp Hour podcast
- Phil's Lab (mixed-signal / embedded YouTube)
- Embedded Artistry — `https://embeddedartistry.com/`

---

## Lessons

### What is in this section

```text
  74-step roadmap: hardware → programming → MCU hands-on → RTOS → quality.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  embedded_labs.md (bare-metal blink · FreeRTOS tasks · UART · I2C)   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── phases 1–2: hardware & programming (1–16) ─────────────────────────┐
  │  circuits → electronics → digital design → CPU architecture           │
  │  C/Assembly (required) · C++ / Python / Rust (recommended)           │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── phases 3–5: MCU & RTOS (17–40) ───────────────────────────────────┐
  │  GPIO/ADC/PWM/DMA/clocks/power/bootloader · JTAG/GDB/OpenOCD         │
  │  FreeRTOS · Zephyr · Embedded Linux (U-Boot / Buildroot / Yocto)     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── phases 6–9: interfaces, quality & advanced (41–74) ────────────────┐
  │  UART/I2C/SPI/USB/CAN → [19] · TDD/CI/SIL/HIL · IEC 61508/ISO 26262│
  │  IoT / Edge AI / AUTOSAR / DSP / control theory / soft skills         │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Embedded Systems — Interactive Labs](embedded_labs.md) | Bare-metal blink, FreeRTOS tasks, UART, I2C sensor |

### Lesson ladder

Ordered to mirror the *Embedded Systems Engineering Roadmap* image. Each step
links to where deeper material lives in the codex.

### Phase 1 — Hardware foundations
1. **Basic math & calculus** — diff/integral, vectors, complex
2. **Electric circuits** — KCL, KVL, RC/RL/RLC → [00c_Analog_Circuits](../00c_Analog_Circuits/)
3. **Electronics fundamentals** — diodes, BJTs, MOSFETs → [00b_Devices](../00b_Devices/)
4. **Digital design** — gates, flip-flops, FSM, RTL → [00d_Digital_Circuits](../00d_Digital_Circuits/)
5. **Computer architecture** — ISA, pipeline, cache → [02_CPU](../02_CPU/)
6. **Lab tools** — multimeter, oscilloscope, logic analyzer, function generator
7. **Breadboarding + first PCB** — KiCad project, fab order, soldering practice

### Phase 2 — Programming foundations
8. **C** *(required)* — pointers, structs, bit-ops, build, link, debug
9. **Assembly** *(required)* — ARM Thumb or RISC-V; tiny boot code
10. **C++** *(recommended)* — RAII, templates, no-exceptions subset for embedded
11. **Python** *(user-circled)* — scripting, automation, embedded host tools
12. **Rust** *(user-circled)* — `no_std`, embedded HAL crates, Embassy or RTIC
13. **Algorithms & data structures** → [17_Algorithms_DSA](../17_Algorithms_DSA/)
14. **Design patterns** for embedded — state, observer, singleton (careful), policy
15. **State machines** — Moore vs Mealy; QM / Boost.SML / hand-rolled
16. **Memory management** — stack vs heap, custom allocators, alignment, MPU/MMU

### Phase 3 — Microcontroller hands-on
17. **GPIO** — blink LED, button input with debounce
18. **ADC / DAC** — read a pot, generate a waveform
19. **Timers & counters** — periodic ISR, input capture, output compare
20. **PWM** — motor speed control, LED dimming
21. **Watchdog** — independent + window
22. **Interrupts** — vector tables, priority/preemption, NVIC config
23. **DMA** — memory↔peripheral; circular vs single-shot
24. **Clock management** — PLLs, prescalers, clock tree
25. **Power management** — sleep, stop, standby modes; wake sources
26. **Bootloader / DFU** — A/B partitions, USB-DFU, OTA

### Phase 4 — Build & debug
27. **GCC / Clang for embedded** — cross-compile, linker scripts, sections
28. **Make / CMake** — out-of-source builds
29. **Bash scripting** — flash, log, test harness
30. **Docker** — reproducible build images
31. **JTAG / SWD** — pinout, target probe, openocd
32. **GDB** — source-level debug, watchpoints, remote
33. **OpenOCD / J-Link / ST-Link / pyOCD** — probe driver

### Phase 5 — OS & RTOS
34. **OS fundamentals** — scheduling, IPC, virtual memory → [05_OS_Kernel](../05_OS_Kernel/)
35. **RTOS basics** — tasks, priorities, mutexes, queues, ISR-safe APIs
36. **FreeRTOS** — port + tickless idle + heap_4 + queue lab
37. **Zephyr** — devicetree, Kconfig, west, drivers
38. **QNX / VxWorks / µC/OS / RT-Thread** — survey
39. **Embedded Linux** — kernel + driver + U-Boot + Buildroot/Yocto → [04](../04_Device_Drivers/) + [05](../05_OS_Kernel/)
40. **Threading & IPC on Linux** — pthreads, fifos, shm, msgq, signals

### Phase 6 — Interfaces & protocols
41. **UART** — bring up at 115200 8N1; getchar/putchar
42. **I²C** — read a sensor (e.g., BME280); handle ACK/NAK
43. **SPI** — SD card or display
44. **USB** — CDC ACM + HID enumeration
45. **Ethernet + lwIP** — TCP echo server
46. **PCIe** — concept only on MCU; do on SBC
47. **CAN / LIN / FlexRay** → [19_Industrial_Protocols](../19_Industrial_Protocols/)
48. **Modbus RTU / TCP**, **Profinet**, **EtherCAT** → [19](../19_Industrial_Protocols/)
49. **MQTT, CoAP** for IoT → [13](../13_Network_Application/README.md#protocols)
50. **BT / BLE, Wi-Fi, LoRa, Zigbee, Thread, Matter, UWB** → [16](../16_RF_Wireless/)
51. **Cellular: GSM/LTE, LTE-M, NB-IoT** → [16](../16_RF_Wireless/)

### Phase 7 — Quality & process
52. **SVN / Git** *(prefer Git)* — feature branches, PR review
53. **SDLC** — Agile/SCRUM, V-Model (regulated industries)
54. **Compilers / GCC** internals enough to read disasm
55. **TDD & unit testing** — Unity, CMock, GoogleTest, Catch2; embedded testbenches
56. **CI/CD pipelines** — GitHub Actions / GitLab CI for cross-compile + sim
57. **SIL / HIL** — software/hardware in the loop
58. **Standards & certifications** — IEC 61508 (functional safety), ISO 26262 (automotive), DO-178C (aviation), IEC 62304 (medical), MISRA C

### Phase 8 — Advanced topics
59. **Embedded security** → [Security › Topics](../14_Security/README.md#topics) (firmware/BMC/JTAG/BYOVD)
60. **Embedded GUI** — LVGL, TouchGFX, Qt for MCU, Slint
61. **IoT** — cloud connectivity, secure provisioning, fleet management
62. **Edge AI** → [15_AI_ML](../15_AI_ML/) (TFLite Micro, CMSIS-NN, microTVM, executorch)
63. **AUTOSAR** (Classic + Adaptive) — automotive ECU software architecture
64. **Memory technologies & file systems** — NOR/NAND/eMMC, LittleFS, FAT, ext4
65. **Hardware sim/emulation** — Renode, QEMU, Wokwi, Tinkercad
66. **Sensors & actuators** — MEMS, motors (BLDC/PMSM), valves
67. **DSP** — FIR/IIR, FFT, fixed-point arithmetic, CMSIS-DSP
68. **Control theory** — PID, state-space, model-predictive control

### Phase 9 — Soft skills
69. **Communication** — write specs, design reviews, postmortems
70. **Problem solving & critical thinking** — root-cause, 5-whys, fishbone
71. **Teamwork & collaboration**
72. **Organizational & time management**
73. **Self-driven & independent**
74. **Adaptability & patience** (embedded debugs are long)

### Industry focus tracks (pick one)
- Automotive · Consumer electronics · Telecom · Healthcare · Robotics · Aerospace · Agriculture

---

## Languages

### What is in this section

```text
  Languages for embedded: required → recommended → niche + toolchains.

  ┌─── dedicated profiles ────────────────────────────────────────────────┐
  │  embedded_c.md · embedded_rust.md · embedded_python.md               │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── required / recommended ────────────────────────────────────────────┐
  │  C (required) — kernels, RTOS, drivers, vendor HALs                  │
  │  Assembly — boot code, ISRs, context switch                           │
  │  C++ — embedded subset (RAII/templates, no exceptions)               │
  │  Python ★ — MicroPython/CircuitPython on chip; host tooling           │
  │  Rust ★  — no_std · Embassy (async) · RTIC · embedded-hal            │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── toolchains & build systems ────────────────────────────────────────┐
  │  arm-none-eabi-gcc · riscv64-unknown-elf-gcc · xtensa-esp32-elf-gcc  │
  │  Make / CMake / PlatformIO / Cargo + cargo-binutils                   │
  └──────────────────────────────────────────────────────────────────────┘
```

The roadmap calls out **C** and **Assembly** as required; the user circled
**Python** and **Rust** on the printed image. Below grouped accordingly.

### Embedded language profiles (man-page-style)

The embedded-specific deltas — `no_std`, freestanding, linker scripts,
flashing, RTOS patterns. Pair each with its host-side baseline.

| Language | Embedded profile | Host baseline |
|----------|------------------|---------------|
| C (freestanding) | [Embedded C](embedded_c.md) | [C](../08_User_Applications/c.md) |
| Rust (`no_std`, Embassy, RTIC) | [Embedded Rust](embedded_rust.md) | [Rust](../08_User_Applications/rust.md) |
| Python (MicroPython / CircuitPython) | [Embedded Python (MicroPython / CircuitPython)](embedded_python.md) | [Python](../08_User_Applications/python.md) |

For low-level assembly (Cortex-M Thumb-2, AArch64, RISC-V), see [CPU › Languages](../02_CPU/README.md#languages).

### Required
| Language | Use |
|----------|-----|
| **C** | The lingua franca. Kernels, RTOS, drivers, firmware, vendor HALs |
| **Assembly** | Boot code, ISRs, context switch, performance-critical inner loops |

### Recommended
| Language | Use |
|----------|-----|
| **C++** | Often as "embedded C++" subset — RAII, templates, no exceptions / no RTTI; Mbed, Arduino, modern STM32 HALs |
| **Python** *(user-circled)* | Host tooling, scripting, test harnesses, prototyping; MicroPython / CircuitPython on chip |
| **Rust** *(user-circled)* | `no_std`, embedded-hal, Embassy (async), RTIC (interrupt-driven); growing fast in safety-critical |

### Niche / specialty
| Language | Use |
|----------|-----|
| Ada / SPARK | High-assurance avionics, defense |
| Go (TinyGo) | Constrained Go for microcontrollers (low adoption but pleasant) |
| JavaScript (Espruino / Moddable XS) | JS on MCUs |
| Lua (NodeMCU) | Light scripting on ESP-class |
| Forth | Open Firmware, niche embedded |

### Embedded Python — the ecosystem
- **MicroPython** — full Python 3 subset on MCUs (ESP32, RP2040, STM32, nRF)
- **CircuitPython** — Adafruit fork; focus on beginners + hardware libs
- **Pyodide** (in WASM) — not embedded but adjacent
- **paho-mqtt, pymodbus, pyserial, python-can** — host-side embedded libs
- **pyOCD** — Python-based debugger / probe driver
- **west** — Zephyr's meta-tool, written in Python

### Embedded Rust — the ecosystem
- **`embedded-hal`** — trait set for portable HALs
- **`cortex-m` / `cortex-m-rt`** — ARM Cortex-M runtime
- **`riscv` / `riscv-rt`** — RISC-V runtime
- **`probe-rs`** — Rust-native debugger + probe driver (alt to openocd)
- **`defmt`** — efficient `printf`-style logging
- **Embassy** — async runtime for embedded
- **RTIC** — interrupt-driven concurrency framework
- **Tock OS** — Rust embedded OS
- **`embedded-hal-async`** — async traits
- **`smoltcp`** — Rust TCP/IP stack

### Toolchains
- `arm-none-eabi-gcc`, `riscv64-unknown-elf-gcc`, `xtensa-esp32-elf-gcc` (vendor cross-tools)
- `clang --target=arm-none-eabi-` (LLVM cross)
- `rustc` with `thumbv7em-none-eabihf`, `riscv32imac-unknown-none-elf`, etc. targets
- Vendor IDEs: STM32CubeIDE, NXP MCUXpresso, IAR Embedded Workbench, Keil µVision, Microchip MPLAB X

### Build systems for embedded
- **Make** — universal
- **CMake** — modern cross-platform; vendor SDKs (ESP-IDF, Zephyr west) often wrap it
- **Bazel / Buck2** — large multi-target shops
- **PlatformIO** — high-level wrapper around vendor toolchains
- **Cargo + cargo-binutils + cargo-flash** — Rust embedded

### Cross-link
- Lower assembly notes → [CPU › Languages](../02_CPU/README.md#languages)
- Kernel C dialect → [OS Kernel › Languages](../05_OS_Kernel/README.md#languages)
- Driver C → [Device Drivers › Languages](../04_Device_Drivers/README.md#languages)

---

## Manual Pages

### What is in this section

```text
  Embedded tooling: compilers, flashers, debuggers, RTOS, sim, testing.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  embedded_tools.md (openocd · probe-rs · esptool · mpremote · minicom)│
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── cross-compile & flash ─────────────────────────────────────────────┐
  │  arm-none-eabi-gcc · riscv64-unknown-elf-gcc · xtensa-esp32-elf-gcc  │
  │  st-flash · openocd · pyocd · esptool.py · dfu-util · picotool       │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── debug, RTOS, sim & test ───────────────────────────────────────────┐
  │  gdb / arm-none-eabi-gdb · minicom / picocom / tio · PulseView       │
  │  west (Zephyr) · idf.py (ESP) · qemu-system-* · Renode · Wokwi      │
  │  Unity/CMock · GoogleTest · cppcheck · clang-tidy                    │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Embedded tools | [Embedded Systems Tools Reference](embedded_tools.md) — openocd, probe-rs, esptool, mpremote, minicom |

---

### Cross-compilers
| Tool | Targets |
|------|---------|
| `arm-none-eabi-gcc` | ARM Cortex-M/R bare-metal |
| `arm-linux-gnueabihf-gcc` | ARM Cortex-A Linux |
| `aarch64-linux-gnu-gcc` | 64-bit ARM Linux |
| `riscv64-unknown-elf-gcc` | RISC-V bare-metal |
| `xtensa-esp32-elf-gcc` | ESP32 (Xtensa) |
| `rustup target add thumbv7em-none-eabihf` | Rust ARM Cortex-M4F |
| `clang --target=...` | LLVM cross |

### Flashing / programming
| Tool | Probe |
|------|-------|
| `st-flash`, `st-info` | ST-Link |
| `openocd` | Universal (J-Link, ST-Link, CMSIS-DAP, FT2232) |
| `pyocd` | Python alt to OpenOCD |
| `probe-rs`, `cargo flash`, `cargo embed` | Rust-native |
| `JLinkExe`, `JLinkGDBServer` | Segger J-Link |
| `dfu-util` | USB-DFU |
| `esptool.py`, `idf.py` | Espressif |
| `bossac` | Atmel SAM |
| `nrfjprog`, `nrfutil` | Nordic |
| `picotool` | Raspberry Pi RP2040 |

### Debugging
| Tool | Purpose |
|------|---------|
| `gdb` / `arm-none-eabi-gdb` | Source-level debug |
| `gdb-multiarch` | Multi-arch GDB |
| `lldb` | LLVM debugger |
| `screen /dev/tty.usbserial-XXX 115200` | Serial console (macOS) |
| `minicom` / `picocom` | Serial console (Linux/macOS) |
| `tio` | Modern serial terminal |
| `pyserial-miniterm` (`python -m serial.tools.miniterm`) | Python serial |
| Logic analyzer SW: PulseView (`sigrok-cli`), Saleae Logic, DSView | Capture & decode |

### RTOS / OS
| Tool | Purpose |
|------|---------|
| `west` | Zephyr meta-tool |
| `idf.py` | ESP-IDF build/flash/monitor |
| `cargo embed` | Rust+probe-rs flash+console |
| `runqemu` | Yocto QEMU launcher |
| `bitbake`, `devtool` | Yocto/OE recipe build |
| `buildroot` (`make menuconfig`) | Buildroot |

### Simulation / emulation
| Tool | Purpose |
|------|---------|
| `qemu-system-*` | CPU/board emulation |
| Renode | Multi-MCU sim (Antmicro) |
| Wokwi (web) | Online ESP/Arduino sim |
| Tinkercad Circuits | Beginner circuit + Arduino sim |
| ngspice/LTspice (cross-link [00b/00c]) | Analog/mixed sim |

### Testing
| Tool | Purpose |
|------|---------|
| Unity / CMock | C unit test |
| Ceedling | Build glue for Unity/CMock |
| GoogleTest / GoogleMock | C++ unit test |
| Catch2 | Modern C++ test |
| pytest + pyserial / pyvisa | Host-side hardware tests |
| robot framework | Acceptance tests |
| LDRA, Polyspace, Coverity | Static analysis (commercial) |
| cppcheck, clang-tidy, scan-build | Static analysis (open) |

### Build / dev
| Tool | Purpose |
|------|---------|
| `make` / `cmake --build` | Build |
| `ninja` | Faster build backend |
| `ccache` | Cache compiled objects |
| `bear` | Generate `compile_commands.json` |
| `clangd` (LSP) | Editor IntelliSense |

---

## Topics

### What is in this section

```text
  Embedded topics indexed against the Embedded Systems Engineering Roadmap.

  ┌─── OS & RTOS ─────────────────────────────────────────────────────────┐
  │  Embedded Linux (U-Boot/Buildroot/Yocto) · FreeRTOS · Zephyr         │
  │  tasks/ISR/mutex/queue · schedulers · memory/MPU · tickless idle      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── MCU peripherals & build ───────────────────────────────────────────┐
  │  GPIO/ADC/DAC/timers/PWM/watchdog/interrupts/DMA/clocks/power        │
  │  bootloader/DFU · linker scripts · GCC sections · JTAG/GDB/OpenOCD   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── advanced topics ───────────────────────────────────────────────────┐
  │  standards: MISRA C · IEC 61508 · ISO 26262 · DO-178C · IEC 62304   │
  │  embedded security · LVGL/GUI · IoT (OTA) · Edge AI · AUTOSAR        │
  │  sensors/actuators · DSP (FIR/IIR/FFT) · PID control theory          │
  └──────────────────────────────────────────────────────────────────────┘
```

Indexed against the *Embedded Systems Engineering Roadmap*, the same source
the lessons ladder follows.

### Embedded Linux specifics
- **Kernel** — pre-built vs custom build; defconfig per board
- **Device drivers** — char/block/net/platform → [04](../04_Device_Drivers/)
- **U-Boot** — env, scripts, FIT, falcon mode
- **Buildroot vs Yocto vs OpenEmbedded** — when to pick which
- **Threading & parallelism** — pthreads, futexes, RT priorities
- **IPC** — pipes, sockets, shm, msgq, DBus
- **Qt for embedded** — XCB-less, EGLFS

### RTOS specifics
- **Concepts** — task, ISR, mutex, semaphore, queue, event flag, software timer
- **Schedulers** — preemptive priority, round-robin within priority, EDF
- **Memory** — heap_1..heap_5 (FreeRTOS), pool allocators, MPU regions
- **FreeRTOS** — tickless, stream/message buffers, idle hook
- **Zephyr** — kernel objects, devicetree-driven init
- **RT-Thread, NuttX, ThreadX (now Eclipse), µC/OS, QNX, VxWorks, INTEGRITY** — survey
- **Verified kernels** — seL4 (cross-link [05](../05_OS_Kernel/))

### Microcontroller peripherals
- **GPIO** — modes (PP/OD), pull-ups, ESD
- **ADC** — sampling time, reference, common-mode range
- **DAC** — output impedance, buffering
- **Timers** — basic, advanced (PWM, dead-time), input capture, output compare
- **PWM** — center- vs edge-aligned
- **Watchdog** — independent (IWDG) vs window (WWDG)
- **Interrupts** — vector table, NVIC, priority groups, nested
- **DMA** — circular, double-buffered, M2M/M2P/P2M
- **Clock management** — HSI/HSE/PLL/LSE; tree configuration
- **Power management** — Run/Sleep/Stop/Standby; wake sources
- **Bootloader/DFU** — A/B partitions, secure boot, anti-rollback

### Build system
- **Compilers/GCC** — link sections, `.text`, `.data`, `.bss`, `.rodata`, custom sections
- **Linker scripts** — MEMORY regions, SECTIONS, `KEEP()`, `__attribute__((section(...)))`
- **Make / CMake** — toolchain files, board configs
- **Bash scripting** — flash/log/test harness
- **Docker** — reproducible toolchains

### Debugging
- **JTAG / SWD / cJTAG** — pinout, protocol layer
- **GDB** — `target remote`, breakpoints, watchpoints, ITM trace
- **OpenOCD** — TCL-driven, configs per probe + target
- **Tracing** — ITM/SWO, ETM, ETB, OS-aware trace (Tracealyzer, SystemView)

### Memory & file systems
- **NOR vs NAND flash**, **eMMC**, **SD**, **SPI flash**
- **NVRAM / FRAM** for state
- **File systems** — LittleFS, SPIFFS, FATFS, ext4, JFFS2, UBIFS
- **Wear leveling**, **bad-block management**

### Hardware sim/emulation
- **QEMU** — system mode for SoCs
- **Renode** — multi-MCU + peripherals + network co-simulation
- **Wokwi / Tinkercad** — beginner
- **HIL** — Speedgoat, NI VeriStand, custom rigs

### Standards / certifications
- **MISRA C** — coding rules for safety
- **IEC 61508** — functional safety (general)
- **ISO 26262** (automotive)
- **DO-178C** (aviation software)
- **DO-254** (aviation hardware)
- **IEC 62304** (medical software)
- **EN 50128** (rail software)

### Embedded security (cross-link)
- Secure boot, anti-rollback, key provisioning, fuses
- TPM 2.0 / TEE / Arm TrustZone / RISC-V Keystone
- Side channels (cross-link [02](../02_CPU/README.md#topics), [14](../14_Security/README.md#topics))
- BYOVD, BMC exploits → [14](../14_Security/README.md#topics)

### Embedded GUI
- LVGL, TouchGFX, Qt for MCUs, Slint, NemaGFX, EmWin
- DIY: framebuffer + simple widgets

### IoT
- Provisioning (BLE, Wi-Fi onboarding)
- Cloud — AWS IoT Core, Azure IoT Hub, GCP IoT Core (deprecated → 3rd party)
- Edge↔cloud — MQTT, CoAP, AMQP, OPC UA
- Fleet management — OTA, telemetry, remote debug

### Edge AI
- TFLite Micro, CMSIS-NN, microTVM, executorch, X-CUBE-AI
- Quantization (INT8/INT4), pruning, knowledge distillation
- HW: Arm Cortex-M with helium, Ethos-U NPU, ESP32-S3 (vector ext), Coral Edge TPU

### AUTOSAR
- Classic Platform vs Adaptive Platform
- RTE (Runtime Environment), BSW (Basic Software), SWC (Software Components)
- COM stack, Diagnostic Communication Manager (DCM)

### Sensors & actuators
- IMU (accel + gyro + mag), pressure, temperature/humidity, light, distance (ToF, ultrasonic, lidar)
- Motors — DC, BLDC (FOC), PMSM, stepper, servo
- Actuators — solenoids, relays, valves

### DSP
- FIR / IIR filters, FFT, windowing
- Fixed-point vs floating-point on MCU
- CMSIS-DSP library

### Control theory
- PID — tuning (Ziegler-Nichols, manual)
- State-space, Kalman filter
- Model Predictive Control (MPC)

### Cross-link
- All the layer-by-layer details live in [00–08](../00_Physics/) of this codex
- Industrial bus protocols → [19_Industrial_Protocols](../19_Industrial_Protocols/)
- Wireless → [16_RF_Wireless](../16_RF_Wireless/)

---

## Protocols

### What is in this section

```text
  Protocol map for embedded — where each one lives in the codex.

  ┌─── on-chip / on-board buses → [01_Circuit_Board] ────────────────────┐
  │  UART (RS-232/422/485) · I²C · SPI · USB · PCIe                     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── wireless → [16_RF_Wireless] ──────────────────────────────────────┐
  │  BT/BLE · Wi-Fi · LoRa/LoRaWAN · Zigbee · Thread · Matter · UWB     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── industrial & automotive → [19_Industrial_Protocols] ──────────────┐
  │  Modbus RTU/TCP · PROFINET · EtherCAT · CAN/CAN-FD · LIN · FlexRay  │
  │  OPC UA · SOME/IP · UDS (ISO 14229) · J1939 · AUTOSAR PDU           │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── debug → [01_Circuit_Board] + [02_CPU] ─────────────────────────────┐
  │  JTAG (IEEE 1149.1) · SWD · SWO/ITM · ETM/ETB                       │
  └──────────────────────────────────────────────────────────────────────┘
```

> On-chip and on-board buses: I²C, SPI, UART, CAN.

### Dedicated Protocol References

| File | Covers |
|------|--------|
| [I2C and SPI](i2c_spi.md) | Timing, addressing, modes, QSPI |
| [UART](uart.md) | Framing, baud rate, RS-232/422/485 |

### Low-speed

| Protocol | Owning codex layer |
|----------|--------------------|
| UART (RS-232 / RS-485 / TTL serial) | [01](../01_Circuit_Board/README.md#protocols), [10_DataLink](../10_Network_DataLink/README.md#protocols) |
| I²C | [01_Circuit_Board](../01_Circuit_Board/README.md#protocols) |
| SPI | [01_Circuit_Board](../01_Circuit_Board/README.md#protocols) |

### High-speed
| Protocol | Owning codex layer |
|----------|--------------------|
| Ethernet (PHY) | [09_Network_Physical](../09_Network_Physical/README.md#protocols) |
| Ethernet (MAC) | [10_Network_DataLink](../10_Network_DataLink/README.md#protocols) |
| USB | [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols) |
| PCIe | [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols) |

### Wireless
| Protocol | Owning codex layer |
|----------|--------------------|
| Bluetooth / BLE | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |
| Wi-Fi (802.11) | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |
| LoRa / LoRaWAN | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |
| Zigbee (802.15.4) | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |
| Thread (IPv6 over 802.15.4) | [16](../16_RF_Wireless/README.md#protocols) + [11_Internet](../11_Network_Internet/README.md#protocols) |
| Matter (over Thread / Wi-Fi / Ethernet) | [User Applications › Protocols](../08_User_Applications/README.md#protocols) |
| UWB | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |

### Industrial (own layer — most relevant to embedded)
| Protocol | Owning codex layer |
|----------|--------------------|
| Modbus RTU / TCP | [19_Industrial_Protocols](../19_Industrial_Protocols/README.md#protocols) |
| Profinet | [19](../19_Industrial_Protocols/README.md#protocols) |
| EtherCAT | [19](../19_Industrial_Protocols/README.md#protocols) |
| EtherNet/IP, CC-Link IE, Sercos III, POWERLINK | [19](../19_Industrial_Protocols/README.md#protocols) |
| MQTT (3.1.1 / 5.0) | [13_Network_Application](../13_Network_Application/README.md#protocols) |
| CoAP | [13_Network_Application](../13_Network_Application/README.md#protocols) |
| OPC UA | [19](../19_Industrial_Protocols/README.md#protocols) |
| HART / WirelessHART | [19](../19_Industrial_Protocols/README.md#protocols) |
| BACnet | [19](../19_Industrial_Protocols/README.md#protocols) |

### Automotive (in 19)
| Protocol | Owning codex layer |
|----------|--------------------|
| CAN / CAN-FD / CAN-XL | [19](../19_Industrial_Protocols/README.md#protocols) |
| LIN | [19](../19_Industrial_Protocols/README.md#protocols) |
| FlexRay | [19](../19_Industrial_Protocols/README.md#protocols) |
| MOST | [19](../19_Industrial_Protocols/README.md#protocols) |
| Automotive Ethernet (100BASE-T1, 1000BASE-T1) | [09](../09_Network_Physical/README.md#protocols) |
| AUTOSAR PDU | [19](../19_Industrial_Protocols/README.md#protocols) |
| SOME/IP | [19](../19_Industrial_Protocols/README.md#protocols) |
| UDS (ISO 14229), KWP2000, J1939 | [19](../19_Industrial_Protocols/README.md#protocols) |

### Network
| Protocol | Owning codex layer |
|----------|--------------------|
| TCP, UDP, QUIC | [12_Network_Transport](../12_Network_Transport/README.md#protocols) |
| IP, ICMP, IPv6 | [11_Network_Internet](../11_Network_Internet/README.md#protocols) |

### Cellular
| Protocol | Owning codex layer |
|----------|--------------------|
| GSM / LTE | [16_RF_Wireless](../16_RF_Wireless/README.md#protocols) |
| 5G NR | [16](../16_RF_Wireless/README.md#protocols) |
| LTE-M, NB-IoT | [16](../16_RF_Wireless/README.md#protocols) |

### Debug
| Protocol | Owning codex layer |
|----------|--------------------|
| JTAG (IEEE 1149.1) | [01](../01_Circuit_Board/README.md#protocols) + [00d](../00d_Digital_Circuits/README.md#protocols) |
| SWD (ARM 2-wire JTAG) | [01](../01_Circuit_Board/README.md#protocols) |
| SWO / ITM | [02_CPU](../02_CPU/README.md#protocols) |
| ETM / ETB | [02_CPU](../02_CPU/) |

### See also
- The mega "logic analyzer decoder" list (DSLogic / sigrok) → [Embedded Bus Protocols](../01_Circuit_Board/embedded_bus_protocols_lookup.md)
