# Firmware / BIOS — Topics

## Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [UEFI Boot Flow](./uefi_boot_flow.md) | SEC→PEI→DXE→BDS, GPT, Secure Boot chain |

## What is in this section

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

## Boot flow
- **x86 reset vector** — `0xFFFFFFF0` real mode → protected → long mode.
- **UEFI boot phases** — SEC → PEI → DXE → BDS → TSL → RT → AL.
- **ARM boot** — BL1 (BootROM) → BL2 → BL31 (ATF) → BL33 (U-Boot/UEFI) → kernel.
- **Bootloaders** — GRUB2, systemd-boot, rEFInd, Windows Boot Manager, iBoot, U-Boot.

## UEFI specifics
- **Boot Services vs Runtime Services**
- **EFI System Partition (ESP)** — FAT32 partition for `.efi` binaries
- **EFI variables (NVRAM)** — `Boot####`, `BootOrder`, `Setup`
- **Capsule updates** — fwupd / LVFS

## ACPI
- **Tables** — RSDP, RSDT/XSDT, MADT, FADT, DSDT, SSDT, MCFG, HPET, BGRT, SLIT/SRAT
- **AML** — ACPI Machine Language; interpreted by OS

## Platform management
- **Intel ME** (Management Engine) — Active Management Technology (AMT)
- **AMD PSP** (Platform Security Processor)
- **BMC** — IPMI, Redfish, OpenBMC; KVM-over-IP
- **System Management Mode (SMM)** — ring -2; highest privilege

## Measured & secure boot
- **TPM 2.0** — PCRs, NV indices, sealing/unsealing, attestation
- **Secure Boot** — db, dbx, KEK, PK; signature chain
- **Boot Guard** (Intel) / **Hardware Validated Boot** (AMD)
- **DRTM** — Dynamic Root of Trust (Intel TXT, AMD SKINIT)

## Embedded
- **RTOS basics** — tasks, scheduling, ISRs, message queues
- **Bare-metal patterns** — vector table, startup.S, linker scripts
- **OTA firmware updates** — A/B partitions, signature verification

## Security cross-link
- Bootkits, evil maid → [14_Security/topics](../../14_Security/topics/INDEX.md)
- BMC vulnerabilities → [14_Security/topics](../../14_Security/topics/INDEX.md)
