# CODEX Encyclopedia

> A layered reference covering the full computing stack from **physics** to
> **applications**, plus cross-cutting domains (Security, AI/ML, RF,
> Algorithms, Embedded Systems, Industrial Protocols) — and two apps for
> reading and learning it.

**Version 3.6** · see [CHANGELOG.md](CHANGELOG.md)

## How it is organized

**One folder and one page per layer.** 23 layers in four bands, each a
folder at the top of the repository. Open a layer and its page has
everything: an overview, an *In this layer* table linking every note, then
the layer's six sections (References, Lessons, Languages, Manual Pages,
Topics, Protocols) on the same page. Every note is one click from its layer
page, and two from here.

```text
                                          ┌─ 14 Security
 08 User Applications ◄──── 17 Algorithms │  15 AI / ML
 07 Runtime Environment                   │  16 RF / Wireless
 06 System Libraries                      │  18 Embedded Systems
 05 OS Kernel ◄──────── 13 Network App    │  19 Industrial Protocols
 04 Device Drivers      12 Transport      └─ (cross-cutting: they
 03 Firmware / BIOS     11 Internet          intersect the stack at
 02 CPU                 10 Data Link         many points at once)
 01 Circuit Board ───── 09 Physical
 00d Digital Circuits
 00c Analog Circuits
 00b Devices
 00 Physics
```

[LAYERS.md](LAYERS.md) has the same map as one table, with the languages,
interfaces and an example flow for each layer.

| Component | What it is |
|-----------|-----------|
| **The codex** | 105 notes on 23 layer pages — the reference itself, in markdown |
| **[Codex_macOS](Codex_macOS/README.md)** | A native SwiftUI reader for the codex |
| **[Codex_LMS](Codex_LMS/README.md)** | CORE — a seven-phase interactive course (React + Vite) |

The codex is a **reference**, organized by where a thing sits in the stack.
CORE is a **course**, organized by the order you'd learn things in.

## Contents

### Foundations

*The physics and circuits everything else is built on.*

| # | Layer | Notes |
|---|-------|-------|
| 00 | **[Physics](00_Physics/)** | [Interactive labs](00_Physics/physics_labs.md) |
| 00b | **[Devices](00b_Devices/)** | [Interactive labs](00b_Devices/device_labs.md) · [MOSFET Cross-Section and Operation](00b_Devices/mosfet_cross_section.md) |
| 00c | **[Analog Circuits](00c_Analog_Circuits/)** | [Interactive labs](00c_Analog_Circuits/analog_labs.md) · [Op-Amp Configurations](00c_Analog_Circuits/opamp_configurations.md) |
| 00d | **[Digital Circuits](00d_Digital_Circuits/)** | [Interactive labs](00d_Digital_Circuits/digital_labs.md) · [Logic Gates Explained](00d_Digital_Circuits/logic_gates.md) |

### Compute stack

*From the circuit board up to the application.*

