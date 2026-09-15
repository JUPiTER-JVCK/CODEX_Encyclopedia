# Firmware / BIOS — Protocols

## What is in this section

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

## Image formats
- **PE/COFF** — UEFI binary format
- **FIT** — U-Boot Flattened Image Tree (kernel + initrd + DT bundled)
- **UEFI capsule** — signed firmware update package
