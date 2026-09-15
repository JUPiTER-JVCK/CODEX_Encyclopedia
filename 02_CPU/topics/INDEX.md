# CPU — Topics

## What is in this section

```text
  Five groups, and they answer five different questions about the same chip.

  ┌─────────────────────────────────────────────────────────────────────┐
  │  ISAs & extensions        what it promises to execute               │
  │    x86-64   MMX · SSE/AVX/AVX-512 · AES-NI · SHA-NI · BMI · AMX     │
  │    AArch64  NEON · SVE/SVE2 · crypto · PAC · MTE                    │
  │    RISC-V   RV32I/RV64I + M A F D C V B H                           │
  │    also     POWER · MIPS · SPARC · z/Arch · Itanium                 │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  one implementation of that promise
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  microarchitecture        how it keeps the promise fast             │
  │    pipelining · out-of-order · superscalar · SMT                    │
  │    branch prediction — bimodal · tournament · perceptron · TAGE     │
  │    speculation and rollback · SIMD execution units                  │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  which needs operands
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  memory hierarchy         where the operands come from              │
  │    L1i/L1d · L2 · L3 — MESI, MOESI, MESIF                           │
  │    TLBs and MMU · ASIDs/PCIDs · huge pages                          │
  │    ordering — TSO, weak, barriers · NUMA — UPI · Fabric · CXL       │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  none of which may leak
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  privilege & isolation    who is allowed to see it                  │
  │    rings and EL levels · VT-x/AMD-V · EPT/NPT · IOMMU               │
  │    TEEs — SGX · SEV · TrustZone · Keystone                          │
  │    pointer auth and CFI — PAC · CET · Zicfilp/Zicfiss               │
  └─────────────────────────────────────────────────────────────────────┘

  ┌─────────────────────────────────────────────────────────────────────┐
  │  observability            how you watch any of the four happen      │
  │    PMU counters · LBR · Intel PT — what perf in man_pages/ reads    │
  └─────────────────────────────────────────────────────────────────────┘

  Speculation appears in two of these groups and is where they collide:
  Spectre, Meltdown, MDS and L1TF are in 14 Security, Rowhammer in 01.

  Detail on the pipeline itself: cpu_pipeline.md.
```

## Dedicated topic files

| Topic | File |
|-------|------|
| CPU Pipeline | [cpu_pipeline.md](cpu_pipeline.md) — 5-stage RISC, superscalar OoO, hazards, cache hierarchy, branch prediction, Spectre |

---

## ISAs & extensions
- **x86-64** — base + MMX, SSE/AVX/AVX-512, AES-NI, SHA-NI, BMI, ADX, AMX.
- **AArch64** — base + NEON, SVE/SVE2, crypto, pointer authentication, MTE.
- **RISC-V** — RV32I/RV64I + standard extensions: M, A, F, D, C, V, B, H.
- **Other** — POWER, MIPS, SPARC, z/Architecture, Itanium (historical).

## Microarchitecture
- **Pipelining** — fetch, decode, rename, dispatch, execute, writeback, retire.
- **Out-of-order execution** — reservation stations, reorder buffer.
- **Superscalar & multi-issue** — multiple ops per cycle per core.
- **Branch prediction** — bimodal, tournament, perceptron, TAGE.
- **Speculation & rollback** — checkpoint, squash, recovery.
- **SIMD / vector** — packed-data execution units.
- **SMT / hyperthreading** — sharing execution resources between hardware threads.

## Memory hierarchy
- **Caches** — L1i/L1d, L2, L3/LLC; inclusive vs exclusive; coherence (MESI, MOESI, MESIF).
- **TLBs & MMU** — page tables, address translation, ASIDs/PCIDs, huge pages.
- **Memory ordering** — TSO (x86), weak (ARM/POWER), barriers/fences.
- **NUMA** — node locality, interconnect (UPI, Infinity Fabric, CXL).

## Privilege & isolation
- **Rings / EL levels** — x86 ring 0/3, ARM EL0–EL3.
- **Virtualization** — VT-x/AMD-V, EPT/NPT, IOMMU (VT-d/AMD-Vi).
- **TEEs** — Intel SGX, AMD SEV, ARM TrustZone, RISC-V Keystone.
- **Pointer auth & CFI** — ARM PAC, Intel CET, RISC-V Zicfilp/Zicfiss.

## Observability
- **PMU / performance counters** — cycles, instructions, cache misses, branch mispredicts.
- **Last Branch Record (LBR)**, **Intel PT** — branch & path tracing.

## Security cross-link
- Speculative side channels (Spectre, Meltdown, MDS, L1TF) → [14_Security/topics](../../14_Security/topics/INDEX.md)
- Rowhammer (DRAM) → [01_Circuit_Board/topics](../../01_Circuit_Board/topics/INDEX.md)