| # | Layer | Notes |
|---|-------|-------|
| 01 | **[Circuit Board](01_Circuit_Board/)** | [Interactive labs](01_Circuit_Board/pcb_labs.md) · [Embedded Bus Protocols](01_Circuit_Board/embedded_bus_protocols_lookup.md) |
| 02 | **[CPU](02_CPU/)** | [Interactive labs](02_CPU/cpu_labs.md) · [AArch64 (ARM64) Assembly](02_CPU/arm64_asm.md) · [RISC-V Assembly](02_CPU/riscv_asm.md) · [x86-64 Assembly](02_CPU/x86_64_asm.md) · [CPU Inspection Commands](02_CPU/cpu_inspection.md) · [CPU Pipeline](02_CPU/cpu_pipeline.md) |
| 03 | **[Firmware / BIOS](03_Firmware_BIOS/)** | [Interactive labs](03_Firmware_BIOS/firmware_labs.md) · [Firmware Management Commands](03_Firmware_BIOS/firmware_tools.md) · [UEFI Boot Flow](03_Firmware_BIOS/uefi_boot_flow.md) |
| 04 | **[Device Drivers](04_Device_Drivers/)** | [Interactive labs](04_Device_Drivers/driver_labs.md) · [Device & Driver Management Commands](04_Device_Drivers/device_commands.md) · [Linux Driver Model](04_Device_Drivers/driver_model.md) |
| 05 | **[OS Kernel](05_OS_Kernel/)** | [Interactive labs](05_OS_Kernel/kernel_labs.md) · [Filesystem Commands](05_OS_Kernel/filesystem_commands.md) · [Memory Management Commands](05_OS_Kernel/memory_commands.md) · [Process Management Commands](05_OS_Kernel/process_commands.md) · [Tracing & Debugging Commands](05_OS_Kernel/tracing_commands.md) · [Virtual Memory](05_OS_Kernel/virtual_memory.md) · [POSIX Syscalls](05_OS_Kernel/posix_syscalls.md) |
| 06 | **[System Libraries](06_System_Libraries/)** | [Interactive labs](06_System_Libraries/library_labs.md) · [Debugging Commands](06_System_Libraries/debug_commands.md) · [Linker & Binary Inspection Commands](06_System_Libraries/linker_commands.md) · [Libc Variants](06_System_Libraries/libc_variants.md) |
| 07 | **[Runtime Environment](07_Runtime_Environment/)** | [Interactive labs](07_Runtime_Environment/runtime_labs.md) · [Container Management Commands](07_Runtime_Environment/container_commands.md) · [Virtual Machine Management Commands](07_Runtime_Environment/vm_commands.md) · [Container Internals](07_Runtime_Environment/container_internals.md) · [OCI Runtime](07_Runtime_Environment/oci_runtime.md) |
| 08 | **[User Applications](08_User_Applications/)** | [Interactive labs](08_User_Applications/app_labs.md) · [Bash / Shell](08_User_Applications/bash.md) · [C](08_User_Applications/c.md) · [C++](08_User_Applications/cpp.md) · [C#](08_User_Applications/csharp.md) · [Go](08_User_Applications/go.md) · [Java](08_User_Applications/java.md) · [JavaScript](08_User_Applications/javascript.md) · [Kotlin](08_User_Applications/kotlin.md) · [Lua](08_User_Applications/lua.md) · [Python](08_User_Applications/python.md) · [Ruby](08_User_Applications/ruby.md) · [Rust](08_User_Applications/rust.md) · [SQL](08_User_Applications/sql.md) · [Swift](08_User_Applications/swift.md) · [TypeScript](08_User_Applications/typescript.md) · [Network Tools](08_User_Applications/network_tools.md) · [Package Manager Commands](08_User_Applications/package_managers.md) · [Shell & Terminal Multiplexer Commands](08_User_Applications/shell_commands.md) · [Text Processing & File Search Commands](08_User_Applications/text_processing.md) |

### Network

*The OSI-aligned stack, physical medium to application protocol.*

| # | Layer | Notes |
|---|-------|-------|
| 09 | **[Network Physical (OSI L1)](09_Network_Physical/)** | [Interactive labs](09_Network_Physical/physical_labs.md) |
| 10 | **[Network Data Link (OSI L2)](10_Network_DataLink/)** | [Interactive labs](10_Network_DataLink/datalink_labs.md) · [Data Link Layer Commands](10_Network_DataLink/datalink_commands.md) · [Ethernet](10_Network_DataLink/ethernet.md) |
| 11 | **[Network Internet (OSI L3)](11_Network_Internet/)** | [Interactive labs](11_Network_Internet/internet_labs.md) · [Internet Layer Commands](11_Network_Internet/ip_commands.md) · [The OSI Model](11_Network_Internet/osi_model.md) · [BGP](11_Network_Internet/bgp.md) · [IPv4 / IPv6](11_Network_Internet/ipv4_ipv6.md) · [OSPF](11_Network_Internet/ospf.md) |
| 12 | **[Network Transport (OSI L4)](12_Network_Transport/)** | [Interactive labs](12_Network_Transport/transport_labs.md) · [Transport Layer Tools](12_Network_Transport/transport_tools.md) · [QUIC](12_Network_Transport/quic.md) · [TCP](12_Network_Transport/tcp.md) · [UDP](12_Network_Transport/udp.md) |
| 13 | **[Network Application (OSI L5–L7)](13_Network_Application/)** | [Interactive labs](13_Network_Application/application_labs.md) · [Application Layer Protocol Tools](13_Network_Application/app_protocol_tools.md) · [DHCP](13_Network_Application/dhcp.md) · [DNS](13_Network_Application/dns.md) · [HTTP](13_Network_Application/http.md) · [MQTT](13_Network_Application/mqtt.md) · [OAuth 2.0 / 2.1](13_Network_Application/oauth2.md) · [SSH](13_Network_Application/ssh.md) · [TLS](13_Network_Application/tls.md) |

### Cross-cutting

*Domains that intersect many layers at once.*

| # | Layer | Notes |
|---|-------|-------|
| 14 | **[Security](14_Security/)** | [Interactive labs](14_Security/security_labs.md) · [Security Tools Reference](14_Security/security_tools.md) · [IPsec](14_Security/tls_ipsec.md) |
| 15 | **[AI / ML](15_AI_ML/)** | [Interactive labs](15_AI_ML/ml_labs.md) · [AI/ML Tools Reference](15_AI_ML/ml_tools.md) · [Transformer Architecture](15_AI_ML/transformer_architecture.md) |
| 16 | **[RF / Wireless](16_RF_Wireless/)** | [Interactive labs](16_RF_Wireless/rf_labs.md) · [RF & Wireless Tools Reference](16_RF_Wireless/rf_tools.md) · [Bluetooth & BLE](16_RF_Wireless/bluetooth.md) · [LoRaWAN](16_RF_Wireless/lorawan.md) · [Wi-Fi](16_RF_Wireless/wifi.md) |
| 17 | **[Algorithms & Data Structures](17_Algorithms_DSA/)** | [Interactive labs](17_Algorithms_DSA/dsa_labs.md) · [100 Must Do LeetCode Problems](17_Algorithms_DSA/100_must_do.md) · [Canonical 100-problem study list](17_Algorithms_DSA/canonical_lists.md) |
| 18 | **[Embedded Systems](18_Embedded_Systems/)** | [Roadmap book (PDF placeholder)](18_Embedded_Systems/embedded_systems_full_roadmap_book.pdf) · [Interactive labs](18_Embedded_Systems/embedded_labs.md) · [Embedded C](18_Embedded_Systems/embedded_c.md) · [Embedded Python (MicroPython / CircuitPython)](18_Embedded_Systems/embedded_python.md) · [Embedded Rust](18_Embedded_Systems/embedded_rust.md) · [Embedded Systems Tools Reference](18_Embedded_Systems/embedded_tools.md) · [I2C and SPI](18_Embedded_Systems/i2c_spi.md) · [UART](18_Embedded_Systems/uart.md) |
| 19 | **[Industrial & Automotive Protocols](19_Industrial_Protocols/)** | [Interactive labs](19_Industrial_Protocols/industrial_labs.md) · [Modbus](19_Industrial_Protocols/modbus.md) · [OPC UA](19_Industrial_Protocols/opc_ua.md) |

### Good places to start

- [100 must-do interview problems](17_Algorithms_DSA/100_must_do.md),
  mapped to LeetCode numbers
- [Logic gates](00d_Digital_Circuits/logic_gates.md) — full truth-table reference
- [Embedded bus protocols](01_Circuit_Board/embedded_bus_protocols_lookup.md)
  — ~150 DSLogic/sigrok decoders mapped to the layers that own them
- [The OSI model](11_Network_Internet/osi_model.md) — how the network layers fit
- [Virtual memory](05_OS_Kernel/virtual_memory.md) and
  [the CPU pipeline](02_CPU/cpu_pipeline.md) — the two notes most others lean on

## The apps

**macOS reader.** Open `Codex_macOS/` and double-click
`Install Codex.command`; it builds the reader and puts `Codex.app` in
`/Applications`. Gatekeeper will refuse the first launch (right-click →
**Open**, once) and the copy asks for your password. Requires macOS 13+ and
the Xcode command-line tools. Terminal and Xcode routes:
[Codex_macOS/README.md](Codex_macOS/README.md#install-it).

**CORE.** Needs Node 20.19+ or 22.12+. Seven phases, 43 topics, 222
chapters, and something to manipulate in every topic — logic gates, a subnet
calculator, a CPU cycle stepper, the JS event loop and more. Progress
persists to `localStorage`. Details: [Codex_LMS/README.md](Codex_LMS/README.md).

```sh
cd Codex_LMS && npm install && npm run dev
```

## Repository layout

```text
CODEX_Encyclopedia/
├── README.md              ← this page: contents of the whole codex
├── LAYERS.md              ← master layer table
├── STRUCTURE.md           ← conventions: naming, frontmatter, cross-links
├── CONTRIBUTING.md        ← how to check your change before a PR
├── CHANGELOG.md · SECURITY.md · THIRD_PARTY.md
├── LICENSE (MIT) · LICENSE-docs (CC BY-SA 4.0)
├── _assets/               ← images, and why there are none
│
├── 00_Physics/            ← one folder per layer, 00 through 19:
│   ├── README.md          ←   the layer page — every section, every note linked
│   └── physics_labs.md    ←   the layer's notes, side by side
├── 00b_Devices/  …  19_Industrial_Protocols/
│
├── Codex_macOS/           ← SwiftUI reader source
├── Codex_LMS/             ← React curriculum source
└── tools/                 ← audits: link, table, layer, diagram, stats, palette
```

Anything added at the root that isn't a layer must also be registered in
`CodexTree.nonContentDirs`, or the macOS app treats it as one. See
[STRUCTURE.md](STRUCTURE.md#repository-layout) for the conventions in full.

## Licensing

| What | License | File |
|------|---------|------|
| Application source, tooling and configuration — `Codex_macOS/`, `Codex_LMS/`, `tools/`, `.github/` | MIT | [LICENSE](LICENSE) |
| **Everything else authored here** — the codex, and every document around it | CC BY-SA 4.0 | [LICENSE-docs](LICENSE-docs) |

The second row is a default rather than a list, so a new document cannot
fall outside both. ShareAlike because `18_Embedded_Systems/` draws on Meysam
Parvizi's CC BY-SA 4.0 Embedded Systems Engineering Roadmap.

**One file is third-party** and licensed by neither:
`18_Embedded_Systems/embedded_systems_full_roadmap_book.pdf`, currently a
generated placeholder rather than Parvizi's book (see *Known gaps*).
Anything third-party added later belongs on that list and in
[THIRD_PARTY.md](THIRD_PARTY.md). If you hold the rights to anything here
and want it removed, open an issue.

## Known gaps

- **The Python TUI is not in this repository.** Older changelog entries
  describe it; use the macOS app or any markdown reader.
- **No images.** Every illustration is drawn in text; see
  [`_assets/README.md`](_assets/README.md).
- **`embedded_systems_full_roadmap_book.pdf` is a placeholder** — a 10-page
  generated stub. The real source is
  [github.com/m3y54m/Embedded-Engineering-Roadmap](https://github.com/m3y54m/Embedded-Engineering-Roadmap)
  (CC BY-SA 4.0).
- **Most of the macOS app's UI is unverified on a real Mac.** CI compiles
  it on every PR, but nothing automated exercises the screens; the open
  questions are in [Codex_macOS/README.md](Codex_macOS/README.md#known-issues).

## Verification

Three GitHub Actions workflows run on every pull request and every push to
`main`, with no path filters:

| Workflow | Catches |
|----------|---------|
| `swift.yml` | The macOS app not compiling, debug or release |
| `docs.yml` | Broken links and anchors, missing H1s, malformed tables, layer pages missing a section or a note, unfenced or over-wide diagrams, stale numbers on this page, palette drift |
| `lms.yml` | CORE not building, `npm audit` findings, or losing progress on reload |

How to run them locally is in [CONTRIBUTING.md](CONTRIBUTING.md).
`tools/stats_audit.py` checks the numbers below against the tree, and treats
a claim it can no longer find as a fault, so rewording this list turns the
build red rather than quietly retiring the check.

Currently:

- 140 markdown files
- 1124 internal links, 0 broken
- 137 files carry a diagram across the repository. The diagram audit
  requires a diagram in 134 files, and 134 of those carry it; the
  other drawings are in the apps' own documentation, which the audit does
  not hold to anything; the remaining 0 are listed in
  `tools/diagram_backlog.txt`. Every diagram is fenced, tagged and within 90
  columns, and every layer page shows where its layer sits
