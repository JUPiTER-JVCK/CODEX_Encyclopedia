# Firmware / BIOS — Languages

## What is in this section

```text
  Two groups, and they answer different questions. The first is what the
  firmware itself is written in; the second is what runs on a
  microcontroller once the firmware hands over.

  ┌─ writing the firmware ─────────────────────────────────────────────┐
  │                                                                    │
  │   C (freestanding)        UEFI · coreboot · U-Boot                 │
  │     └─ EDK II's dialect   Tianocore                                │
  │   Assembly                reset vector, mode switches, early init  │
  │   Rust (no_std)           oreboot · RTIC · Embassy                 │
  │   Forth                   Open Firmware — SPARC, PPC Macs, OLPC    │
  │                                                                    │
  │   and two that describe hardware rather than drive it:             │
  │   ASL  ──▶ iasl           ACPI table source                        │
  │   DTS  ──▶ dtc            ARM and RISC-V hardware description      │
  │                                                                    │
  │   Python runs on the host, not the target: build glue, signing,    │
  │   flashing helpers                                                 │
  └────────────────────────────────────────────────────────────────────┘

  ┌─ running on the microcontroller ───────────────────────────────────┐
  │   C / C++      Zephyr · FreeRTOS · ThreadX · NuttX                 │
  │   Rust         Embassy · RTIC · Tock OS                            │
  │   Ada / SPARK  high-assurance                                      │
  │   MicroPython · CircuitPython · TinyGo                             │
  └────────────────────────────────────────────────────────────────────┘

  Assembly below this layer is 02 CPU; kernel C above it is 05.
```

| Language | Type | Use at this layer | Toolchain |
|----------|------|-------------------|-----------|
| C (freestanding) | Systems | The dominant language: UEFI, coreboot, U-Boot | `gcc -ffreestanding`, Clang |
| Assembly | Low-level | Reset vector, mode switches, early init | GNU `as`, NASM |
| ACPI Source Language (ASL) | DSL | ACPI table source | `iasl` |
| Device Tree Source (DTS) | DSL | ARM/RISC-V hardware description | `dtc` |
| EDK II's C dialect | C subset | Tianocore UEFI development | EDK II build tools |
| Rust (no_std) | Systems | oreboot, embedded firmware (RTIC, Embassy) | rustc + cortex-m crates |
| Forth | Stack lang | Open Firmware (SPARC, PowerPC Macs, OLPC) | Open Firmware |
| Python (host-side) | Scripting | Build glue, signing, flashing helpers | CPython |

## Embedded RTOS languages
- **C / C++** — Zephyr, FreeRTOS, ThreadX, NuttX
- **Rust** — Embassy, RTIC, Tock OS
- **Ada / SPARK** — high-assurance embedded
- **MicroPython / CircuitPython** — high-level on microcontrollers
- **TinyGo** — Go for microcontrollers

## Related
- Lower: assembly → [02_CPU/languages](../../02_CPU/languages/INDEX.md)
- Upper: kernel C → [05_OS_Kernel/languages](../../05_OS_Kernel/languages/INDEX.md)
