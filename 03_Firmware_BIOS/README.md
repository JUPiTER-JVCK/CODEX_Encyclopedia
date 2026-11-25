# 03 — Firmware / BIOS

> The first software the CPU runs. Initializes RAM, enumerates buses, sets up
> the platform, and hands control to a bootloader and ultimately the OS.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  05  OS Kernel                               │
└───────────────────────┬──────────────────────┘
                        │  UEFI services, ACPI tables
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  03  Firmware / BIOS              ◀── here   ┃
┃      power-on · POST · boot · platform init  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  instruction set, microcode, MSRs
┌───────────────────────┴──────────────────────┐
│  02  CPU                                     │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Initializes hardware and loads the OS |
| Languages | Assembly, C (some Rust, e.g. oreboot) |
| Medium / Interface | Firmware routines, hardware I/O, UEFI services, ACPI |
| Example | Loads OS from disk via bootloader |
| Adjacent layers | ↓ [02_CPU](../02_CPU/), ↑ [05_OS_Kernel](../05_OS_Kernel/) |

## What lives here

- Legacy BIOS, UEFI, Open Firmware, coreboot, U-Boot
- Bootloaders: GRUB2, systemd-boot, Windows Boot Manager, iBoot, rEFInd
- Platform firmware: ME (Intel), PSP (AMD), BMC (IPMI/Redfish, OpenBMC)
- Embedded firmware: RTOS, bare-metal Cortex-M, ESP-IDF
- TPM 2.0 measured boot, Secure Boot chain
- ACPI tables, Device Tree Blobs (DTB)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | UEFI spec, coreboot docs, ACPI |
| [Lessons](#lessons) | [Interactive labs](firmware_labs.md) | from blink-an-LED to a UEFI app |
| [Languages](#languages) | — | freestanding C, asm, ACPI Source Language |
| [Manual Pages](#manual-pages) | [Firmware Management Commands](firmware_tools.md) | `efibootmgr`, `mokutil`, `bootctl`, `flashrom` |
| [Topics](#topics) | [UEFI Boot Flow](uefi_boot_flow.md) | boot flow, ACPI, measured boot, BMC |
| [Protocols](#protocols) | — | UEFI, ACPI, SMBIOS, ELF/PE boot, TPM |

## Cross-references

- Bootloader → kernel handoff → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)
- TPM & attestation → [Security › Topics](../14_Security/README.md#topics)
- IPMI/Redfish remote management → [Network Application › Protocols](../13_Network_Application/README.md#protocols)

---

## References

### What is in this section

```text
  Four reference types for this layer.

  ┌────────────────────────────────────────────────────────────────────────┐
  │                           specifications                               │
  │  UEFI · PI · Shell  │  ACPI  │  SMBIOS  │  TCG TPM 2.0               │
  │  Intel Boot Guard / Verified Boot  │  AMD PSP documentation           │
  └────────────────────────────────────────────────────────────────────────┘

  ┌────────────────────────────────────────────────────────────────────────┐
  │                       open implementations                             │
  │  coreboot  │  EDK II (TianoCore UEFI)  │  U-Boot (embedded)          │
  │  LinuxBoot · oreboot · heads (security-focused)  │  OpenBMC · u-bmc   │
  └────────────────────────────────────────────────────────────────────────┘

  ┌────────────────────────────────────────────────────────────────────────┐
  │                              books                                     │
  │  Beyond BIOS (Zimmer et al.)  │  Harnessing the UEFI Shell (Zimmer)   │
  │  Embedded Software for SoC — Jerraya & Wolf                           │
  └────────────────────────────────────────────────────────────────────────┘

  ┌────────────────────────────────────────────────────────────────────────┐
  │                              online                                    │
  │  osdev.org wiki  │  Phoronix (coreboot/UEFI ecosystem coverage)       │
  └────────────────────────────────────────────────────────────────────────┘
```

### Specifications
- **UEFI Specification** — `https://uefi.org/specifications` (UEFI + PI + Shell)
- **ACPI Specification** — UEFI Forum
- **SMBIOS Specification** — DMTF
- **TCG TPM 2.0 Library Specification** — Trusted Computing Group
- **Intel Boot Guard / Verified Boot** whitepapers
- **AMD Platform Security Processor (PSP)** documentation

### Open implementations
- coreboot — `https://www.coreboot.org/`
- EDK II (TianoCore reference UEFI) — `https://github.com/tianocore/edk2`
- U-Boot (embedded bootloader) — `https://docs.u-boot.org/`
- LinuxBoot / oreboot / heads (security-focused)
- OpenBMC, u-bmc

### Books
- *Beyond BIOS: Developing with the Unified Extensible Firmware Interface* — Zimmer, Rothman, Marisetty
- *Harnessing the UEFI Shell* — Zimmer et al.
- *Embedded Software for SoC* — Jerraya & Wolf (older but foundational)

### Online
- osdev.org wiki — bootloader & BIOS programming reference
- Phoronix coverage of coreboot/UEFI ecosystem

---

## Lessons

### What is in this section

```text
  Ten exercises. The file states no prerequisites between them; the
  grouping is editorial, by which end of the machine you are working on.

  ┌─ the smallest thing that runs ─────────────────────────────────────┐
  │   1  Bare-metal "hello"      Cortex-M blink, no RTOS               │
  └────────────────────────────────────────────────────────────────────┘

  ┌─ what is already on the board ─────────────────────────────────────┐
  │   2  Read your firmware      flashrom -r, then binwalk / UEFITool  │
  │   7  ACPI table walk         acpidump, then iasl -d               │
  └────────────────────────────────────────────────────────────────────┘

  ┌─ replace or extend it ─────────────────────────────────────────────┐
  │   3  Build coreboot          build, flash, watch the console       │
  │   4  Write a UEFI app        EDK II HelloWorld.efi from the shell  │
  │   6  U-Boot on QEMU          boot a Linux kernel under emulation   │
  └────────────────────────────────────────────────────────────────────┘

  ┌─ follow the whole chain ───────────────────────────────────────────┐
  │   5  Boot flow study         reset vector ─▶ firmware ─▶ loader    │
  │                              ─▶ kernel, on x86-64 and ARM          │
  │   8  Measured boot lab       tpm2_pcrread, and what fills a PCR    │
  │   9  Secure Boot / MOK       enrol a key, sign a kernel, boot it   │
  └────────────────────────────────────────────────────────────────────┘

  ┌─ the computer inside the computer ─────────────────────────────────┐
  │   10  BMC exploration        OpenBMC source, Redfish endpoints     │
  └────────────────────────────────────────────────────────────────────┘

  Lab: firmware_labs.md — three modules: UEFI shell exploration, firmware
  updates with fwupdmgr, and Secure Boot key enrolment.
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Firmware interactive labs | [Firmware & BIOS](firmware_labs.md) — UEFI shell, fwupdmgr, Secure Boot enrollment |

---

1. **Bare-metal "hello"** — Cortex-M (e.g. STM32 Blue Pill) blink LED with no RTOS.
2. **Read your firmware** — `flashrom -r dump.bin` on a supported board; explore with `binwalk` / UEFITool.
3. **Build coreboot** — pick a supported board, build image, flash, observe console.
4. **Write a UEFI app** — EDK II "HelloWorld.efi"; load from UEFI shell.
5. **Boot flow study** — trace reset vector → BIOS/UEFI → bootloader → kernel for x86-64 and ARM.
6. **U-Boot on QEMU** — boot a Linux kernel from U-Boot in `qemu-system-arm`.
7. **ACPI table walk** — dump tables with `acpidump`, decode with `iasl -d`.
8. **Measured boot lab** — read TPM PCRs (`tpm2_pcrread`), understand the chain.
9. **Secure Boot / MOK** — enroll your own key, sign a kernel, boot it.
10. **BMC exploration** — read OpenBMC source; understand Redfish endpoints.

### Suggested external
- osdev.org "Bare Bones" tutorial
- Coreboot lab series (3mdeb)
- Stephen Wood's Cortex-M / RTOS series

---

## Languages

### What is in this section

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

### Embedded RTOS languages
- **C / C++** — Zephyr, FreeRTOS, ThreadX, NuttX
- **Rust** — Embassy, RTIC, Tock OS
- **Ada / SPARK** — high-assurance embedded
- **MicroPython / CircuitPython** — high-level on microcontrollers
- **TinyGo** — Go for microcontrollers

### Related
- Lower: assembly → [CPU › Languages](../02_CPU/README.md#languages)
- Upper: kernel C → [OS Kernel › Languages](../05_OS_Kernel/README.md#languages)

---

## Manual Pages

### What is in this section

```text
  Sorted by which part of the boot chain each tool touches, because that is
  also the order in which they stop being safe to experiment with.

                     ┌──────────────────────────────┐
                     │  the flash chip              │◀── flashrom
                     │  BIOS/UEFI image             │    binwalk · UEFITool
                     └──────────────┬───────────────┘    chipsec
                                    │  initialises
                     ┌──────────────▼───────────────┐
                     │  the firmware's own tables   │◀── acpidump · iasl
                     │  and variables               │    dtc
                     └──────────────┬───────────────┘
                                    │  chooses
                     ┌──────────────▼───────────────┐
                     │  what boots                  │◀── efibootmgr
                     │  entries, order, signatures  │    bootctl · bcdedit
                     └──────────────┬───────────────┘    bless · nvram
                                    │  is attested by    csrutil  (macOS)
                     ┌──────────────▼───────────────┐
                     │  the TPM                     │◀── tpm2_pcrread
                     │  PCRs · quotes               │    tpm2_quote
                     └──────────────────────────────┘    mokutil
                                                         sbsign · sbverify

  And one group that reaches the machine when none of the above is running:

     ipmitool · redfishtool     the BMC, out of band

  Linux exposes most of the middle two boxes as files rather than commands:
  /sys/firmware/efi/ · /sys/firmware/acpi/tables/ · /sys/firmware/dmi/ ·
  and /dev/mem, which is root-only and restricted for good reason.

  Detail on the update and boot-entry tools: firmware_tools.md.
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Firmware management tools | [Firmware Management Commands](firmware_tools.md) — fwupdmgr, efibootmgr, mokutil, nvram |

---

| Command | Section | Purpose |
|---------|---------|---------|
| `efibootmgr` | 8 | View/modify UEFI boot entries (Linux) |
| `bootctl` | 1 | systemd-boot install / status |
| `mokutil` | 1 | Machine Owner Key — Secure Boot key enrollment |
| `sbverify` | 1 | Verify a signed EFI binary |
| `sbsign` | 1 | Sign an EFI binary |
| `flashrom` | 8 | Read/write SPI flash chip (BIOS/UEFI) |
| `chipsec` | 1 | Platform security assessment framework |
| `acpidump` | 1 | Dump ACPI tables from memory/sysfs |
| `iasl` | 1 | ACPI Source Language compiler/decompiler |
| `dtc` | 1 | Device Tree Compiler |
| `bless` | 8 | macOS — set the boot volume |
| `nvram` | 8 | macOS — read/write NVRAM variables |
| `csrutil` | 1 | macOS — SIP status & toggle (recovery only) |
| `bcdedit` | (Win) | Boot Configuration Data editor |
| `ipmitool` | 1 | IPMI BMC management |
| `redfishtool` | 1 | Redfish API client |
| `tpm2_pcrread` | 1 | Read TPM 2.0 PCR registers |
| `tpm2_quote` | 1 | TPM remote attestation quote |
| `binwalk` | 1 | Firmware image analysis / extraction |
| `UEFITool` (GUI) | n/a | View/edit UEFI capsule images |

### Sysfs / virtual filesystems
- `/sys/firmware/efi/` — EFI runtime, variables (Linux)
- `/sys/firmware/acpi/tables/` — raw ACPI tables
- `/sys/firmware/dmi/` — SMBIOS via DMI
- `/dev/mem` — physical memory (root-only, restricted)

---

## Topics

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [UEFI Boot Flow](uefi_boot_flow.md) | SEC→PEI→DXE→BDS, GPT, Secure Boot chain |

### What is in this section

```text
  Six groups. The first is a sequence, and the rest are what that sequence
  sets up, guards, or runs on.

  ┌─ x86 ──────────────────────┐    ┌─ ARM ────────────────────────────┐
  │  reset vector 0xFFFFFFF0   │    │  BL1  BootROM                    │
  │  real ─▶ protected ─▶ long │    │  BL2                             │
  │                            │    │  BL31 ATF                        │
  │  UEFI phases               │    │  BL33 U-Boot or UEFI             │
  │  SEC ─▶ PEI ─▶ DXE ─▶ BDS  │    │                                  │
  │      ─▶ TSL ─▶ RT ─▶ AL    │    │                                  │
  └─────────────┬──────────────┘    └────────────────┬─────────────────┘
                └────────────┬───────────────────────┘
                             ▼
                       a bootloader
         GRUB2 · systemd-boot · rEFInd · Windows Boot Manager
         iBoot · U-Boot
                             │
                             ▼
                        the kernel  ──▶ 05

  Three things that sequence leaves behind for the OS to use:

    UEFI specifics   Boot Services vs Runtime Services · the ESP, a FAT32
                     partition of .efi binaries · EFI variables in NVRAM
                     (Boot####, BootOrder, Setup) · capsule updates
    ACPI             RSDP ─▶ RSDT/XSDT ─▶ MADT · FADT · DSDT · SSDT ·
                     MCFG · HPET · BGRT · SLIT/SRAT, and AML for the OS
                     to interpret
    embedded         RTOS tasks and ISRs · vector table, startup.S, linker
                     scripts · OTA with A/B partitions

  And two that run underneath or alongside it, at higher privilege than
  anything above:

    platform mgmt    Intel ME / AMT · AMD PSP · BMC (IPMI, Redfish,
                     OpenBMC, KVM-over-IP) · SMM, which is ring −2
    measured boot    TPM 2.0 PCRs, NV indices, sealing, attestation
                     Secure Boot db · dbx · KEK · PK
                     Boot Guard · Hardware Validated Boot · DRTM

  Attacks on all of this — bootkits, evil maid, BMC flaws — are in 14.
  Detail on the UEFI sequence itself: uefi_boot_flow.md.
```

### Boot flow
- **x86 reset vector** — `0xFFFFFFF0` real mode → protected → long mode.
- **UEFI boot phases** — SEC → PEI → DXE → BDS → TSL → RT → AL.
- **ARM boot** — BL1 (BootROM) → BL2 → BL31 (ATF) → BL33 (U-Boot/UEFI) → kernel.
- **Bootloaders** — GRUB2, systemd-boot, rEFInd, Windows Boot Manager, iBoot, U-Boot.

### UEFI specifics
- **Boot Services vs Runtime Services**
- **EFI System Partition (ESP)** — FAT32 partition for `.efi` binaries
- **EFI variables (NVRAM)** — `Boot####`, `BootOrder`, `Setup`
- **Capsule updates** — fwupd / LVFS

### ACPI
- **Tables** — RSDP, RSDT/XSDT, MADT, FADT, DSDT, SSDT, MCFG, HPET, BGRT, SLIT/SRAT
- **AML** — ACPI Machine Language; interpreted by OS

### Platform management
- **Intel ME** (Management Engine) — Active Management Technology (AMT)
- **AMD PSP** (Platform Security Processor)
- **BMC** — IPMI, Redfish, OpenBMC; KVM-over-IP
- **System Management Mode (SMM)** — ring -2; highest privilege

### Measured & secure boot
- **TPM 2.0** — PCRs, NV indices, sealing/unsealing, attestation
- **Secure Boot** — db, dbx, KEK, PK; signature chain
- **Boot Guard** (Intel) / **Hardware Validated Boot** (AMD)
- **DRTM** — Dynamic Root of Trust (Intel TXT, AMD SKINIT)

### Embedded
- **RTOS basics** — tasks, scheduling, ISRs, message queues
- **Bare-metal patterns** — vector table, startup.S, linker scripts
- **OTA firmware updates** — A/B partitions, signature verification

### Security cross-link
- Bootkits, evil maid → [Security › Topics](../14_Security/README.md#topics)
- BMC vulnerabilities → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Seventeen specs from the table below, grouped by role in the platform stack.

  ┌────────────────────────────────────────────────────────────────────────┐
  │                        pre-boot environment                            │
  │  UEFI ── PI (SEC/PEI/DXE)  │  PSCI (ARM)  │  SBI (RISC-V M↔S-mode)  │
  │  OpenPOWER OPAL / skiboot  │  Capsule Update                          │
  └────────────────────────────────────────────┬───────────────────────────┘
                                               │
  ┌────────────────────────────────────────────▼───────────────────────────┐
  │               hardware description & inventory                         │
  │  ACPI (power · config · runtime)  │  SMBIOS/DMI  │  Device Tree       │
  └────────────────────────────────────────────┬───────────────────────────┘
                                               │
  ┌────────────────────────────────────────────▼───────────────────────────┐
  │                         trust & security                               │
  │  TPM 2.0  │  TCG D-RTM (TXT/SKINIT)  │  Secure Boot (PK/KEK/db/dbx)  │
  │  ARM SMC Calling Convention (EL3 secure monitor)                       │
  └────────────────────────────────────────────────────────────────────────┘

  ┌────────────────────────────────────────────────────────────────────────┐
  │                      out-of-band management                            │
  │  IPMI 2.0 (legacy) ──▶ Redfish (REST/JSON)  │  MCTP ── PLDM          │
  └────────────────────────────────────────────────────────────────────────┘
```

| Protocol / spec | Owner | Purpose | Status |
|----------------|-------|---------|--------|
| UEFI | UEFI Forum | Pre-boot environment & runtime services | Active |
| PI (Platform Initialization) | UEFI Forum | UEFI firmware internals (SEC/PEI/DXE) | Active |
| ACPI | UEFI Forum | Power, config, runtime hardware abstraction | Active |
| SMBIOS / DMI | DMTF | System inventory data | Active |
| Device Tree (DT) | DT spec | Hardware description for ARM/PowerPC/RISC-V | Active |
| TPM 2.0 | TCG | Measured boot, attestation, sealed storage | Active |
| TCG D-RTM | TCG | Dynamic Root of Trust (Intel TXT, AMD SKINIT) | Active |
| Secure Boot (UEFI) | UEFI Forum | Signed boot chain (PK/KEK/db/dbx) | Active |
| Capsule Update | UEFI Forum | Standardized firmware update mechanism | Active |
| IPMI 2.0 | Intel/HP/NEC/Dell | Out-of-band BMC management | Legacy |
| Redfish | DMTF | Modern REST/JSON BMC API | Active |
| MCTP | DMTF | Management Component Transport Protocol | Active |
| PLDM | DMTF | Platform Level Data Model (over MCTP) | Active |
| OpenPOWER OPAL / skiboot | OpenPOWER | POWER firmware/OS interface | Active |
| PSCI | ARM | Power State Coordination Interface | Active |
| SBI | RISC-V | Supervisor Binary Interface (M-mode ↔ S-mode) | Active |
| ARM SMC Calling Convention | ARM | Secure monitor calls (EL3) | Active |

### Image formats
- **PE/COFF** — UEFI binary format
- **FIT** — U-Boot Flattened Image Tree (kernel + initrd + DT bundled)
- **UEFI capsule** — signed firmware update package
